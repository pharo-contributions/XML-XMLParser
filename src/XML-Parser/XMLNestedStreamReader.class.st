"
This class represents a stream reader that implements pushBack: using nested streams. This enables subsitution/replacement to be performed without modifying the underlying collections streamed-over or having to copy them. It also performs line-ending normalization, transforming CR and CRLF sequences into a single LF character.

(The code in this class is optimized; refactor with care.)
"
Class {
	#name : #XMLNestedStreamReader,
	#superclass : #Object,
	#instVars : [
		'stream',
		'nestedStreams',
		'peekChar',
		'writeBuffer',
		'normalizedLineEndingChar',
		'currentLineNumber',
		'readLimit'
	],
	#classVars : [
		'CarriageReturn',
		'LineFeed'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'class initialization' }
XMLNestedStreamReader class >> initialize [
	"self initialize"

	super initialize.

	CarriageReturn := Character cr.
	LineFeed := Character lf.
]

{ #category : #'instance creation' }
XMLNestedStreamReader class >> on: anInitialStream readLimit: aReadLimit [
	^ self new
		setStream: anInitialStream
		readLimit: aReadLimit
]

{ #category : #testing }
XMLNestedStreamReader >> atEnd [
	^ peekChar == nil
		and: [stream atEnd
			and: [self hasNestedStreams not
				or: [nestedStreams allSatisfy: [:each | each atEnd]]]]
]

{ #category : #testing }
XMLNestedStreamReader >> atQuote [
	^ self peek == $"
		or: [peekChar == $']
]

{ #category : #accessing }
XMLNestedStreamReader >> basicNext [
	"Returns next character in the stream after performing line-ending normalization."

	| nextChar |

	(nextChar := stream next)
		ifNil: [
			[stream atEnd and: [self hasNestedStreams]]
				whileTrue: [self popCurrentStream].
			nextChar := stream next].

	nextChar == CarriageReturn
		ifTrue: [
			[stream atEnd and: [self hasNestedStreams]]
				whileTrue: [self popCurrentStream].
			(stream peek == LineFeed)
				ifTrue: [stream next].
			^ normalizedLineEndingChar].
	(nextChar == LineFeed)
		ifTrue: [^ normalizedLineEndingChar].

	^ nextChar.
]

{ #category : #'file open/close' }
XMLNestedStreamReader >> close [
	stream close.
	nestedStreams ifNotNil: [nestedStreams reverseDo: [:each | each close]].
]

{ #category : #accessing }
XMLNestedStreamReader >> currentLineNumber [
	^ currentLineNumber
]

{ #category : #private }
XMLNestedStreamReader >> errorNestingLimitExceeded [
	XMLLimitException signal: 'Cannot further nest input streams'
]

{ #category : #private }
XMLNestedStreamReader >> errorReadLimitExceeded [
	XMLLimitException signal:
		'Security read limit on input exceeded; ',
		'use #documentReadLimit: or #externalSubsetReadLimit: ',
		'to change or disable'
]

{ #category : #testing }
XMLNestedStreamReader >> hasNestedStreams [
	^ nestedStreams notNil and: [nestedStreams notEmpty]
]

{ #category : #private }
XMLNestedStreamReader >> maxNestedStreams [
	^ 10
]

{ #category : #accessing }
XMLNestedStreamReader >> next [
	| nextChar |

	peekChar
		ifNil: [nextChar := self basicNext]
		ifNotNil: [
			nextChar := peekChar.
			peekChar := nil].

	nextChar == normalizedLineEndingChar
		ifTrue: [currentLineNumber := currentLineNumber + 1].
	readLimit ifNotNil: [
		(readLimit := readLimit - 1) >= 0
			ifFalse: [self errorReadLimitExceeded]].

	^ nextChar.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextInteger [
	^ XMLIntegerReader
		readFrom: self
		withBase: 16
		startingWithAny: 'x'
		orBase: 10
]

{ #category : #testing }
XMLNestedStreamReader >> nextMatchAll: aString [
	| i nextChar |

	"inlined peek"
	(peekChar ifNil: [peekChar := self basicNext]) == (aString at: 1)
		ifFalse: [^ false].

	"we unrolled the first iteration with the above #peek"
	i := 2.
	self next.
	[(i <= aString size)
		and: [(aString at: i) == (nextChar := self next)]]
		whileTrue: [i := i + 1].
	(i > aString size)
		ifTrue: [^ true].

	self pushBack:
		(nextChar
			ifNotNil: [
				(aString copyFrom: 1 to: i)
					at: i put: nextChar;
					yourself]
			ifNil: [aString copyFrom: 1 to: i - 1]).
	^ false.
]

{ #category : #accessing }
XMLNestedStreamReader >> normalizedLineEndingChar [
	^ normalizedLineEndingChar
]

{ #category : #accessing }
XMLNestedStreamReader >> normalizedLineEndingChar: aCharacter [
	normalizedLineEndingChar := aCharacter
]

{ #category : #accessing }
XMLNestedStreamReader >> peek [
	^ peekChar ifNil: [peekChar := self basicNext]
]

{ #category : #private }
XMLNestedStreamReader >> popCurrentStream [
	stream close.
	stream := nestedStreams removeLast.
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBack: aString [
	aString size > 0
		ifTrue: [self pushStream: (ReadStream on: aString)]
]

{ #category : #private }
XMLNestedStreamReader >> pushBackPeekChar [
	| peekCharString |

	peekCharString := String with: peekChar.
	peekChar := nil.
	self pushBack: peekCharString.
]

{ #category : #positioning }
XMLNestedStreamReader >> pushStream: aStream [
	self pushStream: aStream onClose: nil
]

{ #category : #positioning }
XMLNestedStreamReader >> pushStream: aStream onClose: aBlock [
	peekChar
		ifNotNil: [self pushBackPeekChar].

	nestedStreams
		ifNil: [nestedStreams := OrderedCollection with: stream]
		ifNotNil: [
			(nestedStreams size >= self maxNestedStreams)
				ifTrue: [self errorNestingLimitExceeded].
			nestedStreams addLast: stream].

	self setStream: aStream onClose: aBlock
]

{ #category : #private }
XMLNestedStreamReader >> setStream: aNewStream onClose: aBlock [
	stream :=
		XMLPeekableStreamAdapter
			on: aNewStream
			onClose: aBlock
]

{ #category : #initialization }
XMLNestedStreamReader >> setStream: anInitialStream readLimit: aReadLimit [
	writeBuffer := WriteStream on: (String new: 128).
	currentLineNumber := 1.
	normalizedLineEndingChar := LineFeed.

	self
		setStream: anInitialStream
		onClose: nil.
	readLimit := aReadLimit.
]

{ #category : #streaming }
XMLNestedStreamReader >> skipSeparators [
	"inlined peek"
	[(peekChar ifNil: [peekChar := self basicNext]) notNil
		and: [peekChar isSeparator]]
		whileTrue: [self next].
]

{ #category : #positioning }
XMLNestedStreamReader >> skipTo: aDelimiter [
	[self atEnd] whileFalse: [
		self next == aDelimiter
			ifTrue: [^ true]].
	^ false.
]

{ #category : #accessing }
XMLNestedStreamReader >> stream [
	^ stream
]

{ #category : #accessing }
XMLNestedStreamReader >> upTo: aDelimiter [
	| nextChar |

	writeBuffer reset.
	[self atEnd or: [(nextChar := self next) == aDelimiter]]
		whileFalse: [writeBuffer nextPut: nextChar].

	^ writeBuffer contents.
]

{ #category : #accessing }
XMLNestedStreamReader >> upToAll: aDelimitingString [
	"Answer a subcollection from the current access position to the occurrence
	(if any, but not inclusive) of delimitingString. If delimitingString is not
	in the stream, answer the entire rest of the stream."

	writeBuffer reset.
	[self atEnd or: [self nextMatchAll: aDelimitingString]]
		whileFalse: [writeBuffer nextPut: self next].
	^ writeBuffer contents.
]

{ #category : #accessing }
XMLNestedStreamReader >> upToEnd [
	writeBuffer reset.
	[self atEnd] whileFalse: [writeBuffer nextPut: self next].
	^ writeBuffer contents.
]

{ #category : #streaming }
XMLNestedStreamReader >> useConverterForEncoding: anEncodingName [
	stream converter: (XMLTextConverterFactory newForEncoding: anEncodingName)
]

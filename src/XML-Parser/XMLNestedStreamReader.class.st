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
		'LineFeed',
		'SeparatorCharacters'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'class initialization' }
XMLNestedStreamReader class >> initialize [
	"self initialize"

	super initialize.

	(SeparatorCharacters := BitmapCharacterSet new)
		addAll: Character separators.
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
	^ peekChar isNil
		and: [stream atEnd
			and: [self hasNestedStreams not
				or: [nestedStreams allSatisfy: [:each | each atEnd]]]]
]

{ #category : #testing }
XMLNestedStreamReader >> atQuote [
	^ self peek == $"
		or: [self peek == $']
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
			nextChar := normalizedLineEndingChar.
			[stream atEnd and: [self hasNestedStreams]]
				whileTrue: [self popCurrentStream].
			(stream peek == LineFeed)
				ifTrue: [stream next]]
		ifFalse: [
			(nextChar == LineFeed)
				ifTrue: [nextChar := normalizedLineEndingChar]].

	^ nextChar.
]

{ #category : #accessing }
XMLNestedStreamReader >> currentLineNumber [
	^ currentLineNumber
]

{ #category : #testing }
XMLNestedStreamReader >> hasNestedStreams [
	^ nestedStreams notNil and: [nestedStreams notEmpty]
]

{ #category : #initialization }
XMLNestedStreamReader >> initialize [
	super initialize.

	nestedStreams := nil.
	peekChar := nil.
	writeBuffer := WriteStream on: (String new: 128).
	currentLineNumber := 1.
	normalizedLineEndingChar := LineFeed.
]

{ #category : #private }
XMLNestedStreamReader >> maxNestedStreams [
	^ 10
]

{ #category : #accessing }
XMLNestedStreamReader >> next [
	"Return the next character from the current input stream. If the current
	stream is at end, pop to the next nesting level if there is one."

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
			ifFalse: [XMLLimitException signal: 'Read limit on input exceeded']].

	^ nextChar.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextInteger [
	"We re-implement integer reading here because the impelmentation of Integer>>readFrom: expects
	the underlying stream to be skip:able."
	| base |

	self peek == $x
		ifTrue: [
			self next.
			base := 16]
		ifFalse: [base := 10].

	^ XMLIntegerReader
		readFrom: self
		withBase: base.
]

{ #category : #testing }
XMLNestedStreamReader >> nextMatchAll: aString [
	| i nextChar |

	self peek == (aString at: 1)
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
	"Return the next character from the current input stream."

	^ peekChar ifNil: [peekChar := self basicNext]
]

{ #category : #private }
XMLNestedStreamReader >> popCurrentStream [
	stream close.
	stream := nestedStreams removeLast.
]

{ #category : #streaming }
XMLNestedStreamReader >> pushBack: aString [
	self pushStream: (ReadStream on: aString)
]

{ #category : #streaming }
XMLNestedStreamReader >> pushBackPeekChar [
	| peekCharString |

	peekCharString := String with: peekChar.
	peekChar := nil.
	self pushBack: peekCharString.
]

{ #category : #streaming }
XMLNestedStreamReader >> pushStream: aStream [
	self pushStream: aStream onClose: nil
]

{ #category : #streaming }
XMLNestedStreamReader >> pushStream: aStream onClose: aBlock [
	peekChar
		ifNotNil: [self pushBackPeekChar].

	nestedStreams
		ifNil: [nestedStreams := OrderedCollection with: stream]
		ifNotNil: [
			(nestedStreams size >= self maxNestedStreams)
				ifTrue: [XMLLimitException signal: 'cannot further nest input streams'].
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
	self
		setStream: anInitialStream
		onClose: nil.

	readLimit := aReadLimit.
]

{ #category : #streaming }
XMLNestedStreamReader >> skipSeparators [
	| nextChar |

	[(nextChar := self peek) notNil
		and: [SeparatorCharacters includes: nextChar]]
		whileTrue: [self next].
]

{ #category : #streaming }
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

{ #category : #streaming }
XMLNestedStreamReader >> upTo: aDelimiter [
	| nextChar |

	writeBuffer reset.
	[self atEnd or: [(nextChar := self next) == aDelimiter]]
		whileFalse: [writeBuffer nextPut: nextChar].

	^ writeBuffer contents.
]

{ #category : #streaming }
XMLNestedStreamReader >> upToAll: aDelimitingString [
	"Answer a subcollection from the current access position to the occurrence
	(if any, but not inclusive) of delimitingString. If delimitingString is not
	in the stream, answer the entire rest of the stream."

	writeBuffer reset.
	[self atEnd or: [self nextMatchAll: aDelimitingString]]
		whileFalse: [writeBuffer nextPut: self next].
	^ writeBuffer contents.
]

{ #category : #streaming }
XMLNestedStreamReader >> upToEnd [
	writeBuffer reset.
	[self atEnd] whileFalse: [writeBuffer nextPut: self next].
	^ writeBuffer contents.
]

{ #category : #streaming }
XMLNestedStreamReader >> useConverterForEncoding: anEncodingName [
	| converterClass |

	converterClass :=
		(Smalltalk
			at: #TextConverter
			ifAbsent: [^ self])
				defaultConverterClassForEncoding: anEncodingName asLowercase.
		
	converterClass
		ifNotNil: [stream converter: converterClass new].
]

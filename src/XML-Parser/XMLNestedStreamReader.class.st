"
This class represents a stream reader that implements pushBack: using nested streams. This enables subsitution/replacement to be performed without modifying the underlying collections streamed-over or having to copy them. It also performs line-ending normalization, transforming CR and CRLF sequences into a single LF character.

(The code in this class is optimized; refactor with care.)
"
Class {
	#name : #XMLNestedStreamReader,
	#superclass : #Object,
	#instVars : [
		'stream',
		'onClose',
		'nestedStreams',
		'peekChar',
		'writeBuffer',
		'normalizedLineEndingChar',
		'currentLineNumber',
		'readLimit',
		'isEscapingQuotes'
	],
	#classVars : [
		'CarriageReturn',
		'EncodingHandlerTable',
		'LineFeed'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'class initialization' }
XMLNestedStreamReader class >> initialize [
	"self initialize"

	CarriageReturn := Character cr.
	LineFeed := Character lf.

	EncodingHandlerTable := Array new: 256.
	0 to: 255 do: [:each |
		EncodingHandlerTable
			at: each + 1
			put: (XMLEncodingDetector handlerForLeadByte: each)]
]

{ #category : #'instance creation' }
XMLNestedStreamReader class >> on: aStream [
	^ self
		on: aStream
		readLimit: nil
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
				or: [nestedStreams allSatisfy: [:each | each key atEnd]]]]
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

	stream atEnd
		ifTrue: [
			[self hasNestedStreams and: [stream atEnd]]
				whileTrue: [self popCurrentStream].
			stream atEnd
				ifTrue: [^ nil]].
	(nextChar := stream next) == CarriageReturn
		ifTrue: [
			[stream atEnd and: [self hasNestedStreams]]
				whileTrue: [self popCurrentStream].
			stream atEnd
				ifFalse: [
					(stream peek == LineFeed)
						ifTrue: [stream next]].
			^ normalizedLineEndingChar].
	(nextChar == LineFeed)
		ifTrue: [^ normalizedLineEndingChar].
	isEscapingQuotes
		ifTrue: [^ self escapeQuote: nextChar].

	^ nextChar.
]

{ #category : #'file open/close' }
XMLNestedStreamReader >> close [
	[self hasNestedStreams]
		whileTrue: [self popCurrentStream].
	self closeCurrentStream.
]

{ #category : #private }
XMLNestedStreamReader >> closeCurrentStream [
	(stream respondsTo: #close)
		ifTrue: [stream close].
	onClose ifNotNil: [onClose value].
]

{ #category : #encodings }
XMLNestedStreamReader >> convertFromEncoding: anEncodingName [
	| streamDecoder |

	"encoding declarations for the default encoding are ignored on ReadStreams,
	which are assumed to be on strings that don't need decoding"
	streamDecoder := XMLStreamDecoder newForEncoding: anEncodingName.
	(streamDecoder == nil
		or: [(stream isKindOf: ReadStream)
			and: [streamDecoder isDefaultStreamDecoder]])
		ifFalse: [self decodeStreamWithDecoder: streamDecoder].
]

{ #category : #accessing }
XMLNestedStreamReader >> currentLineNumber [
	^ currentLineNumber
]

{ #category : #encodings }
XMLNestedStreamReader >> decodeStreamWithDecoder: aStreamDecoder [
	(stream respondsTo: #streamDecoder:)
		ifTrue: [stream streamDecoder: aStreamDecoder]
		ifFalse: [
			stream :=
				XMLDecodingReadStreamAdapter
					on: stream
					streamDecoder: aStreamDecoder]
]

{ #category : #encodings }
XMLNestedStreamReader >> detectCurrentEncoding [
	| firstChar characterCode selector encodingDetector |

	stream atEnd
		ifTrue: [^ self].
	firstChar := stream peek.
	((characterCode := firstChar asciiValue) < 256
		and: [(selector := EncodingHandlerTable at: characterCode + 1) notNil])
		ifTrue: [
			(encodingDetector := XMLEncodingDetector on: stream)
				perform: selector]
		ifFalse: [
			firstChar == $<
				ifFalse: [^ self].
			peekChar := stream next.
			(stream atEnd
				or: [stream peek asciiValue > 0])
				ifTrue: [^ self].
			(encodingDetector := XMLEncodingDetector on: stream)
				detectLittleEndianImplicitEncoding].
	encodingDetector streamDecoder
		ifNotNil: [:decoder | self decodeStreamWithDecoder: decoder].
	encodingDetector remainder
		ifNotNil: [:remainder | self pushBack: remainder].
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

{ #category : #private }
XMLNestedStreamReader >> escapeQuote: aCharacter [
	aCharacter ==  $"
		ifTrue: [
			self pushBack: '#34;'.
			^ $&].
	aCharacter == $'
		ifTrue: [
			self pushBack: '#39;'.
			^ $&].
	^ aCharacter.
]

{ #category : #testing }
XMLNestedStreamReader >> hasNestedStreams [
	^ nestedStreams notNil and: [nestedStreams notEmpty]
]

{ #category : #accessing }
XMLNestedStreamReader >> isEscapingQuotes: aBoolean [
	isEscapingQuotes := aBoolean
]

{ #category : #private }
XMLNestedStreamReader >> maxNestedStreams [
	^ 32
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

{ #category : #accessing }
XMLNestedStreamReader >> nextMatchAll: aString [
	| nextChar  |

	"inlined peek"
	(peekChar ifNil: [peekChar := self basicNext]) == (aString at: 1)
		ifFalse: [^ false].
	self next.

	"we unrolled the first iteration with the above #peek"
	2 to: aString size do: [:i |
		(nextChar := self peek) == (aString at: i)
			ifFalse: [
				self pushBack: (aString copyFrom: 1 to: i -1).
				^ false].
			self next].
	^ true.
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
	| nextStreamAndCallback |

	self closeCurrentStream.
	nextStreamAndCallback := nestedStreams removeLast.
	stream := nextStreamAndCallback key.
	onClose := nextStreamAndCallback value.
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBack: aString [
	aString size > 1
		ifTrue: [^ self pushStream: (ReadStream on: aString)].
	aString size = 1
		ifTrue: [self pushBackCharacter: (aString at: 1)]
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBackCharacter: aCharacter [
	self
		pushStream: (XMLSingleCharacterReadStream on: aCharacter)
		onClose: nil
]

{ #category : #positioning }
XMLNestedStreamReader >> pushStream: aStream [
	self
		pushStream: aStream
		onClose: nil
]

{ #category : #positioning }
XMLNestedStreamReader >> pushStream: aStream onClose: aBlock [
	nestedStreams
		ifNil: [(nestedStreams := OrderedCollection new: self maxNestedStreams)].
	(nestedStreams size >= self maxNestedStreams)
		ifTrue: [self errorNestingLimitExceeded].

	nestedStreams addLast: stream -> onClose.
	peekChar
		ifNotNil: [
			nestedStreams addLast: (XMLSingleCharacterReadStream on: peekChar) -> nil.
			peekChar := nil].

	stream := aStream.
	onClose := aBlock.
]

{ #category : #initialization }
XMLNestedStreamReader >> setStream: anInitialStream readLimit: aReadLimit [
	writeBuffer := WriteStream on: (String new: 64).
	currentLineNumber := 1.
	normalizedLineEndingChar := LineFeed.
	stream := anInitialStream.
	readLimit := aReadLimit.
	isEscapingQuotes := false.
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

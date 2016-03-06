"
This class represents a stream reader that implements pushBack: using nested streams. This enables subsitution/replacement to be performed without modifying the underlying collections streamed-over or having to copy them. It also performs line-ending normalization, transforming a CR or a CRLF sequence into a single LF character.

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
		'normalizedLineEndingChar',
		'currentLineNumber',
		'readLimit',
		'isEscapingQuotes'
	],
	#classVars : [
		'CRCharacter',
		'LFCharacter'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'class initialization' }
XMLNestedStreamReader class >> initialize [
	"self initialize"

	"stored in class vars for faster access"
	CRCharacter := Character cr.
	LFCharacter := Character lf.
]

{ #category : #'instance creation' }
XMLNestedStreamReader class >> on: aStream [
	^ self
		on: aStream
		readLimit: nil
]

{ #category : #'instance creation' }
XMLNestedStreamReader class >> on: aStream readLimit: aReadLimit [
	^ self new
		setStream: aStream
		readLimit: aReadLimit
]

{ #category : #testing }
XMLNestedStreamReader >> atEnd [
	peekChar == nil
		ifFalse: [^ false].
	stream atEnd
		ifFalse: [^ false].

	nestedStreams ifNotNil: [
		nestedStreams do: [:each |
			each key atEnd
				ifFalse: [^ false]]].
	^ true.
]

{ #category : #testing }
XMLNestedStreamReader >> atQuote [
	^ self peek == $"
		or: [peekChar == $']
]

{ #category : #private }
XMLNestedStreamReader >> basicNext [
	"Returns next character in the stream after performing line-ending normalization."
	| nextChar |

	stream atEnd
		ifTrue: [
			self popNestedStreamWhileAtEnd.
			stream atEnd
				ifTrue: [^ nil]].
	(nextChar := stream next) == CRCharacter
		ifTrue: [
			self popNestedStreamWhileAtEnd.
			stream atEnd
				ifFalse: [
					stream peek == LFCharacter
						ifTrue: [stream next]].
			nextChar := normalizedLineEndingChar]
		ifFalse: [
			nextChar == LFCharacter
				ifTrue: [nextChar := normalizedLineEndingChar]].
	isEscapingQuotes
		ifTrue: [^ self escapeNextQuoteCharacter: nextChar]
		ifFalse: [^ nextChar].
]

{ #category : #private }
XMLNestedStreamReader >> closeCurrentStream [
	(stream respondsTo: #close)
		ifTrue: [stream close].
	onClose ifNotNil: [onClose value].
]

{ #category : #closing }
XMLNestedStreamReader >> closeStreams [
	nestedStreams ifNotNil: [
		[nestedStreams isEmpty]
			whileFalse: [self popNestedStream]].
	self closeCurrentStream.
]

{ #category : #decoding }
XMLNestedStreamReader >> convertFromEncoding: anEncodingName [
	| streamConverter |

	"encoding declarations for the default encoding are ignored on ReadStreams,
	which are assumed to be on strings that don't need decoding"
	streamConverter := anEncodingName asXMLStreamConverter.
	((stream isKindOf: ReadStream)
		and: [streamConverter isDefault
			or: [streamConverter isNull]])
		ifFalse: [self decodeStreamWithConverter: streamConverter].
]

{ #category : #accessing }
XMLNestedStreamReader >> currentLineNumber [
	^ currentLineNumber
]

{ #category : #decoding }
XMLNestedStreamReader >> decodeStreamWithConverter: aStreamConverter [
	stream isConvertingStreamAdapter
		ifTrue: [stream streamConverter: aStreamConverter]
		ifFalse: [
			stream :=
				XMLDecodingReadStreamAdapter
					on: stream
					streamConverter: aStreamConverter]
]

{ #category : #decoding }
XMLNestedStreamReader >> detectCurrentEncoding [
	(XMLNestedStreamReaderEncodingDetector for: self) detectCurrentEncoding
]

{ #category : #private }
XMLNestedStreamReader >> errorNestingLimitExceeded [
	XMLLimitException signal: 'Cannot further nest input streams'
]

{ #category : #private }
XMLNestedStreamReader >> errorReadLimitExceeded [
	XMLLimitException signal:
		'Security input read limit exceeded; ',
		'use #documentReadLimit: (or #externalSubsetReadLimit:) ',
		'to change or disable or #defaultReadLimit: ',
		'to persistently change or disable'
]

{ #category : #private }
XMLNestedStreamReader >> escapeNextQuoteCharacter: aCharacter [
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
XMLNestedStreamReader >> isEscapingQuotes [
	^ isEscapingQuotes
]

{ #category : #accessing }
XMLNestedStreamReader >> isEscapingQuotes: aBoolean [
	isEscapingQuotes := aBoolean
]

{ #category : #testing }
XMLNestedStreamReader >> isStream [
	^ true
]

{ #category : #private }
XMLNestedStreamReader >> maxNestedStreams [
	^ 32
]

{ #category : #private }
XMLNestedStreamReader >> newWriteStream [
	^ (String new: 128) writeStream
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
XMLNestedStreamReader >> next: anInteger [
	| writeStream |

	writeStream := self newWriteStream.
	1 to: anInteger do: [:i |
		self atEnd
			ifTrue: [^ writeStream contents].
		writeStream nextPut: self next].
	^ writeStream contents.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextInteger [
	^ self nextIntegerPrintedOn: nil
]

{ #category : #accessing }
XMLNestedStreamReader >> nextIntegerPrintedOn: aStream [
	^ (XMLIntegerReader on: self)
		printStream: aStream;
		nextIntegerWithBase: 16 startingWithAny: 'x' orBase: 10
]

{ #category : #accessing }
XMLNestedStreamReader >> nextMatchAll: aString [
	| nextChar oldCurrentLineNumber oldReadLimit |

	"inlined peek"
	(peekChar ifNil: [peekChar := self basicNext]) == (aString at: 1)
		ifFalse: [^ false].

	oldCurrentLineNumber := currentLineNumber.
	oldReadLimit := readLimit.
	self next.
	"we unrolled the first iteration with the above inlined peek"
	2 to: aString size do: [:i |
		(nextChar := self peek) == (aString at: i)
			ifTrue: [self next]
			ifFalse: [
				self pushBack: (aString copyFrom: 1 to: i -1).
				currentLineNumber := oldCurrentLineNumber.
				readLimit := oldReadLimit.
				^ false]].
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
XMLNestedStreamReader >> popNestedStream [
	| nextStreamAndCallback |

	self closeCurrentStream.
	nextStreamAndCallback := nestedStreams removeLast.
	stream := nextStreamAndCallback key.
	onClose := nextStreamAndCallback value.
]

{ #category : #private }
XMLNestedStreamReader >> popNestedStreamWhileAtEnd [
	nestedStreams ifNotNil: [
		[stream atEnd
			and: [nestedStreams notEmpty]]
			whileTrue: [self popNestedStream]]
]

{ #category : #printing }
XMLNestedStreamReader >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: peekChar;
		nextPutAll: '; ';
		print: stream.
	nestedStreams
		ifNotNil: [
			aStream
				space;
				print: nestedStreams].
	aStream nextPut: $).
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBack: aString [
	aString size > 1
		ifTrue: [^ self pushBackStream: aString readStream].
	aString size = 1
		ifTrue: [self pushBackCharacter: (aString at: 1)]
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBackCharacter: aCharacter [
	peekChar
		ifNil: [peekChar := aCharacter]
		ifNotNil: [
			self
				pushBackStream: (XMLSingleCharacterReadStream on: aCharacter)
				onClose: nil]
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBackStream: aStream [
	self
		pushBackStream: aStream
		onClose: nil
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBackStream: aStream onClose: aBlock [
	nestedStreams
		ifNil: [(nestedStreams := OrderedCollection new: self maxNestedStreams)].
	(nestedStreams size >= self maxNestedStreams)
		ifTrue: [self errorNestingLimitExceeded].

	nestedStreams addLast: stream -> onClose.
	peekChar
		ifNotNil: [
			nestedStreams addLast: (XMLSingleCharacterReadStream on: peekChar) -> nil.
			peekChar := nil].

	self stream: aStream.
	onClose := aBlock.
]

{ #category : #accessing }
XMLNestedStreamReader >> readLimit [
	^ readLimit
]

{ #category : #initialization }
XMLNestedStreamReader >> setStream: aStream readLimit: aReadLimit [
	currentLineNumber := 1.
	normalizedLineEndingChar := LFCharacter.
	readLimit := aReadLimit.
	isEscapingQuotes := false.
	self stream: aStream.
]

{ #category : #positioning }
XMLNestedStreamReader >> skip: anInteger [
	1 to: anInteger do: [:i |
		self atEnd
			ifTrue: [^ self].
		self next]
]

{ #category : #positioning }
XMLNestedStreamReader >> skipSeparators [
	"nil understands xmlParserIsSeparator so the result of the inlined #peek
	does not need to be tested for nil first"
	[(peekChar ifNil: [peekChar := self basicNext]) "inlined #peek"
		xmlParserIsSeparator]
		whileTrue: [
			"inlined #next"
			peekChar == normalizedLineEndingChar
				ifTrue: [currentLineNumber := currentLineNumber + 1].
			readLimit ifNotNil: [
				(readLimit := readLimit - 1) >= 0
					ifFalse: [self errorReadLimitExceeded]].
			peekChar := nil]
]

{ #category : #positioning }
XMLNestedStreamReader >> skipTo: aCharacter [
	[self atEnd]
		whileFalse: [
			self next == aCharacter
				ifTrue: [^ true]].
	^ false.
]

{ #category : #accessing }
XMLNestedStreamReader >> stream [
	^ stream
]

{ #category : #accessing }
XMLNestedStreamReader >> stream: aStream [
	"if the stream is not already a decoding adapter,
	then only assume it needs one if it's binary"
	aStream isConvertingStreamAdapter
		ifTrue: [stream := aStream]
		ifFalse: [stream := XMLDecodingReadStreamAdapter onStreamIfBinary: aStream]
]

{ #category : #accessing }
XMLNestedStreamReader >> upTo: aCharacter [
	| writeStream |

	writeStream := self newWriteStream.
	[self atEnd
		or: [self peek == aCharacter]]
		whileFalse: [writeStream nextPut: self next].
	^ writeStream contents.
]

{ #category : #accessing }
XMLNestedStreamReader >> upToEnd [
	| writeStream |

	writeStream := self newWriteStream.
	[self atEnd]
		whileFalse: [writeStream nextPut: self next].
	^ writeStream contents.
]

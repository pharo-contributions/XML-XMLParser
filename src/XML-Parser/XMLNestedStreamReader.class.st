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
		'isEscapingQuotes',
		'currentPosition',
		'currentLineStartPosition'
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

{ #category : #private }
XMLNestedStreamReader >> asEscapedCharacterIfQuote: aCharacter [
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
XMLNestedStreamReader >> atEnd [
	peekChar == nil
		ifFalse: [^ false].
	stream atEnd
		ifFalse: [^ false].
	"to:do: for speed"
	1 to: nestedStreams size do: [:i |
		(nestedStreams at: i) key atEnd
			ifFalse: [^ false]].
	^ true.
]

{ #category : #testing }
XMLNestedStreamReader >> atQuote [
	^ self peek == $"
		or: [peekChar == $']
]

{ #category : #private }
XMLNestedStreamReader >> basicNext [
	"Returns the next character in the stream for #next and #peek with CR/LF/CRLF
	line endings normalized (to LF by default) and quotes escaped when needed."
	| nextChar |

	stream atEnd
		ifTrue: [
			self popNestedStreamWhileAtEnd.
			stream atEnd
				ifTrue: [^ nil]].
	(nextChar := stream next) == LFCharacter
		ifTrue: [^ normalizedLineEndingChar].
	nextChar == CRCharacter
		ifTrue: [
			self popNestedStreamWhileAtEnd.
			stream atEnd
				ifFalse: [
					stream peek == LFCharacter
						ifTrue: [stream next]].
			^ normalizedLineEndingChar].
	isEscapingQuotes
		ifTrue: [^ self asEscapedCharacterIfQuote: nextChar].
	^ nextChar.
]

{ #category : #private }
XMLNestedStreamReader >> closeCurrentStream [
	(stream respondsTo: #close)
		ifTrue: [stream close].
	onClose ifNotNil: [onClose value].
]

{ #category : #closing }
XMLNestedStreamReader >> closeStreams [
	[nestedStreams size > 0]
		whileTrue: [self popNestedStream].
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
XMLNestedStreamReader >> currentColumnNumber [
	"recording the start pos. of the line and subtracting it from the current
	pos. is faster than an explicit column var that would need to be incremented
	each time through #next/#skipSeparators"
	^ currentPosition - currentLineStartPosition
]

{ #category : #accessing }
XMLNestedStreamReader >> currentLineNumber [
	^ currentLineNumber
]

{ #category : #accessing }
XMLNestedStreamReader >> currentPosition [
	^ currentPosition
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
	(XMLNestedStreamReaderEncodingDetector on: self)
		detectCurrentEncoding
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

{ #category : #testing }
XMLNestedStreamReader >> isBinary [
	^ false
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

	"this is inlined in skipSeparators"
	currentPosition := currentPosition + 1.
	readLimit ifNotNil: [
		currentPosition > readLimit
			ifTrue: [self errorReadLimitExceeded]].
	nextChar == normalizedLineEndingChar
		ifTrue: [
			currentLineNumber := currentLineNumber + 1.
			currentLineStartPosition := currentPosition].

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
	| nextChar oldCurrentLineNumber oldCurrentPosition oldCurrentLineStartPosition |

	aString size > 0
		ifFalse: [^ true].

	"inlined peek"
	(peekChar ifNil: [peekChar := self basicNext]) == (aString at: 1)
		ifFalse: [^ false].

	oldCurrentLineNumber := currentLineNumber.
	oldCurrentPosition := currentPosition.
	oldCurrentLineStartPosition := currentLineStartPosition.
	self next.
	"we unrolled the first iteration with the above inlined peek"
	2 to: aString size do: [:i |
		(nextChar := self peek) == (aString at: i)
			ifTrue: [self next]
			ifFalse: [
				self pushBack: (aString copyFrom: 1 to: i -1).
				currentLineNumber := oldCurrentLineNumber.
				currentPosition := oldCurrentPosition.
				currentLineStartPosition := oldCurrentLineStartPosition.
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
	[stream atEnd
		and: [nestedStreams size > 0]]
		whileTrue: [self popNestedStream]
]

{ #category : #printing }
XMLNestedStreamReader >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: peekChar;
		nextPutAll: '; ';
		print: stream;
		space;
		print: nestedStreams;
		nextPut: $).
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
	self
		pushBackStream: (XMLSingleCharacterReadStream on: aCharacter)
		onClose: nil
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBackStream: aStream [
	self
		pushBackStream: aStream
		onClose: nil
]

{ #category : #positioning }
XMLNestedStreamReader >> pushBackStream: aStream onClose: aBlock [
	(nestedStreams size >= self maxNestedStreams)
		ifTrue: [self errorNestingLimitExceeded].

	self
		pushNestedStream: stream
		onClose: onClose.
	peekChar
		ifNotNil: [
			self
				pushNestedStream: (XMLSingleCharacterReadStream on: peekChar)
				onClose: nil.
			peekChar := nil].

	self stream: aStream.
	onClose := aBlock.
]

{ #category : #private }
XMLNestedStreamReader >> pushNestedStream: aStream onClose: aBlock [
	nestedStreams size >= self maxNestedStreams
		ifTrue: [self errorNestingLimitExceeded].
	nestedStreams addLast: aStream -> aBlock.
]

{ #category : #accessing }
XMLNestedStreamReader >> readLimit [
	^ readLimit
]

{ #category : #initialization }
XMLNestedStreamReader >> setStream: aStream readLimit: aReadLimit [
	self stream: aStream.
	nestedStreams := OrderedCollection new: 5.
	currentLineNumber := 1.
	currentPosition := 0.
	currentLineStartPosition := 0.
	normalizedLineEndingChar := LFCharacter.
	readLimit := aReadLimit.
	isEscapingQuotes := false.
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
	"nil understands isXMLSeparator so the result of the inlined #peek
	does not need to be tested for nil first"
	[(peekChar ifNil: [peekChar := self basicNext]) "inlined #peek"
		isXMLSeparator]
		whileTrue: [
			"inlined from #next"
			currentPosition := currentPosition + 1.
			readLimit ifNotNil: [
				currentPosition > readLimit
					ifTrue: [self errorReadLimitExceeded]].
			peekChar == normalizedLineEndingChar
				ifTrue: [
					currentLineNumber := currentLineNumber + 1.
					currentLineStartPosition := currentPosition].

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
	| writeStream nextChar |

	writeStream := self newWriteStream.
	[self atEnd
		or: [(nextChar := self next) == aCharacter]]
		whileFalse: [writeStream nextPut: nextChar].
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

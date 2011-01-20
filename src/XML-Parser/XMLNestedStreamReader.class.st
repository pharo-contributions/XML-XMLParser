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
		'hasNestedStreams',
		'peekChar',
		'writeBuffer',
		'normalizedLineEndingChar',
		'currentLineNumber'
	],
	#classVars : [
		'CarriageReturn',
		'HexDigitCharacterMap',
		'LineFeed',
		'SeparatorCharacters'
	],
	#category : #'XML-Parser'
}

{ #category : #initialization }
XMLNestedStreamReader class >> initialize [
	"self initialize"

	SeparatorCharacters := CharacterSet newFrom: Character separators.

	CarriageReturn := Character cr.
	LineFeed := Character lf.

	HexDigitCharacterMap :=
		Dictionary newFrom:
			(($0 to: $9), ($a to: $f), ($A to: $F)
				collect: [:each | each -> each asUppercase digitValue]).
]

{ #category : #'instance creation' }
XMLNestedStreamReader class >> on: anInitialStream [
	^ self new stream: anInitialStream
]

{ #category : #testing }
XMLNestedStreamReader >> atEnd [
	^ peekChar isNil and: [hasNestedStreams not and: [stream atEnd]]
]

{ #category : #accessing }
XMLNestedStreamReader >> basicNext [
	"Returns next character in the stream after performing line-ending normalization.
	Normalization does not occur across nested streams."

	| nextChar |

	(nextChar := stream next)
		ifNil: [
			hasNestedStreams ifFalse: [^nil].
			self popCurrentStream.
			[hasNestedStreams and: [stream atEnd]]
				whileTrue: [self popCurrentStream].
			nextChar := stream next].

	nextChar == CarriageReturn
		ifTrue: [
			nextChar := normalizedLineEndingChar.
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

{ #category : #initialization }
XMLNestedStreamReader >> initialize [
	stream := nil.
	nestedStreams := nil.
	hasNestedStreams := false.
	peekChar := nil.
	writeBuffer := WriteStream on: (String new: 128).
	currentLineNumber := 1.
	normalizedLineEndingChar := LineFeed.
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

	^ nextChar.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextDecimalInteger [
	| digitChar |

	writeBuffer reset.
	[self atEnd not and: [(digitChar := self peek) isDigit]]
		whileTrue: [writeBuffer nextPut: self next].
	^ Integer readFrom: writeBuffer contents readStream.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextHexInteger [
	| value digitChar digitValue |

	value := HexDigitCharacterMap at: self peek ifAbsent: [^ 0].
	self next.
	[self atEnd not
		and: [HexDigitCharacterMap includesKey: (digitChar := self peek)]]
		whileTrue: [
			self next.
			value := (value * 16) + (HexDigitCharacterMap at: digitChar).
			value < SmallInteger maxVal
				ifFalse: [^ Smalltalk maxVal].].
	^ value.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextIntegerWithBase: aBase [
	aBase = 10
		ifTrue: [^ self nextDecimalInteger].
	aBase = 16
		ifTrue: [^ self nextHexInteger].

	self error: 'Only base 10 and 16 supported'.
]

{ #category : #testing }
XMLNestedStreamReader >> nextMatchAll: aString [
	| i nextChar pushBackString |

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

	pushBackString := aString copyFrom: 1 to: i - 1.
	self pushBack:
		(nextChar
			ifNotNil: [pushBackString copyWith: nextChar]
			ifNil: [pushBackString]).
	^ false.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextWhitespace [
	| nextChar |

	writeBuffer reset.
	[(nextChar := self peek) notNil
		and: [SeparatorCharacters includes: nextChar]]
		whileTrue: [writeBuffer nextPut: self next].
	^ writeBuffer stringContents.
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
	nestedStreams ifEmpty: [hasNestedStreams := false].
]

{ #category : #streaming }
XMLNestedStreamReader >> pushBack: aString [
	"Fixed to push the string before the peek char (if any)."
	| pushBackString |

	pushBackString := aString.
	peekChar
		ifNotNil: [
			pushBackString := pushBackString copyWith: peekChar.
			peekChar := nil].

	self pushStream: (ReadStream on: pushBackString).
]

{ #category : #streaming }
XMLNestedStreamReader >> pushStream: aStream [
	"Continue parsing from the new nested stream."
	peekChar ifNotNil: [self pushBack: ''].

	nestedStreams
		ifNil: [nestedStreams := OrderedCollection with: stream]
		ifNotNil: [nestedStreams addLast: stream].
	hasNestedStreams := true.

	self stream: aStream.
]

{ #category : #streaming }
XMLNestedStreamReader >> skipSeparators [
	| nextChar |

	[(nextChar := self peek) notNil
		and: [SeparatorCharacters includes: nextChar]]
		whileTrue: [self next].
]

{ #category : #streaming }
XMLNestedStreamReader >> skipUpTo: aDelimiter [
	| nextChar |

	[self atEnd or: [(nextChar := self next) == aDelimiter]] whileFalse.
	^ nextChar == aDelimiter.
]

{ #category : #accessing }
XMLNestedStreamReader >> stream [
	^ stream
]

{ #category : #accessing }
XMLNestedStreamReader >> stream: aNewStream [
	stream := XMLPeekableStreamAdapter on: aNewStream
]

{ #category : #streaming }
XMLNestedStreamReader >> upTo: aDelimiter [
	| nextChar |

	writeBuffer reset.
	[self atEnd or: [(nextChar := self next) == aDelimiter]]
		whileFalse: [writeBuffer nextPut: nextChar].

	^ writeBuffer stringContents.
]

{ #category : #streaming }
XMLNestedStreamReader >> upToAll: aDelimitingString [
	"Answer a subcollection from the current access position to the occurrence
	(if any, but not inclusive) of delimitingString. If delimitingString is not
	in the stream, answer the entire rest of the stream."

	writeBuffer reset.
	[self atEnd or: [self nextMatchAll: aDelimitingString]]
		whileFalse: [writeBuffer nextPut: self next].
	^ writeBuffer stringContents.
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

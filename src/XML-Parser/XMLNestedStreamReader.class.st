"
This class represents a stream reader that implements pushBack: using nested streams. This enables subsitution/replacement to be performed without modifying the underlying collections streamed-over or having to copy them. It also performs line-ending normalization, transforming CR and CRLF sequences into a single LF character.

Each nested stream is wrapped in some kind of XMLMinimalReadStream, which implements through forwarding the minimum stream protocol this class expects.

(The code in this class is optimized; refactor with care.)
"
Class {
	#name : #XMLNestedStreamReader,
	#superclass : #Object,
	#instVars : [
		'stream',
		'nestedStreams',
		'buffer',
		'peekChar',
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
		XMLCharacterMap newFrom:
			(($0 to: $9), ($a to: $f), ($A to: $F)
				collect: [:each | each -> each asUppercase digitValue]).
]

{ #category : #'instance creation' }
XMLNestedStreamReader class >> on: anInitialStream [
	^ self new stream: anInitialStream
]

{ #category : #testing }
XMLNestedStreamReader >> atEnd [
	^ peekChar isNil and: [stream atEnd and: [nestedStreams isNil]]
]

{ #category : #accessing }
XMLNestedStreamReader >> basicNext [
	"Returns next character in the stream after performing line-ending normalization.
	Normalization does not occur across nested streams."

	| nextChar |

	(nextChar := stream next) == CarriageReturn
		ifTrue: [
			nextChar := normalizedLineEndingChar.
			currentLineNumber := currentLineNumber + 1.
			(stream peek == LineFeed)
				ifTrue: [stream next]]
		ifFalse: [
			(nextChar == LineFeed)
				ifTrue: [
					nextChar := normalizedLineEndingChar.
					currentLineNumber := currentLineNumber + 1]].

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
	peekChar := nil.
	buffer := WriteStream on: (String new: 128).
	currentLineNumber := 1.
	normalizedLineEndingChar := LineFeed.
]

{ #category : #accessing }
XMLNestedStreamReader >> next [
	"Return the next character from the current input stream. If the current
	stream is at end, pop to the next nesting level if there is one."

	| nextChar |

	peekChar
		ifNil: [
			stream atEnd
				ifTrue: [
					nestedStreams ifNil: [^nil].
					self popCurrentStream.
					[stream atEnd and: [nestedStreams notNil]]
						whileTrue: [self popCurrentStream].
					stream atEnd
						ifTrue: [^ nil]].
			^ self basicNext]
		ifNotNil: [
			nextChar := peekChar.
			peekChar := nil.
			^ nextChar].
]

{ #category : #accessing }
XMLNestedStreamReader >> nextDecimalInteger [
	| digitChar |

	buffer reset.
	[self atEnd not and: [(digitChar := self peek) isDigit]]
		whileTrue: [buffer nextPut: self next].
	^ Integer readFrom: buffer contents readStream.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextHexInteger [
	| maxBaseValue value digitChar |

	maxBaseValue := SmallInteger maxVal / 16.
	value := HexDigitCharacterMap at: self peek ifAbsent: [^ 0].
	self next.
	[self atEnd not
		and: [HexDigitCharacterMap includesKey: (digitChar := self peek)]]
		whileTrue: [| baseValue digitValue |
			self next.

			value <= maxBaseValue
				ifFalse: [^ value].
			baseValue := value * 16.

			digitValue := HexDigitCharacterMap at: digitChar.
			((SmallInteger maxVal - digitValue) > baseValue)
				ifFalse: [^ value].
			value := baseValue + digitValue].
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
	| i oldStream oldPosition oldPeekChar nextChar pushBackString |

	(oldPeekChar := self peek) == (aString at: 1)
		ifFalse: [^ false].
	oldPosition := (oldStream := stream) position.
	i := 1.
	[(i <= aString size)
		and: [(aString at: i) == (nextChar := self next)]]
		whileTrue: [i := i + 1].
	(i > aString size)
		ifTrue: [^ true].

	stream == oldStream
		ifTrue: [
			peekChar := oldPeekChar.
			stream position: oldPosition]
		ifFalse:[
			pushBackString := aString copyFrom: 1 to: i - 1.
			self pushBack:
				(nextChar
					ifNotNil: [pushBackString copyWith: nextChar]
					ifNil: [pushBackString])].
	^ false.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextWhitespace [
	| nextChar |

	buffer reset.
	[(nextChar := self peek) notNil
		and: [SeparatorCharacters includes: nextChar]]
		whileTrue: [buffer nextPut: self next].
	^ buffer stringContents.
]

{ #category : #accessing }
XMLNestedStreamReader >> peek [
	"Return the next character from the current input stream."

	^ peekChar
		ifNil: [
			stream atEnd
				ifTrue: [
					nestedStreams ifNil: [^nil].
					self popCurrentStream.
					[stream atEnd and: [nestedStreams notNil]]
						whileTrue: [self popCurrentStream].
					stream atEnd
						ifTrue: [^ nil]].
			peekChar := self basicNext]
]

{ #category : #private }
XMLNestedStreamReader >> popCurrentStream [
	stream close.
	stream := nestedStreams removeLast.
	nestedStreams ifEmpty: [nestedStreams := nil].
]

{ #category : #streaming }
XMLNestedStreamReader >> pushBack: aString [
	"Fixed to push the string before the peek char (if any)."
	| pushBackString |

	pushBackString :=
		peekChar
			ifNil: [aString]
			ifNotNil: [aString copyWith: peekChar].
	peekChar := nil.
	self pushStream: (ReadStream on: aString)
]

{ #category : #streaming }
XMLNestedStreamReader >> pushStream: aStream [
	"Continue parsing from the new nested stream."
	self unpeek.

	nestedStreams
		ifNil: [nestedStreams := OrderedCollection with: stream]
		ifNotNil: [nestedStreams addLast: stream].

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
	stream := aNewStream
]

{ #category : #streaming }
XMLNestedStreamReader >> streamEncoding: aCharacterEncodingName [
	| converterClass textConverterBase |

	(stream respondsTo: #converter) ifFalse: [^ self].
	textConverterBase := Smalltalk at: #TextConverter ifAbsent: [^ self].
	converterClass :=
		textConverterBase defaultConverterClassForEncoding:
			aCharacterEncodingName asLowercase.
	converterClass
		ifNotNil: [stream converter: converterClass new].
]

{ #category : #streaming }
XMLNestedStreamReader >> unpeek [
	"Fixed to use nested stream since multi-byte streams
	do not properly override pushBack: to deal with multi-byte
	characters."
	
	peekChar ifNotNil: [self pushBack: '']
]

{ #category : #streaming }
XMLNestedStreamReader >> upTo: aDelimiter [
	| nextChar |

	buffer reset.
	[self atEnd or: [(nextChar := self next) == aDelimiter]]
		whileFalse: [buffer nextPut: nextChar].

	^ buffer stringContents.
]

{ #category : #streaming }
XMLNestedStreamReader >> upToAll: aDelimitingString [
	"Answer a subcollection from the current access position to the occurrence
	(if any, but not inclusive) of delimitingString. If delimitingString is not
	in the stream, answer the entire rest of the stream."

	buffer reset.
	[self atEnd or: [self nextMatchAll: aDelimitingString]]
		whileFalse: [buffer nextPut: self next].
	^ buffer stringContents.
]

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

{ #category : #'class initialization' }
XMLNestedStreamReader class >> initialize [
	"self initialize"

	super initialize.

	SeparatorCharacters := CharacterSet newFrom: Character separators.
	CarriageReturn := Character cr.
	LineFeed := Character lf.

	HexDigitCharacterMap := Dictionary new.
	($0 to: $9) do: [:each | HexDigitCharacterMap at: each put: each asciiValue - $0 asciiValue].
	($a to: $f) do: [:each | | digitValue |
		digitValue := each asciiValue - $a asciiValue + 10.
		HexDigitCharacterMap
			at: each put: digitValue;
			at: each asUppercase put: digitValue].
]

{ #category : #'instance creation' }
XMLNestedStreamReader class >> on: anInitialStream onClose: aBlock [
	^ self new
		setStream: anInitialStream
		onClose: aBlock
]

{ #category : #testing }
XMLNestedStreamReader >> atEnd [
	^ peekChar isNil and: [hasNestedStreams not and: [stream atEnd]]
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
			[hasNestedStreams and: [stream atEnd]]
				whileTrue: [self popCurrentStream].
			nextChar := stream next].

	nextChar == CarriageReturn
		ifTrue: [
			nextChar := normalizedLineEndingChar.
			[hasNestedStreams and: [stream atEnd]]
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

{ #category : #initialization }
XMLNestedStreamReader >> initialize [
	super initialize.

	stream := nil.
	nestedStreams := nil.
	hasNestedStreams := false.
	peekChar := nil.
	writeBuffer := WriteStream on: (String new: 128).
	currentLineNumber := 1.
	normalizedLineEndingChar := LineFeed.
]

{ #category : #private }
XMLNestedStreamReader >> maxIntegerValue [
	"SmallInteger maxValue"
	^ 1073741823
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

	^ nextChar.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextDigitWithBase: aBase [
	| digit |

	aBase = 16
		ifTrue: [digit := HexDigitCharacterMap at: self peek ifAbsent: [nil]]
		ifFalse: [
			digit := self peek asciiValue - $0 asciiValue.
			(digit >= 0 and: [digit <= 10])
				ifFalse: [digit := nil]].
	digit ifNotNil: [self next].

	^ digit.
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

	^ self nextIntegerWithBase: base.
]

{ #category : #accessing }
XMLNestedStreamReader >> nextIntegerWithBase: aBase [
	| integer maxValue maxBaseValue digitValue |

	integer := 0.
	maxValue := self maxIntegerValue.
	maxBaseValue := (maxValue / aBase) asInteger.
	[self atEnd not
		and: [(digitValue := self nextDigitWithBase: aBase) notNil]]
		whileTrue: [
			integer > maxBaseValue
				ifTrue: [^ integer].
			integer := integer * aBase.

			integer > (maxValue - digitValue)
				ifTrue: [^ integer].
			integer := integer + digitValue].
	^ integer.
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
	nestedStreams ifEmpty: [hasNestedStreams := false].
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
				ifTrue: [XMLParserException signal: 'cannot further nest input streams'].
			nestedStreams addLast: stream].
	hasNestedStreams := true.

	self setStream: aStream onClose: aBlock
]

{ #category : #accessing }
XMLNestedStreamReader >> setStream: aNewStream onClose: aBlock [
	stream :=
		XMLPeekableStreamAdapter
			on: aNewStream
			onClose: aBlock
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
	[self atEnd] whileFalse: [self next == aDelimiter ifTrue: [^ true]].
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

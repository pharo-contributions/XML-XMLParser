"
This class represents a stream reader that implements pushBack: using nested streams. This enables subsitution/replacement to be performed without modifying the underlying collections streamed-over or copying them. It also performs line-ending normalization, returning CR and CRLF sequences read from the input stream as a single LF character.

(The code in this class looks the way it does for performance reasons.)
"
Class {
	#name : #XMLStreamReader,
	#superclass : #Object,
	#instVars : [
		'stream',
		'nestedStreams',
		'peekChar',
		'buffer'
	],
	#classVars : [
		'CarriageReturn',
		'DigitTable',
		'LineFeed',
		'SeparatorTable'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #initialization }
XMLStreamReader class >> initialize [
	"XMLStreamReader initialize"

	SeparatorTable  := CharacterSet new.
	#(9 10 12 13 32) do: [:each | SeparatorTable add: each asCharacter].

	DigitTable := Array new: 256.
	DigitTable atAllPut: -1.
	($0 to: $9) do: [:each | DigitTable at: each asciiValue put: each digitValue].
	($a to: $f) do: [:each | DigitTable at: each asciiValue put: each digitValue].
	($A to: $F) do: [:each | DigitTable at: each asciiValue put: each digitValue].

	CarriageReturn := Character cr.
	LineFeed := Character lf.
]

{ #category : #'instance creation' }
XMLStreamReader class >> on: anInitialStream [
	^ self new stream: anInitialStream
]

{ #category : #testing }
XMLStreamReader >> atEnd [
	^ self peek isNil
]

{ #category : #accessing }
XMLStreamReader >> basicNext [
	"Returns next character in the stream after performing line-endings normalization.
	Normalization does not occur across nested streams."
	| nextChar |
	
	stream atEnd ifTrue: [ ^ nil ].
	((nextChar := stream next) == CarriageReturn)
		ifTrue: [
			nextChar := LineFeed.
			(stream peek == LineFeed)
				ifTrue: [stream next]].
	^ nextChar.
]

{ #category : #streaming }
XMLStreamReader >> checkNestedStream [
	nestedStreams ifNotNil: [
		(peekChar isNil and: [stream atEnd])
			ifTrue: [
				self popNestingLevel.
				self checkNestedStream]]
]

{ #category : #initialization }
XMLStreamReader >> initialize [
	stream := nil.
	nestedStreams := nil.
	peekChar := nil.
	buffer := WriteStream on: (String new: 128).
]

{ #category : #private }
XMLStreamReader >> nestedStreams [
	^ nestedStreams ifNil: [nestedStreams := OrderedCollection new]
]

{ #category : #accessing }
XMLStreamReader >> next [
	"Return the next character from the current input stream. If the current
	stream is at end, pop to the next nesting level if there is one.

	Due to the potential nesting of original document, included documents
	and replacment texts the streams are held in a stack representing the
	nested streams. The current stream is the top one."
	| nextChar |

	peekChar
		ifNil: [
			nestedStreams ifNotNil: [self checkNestedStream].
			^ self basicNext]
		ifNotNil: [
			nextChar := peekChar.
			peekChar := nil.
			^ nextChar].
]

{ #category : #testing }
XMLStreamReader >> nextMatchAll: aString [
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

{ #category : #tokenizing }
XMLStreamReader >> nextWhitespace [
	| nextChar |

	buffer reset.
	[(nextChar := self peek) notNil
		and: [SeparatorTable includes: nextChar]]
		whileTrue: [buffer nextPut: self next].
	^ buffer stringContents.
]

{ #category : #accessing }
XMLStreamReader >> peek [
	"Return the next character from the current input stream.

	Due to the potential nesting of original document, included
	documents and replacment texts the streams are held in a stack
	representing the nested streams. The current stream is the top one."

	^ peekChar
		ifNil: [
			nestedStreams ifNotNil: [self checkNestedStream].
			peekChar := self basicNext]
]

{ #category : #streaming }
XMLStreamReader >> popNestingLevel [
	nestedStreams ifNotNil: [
		self stream close.
		self stream: self nestedStreams removeLast.
		self nestedStreams ifEmpty: [nestedStreams := nil]]
]

{ #category : #streaming }
XMLStreamReader >> pushBack: aString [
	"Fixed to push the string before the peek char (if any)."
	| pushBackString |

	pushBackString := peekChar
		ifNil: [aString]
		ifNotNil: [aString copyWith: peekChar].
	peekChar := nil.
	self pushStream: (ReadStream on: pushBackString).
]

{ #category : #streaming }
XMLStreamReader >> pushStream: aStream [
	"Continue parsing from the new nested stream."
	self unpeek.
	self nestedStreams addLast: self stream.
	self stream: aStream.
]

{ #category : #private }
XMLStreamReader >> readNumberBase: base [
	"Read a hex number from stream until encountering $; "

	| value digit |

	base = 10
		ifFalse: [ | numberString | 
			numberString := self upTo: $;.
			stream skip: -1.
			^ Integer readFrom: numberString asUppercase readStream base: base].

	value := 0.
	digit := DigitTable at: self peek asciiValue.
	digit < 0
		ifTrue: [^ nil].
	self next.
	value := digit.
	[digit := DigitTable at: self peek asciiValue.
	digit < 0
		ifTrue: [^value]
		ifFalse: [
			self next.
			value := value * base + digit]
		] repeat.
	^ value
]

{ #category : #streaming }
XMLStreamReader >> skipSeparators [
	| nextChar |

	[(nextChar := self peek) notNil
		and: [SeparatorTable includes: nextChar]]
		whileTrue: [self next].
]

{ #category : #streaming }
XMLStreamReader >> skipUpTo: delimiter [
	| nextChar |

	[self atEnd or: [(nextChar := self next) == delimiter]] whileFalse.
	^ nextChar == delimiter.
]

{ #category : #accessing }
XMLStreamReader >> stream [
	^ stream
]

{ #category : #accessing }
XMLStreamReader >> stream: aNewStream [
	"Continue parsing from the new nested stream."
	stream := aNewStream
]

{ #category : #streaming }
XMLStreamReader >> streamEncoding: encodingString [

	| converterClass |
	Smalltalk at: #TextConverter ifPresent: [:tc | 
		(stream respondsTo: #converter:) ifTrue: [
			converterClass := tc defaultConverterClassForEncoding: encodingString asLowercase.
			converterClass ifNotNil: [stream converter: converterClass new]]].
]

{ #category : #streaming }
XMLStreamReader >> topStream [
	^ nestedStreams
		ifNil: [self stream]
		ifNotNil: [self nestedStreams first]
]

{ #category : #streaming }
XMLStreamReader >> unpeek [
	"Fixed to use nested stream since multi-byte streams
	do not properly override pushBack: to deal with multi-byte
	characters."
	
	peekChar ifNotNil: [self pushBack: '']
]

{ #category : #streaming }
XMLStreamReader >> upTo: aDelimiter [
	| nextChar |

	buffer reset.
	[self atEnd or: [(nextChar := self next) == aDelimiter]]
		whileFalse: [buffer nextPut: nextChar].

	^ nextChar == aDelimiter
		ifTrue: [buffer stringContents]
		ifFalse: [nil].
]

{ #category : #streaming }
XMLStreamReader >> upToAll: aDelimitingString [
	"Answer a subcollection from the current access position to the occurrence
	(if any, but not inclusive) of delimitingString. If delimitingString is not
	in the stream, answer the entire rest of the stream."

	buffer reset.
	[self atEnd or: [self nextMatchAll: aDelimitingString]]
		whileFalse: [buffer nextPut: self next].
	^ buffer stringContents.
]

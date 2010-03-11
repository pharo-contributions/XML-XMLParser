Class {
	#name : #XMLStreamReader,
	#superclass : #Object,
	#instVars : [
		'stream',
		'nestedStreams',
		'peekChar'
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
	nestedStreams == nil
		ifTrue: [^ peekChar == nil and: [stream atEnd]].
	^ stream atEnd
		ifTrue: [
			self popNestingLevel.
			self atEnd]
		ifFalse: [false]
]

{ #category : #accessing }
XMLStreamReader >> basicNext [
	"Returns next character in the stream after performing line endings normalization"
	| char |
	
	((char := stream next) == CarriageReturn)
		ifTrue: [
			char := LineFeed.
			(stream peek == LineFeed)
				ifTrue: [stream next]].
	^ char.
]

{ #category : #streaming }
XMLStreamReader >> checkNestedStream [
	nestedStreams == nil
		ifFalse: [(peekChar == nil and: [self stream atEnd])
			ifTrue: [
				self popNestingLevel.
				self checkNestedStream]]
]

{ #category : #testing }
XMLStreamReader >> hasNestedStreams [
	^nestedStreams notNil
]

{ #category : #streaming }
XMLStreamReader >> match: subCollection into: resultStream [
	"Set the access position of the receiver to be past the next occurrence
	of the subCollection.
	
	Answer whether subCollection is found.  No wildcards, and case does matter."

	| pattern startMatch |
	pattern _ ReadStream on: subCollection.
	startMatch _ nil.
	[pattern atEnd] whileFalse: 
		[self atEnd ifTrue: [^ false].
		(self next) = (pattern next) 
			ifTrue: [pattern position = 1 ifTrue: [startMatch _ self position]]
			ifFalse: [pattern position: 0.
					startMatch ifNotNil: [
						self position: startMatch.
						startMatch _ nil]]].
	^ true.
]

{ #category : #private }
XMLStreamReader >> nestedStreams [
	nestedStreams ifNil: [nestedStreams := OrderedCollection new].
	^nestedStreams
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

{ #category : #reading }
XMLStreamReader >> next: size [
	| buffer i |

	"Faster than creating a WriteStream and sending it #contents when finished"
	buffer := String new: size.
	i := 1.
	[i <= size and: [self atEnd not]]
		whileTrue: [buffer at: i put: self next. i := i + 1].
	^ buffer copyFrom: 1 to: i - 1.
]

{ #category : #streaming }
XMLStreamReader >> nextTrimmedBlanksUpTo: delimiter [
	| resultStream nextChar |
	resultStream := WriteStream on: (String new: 10).
	nextChar := nil.
	[(nextChar := self next) == delimiter]
		whileFalse: [
			nextChar == $  ifFalse: [
				resultStream nextPut: nextChar]].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found'].
	^resultStream contents.
]

{ #category : #streaming }
XMLStreamReader >> nextUpTo: delimiter [
	| resultStream nextChar |
	resultStream := WriteStream on: (String new: 10).
	[self atEnd or: [(nextChar := self next) == delimiter]]
		whileFalse: [resultStream nextPut: nextChar].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found'].
	^resultStream contents.
]

{ #category : #streaming }
XMLStreamReader >> nextUpToAll: delimitingString [
	| string |
	self unpeek.
	string := self upToAll: delimitingString.
	string
		ifNil: [self parseError: 'XML no delimiting ' , delimitingString printString , ' found'].
	^string.
]

{ #category : #tokenizing }
XMLStreamReader >> nextWhitespace [
	| nextChar resultStream resultString|
	resultStream := (String new: 10) writeStream.
	[((nextChar := self peek) ~~ nil)
		and: [SeparatorTable includes: nextChar]]
		whileTrue: [
			resultStream nextPut: nextChar.
			self next.
			(nestedStreams == nil or: [self atEnd not])
				ifFalse: [self checkNestedStream]].
	^ resultStream contents.
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
	self hasNestedStreams
		ifTrue: [
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
		ifNotNil: [aString, peekChar asString].
	peekChar := nil.
	self pushStream: (ReadStream on: pushBackString).
]

{ #category : #streaming }
XMLStreamReader >> pushStream: newStream [
	"Continue parsing from the new nested stream."
	self unpeek.
	self nestedStreams addLast: self stream.
	self stream: newStream.
]

{ #category : #private }
XMLStreamReader >> readNumberBase: base [
	"Read a hex number from stream until encountering $; "

	| value digit |

	base = 10 ifFalse: [	| numberString | 
		numberString := self nextUpTo: $;.
		stream skip: -1.
		^Integer readFrom: numberString asUppercase readStream base: base. 
	].

	value := 0.
	digit := DigitTable at: self peek asciiValue.
	digit < 0
		ifTrue: [self errorExpected: 'At least one digit expected here'].
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
	[((nextChar := self peek) ~~ nil)
		and: [SeparatorTable includes: nextChar]]
		whileTrue: [self next].
	(nestedStreams == nil or: [self atEnd not])
		ifFalse: [
			self checkNestedStream.
			self skipSeparators].
]

{ #category : #streaming }
XMLStreamReader >> skipUpTo: delimiter [
	| nextChar |
	self unpeek.
	[self atEnd or: [(nextChar := self next) == delimiter]]
		whileFalse: [].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found'].
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
XMLStreamReader >> stream: aStream upToAll: aCollection [
	"Answer a subcollection from the current access position to the occurrence (not inclusive) of aCollection. If aCollection is not in the stream, answer nil."

	| startPos endMatch result |
	startPos := aStream position.
	(aStream  match: aCollection) 
		ifTrue: [endMatch := aStream position.
			aStream position: startPos.
			result := aStream next: endMatch - startPos - aCollection size.
			aStream position: endMatch.
			^ result]
		ifFalse: [
			aStream position: startPos.
			^nil].
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
	^self hasNestedStreams
		ifTrue: [self nestedStreams first]
		ifFalse: [self stream]
]

{ #category : #streaming }
XMLStreamReader >> unpeek [
	"Fixed to use nested stream since multi-byte streams
	do not properly override pushBack: to deal with multi-byte
	characters."
	
	peekChar ifNotNil: [self pushBack: '']
]

{ #category : #streaming }
XMLStreamReader >> upToAll: delimitingString [
	"Answer a subcollection from the current access position to the occurrence
	(if any, but not inclusive) of delimitingString. If delimitingString is not
	in the stream, answer the entire rest of the stream."

	| result |

	self hasNestedStreams
		ifFalse: [
			result := self stream: self stream upToAll: delimitingString.
			result
				ifNil: [self parseError: 'XML no delimiting ' , delimitingString printString , ' found'].
			^result].

	result := self stream: self stream upToAll: delimitingString.
	result
		ifNotNil: [^result].
	result := String streamContents: [:resultStream |
		resultStream nextPutAll: self stream upToEnd.
		self atEnd
			ifTrue: [self parseError: 'XML no delimiting ' , delimitingString printString , ' found'].
		self stream position timesRepeat: [
			self atEnd
				ifFalse: [
					resultStream nextPut: self next]]].
	self pushBack: result.
	^self upToAll: delimitingString.
]

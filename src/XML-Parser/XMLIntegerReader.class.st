"
This class reads positive hex or decimal integers up to the maximum a SmallInteger can hold from minimal streams supporting next, peek, and atEnd. It returns nil instead of raising errors for invalid integers.
"
Class {
	#name : #XMLIntegerReader,
	#superclass : #Object,
	#instVars : [
		'readStream',
		'printStream'
	],
	#classVars : [
		'CharacterDigitValues',
		'MaxIntegerValue'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #'class initialization' }
XMLIntegerReader class >> initialize [
	"self initialize"

	self
		initializeMaxIntegerValue;
		initializeCharacterDigitValues
]

{ #category : #'class initialization' }
XMLIntegerReader class >> initializeCharacterDigitValues [
	"array instead of dictionary for speed"
	CharacterDigitValues := Array new: 255.
	#(#($0 $9 0) #($a $f 10) #($A $Z 10)) do: [:each |
		each first asciiValue
			to: each second asciiValue
			do: [:i |
				CharacterDigitValues
					at: i
					put: i - each first asciiValue + each last]].
]

{ #category : #'class initialization' }
XMLIntegerReader class >> initializeMaxIntegerValue [
	MaxIntegerValue := SmallInteger maxVal
]

{ #category : #private }
XMLIntegerReader class >> maxBase [
	^ 16
]

{ #category : #private }
XMLIntegerReader class >> maxIntegerValue [
	^ MaxIntegerValue
]

{ #category : #'instance creation' }
XMLIntegerReader class >> on: aStringOrStream [
	^ self new on: aStringOrStream
]

{ #category : #'instance creation' }
XMLIntegerReader class >> readFrom: aStream [
	^ (self on: aStream) nextInteger
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aBase [
	^ (self on: aStream) nextIntegerWithBase: aBase
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aFirstBase startingWithAny: aCharacterCollection orBase: aSecondBase [
	^ (self on: aStream)
		nextIntegerWithBase: aFirstBase
		startingWithAny: aCharacterCollection
		orBase: aSecondBase
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aBase upTo: anInteger [
	^ (self on: aStream)
		nextIntegerWithBase: aBase
		upTo: anInteger
]

{ #category : #testing }
XMLIntegerReader >> atEnd [
	^ readStream atEnd
]

{ #category : #private }
XMLIntegerReader >> next [
	| nextChar |

	self atEnd
		ifFalse: [
			nextChar := readStream next.
			printStream
				ifNotNil: [printStream nextPut: nextChar]].
	^ nextChar.
]

{ #category : #private }
XMLIntegerReader >> nextDigitWithBase: aBase [
	| asciiValue digit |

	((asciiValue := self peek asciiValue) > 0
		and: [asciiValue <= CharacterDigitValues size
			and: [(digit := CharacterDigitValues at: asciiValue) notNil
				and: [digit < aBase]]])
				ifTrue: [
					self next.
					^ digit]
				ifFalse: [^ nil]
]

{ #category : #reading }
XMLIntegerReader >> nextInteger [
	^ self nextIntegerWithBase: 10
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aBase [
	^ self nextIntegerWithBase: aBase upTo: nil
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aFirstBase startingWithAny: aCharacterCollection orBase: aSecondBase [
	(aCharacterCollection includes: self peek)
		ifTrue: [
			self next.
			^ self nextIntegerWithBase: aFirstBase]
		ifFalse: [^ self nextIntegerWithBase: aSecondBase]
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aBase upTo: aReadLimit [
	| integer maxValue maxBaseValue digitValue readLimit |

	(aBase > 1 and: [aBase <= self class maxBase])
		ifFalse: [Error signal: 'Unsupported base ', aBase printString].

	maxValue := self class maxIntegerValue.
	maxBaseValue := (maxValue / aBase) floor.
	readLimit := aReadLimit.
	[self atEnd
		or: [(readLimit notNil and: [readLimit <= 0])
			or: [(digitValue := self nextDigitWithBase: aBase) isNil]]]
		whileFalse: [
			integer
				ifNil: [integer := 0].
	
			integer > maxBaseValue
				ifTrue: [^ maxValue].
			integer := integer * aBase.

			integer > (maxValue - digitValue)
				ifTrue: [^ maxValue].
			integer := integer + digitValue.
			readLimit
				ifNotNil: [readLimit := readLimit - 1]].
	^ integer.
]

{ #category : #initialization }
XMLIntegerReader >> on: aStringOrStream [
	readStream :=
		aStringOrStream isStream
			ifTrue: [aStringOrStream]
			ifFalse: [aStringOrStream readStream]
]

{ #category : #private }
XMLIntegerReader >> peek [
	self atEnd
		ifTrue: [^ nil]
		ifFalse: [^ readStream peek]
]

{ #category : #accessing }
XMLIntegerReader >> printStream: aStream [
	printStream := aStream
]

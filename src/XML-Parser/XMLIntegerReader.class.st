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
	| temp |

	"use an array instead of a dictionary for speed, and use a temp
	to fully initialize it before assignment to avoid possible race
	conditions during class reinitialization"
	temp := Array new: 255.
	#(#($0 $9 0) #($a $f 10) #($A $Z 10)) do: [:each |
		| firstDigitValue lastDigitValue baseValue |
		firstDigitValue := each first asciiValue.
		lastDigitValue := each second asciiValue.
		baseValue := each third.
		firstDigitValue
			to: lastDigitValue
			do: [:i |
				temp
					at: i
					put: i - firstDigitValue + baseValue]].
	CharacterDigitValues := temp.
]

{ #category : #'class initialization' }
XMLIntegerReader class >> initializeMaxIntegerValue [
	"'SmallInteger maxVal' is large enough for char codes and port numbers"
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
XMLIntegerReader class >> readFrom: aStream withBase: aFirstBase andPrefixes: aCharacterCollection orBase: aSecondBase [
	^ (self on: aStream)
		nextIntegerWithBase: aFirstBase
		andPrefixes: aCharacterCollection
		orBase: aSecondBase
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aFirstBase andPrefixes: aCharacterCollection orBase: aSecondBase upTo: aReadLimit [
	^ (self on: aStream)
		nextIntegerWithBase: aFirstBase
		andPrefixes: aCharacterCollection
		orBase: aSecondBase
		upTo: aReadLimit
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aBase upTo: aReadLimit [
	^ (self on: aStream)
		nextIntegerWithBase: aBase
		upTo: aReadLimit
]

{ #category : #testing }
XMLIntegerReader >> atEnd [
	^ readStream atEnd
]

{ #category : #private }
XMLIntegerReader >> errorUnsupportedBase: aBase [
	Error signal: 'Unsupported base ', aBase printString
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
	^ self
		nextIntegerWithBase: aBase
		upTo: nil
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aFirstBase andPrefixes: aCharacterCollection orBase: aSecondBase [
	^ self
		nextIntegerWithBase: aFirstBase
		andPrefixes: aCharacterCollection
		orBase: aSecondBase
		upTo: nil
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aFirstBase andPrefixes: aCharacterCollection orBase: aSecondBase upTo: aReadLimit [
	^ self
		nextIntegerWithBase:
			((self atEnd not
				and: [aCharacterCollection includes: self peek])
				ifTrue: [
					self next.
					aFirstBase]
				ifFalse: [aSecondBase])
		upTo: aReadLimit
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aBase upTo: aReadLimit [
	| integer maxValue maxBaseValue digitValue readLimit |

	(aBase > 1
		and: [aBase <= self class maxBase])
		ifFalse: [self errorUnsupportedBase: aBase].

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

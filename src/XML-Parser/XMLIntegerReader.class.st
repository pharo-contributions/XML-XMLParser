"
This class reads hex or decimal integers from a minimal stream supporting next, peek, and atEnd.
"
Class {
	#name : #XMLIntegerReader,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#classVars : [
		'CharacterDigitValues'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'class initialization' }
XMLIntegerReader class >> initialize [
	"self initialize"

	super initialize.

	"array instead of dictionary for speed"
	CharacterDigitValues := Array new: 256 withAll: -1.
	($0 to: $9) do: [:each |
		CharacterDigitValues
			at: each asciiValue
			put: each asciiValue - $0 asciiValue].
	($A to: $F) do: [:each |
		CharacterDigitValues
			at: each asciiValue
			put: each asciiValue - $A asciiValue + 10].
	($a to: $f) do: [:each |
		CharacterDigitValues
			at: each asciiValue
			put: each asciiValue - $a asciiValue + 10].
]

{ #category : #private }
XMLIntegerReader class >> maxBase [
	^ 16
]

{ #category : #private }
XMLIntegerReader class >> maxIntegerValue [
	"SmallInteger maxVal"
	^ 1073741823
]

{ #category : #'instance creation' }
XMLIntegerReader class >> on: aStream [
	^ self new stream: aStream
]

{ #category : #'instance creation' }
XMLIntegerReader class >> readFrom: aStream [
	^ self readFrom: aStream withBase: 10
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aBase [
	^ self
		readFrom: aStream
		withBase: aBase
		upTo: nil
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aFirstBase startingWithAny: aCharacterCollection orBase: aSecondBase [
	^ (aCharacterCollection anySatisfy: [:each | aStream peek == each])
		ifTrue: [
			aStream next.
			self readFrom: aStream withBase: aFirstBase]
		ifFalse: [self readFrom: aStream withBase: aSecondBase]
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aBase upTo: anInteger [
	^ (self on: aStream)
		nextIntegerWithBase: aBase
		upTo: anInteger
]

{ #category : #private }
XMLIntegerReader >> nextDigitWithBase: aBase [
	| digit |
	
	digit :=
		CharacterDigitValues
			at: stream peek asciiValue
			ifAbsent: [^ nil].
	(digit >= 0 and: [digit < aBase])
		ifFalse: [^ nil].
	stream next.
	^ digit.
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aBase upTo: aReadLimit [
	| integer maxValue maxBaseValue digitValue readLimit |

	(aBase > 1 and: [aBase <= self class maxBase])
		ifFalse: [Error signal: 'Unsupported base ', aBase printString].

	maxValue := self class maxIntegerValue.
	maxBaseValue := (maxValue / aBase) asInteger.
	readLimit := aReadLimit.
	[stream atEnd
		or: [(readLimit notNil and: [readLimit <= 0])
			or: [(digitValue := self nextDigitWithBase: aBase) isNil]]]
		whileFalse: [
			integer ifNil: [integer := 0].
	
			integer > maxBaseValue
				ifTrue: [^ maxValue].
			integer := integer * aBase.

			integer > (maxValue - digitValue)
				ifTrue: [^ maxValue].
			integer := integer + digitValue.
			readLimit ifNotNil: [readLimit := readLimit - 1]].
	^ integer.
]

{ #category : #reading }
XMLIntegerReader >> stream: aStream [
	stream := aStream
]

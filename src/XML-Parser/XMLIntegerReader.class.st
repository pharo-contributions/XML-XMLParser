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
		'HexDigitCharacterMap'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'class initialization' }
XMLIntegerReader class >> initialize [
	"self initialize"

	super initialize.
	HexDigitCharacterMap := Dictionary new.
	($0 to: $9) do: [:each |
		HexDigitCharacterMap
			at: each
			put: each asciiValue - $0 asciiValue].
	($a to: $f) do: [:each |
		HexDigitCharacterMap
			at: each
			put: each asciiValue - $a asciiValue + 10.
		HexDigitCharacterMap
			at: each asUppercase
			put: (HexDigitCharacterMap at:each)].
]

{ #category : #'instance creation' }
XMLIntegerReader class >> on: aStream [
	^ self new stream: aStream
]

{ #category : #'instance creation' }
XMLIntegerReader class >> readFrom: aStream [
	^ (aStream atEnd not
		and: [aStream peek == $x])
		ifTrue: [
			aStream next.
			self readFrom: aStream withBase: 16]
		ifFalse: [self readFrom: aStream withBase: 10]
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aBase [
	^ self
		readFrom: aStream
		withBase: aBase
		upTo: nil
]

{ #category : #reading }
XMLIntegerReader class >> readFrom: aStream withBase: aBase upTo: anInteger [
	^ (self on: aStream)
		nextIntegerWithBase: aBase
		upTo: anInteger
]

{ #category : #private }
XMLIntegerReader >> maxIntegerValue [
	"SmallInteger maxValue"
	^ 1073741823
]

{ #category : #private }
XMLIntegerReader >> nextDigitWithBase: aBase [
	| digit nextChar |
	
	nextChar := stream peek.
	aBase = 16
		ifTrue: [digit := HexDigitCharacterMap at: nextChar ifAbsent: [^ nil]]
		ifFalse: [
			digit := nextChar asciiValue - $0 asciiValue.
			(digit >= 0 and: [digit <= 9])
				ifFalse: [^ nil]].
	stream next.

	^ digit.
]

{ #category : #reading }
XMLIntegerReader >> nextIntegerWithBase: aBase upTo: anInteger [
	| integer maxValue maxBaseValue digitValue readLimit |

	maxValue := self maxIntegerValue.
	maxBaseValue := (maxValue / aBase) asInteger.
	readLimit := anInteger.
	[stream atEnd
		or: [(readLimit notNil and: [readLimit <= 0])
			or: [(digitValue := self nextDigitWithBase: aBase) isNil]]]
		whileFalse: [
			integer ifNil: [integer := 0].
	
			integer > maxBaseValue
				ifTrue: [^ integer].
			integer := integer * aBase.

			integer > (maxValue - digitValue)
				ifTrue: [^ integer].
			integer := integer + digitValue.
			readLimit ifNotNil: [readLimit := readLimit - 1]].
	^ integer.
]

{ #category : #reading }
XMLIntegerReader >> stream: aStream [
	stream := aStream
]

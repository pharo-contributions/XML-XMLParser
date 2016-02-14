"
An abstract class for Unicode stream converters.
"
Class {
	#name : #XMLUTFStreamConverter,
	#superclass : #XMLStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #converting }
XMLUTFStreamConverter >> characterWithValue: aCodePoint [
	aCodePoint > 16r10FFFF
		ifTrue: [self errorInvalidCharacter].

	^ Character value: aCodePoint.
]

{ #category : #converting }
XMLUTFStreamConverter >> valueFromCharacter: aCharacter [
	| asciiValue |

	(asciiValue := aCharacter asciiValue) > 16r10FFFF
		ifTrue: [self errorInvalidCharacter].

	^ asciiValue.
]

"
An abstract class for Unicode stream converters.
"
Class {
	#name : #XMLUTFStreamConverter,
	#superclass : #XMLStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #converting }
XMLUTFStreamConverter >> characterForValue: aCodePoint [
	aCodePoint > 16r10FFFF
		ifTrue: [self errorInvalidCharacter].

	^ Character value: aCodePoint.
]

{ #category : #converting }
XMLUTFStreamConverter >> valueOfCharacter: aCharacter [
	| codePoint |

	(codePoint := aCharacter asciiValue) > 16r10FFFF
		ifTrue: [self errorInvalidCharacter].

	^ codePoint.
]

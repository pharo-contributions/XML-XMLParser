"
An abstract class for Unicode stream converters.
"
Class {
	#name : #XMLUTFStreamConverter,
	#superclass : #XMLStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #converting }
XMLUTFStreamConverter >> characterFromCodePoint: aCodePoint [
	aCodePoint > 16r10FFFF "max code point"
		ifTrue: [self errorBadCharacterValue: aCodePoint].
	^ Character value: aCodePoint.
]

{ #category : #converting }
XMLUTFStreamConverter >> codePointFromCharacter: aCharacter [
	| codePoint |

	(codePoint := aCharacter asciiValue) > 16r10FFFF "max code point"
		ifTrue: [self errorBadCharacterValue: codePoint].
	^ codePoint.
]

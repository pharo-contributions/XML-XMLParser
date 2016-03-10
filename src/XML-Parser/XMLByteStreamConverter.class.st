"
A stream converter for ISO Latin-1, ASCII,  and other compatible byte character encodings.
"
Class {
	#name : #XMLByteStreamConverter,
	#superclass : #XMLStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLByteStreamConverter class >> basicEncodingNames [
	^ #('ASCII' 'Latin-1' 'Latin1' 'CP819' 'IBM819' 'ISO-8859-1' 'ISO-IR-100' 'L1' 'csISOLatin1')
]

{ #category : #decoding }
XMLByteStreamConverter >> nextFromStream: aStream [
	| character |

	((character := aStream basicNext) notNil
		and: [character asciiValue > 255])
		ifTrue: [self errorBadCharacterValue: character asciiValue].

	^ character.
]

{ #category : #encoding }
XMLByteStreamConverter >> nextPut: aCharacter toStream: aStream [
	aCharacter asciiValue > 255
		ifTrue: [self errorBadCharacterValue: aCharacter asciiValue].

	aStream basicNextPut: aCharacter.
]

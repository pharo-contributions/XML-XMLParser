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
	^ #('Latin-1' 'Latin1' 'ASCII' 'CP819' 'IBM819' 'ISO-8859-1' 'ISO-IR-100' 'L1' 'csISOLatin1')
]

{ #category : #decoding }
XMLByteStreamConverter >> nextFromStream: aStream [
	| character |

	((character := aStream basicNext) notNil
		and: [character asciiValue > 255])
		ifTrue: [self errorInvalidCharacter].

	^ character.
]

{ #category : #encoding }
XMLByteStreamConverter >> nextPut: aCharacter toStream: aStream [
	aCharacter asciiValue > 255
		ifTrue: [self errorInvalidCharacter].

	aStream basicNextPut: aCharacter.
]

"
A stream converter for ISO Latin-1, ASCII,  and other compatible byte character encodings.
"
Class {
	#name : #XMLByteStreamConverter,
	#superclass : #XMLStatelessStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #basic }
XMLByteStreamConverter class >> basicEncodingNames [
	^ #('Latin-1' 'Latin1'
			'CP-819' 'CP819'
			'IBM-819' 'IBM819'
			'ISO-8859-1' 'ISO8859-1' 'ISO-88591' 'ISO88591'
			'ISO-IR-100' 'ISOIR-100' 'ISO-IR100' 'ISOIR100'
			'L1'
			'csISOLatin1'
			'ASCII')
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

"
A read stream for single characters. (faster and less memory than converting a char to a string and creating a read stream on it)
"
Class {
	#name : #XMLSingleCharacterReadStream,
	#superclass : #Object,
	#instVars : [
		'character'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLSingleCharacterReadStream class >> on: aCharacter [
	^ self new on: aCharacter
]

{ #category : #testing }
XMLSingleCharacterReadStream >> atEnd [
	^ character == nil
]

{ #category : #accessing }
XMLSingleCharacterReadStream >> basicNext [
	^ self next
]

{ #category : #closing }
XMLSingleCharacterReadStream >> close [
]

{ #category : #testing }
XMLSingleCharacterReadStream >> isBinary [
	^ false
]

{ #category : #testing }
XMLSingleCharacterReadStream >> isStream [
	^ true
]

{ #category : #accessing }
XMLSingleCharacterReadStream >> next [
	^ character ifNotNil: [:nextChar |
		character := nil.
		nextChar]
]

{ #category : #initialization }
XMLSingleCharacterReadStream >> on: aCharacter [
	character := aCharacter
]

{ #category : #accessing }
XMLSingleCharacterReadStream >> peek [
	^ character
]

{ #category : #printing }
XMLSingleCharacterReadStream >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: character;
		nextPut: $).
]

"
A read stream for single characters.
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

{ #category : #'file open/close' }
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

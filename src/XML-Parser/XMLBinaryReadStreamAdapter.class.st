"
This adapter converts the byte contents of a binary stream to character objects.
"
Class {
	#name : #XMLBinaryReadStreamAdapter,
	#superclass : #XMLReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLBinaryReadStreamAdapter >> atEnd [
	^ stream atEnd
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> basicNext [
	^ stream next asCharacter
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> next [
	^ stream next asCharacter
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> peek [
	^ stream peek asCharacter
]

"
This class is a SAX2ElementHandler that handles #characters: events. Sending #characters returns the complete character data of the element as a string.
"
Class {
	#name : #SAX2ElementCharacterHandler,
	#superclass : #SAX2ElementHandler,
	#instVars : [
		'characters'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
SAX2ElementCharacterHandler >> characters [
	"This returns the combined #characters: events handled by the receiver
	as a string."

	^ characters ifNil: [characters := '']
]

{ #category : #'handling - content' }
SAX2ElementCharacterHandler >> characters: aString [
	characters :=
		(characters == nil "optimization"
			or: [characters size = 0]) "optimization"
			ifTrue: [aString]
			ifFalse: [characters, aString]
]

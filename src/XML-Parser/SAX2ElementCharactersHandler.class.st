"
This class is a SAX2ElementHandler that tracks character data. Sending #characters returns the complete character data of the element as a string.
"
Class {
	#name : #SAX2ElementCharactersHandler,
	#superclass : #SAX2ElementHandler,
	#instVars : [
		'characters'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
SAX2ElementCharactersHandler >> characters [
	"This returns the combined #characters: events handled by the receiver
	as a string."

	^ characters ifNil: [characters := '']
]

{ #category : #'handling - content' }
SAX2ElementCharactersHandler >> characters: aString [
	(characters == nil "optimization"
		or: [characters size = 0]) "optimization"
		ifTrue: [characters := aString]
		ifFalse: [characters := characters, aString]
]

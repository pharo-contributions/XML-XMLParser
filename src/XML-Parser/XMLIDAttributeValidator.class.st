Class {
	#name : #XMLIDAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'ids'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLIDAttributeValidator >> ids [
	^ ids ifNil: [ids := Set new]
	
]

{ #category : #testing }
XMLIDAttributeValidator >> isIDValidator [
	^ true
]

{ #category : #validation }
XMLIDAttributeValidator >> validateAttributeValue: aValue [
	self validateID: aValue.
	(self ids includes: aValue)
		ifTrue: [
			XMLValidationException signal:
				'ID "', aValue, '" used more than once for <', element, '>'].

	self ids add: aValue.
]

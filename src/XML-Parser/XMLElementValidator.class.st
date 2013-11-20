"
This is a base class for element content validators.
"
Class {
	#name : #XMLElementValidator,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLElementValidator class >> name: aName [
	^ self new name: aName
]

{ #category : #testing }
XMLElementValidator >> atEnd [
	self subclassResponsibility
]

{ #category : #private }
XMLElementValidator >> errorUnexpectedElement: aName [
	XMLValidationException signal:
		'Unexpected <', aName, '> element in <', self name, '> element'.
]

{ #category : #private }
XMLElementValidator >> errorUnexpectedPCData: aString [
	XMLValidationException signal:
		'Unexpected PCDATA in <', self name, '> element'.
]

{ #category : #accessing }
XMLElementValidator >> name [
	^ name
]

{ #category : #accessing }
XMLElementValidator >> name: aName [
	name := aName
]

{ #category : #validation }
XMLElementValidator >> validatePCData: aString [
]

{ #category : #validation }
XMLElementValidator >> validateStartTag: aName [
]

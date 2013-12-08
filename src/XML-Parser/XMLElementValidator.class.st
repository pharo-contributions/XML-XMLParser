"
This is a base class for element content validators.
"
Class {
	#name : #XMLElementValidator,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLElementValidator class >> element: aName [
	^ self new element: aName
]

{ #category : #testing }
XMLElementValidator >> atEnd [
	self subclassResponsibility
]

{ #category : #accessing }
XMLElementValidator >> element [
	^ element
]

{ #category : #accessing }
XMLElementValidator >> element: aName [
	element := aName
]

{ #category : #private }
XMLElementValidator >> errorUnexpectedElement: aName [
	XMLValidationException signal:
		'Unexpected <', aName, '> element in <', self element, '> element'.
]

{ #category : #private }
XMLElementValidator >> errorUnexpectedPCData: aString [
	XMLValidationException signal:
		'Unexpected PCDATA in <', self element, '> element'.
]

{ #category : #validation }
XMLElementValidator >> validatePCData: aString [
]

{ #category : #validation }
XMLElementValidator >> validateStartTag: aName [
]

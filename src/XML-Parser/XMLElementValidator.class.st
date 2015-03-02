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
	XMLValidationException
		formatSignal: 'Unexpected <{1}> element in <{2}> element'
		with: aName
		with: self element
]

{ #category : #private }
XMLElementValidator >> errorUnexpectedPCData: aString [
	XMLValidationException
		formatSignal: 'Unexpected PCDATA in <{1}> element'
		with: self element
]

{ #category : #validating }
XMLElementValidator >> validatePCData: aString [
]

{ #category : #validating }
XMLElementValidator >> validateStartTag: aName [
]

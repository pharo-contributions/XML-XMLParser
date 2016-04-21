"
This class validates elements that can contain a mix of PCDATA and certain elements.
"
Class {
	#name : #XMLMixedContentElementValidator,
	#superclass : #XMLElementValidator,
	#instVars : [
		'allowedElements'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLMixedContentElementValidator class >> element: anElement allowedElements: anAllowedElementsCollection [
	^ self new
		setElement: anElement
		allowedElements: anAllowedElementsCollection
]

{ #category : #accessing }
XMLMixedContentElementValidator >> allowedElements [
	^ allowedElements
]

{ #category : #testing }
XMLMixedContentElementValidator >> atEnd [
	^ true
]

{ #category : #initialization }
XMLMixedContentElementValidator >> setElement: anElement allowedElements: anAllowedElementsCollection [
	element := anElement.
	allowedElements := anAllowedElementsCollection asSet.
]

{ #category : #accessing }
XMLMixedContentElementValidator >> type [
	^ 'mixed content'
]

{ #category : #validating }
XMLMixedContentElementValidator >> validateStartTag: anElement [
	(self allowedElements includes: anElement)
		ifFalse: [self errorUnexpectedElement: anElement]
	
]

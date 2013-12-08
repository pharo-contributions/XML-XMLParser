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
XMLMixedContentElementValidator class >> element: aName allowedElements: aNameCollection [
	^ self new
		setElement: aName
		allowedElements: aNameCollection
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
XMLMixedContentElementValidator >> setElement: aName allowedElements: aNameCollection [
	element := aName.
	allowedElements := aNameCollection.
]

{ #category : #validation }
XMLMixedContentElementValidator >> validateStartTag: aName [
	(self allowedElements includes: aName)
		ifFalse: [self errorUnexpectedElement: aName]
	
]

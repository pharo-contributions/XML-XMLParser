"
This class validates elements that can contain a mix of PCDATA and certain elements.
"
Class {
	#name : #XMLMixedElementValidator,
	#superclass : #XMLElementValidator,
	#instVars : [
		'elements'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLMixedElementValidator class >> name: aName elements: aNameCollection [
	^ self new
		setName: aName
		elements: aNameCollection
]

{ #category : #testing }
XMLMixedElementValidator >> atEnd [
	^ true
]

{ #category : #accessing }
XMLMixedElementValidator >> elements [
	^ elements
]

{ #category : #initialization }
XMLMixedElementValidator >> setName: aName elements: aNameCollection [
	name := aName.
	elements := aNameCollection.
]

{ #category : #validation }
XMLMixedElementValidator >> validateStartTag: aName [
	(self elements includes: aName)
		ifFalse: [self errorUnexpectedElement: aName]
	
]

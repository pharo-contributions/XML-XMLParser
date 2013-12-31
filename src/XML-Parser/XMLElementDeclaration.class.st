Class {
	#name : #XMLElementDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'contentModel',
		'element'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLElementDeclaration class >> element: aName contentModel: aContentModelString [
	^ self new setElement: aName contentModel: aContentModelString
]

{ #category : #accessing }
XMLElementDeclaration >> contentModel [
	^ contentModel ifNil: [contentModel := '']
]

{ #category : #accessing }
XMLElementDeclaration >> element [
	^ element ifNil: [element := '']
]

{ #category : #initialization }
XMLElementDeclaration >> setElement: aName contentModel: aContentModelString [
	element := aName.
	contentModel := aContentModelString.
]

{ #category : #printing }
XMLElementDeclaration >> writeXMLOn: aWriter [
	aWriter elementDeclaration
		element: self element;
		contentModel: self contentModel
]

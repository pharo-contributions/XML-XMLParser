"
This is a class for <!ELEMENT> declarations.
"
Class {
	#name : #XMLElementDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'element',
		'contentModel'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLElementDeclaration class >> element: aName contentModel: aContentModel [
	^ self new
		element: aName;
		contentModel: aContentModel
]

{ #category : #accessing }
XMLElementDeclaration >> contentModel [
	^ contentModel ifNil: [contentModel := '']
]

{ #category : #accessing }
XMLElementDeclaration >> contentModel: aContentModel [
	contentModel := aContentModel
]

{ #category : #accessing }
XMLElementDeclaration >> element [
	^ element ifNil: [element := '']
]

{ #category : #accessing }
XMLElementDeclaration >> element: aName [
	element := aName
]

{ #category : #printing }
XMLElementDeclaration >> writeXMLOn: aWriter [
	aWriter elementDeclaration
		element: self element;
		contentModel: self contentModel
]

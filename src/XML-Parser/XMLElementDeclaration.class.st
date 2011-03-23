Class {
	#name : #XMLElementDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'contentModel'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLElementDeclaration class >> name: aName contentModel: aContentModelString [
	^ self new setName: aName contentModel: aContentModelString
]

{ #category : #accessing }
XMLElementDeclaration >> contentModel [
	^ contentModel ifNil: [contentModel := '']
]

{ #category : #initialization }
XMLElementDeclaration >> setName: aName contentModel: aContentModelString [
	name := aName.
	contentModel := aContentModelString.
]

{ #category : #printing }
XMLElementDeclaration >> writeXMLOn: aWriter [
	aWriter elementDeclaration
		name: self name;
		contentModel: self contentModel
]

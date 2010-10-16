Class {
	#name : #XMLElementDeclarationNode,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'contentModel'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLElementDeclarationNode class >> name: aName contentModel: aContentModelString [
	^ self new setName: aName contentModel: aContentModelString
]

{ #category : #accessing }
XMLElementDeclarationNode >> contentModel [
	^ contentModel
]

{ #category : #printing }
XMLElementDeclarationNode >> printXMLOn: aWriter [
	aWriter elementDeclaration
		name: self name;
		contentModel: self contentModel
]

{ #category : #initialization }
XMLElementDeclarationNode >> setName: aName contentModel: aContentModelString [
	name := aName.
	contentModel := aContentModelString.
]

Class {
	#name : #XMLNotationDeclarationNode,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'publicId',
		'systemId'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLNotationDeclarationNode class >> name: aName publicID: aPublicId systemID: aSystemId [
	^ self new setName: aName publicID: aPublicId systemID: aSystemId
]

{ #category : #printing }
XMLNotationDeclarationNode >> printXMLOn: aWriter [
	aWriter notationDeclaration
		name: self name;
		publicID: self publicID;
		systemID: self systemID
]

{ #category : #accessing }
XMLNotationDeclarationNode >> publicID [
	^ publicId
]

{ #category : #initialization }
XMLNotationDeclarationNode >> setName: aName publicID: aPublicId systemID: aSystemId [
	name := aName.
	publicId := aPublicId.
	systemId := aSystemId.
]

{ #category : #accessing }
XMLNotationDeclarationNode >> systemID [
	^ systemId
]

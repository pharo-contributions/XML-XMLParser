"
This is class for <!NOTATION> declarations.

"
Class {
	#name : #XMLNotationDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'name',
		'publicId',
		'systemId'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLNotationDeclaration class >> name: aName publicID: aPublicId systemID: aSystemId [
	^ self new setName: aName publicID: aPublicId systemID: aSystemId
]

{ #category : #accessing }
XMLNotationDeclaration >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XMLNotationDeclaration >> publicID [
	^ publicId ifNil: [publicId := '']
]

{ #category : #initialization }
XMLNotationDeclaration >> setName: aName publicID: aPublicId systemID: aSystemId [
	name := aName.
	publicId := aPublicId.
	systemId := aSystemId.
]

{ #category : #accessing }
XMLNotationDeclaration >> systemID [
	^ systemId ifNil: [systemId := '']
]

{ #category : #printing }
XMLNotationDeclaration >> writeXMLOn: aWriter [
	aWriter notationDeclaration
		name: self name;
		publicID: self publicID;
		systemID: self systemID
]

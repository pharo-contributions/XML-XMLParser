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
	^ self new
		name: aName;
		publicID: aPublicId;
		systemID: aSystemId
]

{ #category : #accessing }
XMLNotationDeclaration >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XMLNotationDeclaration >> name: aName [
	name := aName
]

{ #category : #accessing }
XMLNotationDeclaration >> publicID [
	^ publicId ifNil: [publicId := '']
]

{ #category : #accessing }
XMLNotationDeclaration >> publicID: aPublicId [
	publicId := aPublicId
]

{ #category : #accessing }
XMLNotationDeclaration >> systemID [
	^ systemId ifNil: [systemId := '']
]

{ #category : #accessing }
XMLNotationDeclaration >> systemID: aSystemId [
	systemId := aSystemId
]

{ #category : #printing }
XMLNotationDeclaration >> writeXMLOn: aWriter [
	aWriter notationDeclaration
		name: self name;
		publicID: self publicID;
		systemID: self systemID
]

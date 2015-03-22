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
XMLNotationDeclaration class >> name: aName publicID: aPublicID systemID: aSystemID [
	^ self new
		name: aName;
		publicID: aPublicID;
		systemID: aSystemID
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
XMLNotationDeclaration >> publicID: aPublicID [
	publicId := aPublicID
]

{ #category : #accessing }
XMLNotationDeclaration >> systemID [
	^ systemId ifNil: [systemId := '']
]

{ #category : #accessing }
XMLNotationDeclaration >> systemID: aSystemID [
	systemId := aSystemID
]

{ #category : #printing }
XMLNotationDeclaration >> writeXMLOn: aWriter [
	aWriter notationDeclaration
		name: self name;
		publicID: self publicID;
		systemID: self systemID
]

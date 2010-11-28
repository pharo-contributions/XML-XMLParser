Class {
	#name : #XMLEntityDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'replacement',
		'publicId',
		'systemId',
		'ndata'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLEntityDeclaration class >> name: aName publicID: aPublicId systemID: aSystemId [
	^ self new
		setName: aName
		replacement: nil
		publicID: aPublicId
		systemID: aSystemId
		ndata: nil
]

{ #category : #'instance creation' }
XMLEntityDeclaration class >> name: aName publicID: aPublicId systemID: aSystemId ndata: aNotationName [
	^ self new
		setName: aName
		replacement: nil
		publicID: aPublicId
		systemID: aSystemId
		ndata: aNotationName
]

{ #category : #'instance creation' }
XMLEntityDeclaration class >> name: aName replacement: aReplacement [
	^ self new
		setName: aName
		replacement: aReplacement
		publicID: nil
		systemID: nil
		ndata: nil
]

{ #category : #accessing }
XMLEntityDeclaration >> ndata [
	^ ndata ifNil: [ndata := '']
]

{ #category : #accessing }
XMLEntityDeclaration >> publicID [
	^ publicId ifNil: [publicId := '']
]

{ #category : #accessing }
XMLEntityDeclaration >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #initialization }
XMLEntityDeclaration >> setName: aName replacement: aReplacement publicID: aPublicId systemID: aSystemId ndata: aNotationName [
	name := aName.
	replacement := aReplacement.
	publicId := aPublicId.
	systemId := aSystemId.
	ndata := aNotationName.
]

{ #category : #accessing }
XMLEntityDeclaration >> systemID [
	^ systemId ifNil: [systemId := '']
]

{ #category : #printing }
XMLEntityDeclaration >> writeXMLWith: aWriter [
	aWriter entityDeclaration
		name: self name;
		replacement: self replacement;
		publicID: self publicID;
		systemID: self systemID;
		ndata: self ndata
]

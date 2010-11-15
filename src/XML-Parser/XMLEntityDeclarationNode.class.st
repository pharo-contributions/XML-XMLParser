Class {
	#name : #XMLEntityDeclarationNode,
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
XMLEntityDeclarationNode class >> name: aName publicID: aPublicId systemID: aSystemId [
	^ self new
		setName: aName
		replacement: nil
		publicID: aPublicId
		systemID: aSystemId
		ndata: nil
]

{ #category : #'instance creation' }
XMLEntityDeclarationNode class >> name: aName publicID: aPublicId systemID: aSystemId ndata: aNotationName [
	^ self new
		setName: aName
		replacement: nil
		publicID: aPublicId
		systemID: aSystemId
		ndata: aNotationName
]

{ #category : #'instance creation' }
XMLEntityDeclarationNode class >> name: aName replacement: aReplacement [
	^ self new
		setName: aName
		replacement: aReplacement
		publicID: nil
		systemID: nil
		ndata: nil
]

{ #category : #accessing }
XMLEntityDeclarationNode >> ndata [
	^ ndata ifNil: [ndata := '']
]

{ #category : #printing }
XMLEntityDeclarationNode >> printXMLOn: aWriter [
	aWriter entityDeclaration
		name: self name;
		replacement: self replacement;
		publicID: self publicID;
		systemID: self systemID;
		ndata: self ndata
]

{ #category : #accessing }
XMLEntityDeclarationNode >> publicID [
	^ publicId ifNil: [publicId := '']
]

{ #category : #accessing }
XMLEntityDeclarationNode >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #initialization }
XMLEntityDeclarationNode >> setName: aName replacement: aReplacement publicID: aPublicId systemID: aSystemId ndata: aNotationName [
	name := aName.
	replacement := aReplacement.
	publicId := aPublicId.
	systemId := aSystemId.
	ndata := aNotationName.
]

{ #category : #accessing }
XMLEntityDeclarationNode >> systemID [
	^ systemId ifNil: [systemId := '']
]

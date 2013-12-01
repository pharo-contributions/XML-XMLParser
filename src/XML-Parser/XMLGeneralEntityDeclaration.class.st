Class {
	#name : #XMLGeneralEntityDeclaration,
	#superclass : #XMLEntityDeclaration,
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLGeneralEntityDeclaration class >> name: aName publicID: aPublicId systemID: aSystemId ndata: aNotationName [
	^ self new
		setName: aName
		replacement: nil
		publicID: aPublicId
		systemID: aSystemId
		ndata: aNotationName
]

"
This is a class for internal/external parsed/unparsed general <!ENTITY> declarations.
"
Class {
	#name : #XMLGeneralEntityDeclaration,
	#superclass : #XMLEntityDeclaration,
	#category : #'XML-Parser-DOM'
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

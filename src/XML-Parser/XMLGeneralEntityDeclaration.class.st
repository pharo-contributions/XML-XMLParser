"
This is a class for internal/external parsed/unparsed general <!ENTITY> declarations.
"
Class {
	#name : #XMLGeneralEntityDeclaration,
	#superclass : #XMLEntityDeclaration,
	#instVars : [
		'ndata'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLGeneralEntityDeclaration class >> name: aName publicID: aPublicID systemID: aSystemID ndata: aNotationName [
	^ self new
		name: aName;
		publicID: aPublicID;
		systemID: aSystemID;
		ndata: aNotationName
]

{ #category : #accessing }
XMLGeneralEntityDeclaration >> ndata [
	^ ndata ifNil: [ndata := '']
]

{ #category : #accessing }
XMLGeneralEntityDeclaration >> ndata: anNdata [
	ndata := anNdata
]

{ #category : #printing }
XMLGeneralEntityDeclaration >> writeXMLOn: aWriter [
	aWriter entityDeclaration
		name: self name;
		isParameter: false;
		replacement: self replacement;
		publicID: self publicID;
		systemID: self systemID;
		ndata: self ndata
]

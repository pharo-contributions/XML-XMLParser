"
This class represents the <!DOCTYPE ...> declaration one often finds at the top of an XML document. It stores the root element name, formal public identifier (FPI) if any, system identifier (a URI) and then any nodes comprising the internal subset.
"
Class {
	#name : #XMLDoctypeDeclaration,
	#superclass : #XMLNodeWithChildren,
	#instVars : [
		'root',
		'publicId',
		'systemId'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLDoctypeDeclaration class >> root: aRootElementName publicID: aPublicId systemID: aSystemId [
	^ self new
		root: aRootElementName;
		publicID: aPublicId;
		systemID: aSystemId
]

{ #category : #private }
XMLDoctypeDeclaration >> newNodeListForSelect [
	^ XMLInternalSubsetList new
]

{ #category : #private }
XMLDoctypeDeclaration >> nodeListClass [
	^ XMLInternalSubsetList
]

{ #category : #accessing }
XMLDoctypeDeclaration >> publicID [
	^ publicId ifNil: [publicId := '']
]

{ #category : #accessing }
XMLDoctypeDeclaration >> publicID: aPublicId [
	publicId := aPublicId
]

{ #category : #accessing }
XMLDoctypeDeclaration >> root [
	^ root ifNil: [root := '']
]

{ #category : #accessing }
XMLDoctypeDeclaration >> root: aRootElementName [
	root := aRootElementName
]

{ #category : #accessing }
XMLDoctypeDeclaration >> systemID [
	^ systemId ifNil: [systemId := '']
]

{ #category : #accessing }
XMLDoctypeDeclaration >> systemID: aSystemId [
	systemId := aSystemId
]

{ #category : #printing }
XMLDoctypeDeclaration >> writeXMLOn: aWriter [
	aWriter doctype
		root: self root;
		publicID: self publicID;
		systemID: self systemID;
		withInternalSubset: [self writeInnerXMLOn: aWriter]
]

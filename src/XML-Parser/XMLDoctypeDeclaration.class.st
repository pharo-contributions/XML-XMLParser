"
This class represents the <!DOCTYPE ...> declaration one often finds at the top of an XML document. It stores the root element name, formal public identifier (FPI) if any, system identifier (a URI) and then any nodes comprising the internal subset.
"
Class {
	#name : #XMLDoctypeDeclaration,
	#superclass : #XMLNodeWithChildren,
	#instVars : [
		'root',
		'publicID',
		'systemID'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLDoctypeDeclaration class >> root: aRootElementName publicID: aPublicID systemID: aSystemID [
	^ self new
		root: aRootElementName;
		publicID: aPublicID;
		systemID: aSystemID
]

{ #category : #private }
XMLDoctypeDeclaration >> newListForSelect [
	^ XMLInternalSubsetList new: 10
]

{ #category : #private }
XMLDoctypeDeclaration >> nodeListClass [
	^ XMLInternalSubsetList
]

{ #category : #accessing }
XMLDoctypeDeclaration >> publicID [
	^ publicID ifNil: [publicID := '']
]

{ #category : #accessing }
XMLDoctypeDeclaration >> publicID: aPublicID [
	publicID := aPublicID
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
	^ systemID ifNil: [systemID := '']
]

{ #category : #accessing }
XMLDoctypeDeclaration >> systemID: aSystemID [
	systemID := aSystemID
]

{ #category : #printing }
XMLDoctypeDeclaration >> writeXMLOn: aWriter [
	aWriter doctype
		root: self root;
		publicID: self publicID;
		systemID: self systemID;
		withInternalSubset: [self writeInnerXMLOn: aWriter]
]

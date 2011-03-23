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
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLDoctypeDeclaration class >> root: aRootElementName publicID: aPublicId systemID: aSystemId [
	^ self new
		setRoot: aRootElementName
		publicID: aPublicId
		systemID: aSystemId
]

{ #category : #private }
XMLDoctypeDeclaration >> nodesClass [
	^ XMLInternalSubsetList
]

{ #category : #accessing }
XMLDoctypeDeclaration >> publicID [
	^ publicId
]

{ #category : #accessing }
XMLDoctypeDeclaration >> root [
	^ root
]

{ #category : #initialization }
XMLDoctypeDeclaration >> setRoot: aRootElementName publicID: aPublicId systemID: aSystemId [
	root := aRootElementName.
	publicId := aPublicId.
	systemId := aSystemId.
]

{ #category : #accessing }
XMLDoctypeDeclaration >> systemID [
	^ systemId
]

{ #category : #printing }
XMLDoctypeDeclaration >> writeXMLOn: aWriter [
	aWriter doctype
		root: self root;
		publicID: self publicID;
		systemID: self systemID;
		withInternalSubset: [self writeInnerXMLOn: aWriter]
]

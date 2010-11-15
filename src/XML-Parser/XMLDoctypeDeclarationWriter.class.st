"
This class writes <!DOCTYPE ...> declarations. You can set the root element, public ID and system ID using the messages under ""accessing"" before specifying any internal subset with #internalSubset: (which results in the declaration being written). If no public ID is supplied, then the declaration written will be of type ""SYSTEM"" rather than ""PUBLIC"" and will not have any Formal Public Identifier (FPI). The internal subset, if supplied, should consist of markup declarations generated with instances of XMLMarkupDeclarationWriter subclasses.
"
Class {
	#name : #XMLDoctypeDeclarationWriter,
	#superclass : #XMLEmbeddedMarkupWriter,
	#instVars : [
		'root',
		'externalIdWriter'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #accessing }
XMLDoctypeDeclarationWriter >> externalIDWriter [
	^ externalIdWriter ifNil: [externalIdWriter := XMLExternalIDWriter writer: self writer]
]

{ #category : #accessing }
XMLDoctypeDeclarationWriter >> publicID [
	^ self externalIDWriter publicID
]

{ #category : #accessing }
XMLDoctypeDeclarationWriter >> publicID: aPublicId [
	self externalIDWriter publicID: aPublicId
]

{ #category : #accessing }
XMLDoctypeDeclarationWriter >> root [
	^ root ifNil: ['']
]

{ #category : #accessing }
XMLDoctypeDeclarationWriter >> root: aRootElementName [
	root := aRootElementName
]

{ #category : #accessing }
XMLDoctypeDeclarationWriter >> systemID [
	^ self externalIDWriter systemID
]

{ #category : #accessing }
XMLDoctypeDeclarationWriter >> systemID: aSystemId [
	self externalIDWriter systemID: aSystemId
]

{ #category : #'embedding markup' }
XMLDoctypeDeclarationWriter >> with: aStringOrCollectionOrBlock [
	self writer isCanonical
		ifFalse: [^ super with: aStringOrCollectionOrBlock]
]

{ #category : #'embedding markup' }
XMLDoctypeDeclarationWriter >> withInternalSubset: aStringOrCollectionOrBlock [
	^ self with: aStringOrCollectionOrBlock
]

{ #category : #private }
XMLDoctypeDeclarationWriter >> writeBeforeEmbeddedMarkup [
	self writer
		nextPutAll: ' [';
		indent
]

{ #category : #private }
XMLDoctypeDeclarationWriter >> writeEpilogue [
	self hasEmbeddedMarkup
		ifTrue: [
			self writer
				outdent;
				cr;
				nextPut: $]].
	self writer
		nextPut: $>;
		cr.
]

{ #category : #private }
XMLDoctypeDeclarationWriter >> writePrologue [
	self writer
		cr;
		nextPutAll: '<!DOCTYPE';
		space;
		writeName: self root;
		space.

	self externalIDWriter write.
]

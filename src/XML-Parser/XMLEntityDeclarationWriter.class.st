Class {
	#name : #XMLEntityDeclarationWriter,
	#superclass : #XMLMarkupDeclarationWriter,
	#instVars : [
		'replacement',
		'ndata',
		'externalIdWriter'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #accessing }
XMLEntityDeclarationWriter >> declarationType [
	^ 'ENTITY'
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> externalIDWriter [
	^ externalIdWriter ifNil: [externalIdWriter := XMLExternalIDWriter writer: self writer]
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> ndata [
	^ ndata ifNil: [ndata := '']
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> ndata: aNotationName [
	ndata := aNotationName
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> publicID [
	^ self externalIDWriter publicID
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> publicID: aPublicId [
	self externalIDWriter publicID: aPublicId
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> replacement: aReplacement [
	replacement := aReplacement
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> systemID [
	^ self externalIDWriter systemID
]

{ #category : #accessing }
XMLEntityDeclarationWriter >> systemID: aSystemId [
	self externalIDWriter systemID: aSystemId
]

{ #category : #private }
XMLEntityDeclarationWriter >> writeBody [
	self replacement
		ifNotEmpty: [self writer writeXmlEncodedString: self replacement]
		ifEmpty: [
			self externalIDWriter write.
			self ndata
				ifNotEmpty: [
					self writer
						space;
						nextPutAll: 'NDATA';
						space;
						writeName: self ndata]]
]

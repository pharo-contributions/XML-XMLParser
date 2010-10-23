Class {
	#name : #XMLExternalIDWriter,
	#superclass : #XMLMarkupWriter,
	#instVars : [
		'publicId',
		'systemId'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #accessing }
XMLExternalIDWriter >> publicID [
	^ publicId ifNil: [publicId := '']
]

{ #category : #accessing }
XMLExternalIDWriter >> publicID: aPublicId [
	publicId := aPublicId
]

{ #category : #accessing }
XMLExternalIDWriter >> systemID [
	^ systemId ifNil: [systemId := '']
]

{ #category : #accessing }
XMLExternalIDWriter >> systemID: aSystemId [
	systemId := aSystemId
]

{ #category : #private }
XMLExternalIDWriter >> write [
	self publicID
		ifNotEmpty: [
			self writer
				nextPutAll: 'PUBLIC';
				space;
				writeXmlEncodedString: self publicID]
		ifEmpty: [
			self systemID ifNotEmpty: [self writer nextPutAll: 'SYSTEM']].

	self systemID ifNotEmpty: [
		self writer
			space
			writeXmlEncodedString: self systemID].
]

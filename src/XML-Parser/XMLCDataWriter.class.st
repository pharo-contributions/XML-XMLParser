"
This class generates a <![CDATA[...]]> section. If the XMLWriter object has been set to generate canonical XML, CDATA sections will not be produced and their content will instead be XML-escaped and inserted directly into the document.
"
Class {
	#name : #XMLCDataWriter,
	#superclass : #XMLEmbeddedMarkupWriter,
	#category : #'XML-Parser-Writers'
}

{ #category : #'embedding markup' }
XMLCDataWriter >> cdata: aString [
	^ self with: aString
]

{ #category : #private }
XMLCDataWriter >> embedString: aString [
	self writer isCanonical
		ifTrue: [self writer writeXmlEncoded: aString]
		ifFalse: [self writer nextPutAll: aString]
]

{ #category : #private }
XMLCDataWriter >> writeEpilogue [
	self writer isCanonical
		ifFalse: [self writer nextPutAll: ']]>']
]

{ #category : #private }
XMLCDataWriter >> writePrologue [
	self writer isCanonical
		ifFalse: [self writer nextPutAll: '<![CDATA[']
]

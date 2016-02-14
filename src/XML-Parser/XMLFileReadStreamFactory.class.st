"
An abstract factory for file read streams used by XMLFileHandle.

Subclasses should create read streams that return raw byte characters and not characters decoded from some encoding (like UTF-8), so that XMLParser can do its own decoding later looking at byte-order marks and the <?xml ...?> encoding attribute.
"
Class {
	#name : #XMLFileReadStreamFactory,
	#superclass : #XMLAbstractFactory,
	#category : #'XML-Parser-File'
}

{ #category : #private }
XMLFileReadStreamFactory class >> errorUnsupported [
	XMLFileException signal: 'File reading unsupported'
]

{ #category : #'instance creation' }
XMLFileReadStreamFactory class >> fileReadStreamOnPath: aPath [
	self subclassResponsibility
]

{ #category : #'instance creation' }
XMLFileReadStreamFactory class >> onPath: aPath [
	^ self implementation fileReadStreamOnPath: aPath
]

{ #category : #private }
XMLFileReadStreamFactory class >> preferredImplementation [
	^ XMLStandardFileStreamReadStreamFactory
]

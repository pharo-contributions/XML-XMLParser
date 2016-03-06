"
A StandardFileStream read stream factory. This stream is preferred for Squeak/Pharo because it does no decoding and returns byte characters, so XMLParser can do its own decoding.
"
Class {
	#name : #XMLStandardFileStreamReadStreamFactory,
	#superclass : #XMLFileReadStreamFactory,
	#category : #'XML-Parser-File'
}

{ #category : #'instance creation' }
XMLStandardFileStreamReadStreamFactory class >> fileReadStreamOnPath: aPath [
	^ (Smalltalk at: #StandardFileStream) readOnlyFileNamed: aPath
]

{ #category : #testing }
XMLStandardFileStreamReadStreamFactory class >> isSupportedImplementation [
	^ (Smalltalk includesKey: #StandardFileStream)
]

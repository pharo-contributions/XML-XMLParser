"
A StandardFileStream read stream factory. This stream is preferred for Squeak/Pharo because it does no decoding and returns byte characters so XMLParser can do its own decoding.
"
Class {
	#name : 'XMLPharoFileReferenceReadStreamFactory',
	#superclass : 'XMLFileReadStreamFactory',
	#category : 'XML-Parser-Files',
	#package : 'XML-Parser',
	#tag : 'Files'
}

{ #category : 'basic' }
XMLPharoFileReferenceReadStreamFactory class >> basicOnPath: aPathString [
	^ aPathString asFileReference ensureCreateFile binaryReadStream
]

{ #category : 'testing' }
XMLPharoFileReferenceReadStreamFactory class >> isSupportedImplementation [
	^ XMLClassFinder hasClassNamed: #ZnBufferedReadStream
]

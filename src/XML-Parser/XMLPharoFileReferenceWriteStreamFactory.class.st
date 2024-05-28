"
A StandardFileStream write stream factory. This stream is preferred for Pharo/Squeak because it does no encoding and accepts byte characters so XMLParser can do its own encoding.
"
Class {
	#name : 'XMLPharoFileReferenceWriteStreamFactory',
	#superclass : 'XMLFileWriteStreamFactory',
	#category : 'XML-Parser-Files',
	#package : 'XML-Parser',
	#tag : 'Files'
}

{ #category : 'basic' }
XMLPharoFileReferenceWriteStreamFactory class >> basicOnPath: aPathString [
	^ aPathString asFileReference ensureCreateFile binaryWriteStream
]

{ #category : 'testing' }
XMLPharoFileReferenceWriteStreamFactory class >> isSupportedImplementation [
	^ XMLClassFinder hasClassNamed: #ZnBufferedWriteStream
]

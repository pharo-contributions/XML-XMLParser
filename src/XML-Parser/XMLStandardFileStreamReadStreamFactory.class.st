"
A StandardFileStream read stream factory. This stream is preferred for Pharo/Squeak because it does no encoding conversion so XMLParser can do its own.
"
Class {
	#name : #XMLStandardFileStreamReadStreamFactory,
	#superclass : #XMLFileReadStreamFactory,
	#category : #'XML-Parser-File'
}

{ #category : #'instance creation' }
XMLStandardFileStreamReadStreamFactory class >> fileReadStreamOn: aPath [
	^ (Smalltalk at: #StandardFileStream) readOnlyFileNamed: aPath
]

{ #category : #testing }
XMLStandardFileStreamReadStreamFactory class >> isSupported [
	^ (Smalltalk includesKey: #StandardFileStream)
]

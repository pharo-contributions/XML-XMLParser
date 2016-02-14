"
A StandardFileStream write stream factory. This stream is preferred for Pharo/Squeak because it does no encoding and accepts byte characters, so XMLParser can do its own encoding.
"
Class {
	#name : #XMLStandardFileStreamWriteStreamFactory,
	#superclass : #XMLFileWriteStreamFactory,
	#category : #'XML-Parser-File'
}

{ #category : #'instance creation' }
XMLStandardFileStreamWriteStreamFactory class >> fileWriteStreamOnPath: aPath [
	"use forceNewFileNamed: to ensure truncation of existing files before writing"
	^ (Smalltalk at: #StandardFileStream) forceNewFileNamed: aPath
]

{ #category : #testing }
XMLStandardFileStreamWriteStreamFactory class >> isSupported [
	^ (Smalltalk includesKey: #StandardFileStream)
]

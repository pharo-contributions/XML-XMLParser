"
An abstract factory for file write streams used by XMLFileHandle.

Subclasses should create write streams that do no automatic encoding and accept raw byte characters, so XMLParser can do its own encoding.
"
Class {
	#name : #XMLFileWriteStreamFactory,
	#superclass : #XMLAbstractFactory,
	#category : #'XML-Parser-File'
}

{ #category : #private }
XMLFileWriteStreamFactory class >> errorUnsupported [
	XMLFileException signal: 'File writing unsupported'
]

{ #category : #'instance creation' }
XMLFileWriteStreamFactory class >> fileWriteStreamOnPath: aPath [
	self subclassResponsibility
]

{ #category : #'instance creation' }
XMLFileWriteStreamFactory class >> onPath: aPath [
	^ self implementation fileWriteStreamOnPath: aPath
]

{ #category : #private }
XMLFileWriteStreamFactory class >> preferredImplementation [
	^ XMLStandardFileStreamWriteStreamFactory
]

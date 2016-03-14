"
An abstract factory for file write streams used by XMLFileHandles.

Subclasses should create write streams that do no automatic encoding and accept raw byte characters, so XMLParser can do its own encoding.
"
Class {
	#name : #XMLFileWriteStreamFactory,
	#superclass : #XMLAbstractFactory,
	#category : #'XML-Parser-Files'
}

{ #category : #'instance creation' }
XMLFileWriteStreamFactory class >> basicOnPath: aPathString [
	self subclassResponsibility
]

{ #category : #private }
XMLFileWriteStreamFactory class >> errorNoSupportedImplementation [
	XMLFileException signal: 'File writing unsupported'
]

{ #category : #'instance creation' }
XMLFileWriteStreamFactory class >> onPath: aPathString [
	^ self implementation basicOnPath: aPathString
]

{ #category : #accessing }
XMLFileWriteStreamFactory class >> preferredImplementation [
	^ XMLStandardFileStreamWriteStreamFactory
]

"
An abstract factory for file write streams used by XMLFileHandle.
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
XMLFileWriteStreamFactory class >> fileWriteStreamOn: aPath [
	self subclassResponsiblity
]

{ #category : #'instance creation' }
XMLFileWriteStreamFactory class >> on: aPath [
	^ self implementation fileWriteStreamOn: aPath
]

{ #category : #private }
XMLFileWriteStreamFactory class >> preferredImplementation [
	^ XMLFileStreamWriteStreamFactory
]

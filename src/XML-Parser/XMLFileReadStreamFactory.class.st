"
An abstract factory for file read streams used by XMLFileHandle.
"
Class {
	#name : #XMLFileReadStreamFactory,
	#superclass : #XMLAbstractImplementation,
	#category : #'XML-Parser-File'
}

{ #category : #private }
XMLFileReadStreamFactory class >> errorUnsupported [
	XMLFileException signal: 'File reading unsupported'
]

{ #category : #'instance creation' }
XMLFileReadStreamFactory class >> fileReadStreamOn: aPath [
	self subclassResponsibility
]

{ #category : #'instance creation' }
XMLFileReadStreamFactory class >> on: aPath [
	^ self implementation fileReadStreamOn: aPath
]

{ #category : #private }
XMLFileReadStreamFactory class >> preferredImplementation [
	^ XMLStandardFileStreamReadStreamFactory
]

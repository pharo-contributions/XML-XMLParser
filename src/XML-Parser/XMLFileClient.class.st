"
A base class for file IO clients. Messages expect and return paths as strings. See the FileSystem implementation for an example.
"
Class {
	#name : #XMLFileClient,
	#superclass : #XMLIOClient,
	#category : #'XML-Parser-Clients'
}

{ #category : #accessing }
XMLFileClient class >> defaultImplementation [
	^ XMLFileSystemClient
]

{ #category : #paths }
XMLFileClient >> currentWorkingDirectory [
	"should return cwd as a string"
	self subclassResponsibility
]

{ #category : #retrieving }
XMLFileClient >> get: aFullPath [
	^ self
		get: aFullPath
		onError: [:error | XMLFileIOException signal: error messageText]
]

{ #category : #retrieving }
XMLFileClient >> get: aFullPath onError: aBlock [
	self subclassResponsibility
]

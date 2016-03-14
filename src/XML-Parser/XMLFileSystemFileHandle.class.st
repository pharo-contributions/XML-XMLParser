"
This class uses the Pharo FileSystem API to implement file IO. The preferred implementation.
"
Class {
	#name : #XMLFileSystemFileHandle,
	#superclass : #XMLFileHandle,
	#instVars : [
		'fileReference'
	],
	#category : #'XML-Parser-File'
}

{ #category : #private }
XMLFileSystemFileHandle class >> basicCurrentWorkingDirectory [
	^ String streamContents: [:stream |
		"the class-side workingDirectory isn't used for backwards compatibility"
		(Smalltalk at: #FileSystem) disk workingDirectory
			path segments do: [:each |
				stream
					nextPut: $/;
					nextPutAll: each]].
]

{ #category : #'instance creation' }
XMLFileSystemFileHandle class >> fileReference: aFileReference [
	^ self new fileReference: aFileReference
]

{ #category : #testing }
XMLFileSystemFileHandle class >> isSupportedImplementation [
	^ Smalltalk includesKey: #FileSystem
]

{ #category : #private }
XMLFileSystemFileHandle >> basicDelete [
	self fileReference delete
]

{ #category : #testing }
XMLFileSystemFileHandle >> exists [
	^ self fileReference exists
]

{ #category : #accessing }
XMLFileSystemFileHandle >> fileReference [
	^ fileReference ifNil: [fileReference := self path asFileReference]
]

{ #category : #accessing }
XMLFileSystemFileHandle >> fileReference: aFileReference [
	fileReference := aFileReference.
	self path: aFileReference fullName.
]

{ #category : #accessing }
XMLFileSystemFileHandle >> fileSize [
	^ self fileReference size
]

{ #category : #testing }
XMLFileSystemFileHandle >> isFile [
	^ self fileReference isFile
]

{ #category : #private }
XMLFileSystemFileHandle >> newFileReadStreamOnPath [
	"memory file references need special handling"
	self fileReference fileSystem isMemoryFileSystem
		ifTrue: [^ self fileReference readStream]
		ifFalse: [^ super newFileReadStreamOnPath]
]

{ #category : #private }
XMLFileSystemFileHandle >> newFileWriteStreamOnPath [
	"memory file references need special handling"
	self fileReference fileSystem isMemoryFileSystem
		ifTrue: [^ self fileReference writeStream]
		ifFalse: [^ super newFileWriteStreamOnPath]
]

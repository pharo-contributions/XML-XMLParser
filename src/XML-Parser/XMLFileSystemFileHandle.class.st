"
This class uses the Pharo FileSystem API to implement file IO. The preferred implementation.
"
Class {
	#name : #XMLFileSystemFileHandle,
	#superclass : #XMLFileHandle,
	#instVars : [
		'fileReference'
	],
	#category : #'XML-Parser-Files'
}

{ #category : #private }
XMLFileSystemFileHandle class >> basicCurrentWorkingDirectory [
	^ String streamContents: [:stream |
		"the class-side workingDirectory isn't used for backwards compatibility"
		(XMLClassFinder classNamed: #FileSystem) disk workingDirectory
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
	^ XMLClassFinder hasClassNamed: #FileSystem
]

{ #category : #private }
XMLFileSystemFileHandle >> basicDelete [
	self fileReference delete
]

{ #category : #private }
XMLFileSystemFileHandle >> basicFileSize [
	^ self fileReference size
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

{ #category : #testing }
XMLFileSystemFileHandle >> isFile [
	^ self fileReference isFile
]

{ #category : #private }
XMLFileSystemFileHandle >> newFileReadStreamOnPath [
	"memory file references need special handling"
	self usesMemoryStore
		ifTrue: [^ self fileReference readStream].
	^ super newFileReadStreamOnPath.
]

{ #category : #private }
XMLFileSystemFileHandle >> newFileWriteStreamOnPath [
	"memory file references need special handling"
	self usesMemoryStore
		ifTrue: [^ self fileReference writeStream].
	^ super newFileWriteStreamOnPath.
]

{ #category : #private }
XMLFileSystemFileHandle >> usesMemoryStore [
	"Pharo 3.0 has memory stores but lacks #isMemoryFileSystem, so
	this test is used instead for backwards compatibility"
	^ self fileReference fileSystem store class ==
		(XMLClassFinder classNamed: #MemoryStore)
]

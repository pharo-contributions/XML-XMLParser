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
XMLFileSystemFileHandle class >> currentWorkingDirectoryPathString [
	^ String streamContents: [:stream |
		"the class-side workingDirectory isn't used for backwards compatibility"
		(Smalltalk at: #FileSystem) disk workingDirectory
			path segments do: [:each |
				stream
					nextPut: $/;
					nextPutAll: each]].
]

{ #category : #testing }
XMLFileSystemFileHandle class >> isSupportedImplementation [
	^ Smalltalk includesKey: #FileSystem
]

{ #category : #private }
XMLFileSystemFileHandle >> deleteFileOrDo: aBlock [
	[self fileReference delete]
		on: self fileSystemError 
		do: aBlock
]

{ #category : #private }
XMLFileSystemFileHandle >> fileReference [
	^ fileReference ifNil: [fileReference := path asFileReference]
]

{ #category : #accessing }
XMLFileSystemFileHandle >> fileSize [
	^ self fileReference size
]

{ #category : #private }
XMLFileSystemFileHandle >> fileSystemError [
	^ Smalltalk at: #FileSystemError
]

{ #category : #testing }
XMLFileSystemFileHandle >> isFile [
	^ self fileReference isFile
]

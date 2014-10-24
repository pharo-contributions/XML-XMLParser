"
This class uses the Pharo FileSystem API to implement file IO.
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
		(Smalltalk at: #FileSystem) workingDirectory
			path segments do: [:each |
				stream
					nextPut: $/;
					nextPutAll: each]].
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

{ #category : #private }
XMLFileSystemFileHandle >> readStreamOnFileOrDo: aBlock [
	^ [self fileReference readStream]
		on: self fileSystemError
		do: aBlock
]

{ #category : #private }
XMLFileSystemFileHandle >> writeStreamOnFileOrDo: aBlock [
	^ [self fileReference writeStream]
		on: self fileSystemError
		do: aBlock
]

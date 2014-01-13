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
XMLFileSystemFileHandle class >> currentWorkingDirectoryPath [
	| fileSystemPath |

	fileSystemPath := (Smalltalk at: #FileSystem) workingDirectory path.
	^ ($/ join: fileSystemPath segments) copyWithFirst: $/.
]

{ #category : #private }
XMLFileSystemFileHandle >> fileReference [
	^ fileReference ifNil: [fileReference := path asFileReference]
]

{ #category : #testing }
XMLFileSystemFileHandle >> isFile [
	^ self fileReference isFile
]

{ #category : #private }
XMLFileSystemFileHandle >> readStreamOnFileOrDo: aBlock [
	^ [self fileReference readStream]
		on: (Smalltalk at: #FileSystemError)
		do: aBlock
]

{ #category : #accessing }
XMLFileSystemFileHandle >> sizeOnDisk [
	^ self fileReference size
]

"
This uses the FileSystem API to implement file IO, but does not refer to FileSystem classes directly to avoid compile errors on platforms without FileSystem.

"
Class {
	#name : #XMLFileSystemClient,
	#superclass : #XMLFileClient,
	#category : #'XML-Parser-Clients'
}

{ #category : #paths }
XMLFileSystemClient >> combineRelative: aRelativePath withBase: aBasePath [

	^ (self isNonRelative: aRelativePath)
		ifTrue: [aRelativePath]
		ifFalse: [
			(self pathClass from: aBasePath) asFileReference isDirectory
				ifTrue: [
					self systemPathFrom:
						(self pathClass from: aBasePath) / (self trimRelativePath: aRelativePath)]
				ifFalse: [
					self systemPathFromSegments:
						(self pathClass from: aBasePath) segments allButLast,
							(self pathClass from: (self trimRelativePath: aRelativePath))]]
]

{ #category : #paths }
XMLFileSystemClient >> currentWorkingDirectory [
	^ self systemPathFrom: (Smalltalk at: #FileSystem) workingDirectory path
]

{ #category : #retrieving }
XMLFileSystemClient >> get: aFullPath onError: aBlock [
	^ [(self pathClass from: aFullPath) asFileReference readStream]
		on: (Smalltalk at: #FileSystemError)
		do: aBlock
]

{ #category : #private }
XMLFileSystemClient >> pathClass [
	^ Smalltalk at: #Path
]

{ #category : #private }
XMLFileSystemClient >> systemPathFrom: aFileSystemPath [
	^ self systemPathFromSegments: aFileSystemPath segments
]

{ #category : #private }
XMLFileSystemClient >> systemPathFromSegments: aFileSystemPathSegmentArray [
	| pathStream |

	pathStream := (String new: 32) writeStream.
	aFileSystemPathSegmentArray
		do: [:each |
			pathStream
				nextPut: self pathSeparator;
				nextPutAll: each].
	pathStream position > 0
		ifFalse: [pathStream nextPut: self pathSeparator].
	^ pathStream contents.
]

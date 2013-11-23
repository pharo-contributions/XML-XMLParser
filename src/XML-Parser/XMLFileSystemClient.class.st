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
	| basePath fullPathString |

	(self isNonRelative: aRelativePath)
		ifTrue: [^ aRelativePath].

	(basePath := self pathClass from: aBasePath) asFileReference isDirectory
		ifTrue: [
			fullPathString :=
				self systemPathFrom: (basePath / (self trimRelativePath: aRelativePath))]
		ifFalse: [
			fullPathString :=
				self pathSeparator join:
					(basePath segments allButLast,
						(self pathClass from: (self trimRelativePath: aRelativePath)))].
	^ (self isNonRelative: aBasePath)
		ifTrue: [fullPathString copyWithFirst: self pathSeparator]
		ifFalse: [fullPathString].
]

{ #category : #paths }
XMLFileSystemClient >> currentWorkingDirectory [
	^ (self systemPathFrom: (Smalltalk at: #FileSystem) workingDirectory path)
		copyWithFirst: self pathSeparator
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
	^ self pathSeparator join: aFileSystemPath segments
]

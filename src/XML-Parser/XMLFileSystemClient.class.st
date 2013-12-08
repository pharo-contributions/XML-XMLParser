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
	| basePathObject fullPathString |

	(self isNonRelative: aRelativePath)
		ifTrue: [^ aRelativePath].

	basePathObject := self pathObjectFrom: aBasePath.
	fullPathString :=
		(basePathObject isRoot or: [aBasePath last == self pathSeparator])
			ifTrue: [self pathToString: (basePathObject / (self trimRelativePath: aRelativePath))]
			ifFalse: [
				self pathSeparator join:
					(basePathObject segments allButLast
						copyWith: (self trimRelativePath: aRelativePath))].
	^ (self isNonRelative: aBasePath)
		ifTrue: [self makeNonRelative: fullPathString]
		ifFalse: [fullPathString].
]

{ #category : #paths }
XMLFileSystemClient >> currentWorkingDirectory [
	^ self makeNonRelative:
		(self pathToString: (Smalltalk at: #FileSystem) workingDirectory path)
]

{ #category : #retrieving }
XMLFileSystemClient >> get: aFullPath onError: aBlock [
	^ [(self pathObjectFrom: aFullPath) asFileReference readStream]
		on: (Smalltalk at: #FileSystemError)
		do: aBlock
]

{ #category : #testing }
XMLFileSystemClient >> isNonRelative: aPathString [
	^ (self pathObjectFrom: aPathString) isRelative not
]

{ #category : #private }
XMLFileSystemClient >> makeNonRelative: aPathString [
	^ aPathString copyWithFirst: self pathSeparator
]

{ #category : #private }
XMLFileSystemClient >> pathObjectFrom: aPathString [
	^ (Smalltalk at: #Path) from: aPathString
]

{ #category : #private }
XMLFileSystemClient >> pathToString: aPathObject [
	^ self pathSeparator join: aPathObject segments
]

{ #category : #paths }
XMLFileSystemClient >> trimRelativePath: aPath [
	^ (aPath beginsWith: (String with: $. with: self pathSeparator))
		ifTrue: [aPath allButFirst: 2]
		ifFalse: [aPath]
]

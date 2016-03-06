"
This class uses FileDirectory/DirectoryEntry to implement file IO. This is used on Squeak and Gemstone, which don't support the FileSystem API.
"
Class {
	#name : #XMLFileDirectoryFileHandle,
	#superclass : #XMLFileHandle,
	#instVars : [
		'fileDirectory'
	],
	#category : #'XML-Parser-File'
}

{ #category : #private }
XMLFileDirectoryFileHandle class >> currentWorkingDirectoryPathString [
	^ (Smalltalk at: #FileDirectory) default pathName
]

{ #category : #testing }
XMLFileDirectoryFileHandle class >> isSupportedImplementation [
	^ Smalltalk includesKey: #FileDirectory
]

{ #category : #private }
XMLFileDirectoryFileHandle >> deleteFileOrDo: aBlock [
	[self fileDirectory
		deleteFileNamed: path
		ifAbsent: [^ aBlock value]]
		on: Error
		do: aBlock
]

{ #category : #private }
XMLFileDirectoryFileHandle >> directoryEntry [
	^ self fileDirectory directoryEntryFor: path
]

{ #category : #private }
XMLFileDirectoryFileHandle >> fileDirectory [
	^ fileDirectory
		ifNil: [fileDirectory := (Smalltalk at: #FileDirectory) default]
]

{ #category : #accessing }
XMLFileDirectoryFileHandle >> fileSize [
	^ (self directoryEntry ifNil: [^ 0]) fileSize
]

{ #category : #testing }
XMLFileDirectoryFileHandle >> isFile [
	^ self directoryEntry notNil
		and: [self directoryEntry isDirectory not]
]

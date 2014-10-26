"
This class uses FileDirectory/DirectoryEntry to implement file IO.
"
Class {
	#name : #XMLFileDirectoryFileHandle,
	#superclass : #XMLFileHandle,
	#instVars : [
		'directoryEntry'
	],
	#category : #'XML-Parser-File'
}

{ #category : #private }
XMLFileDirectoryFileHandle class >> currentWorkingDirectoryPathString [
	^ (Smalltalk at: #FileDirectory) default pathName
]

{ #category : #testing }
XMLFileDirectoryFileHandle class >> isSupported [
	^ Smalltalk includesKey: #FileDirectory
]

{ #category : #private }
XMLFileDirectoryFileHandle >> deleteFileOrDo: aBlock [
	[(self directoryEntry ifNil: [^ aBlock value]) delete]
		on: Error
		do: aBlock
]

{ #category : #private }
XMLFileDirectoryFileHandle >> directoryEntry [
	^ directoryEntry
		ifNil: [directoryEntry := (Smalltalk at: #FileDirectory) directoryEntryFor: path]
]

{ #category : #accessing }
XMLFileDirectoryFileHandle >> fileSize [
	^ (self directoryEntry ifNil: [^ 0]) size
]

{ #category : #testing }
XMLFileDirectoryFileHandle >> isFile [
	^ self directoryEntry notNil
		and: [self directoryEntry isDirectory not]
]

{ #category : #private }
XMLFileDirectoryFileHandle >> readStreamOnFileOrDo: aBlock [
	^ [((Smalltalk at: #FileStream) readOnlyFileNamed: path)]
		on: Error
		do: aBlock
]

{ #category : #private }
XMLFileDirectoryFileHandle >> writeStreamOnFileOrDo: aBlock [
	^ [((Smalltalk at: #FileStream) newFileNamed: path)]
		on: Error
		do: aBlock
]

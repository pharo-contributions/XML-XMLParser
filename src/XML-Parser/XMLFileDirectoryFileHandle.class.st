"
This class uses FileDirectory/DirectoryEntry to implement file IO.
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
	^ self fileDirectory directoryEntryFor: path
]

{ #category : #private }
XMLFileDirectoryFileHandle >> fileDirectory [
	^ fileDirectory ifNil: [fileDirectory := (Smalltalk at: #FileDirectory) default]
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

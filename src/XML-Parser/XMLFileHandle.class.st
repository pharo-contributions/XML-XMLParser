"
This is an abstract class for file handles to read/write/delete files. Subclasses need to implement the abstract methods. The class defaultImplementation method should return the subclass to use for this platform.
"
Class {
	#name : #XMLFileHandle,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'XML-Parser-File'
}

{ #category : #accessing }
XMLFileHandle class >> currentWorkingDirectory [
	^ self implementation currentWorkingDirectoryPathString
]

{ #category : #private }
XMLFileHandle class >> currentWorkingDirectoryPathString [
	self subclassResponsibility
]

{ #category : #accessing }
XMLFileHandle class >> defaultImplementation [
	^ (Smalltalk includesKey: #FileSystem)
		ifTrue: [XMLFileSystemFileHandle]
		ifFalse: [XMLFileDirectoryFileHandle]
]

{ #category : #accessing }
XMLFileHandle class >> implementation [
	^ self == XMLFileHandle
		ifTrue: [self defaultImplementation]
		ifFalse: [self]
]

{ #category : #'instance creation' }
XMLFileHandle class >> path: aSystemPath [
	^ self implementation new path: aSystemPath
]

{ #category : #deleting }
XMLFileHandle >> delete [
	self deleteFileOrDo: [:error | error resignalAs: XMLFileException]
]

{ #category : #private }
XMLFileHandle >> deleteFileOrDo: aBlock [
	self subclassResponsibility
]

{ #category : #accessing }
XMLFileHandle >> fileSize [
	self subclassResponsibility
]

{ #category : #requesting }
XMLFileHandle >> get [
	^ self readStream
]

{ #category : #requesting }
XMLFileHandle >> getUpToLimit: aMaxSize [
	^ self readStreamUpToLimit: aMaxSize
]

{ #category : #testing }
XMLFileHandle >> isFile [
	self subclassResponsibility
]

{ #category : #accessing }
XMLFileHandle >> path [
	^ path
]

{ #category : #accessing }
XMLFileHandle >> path: aPath [
	path := aPath
]

{ #category : #reading }
XMLFileHandle >> readStream [
	^ self readStreamUpToLimit: nil
]

{ #category : #private }
XMLFileHandle >> readStreamOnFileOrDo: aBlock [
	self subclassResponsibility
]

{ #category : #reading }
XMLFileHandle >> readStreamUpToLimit: aMaxSize [
	| fileSize |

	self isFile
		ifFalse: [XMLFileException signal: 'Not a file'].
	
	(fileSize := self fileSize) > 0
		ifFalse: [ ^ '' readStream].
	(aMaxSize notNil and: [fileSize > aMaxSize])
		ifTrue: [XMLLimitException signal: 'File size limit exceeded'].

	^ self readStreamOnFileOrDo: [:error | error resignalAs: XMLFileException]
]

{ #category : #writing }
XMLFileHandle >> writeStream [
	^ self writeStreamOnFileOrDo: [:error | error resignalAs: XMLFileException]
]

{ #category : #private }
XMLFileHandle >> writeStreamOnFileOrDo: aBlock [
	self subclassResponsibility
]

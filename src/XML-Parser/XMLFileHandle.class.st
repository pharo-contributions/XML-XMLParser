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

{ #category : #private }
XMLFileHandle class >> errorUnsupported [
	XMLFileException signal: 'File IO unsupported'.
]

{ #category : #private }
XMLFileHandle class >> implementation [
	^ self == XMLFileHandle
		ifTrue: [self selectImplementation]
		ifFalse: [self]
]

{ #category : #testing }
XMLFileHandle class >> isSupported [
	^ false
]

{ #category : #'instance creation' }
XMLFileHandle class >> new [
	^ self implementation basicNew initialize
]

{ #category : #'instance creation' }
XMLFileHandle class >> path: aSystemPath [
	^ self new path: aSystemPath
]

{ #category : #private }
XMLFileHandle class >> preferredImplementation [
	^ XMLFileSystemFileHandle
]

{ #category : #private }
XMLFileHandle class >> selectImplementation [
	self preferredImplementation isSupported
		ifTrue: [^ self preferredImplementation].
	self allSubclassesDo: [:each |
		each isSupported
			ifTrue: [^ each]].
	self errorUnsupported.
]

{ #category : #deleting }
XMLFileHandle >> delete [
	self deleteFileOrDo: [:error | error resignalAs: XMLFileException]
]

{ #category : #private }
XMLFileHandle >> deleteFileOrDo: aBlock [
	self subclassResponsibility
]

{ #category : #private }
XMLFileHandle >> errorFileSize: aFileSize exceedsMaxSize: aMaxSize [
	XMLLimitException
		formatSignal: 'File of size {1} exceeds max size limit of {2}: {3}'
		with: aFileSize
		with: aMaxSize
		with: path
]

{ #category : #private }
XMLFileHandle >> errorNotAFile [
	XMLFileException
		formatSignal: 'Not a file: {1}'
		with: path
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
		ifFalse: [self errorNotAFile].
	
	(fileSize := self fileSize) > 0
		ifFalse: [ ^ '' readStream].
	(aMaxSize notNil and: [fileSize > aMaxSize])
		ifTrue: [self errorFileSize: fileSize exceedsMaxSize: aMaxSize].

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

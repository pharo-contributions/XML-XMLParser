"
This is an abstract class for file handles to read files from disk.
"
Class {
	#name : #XMLFileHandle,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'XML-Parser-File'
}

{ #category : #private }
XMLFileHandle class >> currentWorkingDirectoryPath [
	self subclassResponsibility
]

{ #category : #accessing }
XMLFileHandle class >> defaultImplementation [
	^ XMLFileSystemFileHandle
]

{ #category : #'instance creation' }
XMLFileHandle class >> path: aSystemPath [
	^ self new path: aSystemPath
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
	| sizeOnDisk |

	self isFile
		ifFalse: [XMLFileException signal: 'Not a file'].
	
	(sizeOnDisk := self sizeOnDisk) > 0
		ifFalse: [ ^ '' readStream].
	(aMaxSize notNil and: [sizeOnDisk > aMaxSize])
		ifTrue: [XMLLimitException signal: 'File size limit exceeded'].

	^ self readStreamOnFileOrDo: [:error | XMLFileException signal: error messageText]
]

{ #category : #accessing }
XMLFileHandle >> sizeOnDisk [
	self subclassResponsibility
]

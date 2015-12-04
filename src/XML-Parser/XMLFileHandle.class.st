"
This is an abstract class for file handles to read/write/delete files. Subclasses need to implement the abstract methods.
"
Class {
	#name : #XMLFileHandle,
	#superclass : #XMLAbstractFactory,
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
	XMLFileException signal: 'File IO unsupported'
]

{ #category : #'instance creation' }
XMLFileHandle class >> path: aSystemPath [
	^ self new path: aSystemPath
]

{ #category : #private }
XMLFileHandle class >> preferredImplementation [
	^ XMLFileSystemFileHandle
]

{ #category : #deleting }
XMLFileHandle >> delete [
	self deleteFileOrDo: [:error | XMLFileException signalMessageFrom: error]
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

{ #category : #retrieving }
XMLFileHandle >> get [
	^ self
		getUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLFileHandle >> getUpToLimit: aMaxSize decoding: aBoolean [
	| stream contents |

	stream :=
		self
			streamGetUpToLimit: aMaxSize
			decoding: aBoolean.
	contents := stream contents.
	stream close.

	^ contents.
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

{ #category : #printing }
XMLFileHandle >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: path;
		nextPut: $).
]

{ #category : #reading }
XMLFileHandle >> readStream [
	^ self readStreamUpToLimit: nil
]

{ #category : #private }
XMLFileHandle >> readStreamOnFileOrDo: aBlock [
	^ [XMLFileReadStreamFactory on: path]
		on: Error
		do: aBlock
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

	^ self readStreamOnFileOrDo: [:error | XMLFileException signalMessageFrom: error]
]

{ #category : #retrieving }
XMLFileHandle >> streamGet [
	^ self
		streamGetUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLFileHandle >> streamGetUpToLimit: aMaxSize decoding: aBoolean [
	^ self readStreamUpToLimit: aMaxSize
]

{ #category : #writing }
XMLFileHandle >> writeStream [
	^ self writeStreamOnFileOrDo: [:error | XMLFileException signalMessageFrom: error]
]

{ #category : #private }
XMLFileHandle >> writeStreamOnFileOrDo: aBlock [
	^ [XMLFileWriteStreamFactory on: path]
		on: Error
		do: aBlock
]

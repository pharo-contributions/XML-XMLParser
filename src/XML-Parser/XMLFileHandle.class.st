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

{ #category : #converting }
XMLFileHandle >> asXMLFileHandle [
	^ self
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
	| stream upToEnd |

	stream :=
		self
			streamGetUpToLimit: aMaxSize
			decoding: aBoolean.
	upToEnd := stream upToEnd.
	stream close.

	^ upToEnd.
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
	^ self
		readStreamUpToLimit: nil
		decoding: true
]

{ #category : #reading }
XMLFileHandle >> readStreamDo: aBlock [
	| readStream |

	readStream := self readStream.
	^ [aBlock value: readStream]
		ensure: [readStream close].
]

{ #category : #reading }
XMLFileHandle >> readStreamUpToLimit: aMaxSize decoding: aBoolean [
	| fileSize readStream |

	self isFile
		ifFalse: [self errorNotAFile].
	
	(fileSize := self fileSize) > 0
		ifFalse: [ ^ '' readStream].

	(aMaxSize notNil
		and: [fileSize > aMaxSize])
		ifTrue: [self errorFileSize: fileSize exceedsMaxSize: aMaxSize].

	[readStream := XMLFileReadStreamFactory onPath: path]
		on: Error
		do: [:error | XMLFileException signalMessageFrom: error].

	aBoolean
		ifTrue: [| decodingReadStreamAdapter |
			decodingReadStreamAdapter := XMLDecodingReadStreamAdapter on: readStream.
			(XMLFileStreamEncodingDetector for: decodingReadStreamAdapter)
				detectCurrentEncoding.
			^ decodingReadStreamAdapter]
		ifFalse: [^ readStream].
]

{ #category : #retrieving }
XMLFileHandle >> streamGet [
	^ self
		streamGetUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLFileHandle >> streamGetUpToLimit: aMaxSize decoding: aBoolean [
	^ self
		readStreamUpToLimit: aMaxSize
		decoding: aBoolean
]

{ #category : #writing }
XMLFileHandle >> writeStream [
	^ self writeStreamDecoding: true
]

{ #category : #writing }
XMLFileHandle >> writeStreamDecoding: aBoolean [
	| writeStream |

	writeStream :=
		[XMLFileWriteStreamFactory onPath: path]
			on: Error
			do: [:error | XMLFileException signalMessageFrom: error].

	aBoolean
		ifTrue: [^ XMLEncodingWriteStreamAdapter on: writeStream]
		ifFalse: [^ writeStream].
]

{ #category : #writing }
XMLFileHandle >> writeStreamDo: aBlock [
	| writeStream |

	writeStream := self writeStream.
	^ [aBlock value: writeStream]
		ensure: [writeStream close].
]

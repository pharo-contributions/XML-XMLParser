"
This is an abstract class for file handles to read/write/delete files. Subclasses need to implement the abstract methods, and then instances of the correct concrete class for this platform can be created by sending #asXMLFileHandle to a string.

The #readStream/#writeStream messages return file streams that do decoding/encoding, while the #rawReadStream/#rawWriteStream streams don't.

The #get/#getUpToLimit:decoding: and #streamGet/#streamGetUpToLimit:decoding: interface of XMLURI is supported.
"
Class {
	#name : #XMLFileHandle,
	#superclass : #XMLAbstractFactory,
	#instVars : [
		'path'
	],
	#classVars : [
		'XMLDocumentFileExtensions'
	],
	#category : #'XML-Parser-Files'
}

{ #category : #private }
XMLFileHandle class >> basicCurrentWorkingDirectory [
	self subclassResponsibility
]

{ #category : #accessing }
XMLFileHandle class >> currentWorkingDirectory [
	"returns a path string for the current working directory"

	^ self implementation basicCurrentWorkingDirectory
]

{ #category : #private }
XMLFileHandle class >> errorNoSupportedImplementation [
	XMLFileException signal: 'File IO unsupported'
]

{ #category : #initialization }
XMLFileHandle class >> initialize [
	"self initialize"

	XMLDocumentFileExtensions :=
		Set withAll: "avoid newFrom: for GS portability"
			#('dbk' "DocBook XML"
				'docm' "Office Open XML Document"
				'docx' "Office Open XML Document"
				'pptm' "Office Open XML Presentation"
				'pptx' "Office Open XML Presentation"
				'rdf' "Resource Description Framework"
				'xbel' "XML Bookmark Exchange Language"
				'xfd' "Extensible Forms Description Language"
				'xfdl' "Extensible Forms Description Language"
				'xhtml'
				'xlsm' "Office Open XML Workbook"
				'xlsx' "Office Open XML Workbook"
				'xml'
				'xsd' "XML Schema Definition"
				'xspf' "XML Shareable Playlist Format"
				'xul') "XML User Interface Language"
]

{ #category : #'instance creation' }
XMLFileHandle class >> path: aPathString [
	^ self new path: aPathString
]

{ #category : #accessing }
XMLFileHandle class >> preferredImplementation [
	^ XMLFileSystemFileHandle
]

{ #category : #converting }
XMLFileHandle >> asXMLFileHandle [
	^ self
]

{ #category : #private }
XMLFileHandle >> basicDelete [
	self subclassResponsibility
]

{ #category : #accessing }
XMLFileHandle >> contents [
	"the read stream adapters don't support #contents so #upToEnd is used instead"
	^ self readStreamDo: [:readStream | readStream upToEnd]
]

{ #category : #deleting }
XMLFileHandle >> delete [
	self exists
		ifFalse: [self errorFileDoesNotExist].

	[self basicDelete]
		on: Error
		do: [:error | XMLFileException signalMessageFrom: error].
]

{ #category : #private }
XMLFileHandle >> errorFileDoesNotExist [
	XMLFileException
		formatSignal: 'File does does not exist: {1}'
		with: self path
]

{ #category : #private }
XMLFileHandle >> errorFileExceedsMaxSize: aMaxSize [
	XMLLimitException
		formatSignal: 'File exceeds max size of {1}: {2}'
		with: aMaxSize
		with: self path
]

{ #category : #private }
XMLFileHandle >> errorNotAFile [
	XMLFileException
		formatSignal: 'Not a file: {1}'
		with: self path
]

{ #category : #testing }
XMLFileHandle >> exists [
	"returns true if the file exists"

	self subclassResponsibility
]

{ #category : #accessing }
XMLFileHandle >> extension [
	^ self path copyAfterLast: $.
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

	"can be safely implemented using streamGetUpToLimit:decoding: rather
	than the other way around like XMLHTTPRequest requires, because files
	are local and can be safely read incrementally, unlike an HTTP response
	which must be read immediately and stored entirely in memory"
	stream :=
		self
			streamGetUpToLimit: aMaxSize
			decoding: aBoolean.
	"the read stream adapters don't support #contents so #upToEnd is used instead"
	contents := stream upToEnd.
	stream close.

	^ contents.
]

{ #category : #testing }
XMLFileHandle >> isFile [
	"returns true if the file exists and is a file (not a directory)"

	self subclassResponsibility
]

{ #category : #testing }
XMLFileHandle >> isXMLDocumentFile [
	"Returns true if the file has a known extension of an XML document format
	such as .xml, .xhtml, .xul, but not .dtd, .ent, or other XML-related
	formats that aren't proper XML documents."

	^ XMLDocumentFileExtensions includes: self extension asLowercase
]

{ #category : #private }
XMLFileHandle >> newFileReadStreamOnPath [
	^ XMLFileReadStreamFactory onPath: self path
]

{ #category : #private }
XMLFileHandle >> newFileWriteStreamOnPath [
	^ XMLFileWriteStreamFactory onPath: self path
]

{ #category : #accessing }
XMLFileHandle >> path [
	^ path
]

{ #category : #accessing }
XMLFileHandle >> path: aPathString [
	path := aPathString
]

{ #category : #printing }
XMLFileHandle >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self path;
		nextPut: $).
]

{ #category : #reading }
XMLFileHandle >> rawReadStream [
	"returns a raw file read stream with no decoding"

	self exists
		ifFalse: [self errorFileDoesNotExist].
	self isFile
		ifFalse: [self errorNotAFile].
	
	^ [self newFileReadStreamOnPath]
		on: Error
		do: [:error | XMLFileException signalMessageFrom: error].
]

{ #category : #writing }
XMLFileHandle >> rawWriteStream [
	"returns a raw file write stream with no encoding; truncates existing files"

	^ [self newFileWriteStreamOnPath]
		on: Error
		do: [:error | XMLFileException signalMessageFrom: error]
]

{ #category : #reading }
XMLFileHandle >> readStream [
	"returns a file read stream with decoding"

	| decodingReadStreamAdapter |
	
	decodingReadStreamAdapter :=
		XMLDecodingReadStreamAdapter on: self rawReadStream.
	(XMLFileStreamEncodingDetector on: decodingReadStreamAdapter)
			detectCurrentEncoding.
	^ decodingReadStreamAdapter.
]

{ #category : #reading }
XMLFileHandle >> readStreamDo: aBlock [
	| readStream |

	readStream := self readStream.
	^ [aBlock value: readStream]
		ensure: [readStream close].
]

{ #category : #retrieving }
XMLFileHandle >> streamGet [
	^ self
		streamGetUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLFileHandle >> streamGetUpToLimit: aMaxSize decoding: aBoolean [
	(aMaxSize notNil
		and: [self fileSize > aMaxSize])
		ifTrue: [self errorFileExceedsMaxSize: aMaxSize].

	^ aBoolean
		ifTrue: [self readStream]
		ifFalse: [self rawReadStream].
]

{ #category : #writing }
XMLFileHandle >> writeStream [
	^ XMLEncodingWriteStreamAdapter on: self rawWriteStream
]

{ #category : #writing }
XMLFileHandle >> writeStreamDo: aBlock [
	| writeStream |

	writeStream := self writeStream.
	^ [aBlock value: writeStream]
		ensure: [writeStream close].
]

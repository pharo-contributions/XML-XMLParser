"
This is an abstract base class for response content readers. The #readUpToLimit:decoding: message returns the entire  decoded (if enabled) response content, raising an XMLLimitException if it exceeds the specified limit.

Subclasses need to implement #rawReadWithLength:upToLimit: to read and return the raw response content and signal an error if it exceeds the limit.
"
Class {
	#name : #XMLHTTPResponseContentReader,
	#superclass : #Object,
	#instVars : [
		'response',
		'rawContent',
		'contentReadStream',
		'limitedContentReadStream',
		'isDecompressing'
	],
	#category : #'XML-Parser-HTTP'
}

{ #category : #accessing }
XMLHTTPResponseContentReader class >> response: aResponse [
	^ self new setResponse: aResponse
]

{ #category : #private }
XMLHTTPResponseContentReader >> contentReadStreamUpToEnd [
	| contentWriteStream |

	contentWriteStream := self newContentWriteStream.
	[contentReadStream atEnd]
		whileFalse: [contentWriteStream nextPut: contentReadStream next].
	^ contentWriteStream contents.
]

{ #category : #private }
XMLHTTPResponseContentReader >> decodedContentReadStreamUpToEndWithCharset: aCharset [
	| streamConverter |

	(streamConverter := aCharset asXMLStreamConverter) isNull
		ifTrue: [self errorUnrecognizedContentTypeCharset: aCharset].

	contentReadStream :=
		XMLDecodingReadStreamAdapter
			on: contentReadStream
			streamConverter: streamConverter.

	[^ self contentReadStreamUpToEnd]
		on: XMLEncodingException
		do: [:error |
			"might actually be a limit exception"
			self ensureContentReadStreamWasNotLimited.

			error pass].
]

{ #category : #private }
XMLHTTPResponseContentReader >> ensureContentReadStreamWasNotLimited [
	(limitedContentReadStream isNotNil
		and: [limitedContentReadStream atLimitedEnd])
		ifTrue: [self errorContentLimitExceeded]
]

{ #category : #private }
XMLHTTPResponseContentReader >> errorContentLimitExceeded [
	XMLLimitException signal: 'HTTP reponse content limit exceeded'
]

{ #category : #private }
XMLHTTPResponseContentReader >> errorUnrecognizedContentTypeCharset: aCharset [
	XMLEncodingException
		formatSignal:
			'Unrecognized Content-Type charset "{1}" encoding for HTTP content'
		with: aCharset
]

{ #category : #testing }
XMLHTTPResponseContentReader >> handlesDecompression [
	^ false
]

{ #category : #initialization }
XMLHTTPResponseContentReader >> initializeDecompressionWithSchemes: aCompressionSchemeSequence upToLimit: aMaxSize [
	isDecompressing := true.
	aCompressionSchemeSequence reverseDo: [:each |
		contentReadStream :=
			XMLHTTPDecompressingReadStreamAdapterFactory
				on: contentReadStream
				compression: each].
	aMaxSize
		ifNotNil: [self limitContentReadStreamUpToLimit: aMaxSize].
]

{ #category : #accessing }
XMLHTTPResponseContentReader >> limitContentReadStreamUpToLimit: aMaxSize [
	limitedContentReadStream :=
		XMLLimitedReadStreamAdapter
			on: contentReadStream
			limit: aMaxSize.
	contentReadStream := limitedContentReadStream.
]

{ #category : #'instance creation' }
XMLHTTPResponseContentReader >> newContentWriteStream [
	^ (String new: rawContent size) writeStream
]

{ #category : #reading }
XMLHTTPResponseContentReader >> rawReadWithLength: aContentLength upToLimit: aMaxSize [
	self subclassResponsibility
]

{ #category : #reading }
XMLHTTPResponseContentReader >> readUpToLimit: arg1 decoding: arg2 [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := response contentLength.
	(response isChunked or: [ tmp1 isNil ])
		ifTrue: [ tmp1 := nil ]
		ifFalse: [
			tmp1 > 0 ifFalse: [ ^ '' ].
			(arg1 isNotNil and: [ tmp1 > arg1 ]) ifTrue: [
				self errorContentLimitExceeded ] ].
	rawContent := self rawReadWithLength: tmp1 upToLimit: arg1.
	contentReadStream := rawContent readStream.
	(self handlesDecompression and: [
		 (tmp3 := response contentEncoding) isNotEmpty ]) ifTrue: [
		self initializeDecompressionWithSchemes: tmp3 upToLimit: arg1 ].
	(arg2 and: [
		 (tmp2 := response contentType) isNotNil and: [
			 (tmp4 := tmp2 charset) ~= tmp2 defaultCharset ] ])
		ifTrue: [
		tmp5 := self decodedContentReadStreamUpToEndWithCharset: tmp4 ]
		ifFalse: [ tmp5 := self undecodedContentReadStreamUpToEnd ].
	self ensureContentReadStreamWasNotLimited.
	^ tmp5
]

{ #category : #initialization }
XMLHTTPResponseContentReader >> setResponse: aResponse [
	response := aResponse.
	isDecompressing := false.
]

{ #category : #streaming }
XMLHTTPResponseContentReader >> undecodedContentReadStreamUpToEnd [
	^ (isDecompressing
		or: [limitedContentReadStream isNotNil])
		ifTrue: [self contentReadStreamUpToEnd]
		ifFalse: [rawContent]
]

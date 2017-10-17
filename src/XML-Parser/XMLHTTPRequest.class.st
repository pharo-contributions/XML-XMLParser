"
This is an abstract base class for HTTP requests. Subclasses need to implement #basicGetResponseUpToLimit:decoding: to return the correct XMLHTTPResponse object or raise an exception if an HTTP/network error happens or if the response is too large.

These classes implement the #get/#getUpToLimit:decoding: and #streamGet/#streamGetUpToLimit:decoding: interface of XMLURI.
"
Class {
	#name : #XMLHTTPRequest,
	#superclass : #XMLAbstractFactory,
	#instVars : [
		'url'
	],
	#category : #'XML-Parser-HTTP'
}

{ #category : #finding }
XMLHTTPRequest class >> noSupportedImplementationFound [
	XMLHTTPException signal: 'HTTP unsupported; install Zinc or WebClient'
]

{ #category : #defaults }
XMLHTTPRequest class >> preferredImplementation [
	^ XMLZincHTTPRequest
]

{ #category : #'instance creation' }
XMLHTTPRequest class >> url: aURLString [
	^ self new setURL: aURLString
]

{ #category : #converting }
XMLHTTPRequest >> asXMLHTTPRequest [
	^ self
]

{ #category : #basic }
XMLHTTPRequest >> basicGetResponseUpToLimit: aMaxSize decoding: aBoolean [
	self subclassResponsibility
]

{ #category : #defaults }
XMLHTTPRequest >> defaultTimeout [
	^ 30
]

{ #category : #private }
XMLHTTPRequest >> errorHTTPException: anError [
	XMLHTTPException signalMessageFrom: anError
]

{ #category : #private }
XMLHTTPRequest >> errorHTTPResponseLimitExceeded [
	XMLLimitException signal: 'HTTP reponse limit exceeded'
]

{ #category : #retrieving }
XMLHTTPRequest >> get [
	^ self
		getUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLHTTPRequest >> getResponse [
	^ self
		getResponseUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLHTTPRequest >> getResponseUpToLimit: aMaxSize decoding: aBoolean [
	^ [self
			basicGetResponseUpToLimit: aMaxSize
			decoding: aBoolean]
			on: Error
			do: [:error |
				(self isMaxSizeException: error)
					ifTrue: [self errorHTTPResponseLimitExceeded]
					ifFalse: [self errorHTTPException: error]]
]

{ #category : #retrieving }
XMLHTTPRequest >> getUpToLimit: aMaxSize decoding: aBoolean [
	^ (self
		getResponseUpToLimit: aMaxSize
		decoding: aBoolean) content
]

{ #category : #testing }
XMLHTTPRequest >> isMaxSizeException: anException [
	^ anException class == XMLLimitException
]

{ #category : #'instance creation' }
XMLHTTPRequest >> newResponse [
	^ self responseClass request: self
]

{ #category : #printing }
XMLHTTPRequest >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self url;
		nextPut: $).
]

{ #category : #defaults }
XMLHTTPRequest >> responseClass [
	self subclassResponsibility
]

{ #category : #initialization }
XMLHTTPRequest >> setURL: aURLString [
	url := aURLString
]

{ #category : #retrieving }
XMLHTTPRequest >> streamGet [
	^ self
		streamGetUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLHTTPRequest >> streamGetUpToLimit: aMaxSize decoding: aBoolean [
	"must be implemented using getUpToLimit:decoding: rather than the other
	way around like XMLFileHandle does, because HTTP responses must be read
	immediately and stored entirely in memory, unlike a file stream which
	can safely be left open and read from incrementally"
	^ (self
		getUpToLimit: aMaxSize
		decoding: aBoolean) readStream
]

{ #category : #accessing }
XMLHTTPRequest >> url [
	^ url ifNil: [url := '']
]

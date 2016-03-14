"
A base class for HTTP requests. Subclasses need to implement the abstract requesting method to return the HTTP response as a string or raise an exception if an HTTP/network error happens or the response is too large.
"
Class {
	#name : #XMLHTTPRequest,
	#superclass : #XMLAbstractFactory,
	#instVars : [
		'url'
	],
	#category : #'XML-Parser-HTTP'
}

{ #category : #private }
XMLHTTPRequest class >> errorNoSupportedImplementation [
	XMLHTTPException signal: 'HTTP unsupported; install Zinc or WebClient'
]

{ #category : #accessing }
XMLHTTPRequest class >> preferredImplementation [
	^ XMLZincHTTPRequest
]

{ #category : #'instance creation' }
XMLHTTPRequest class >> url: aURL [
	^ self new url: aURL
]

{ #category : #converting }
XMLHTTPRequest >> asXMLHTTPRequest [
	^ self
]

{ #category : #private }
XMLHTTPRequest >> basicGetUpToLimit: aMaxSize decoding: aBoolean [
	self subclassResponsibility
]

{ #category : #private }
XMLHTTPRequest >> defaultTimeout [
	^ 30
]

{ #category : #retrieving }
XMLHTTPRequest >> get [
	^ self
		getUpToLimit: nil
		decoding: true
]

{ #category : #retrieving }
XMLHTTPRequest >> getUpToLimit: aMaxSize decoding: aBoolean [
	^ [self
			basicGetUpToLimit: aMaxSize
			decoding: aBoolean]
			on: Error
			do: [:error |
				(self isMaxSizeException: error)
					ifTrue: [XMLLimitException signal: 'HTTP reponse limit exceeded']
					ifFalse: [XMLHTTPException signalMessageFrom: error]]
]

{ #category : #private }
XMLHTTPRequest >> isMaxSizeException: anException [
	^ anException isKindOf: XMLLimitException
]

{ #category : #printing }
XMLHTTPRequest >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self url;
		nextPut: $).
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
	^ url
]

{ #category : #accessing }
XMLHTTPRequest >> url: aURL [
	url := aURL
]

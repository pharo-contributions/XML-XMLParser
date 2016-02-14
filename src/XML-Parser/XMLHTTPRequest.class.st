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
XMLHTTPRequest class >> errorUnsupported [
	XMLHTTPException signal: 'HTTP unsupported'
]

{ #category : #private }
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
XMLHTTPRequest >> defaultTimeout [
	^ 30
]

{ #category : #retrieving }
XMLHTTPRequest >> get [
	^ self
		getUpToLimit: nil
		decoding: true
]

{ #category : #private }
XMLHTTPRequest >> getResponseUpToLimit: aMaxSize decoding: aBoolean timeout: aTimeout onError: aBlock [
	self subclassResponsibility
]

{ #category : #retrieving }
XMLHTTPRequest >> getUpToLimit: aMaxSize decoding: aBoolean [
	^ self
		getResponseUpToLimit: aMaxSize
		decoding: aBoolean
		timeout: self defaultTimeout
		onError: [:error |
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
		nextPutAll: url;
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

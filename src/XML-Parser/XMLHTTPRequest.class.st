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

{ #category : #private }
XMLHTTPRequest >> defaultTimeout [
	^ 30
]

{ #category : #retrieving }
XMLHTTPRequest >> get [
	^ self getUpToLimit: nil
]

{ #category : #private }
XMLHTTPRequest >> getResponseUpToLimit: aMaxSize withTimeout: aTimeout onError: aBlock [
	self subclassResponsibility
]

{ #category : #retrieving }
XMLHTTPRequest >> getUpToLimit: aMaxSize [
	^ self
		getResponseUpToLimit: aMaxSize
		withTimeout: self defaultTimeout
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
	^ self streamGetUpToLimit: nil
]

{ #category : #retrieving }
XMLHTTPRequest >> streamGetUpToLimit: aMaxSize [
	^ (self getUpToLimit: aMaxSize) readStream
]

{ #category : #accessing }
XMLHTTPRequest >> url [
	^ url
]

{ #category : #accessing }
XMLHTTPRequest >> url: aURL [
	url := aURL
]

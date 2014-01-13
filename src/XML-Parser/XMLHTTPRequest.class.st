"
A base class for HTTP requests. Subclasses need to implement the abstract requesting method to return a ReadStream on the respone or raise an exception if it is too large or an HTTP error happens.
"
Class {
	#name : #XMLHTTPRequest,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #'XML-Parser-HTTP'
}

{ #category : #accessing }
XMLHTTPRequest class >> defaultImplementation [
	^ XMLZincHTTPRequest
]

{ #category : #'instance creation' }
XMLHTTPRequest class >> url: aUrl [
	^ self new url: aUrl
]

{ #category : #private }
XMLHTTPRequest >> defaultTimeout [
	^ 10
]

{ #category : #requesting }
XMLHTTPRequest >> get [
	^ self getUpToLimit: nil
]

{ #category : #private }
XMLHTTPRequest >> getResponseUpToLimit: aMaxSize withTimeout: aTimeout onError: aBlock [
	self subclassResponsibility
]

{ #category : #requesting }
XMLHTTPRequest >> getUpToLimit: aMaxSize [
	^ self
		getResponseUpToLimit: aMaxSize
		withTimeout: self defaultTimeout
		onError: [:error |
			(error isKindOf: XMLLimitException)
				ifTrue: [XMLLimitException signal: 'HTTP reponse limit exceeded']
				ifFalse: [XMLHTTPException signal: error messageText]]
]

{ #category : #accessing }
XMLHTTPRequest >> url [
	^ url
]

{ #category : #accessing }
XMLHTTPRequest >> url: aUrl [
	url := aUrl
]

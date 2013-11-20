"
A base class for HTTP clients. See the Zinc implementation for an example.
"
Class {
	#name : #XMLHTTPClient,
	#superclass : #XMLIOClient,
	#instVars : [
		'timeout'
	],
	#category : #'XML-Parser-Clients'
}

{ #category : #accessing }
XMLHTTPClient class >> defaultImplementation [
	^ XMLZincClient
]

{ #category : #testing }
XMLHTTPClient >> beginsWithSupportedURLProtocol: aUrl [
	^ self supportedURLProtocols anySatisfy: [:each |
		aUrl asLowercase beginsWith: each, '://']
]

{ #category : #retrieving }
XMLHTTPClient >> get: aUrl [
	^ self
		get: aUrl
		timeout: self timeout
]

{ #category : #retrieving }
XMLHTTPClient >> get: aUrl timeout: aTimeout [
	^ self
		get: aUrl
		timeout: aTimeout
		onError: [:error | XMLHTTPException signal: error messageText]
]

{ #category : #retrieving }
XMLHTTPClient >> get: aUrl timeout: aTimeout onError: aBlock [
	self subclassResponsibility
]

{ #category : #accessing }
XMLHTTPClient >> supportedURLProtocols [
	^ #('http' 'file')
]

{ #category : #accessing }
XMLHTTPClient >> timeout [
	^ timeout ifNil: [timeout := 30]
]

{ #category : #accessing }
XMLHTTPClient >> timeout: aNumber [
	timeout := aNumber
]

Class {
	#name : #XMLHTTPResponseTest,
	#superclass : #XMLHTTPMessageTest,
	#category : #'XML-Parser-Tests-HTTP'
}

{ #category : #testing }
XMLHTTPResponseTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLHTTPResponseTest >> messageClass [
	^ XMLHTTPResponse
]

{ #category : #tests }
XMLHTTPResponseTest >> testProtocol [

	| response |
	self isSupported ifFalse: [ ^ self ].

	response := self newMessage.
	self
		assert: response protocol equals: 'HTTP/1.1';
		assert: (response protocol: 'HTTP/1.0') identicalTo: response;
		assert: response protocol equals: 'HTTP/1.0'
]

{ #category : #tests }
XMLHTTPResponseTest >> testStatusCode [

	| response |
	self isSupported ifFalse: [ ^ self ].

	response := self newMessage.
	self
		assert: response statusCode equals: 200;
		assert: (response statusCode: 404) identicalTo: response;
		assert: response statusCode equals: 404
]

{ #category : #tests }
XMLHTTPResponseTest >> testStatusDescription [

	| response |
	self isSupported ifFalse: [ ^ self ].

	response := self newMessage.
	self assert: response statusDescription equals: 'OK'.

	response statusCode: 404.
	self assert: response statusDescription equals: 'Not Found'
]

{ #category : #tests }
XMLHTTPResponseTest >> testStatusLine [

	| response |
	self isSupported ifFalse: [ ^ self ].

	response := self newMessage.
	self assert: response statusLine equals: 'HTTP/1.1 200 OK'.

	response statusCode: 404.
	self assert: response statusLine equals: 'HTTP/1.1 404 Not Found'.

	response protocol: 'HTTP/1.0'.
	self assert: response statusLine equals: 'HTTP/1.0 404 Not Found'
]

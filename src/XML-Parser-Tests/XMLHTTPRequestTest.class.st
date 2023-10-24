Class {
	#name : #XMLHTTPRequestTest,
	#superclass : #XMLHTTPMessageTest,
	#category : #'XML-Parser-Tests-HTTP'
}

{ #category : #testing }
XMLHTTPRequestTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLHTTPRequestTest >> defaultTimeout [
	^ 30
]

{ #category : #accessing }
XMLHTTPRequestTest >> messageClass [
	^ XMLHTTPRequest
]

{ #category : #'instance creation' }
XMLHTTPRequestTest >> newMessage [
	^ self newRequestWithURL
]

{ #category : #'instance creation' }
XMLHTTPRequestTest >> newRequestWithURL [
	^ self messageClass url: self url
]

{ #category : #tests }
XMLHTTPRequestTest >> testAcceptEncoding [

	| request defaultValue absentValue |
	self isSupported ifFalse: [ ^ self ].

	request := self newRequestWithURL.
	defaultValue := request defaultAcceptEncoding asOrderedCollection.
	absentValue := OrderedCollection new.
	self
		assert: request acceptEncoding sorted equals: defaultValue sorted;
		assert: (request acceptEncoding: 'one') identicalTo: request;
		assert: request acceptEncoding
		equals: #( 'one' ) asOrderedCollection;
		assert: (request acceptEncoding: ' one, identity, two')
		identicalTo: request;
		assert: request acceptEncoding
		equals: #( 'one' 'two' ) asOrderedCollection;
		assert: (request acceptEncoding: #( 'one' )) identicalTo: request;
		assert: request acceptEncoding
		equals: #( 'one' ) asOrderedCollection;
		assert: (request acceptEncoding: #( 'one' 'identity' 'two' ))
		identicalTo: request;
		assert: request acceptEncoding
		equals: #( 'one' 'two' ) asOrderedCollection;
		assert: (request acceptEncoding: '') identicalTo: request;
		assert: request acceptEncoding equals: absentValue;
		assert: (request acceptEncoding: #(  )) identicalTo: request;
		assert: request acceptEncoding equals: absentValue.

	request
		headerAt: 'Accept-Encoding'
		put: 'identity,one,identity,two,identity,three,identity'.
	self
		assert: request acceptEncoding
		equals: #( 'one' 'two' 'three' ) asOrderedCollection.

	request removeHeaderAt: 'Accept-Encoding'.
	self assert: request acceptEncoding equals: absentValue
]

{ #category : #tests }
XMLHTTPRequestTest >> testAsXMLHTTPRequest [

	| request |
	self isSupported ifFalse: [ ^ self ].

	request := self newMessage.
	self assert: request asXMLHTTPRequest identicalTo: request
]

{ #category : #tests }
XMLHTTPRequestTest >> testEnableCompression [

	| request |
	self isSupported ifFalse: [ ^ self ].

	(request := self newRequestWithURL) acceptEncoding: ''.
	self
		assert: request enableCompression identicalTo: request;
		deny: request acceptEncoding isEmpty.
	request acceptEncoding do: [ :each |
		self assert:
			(XMLHTTPDecompressingReadStreamAdapterFactory classForCompression:
				 each) notNil ]
]

{ #category : #tests }
XMLHTTPRequestTest >> testMethod [

	| request |
	self isSupported ifFalse: [ ^ self ].

	request := self newMessage.
	self
		assert: request method equals: 'GET';
		deny: request method isSymbol;
		assert: (request method: 'POST') identicalTo: request;
		assert: request method equals: 'POST';
		deny: request method isSymbol
]

{ #category : #tests }
XMLHTTPRequestTest >> testTimeout [

	| request |
	self isSupported ifFalse: [ ^ self ].

	request := self newMessage.
	self
		assert: request timeout equals: self defaultTimeout;
		assert: (request timeout: self defaultTimeout + 1)
		identicalTo: request;
		assert: request timeout equals: self defaultTimeout + 1
]

{ #category : #tests }
XMLHTTPRequestTest >> testURL [

	self isSupported ifFalse: [ ^ self ].
	self assert: self newRequestWithURL url equals: self url
]

{ #category : #accessing }
XMLHTTPRequestTest >> url [
	^ 'http://pharo.org'
]

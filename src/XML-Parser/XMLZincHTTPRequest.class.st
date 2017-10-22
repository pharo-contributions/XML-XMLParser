"
This class uses Zinc HTTP Components to implement HTTP requests and is the preferred implementation.
"
Class {
	#name : #XMLZincHTTPRequest,
	#superclass : #XMLHTTPRequest,
	#category : #'XML-Parser-HTTP'
}

{ #category : #testing }
XMLZincHTTPRequest class >> isSupportedImplementation [
	^ XMLClassFinder hasClassNamed: #ZnClient
]

{ #category : #basic }
XMLZincHTTPRequest >> basicGetResponseUpToLimit: aMaxSize decoding: aBoolean [
	"value:during: on GS doesn't return the result of evaluating its second
	argument, so instead the value:during: block is returned from"
	(XMLClassFinder classNamed: #ZnMaximumEntitySize)
		value: aMaxSize
		during: [
			"Use streaming entities to get the undecoded response when
			decoding is disabled. This is used to not conflict with our
			own decoding that relies on byte-order marks and <?xml?>
			encoding attributes."
			^ self newResponse setZincResponse:
				((XMLClassFinder classNamed: #ZnClient) new
					streaming: aBoolean not; "use streaming if not decoding"
					timeout: self defaultTimeout;
					url: self url;
					get;
					response)]
]

{ #category : #testing }
XMLZincHTTPRequest >> isMaxSizeException: anException [
	^ anException class == (XMLClassFinder classNamed: #ZnEntityTooLarge)
]

{ #category : #defaults }
XMLZincHTTPRequest >> responseClass [
	^ XMLZincHTTPResponse
]

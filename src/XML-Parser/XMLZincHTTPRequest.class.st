"
This client uses Zinc-HTTP, but does not refer to Zinc classes directly to avoid compile errors on platforms without Zinc.
"
Class {
	#name : #XMLZincHTTPRequest,
	#superclass : #XMLHTTPRequest,
	#category : #'XML-Parser-HTTP'
}

{ #category : #private }
XMLZincHTTPRequest >> getResponseUpToLimit: aMaxSize withTimeout: aTimeout onError: aBlock [
	^ (Smalltalk at: #ZnMaximumEntitySize)
		value: aMaxSize
		during: [
			((Smalltalk at: #ZnClient) new
				timeout: aTimeout;
				ifFail: [:error |
					(error isKindOf: (Smalltalk at: #ZnEntityTooLarge))
						ifTrue: [XMLLimitException signal]
						ifFalse: [error signal]];
				url: url;
				get) readStream]
]

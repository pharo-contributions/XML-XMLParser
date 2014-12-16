"
This client uses Zinc-HTTP, but does not refer to Zinc classes directly to avoid compile errors on platforms without Zinc.
"
Class {
	#name : #XMLZincHTTPRequest,
	#superclass : #XMLHTTPRequest,
	#category : #'XML-Parser-HTTP'
}

{ #category : #testing }
XMLZincHTTPRequest class >> isSupported [
	^ Smalltalk includesKey: #ZnClient
]

{ #category : #private }
XMLZincHTTPRequest >> getResponseUpToLimit: aMaxSize withTimeout: aTimeout onError: aBlock [
	^ self
		setZincMaxEntitySize: aMaxSize
		during: [
			((Smalltalk at: #ZnClient) new
				timeout: aTimeout;
				url: url;
				get) readStream]
		onError: aBlock
]

{ #category : #private }
XMLZincHTTPRequest >> isMaxSizeException: anException [
	^ anException isKindOf: (Smalltalk at: #ZnEntityTooLarge)
]

{ #category : #private }
XMLZincHTTPRequest >> setZincMaxEntitySize: aMaxSize during: aDuringBlock onError: anErrorBlock [
	^ [(Smalltalk at: #ZnMaximumEntitySize)
		value: aMaxSize
		during: [
			"value:during: doesn't return during block on gemstone"
			^ aDuringBlock value]]
		on: Error
		do: anErrorBlock
]

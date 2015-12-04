"
This client uses Zinc-HTTP, but does not refer to Zinc classes directly to avoid compile errors on platforms without it.
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
XMLZincHTTPRequest >> getResponseUpToLimit: aMaxSize decoding: aBoolean timeout: aTimeout onError: aBlock [
	^ self
		setZincMaxEntitySize: aMaxSize
		during: [
			"Use streaming entities to get the undecoded response when
			decoding is disabled. This is used to not conflict with our
			own decoding that relies on byte-order marks and <?xml?>
			encoding attributes."
			((Smalltalk at: #ZnClient) new
				streaming: aBoolean not;
				timeout: aTimeout;
				url: url;
				get;
				entity) contents]
		onError: aBlock
]

{ #category : #private }
XMLZincHTTPRequest >> isMaxSizeException: anException [
	^ anException isKindOf: (Smalltalk at: #ZnEntityTooLarge)
]

{ #category : #private }
XMLZincHTTPRequest >> setZincMaxEntitySize: aMaxSize during: aDuringBlock onError: anErrorBlock [
	^ [
		(Smalltalk at: #ZnMaximumEntitySize)
			value: aMaxSize
			during: [
				"^ is for GS value:during: which does not return block result"
				^ aDuringBlock value]]
		on: Error
		do: anErrorBlock
]

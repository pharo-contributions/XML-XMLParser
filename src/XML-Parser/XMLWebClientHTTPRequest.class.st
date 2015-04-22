"
This class uses the Squeak WebClient library, but does not refer to WebClient classes directly to avoid compile errors on platforms without it.
"
Class {
	#name : #XMLWebClientHTTPRequest,
	#superclass : #XMLHTTPRequest,
	#category : #'XML-Parser-HTTP'
}

{ #category : #testing }
XMLWebClientHTTPRequest class >> isSupported [
	^ Smalltalk includesKey: #WebClient
]

{ #category : #private }
XMLWebClientHTTPRequest >> getResponseUpToLimit: aMaxSize withTimeout: aTimeout onError: aBlock [
	^ [| response |
		response :=
			(Smalltalk at: #WebClient) new
				timeout: aTimeout;
				httpGet: url.
		response isSuccess
			ifFalse: [XMLHTTPException signal: response status].
		aMaxSize
			ifNotNil: [
				response contentLength
					ifNil: [
						response content size > aMaxSize
							ifTrue: [XMLLimitException signal]]
					ifNotNil: [
						response contentLength > aMaxSize
							ifTrue: [XMLLimitException signal]]].
		response content readStream]
			on: Error
			do: aBlock
]

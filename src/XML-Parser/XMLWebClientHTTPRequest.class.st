"
This class uses the WebClient library to implement HTTP requests. This is used on Squeak when Zinc isn't installed.
"
Class {
	#name : #XMLWebClientHTTPRequest,
	#superclass : #XMLHTTPRequest,
	#category : #'XML-Parser-HTTP'
}

{ #category : #testing }
XMLWebClientHTTPRequest class >> isSupportedImplementation [
	^ XMLClassFinder hasClassNamed: #WebClient
]

{ #category : #basic }
XMLWebClientHTTPRequest >> basicGetResponseUpToLimit: aMaxSize decoding: aBoolean [
	| response |

	(response := self newResponse)
		setWebClientResponse:
			((XMLClassFinder classNamed: #WebClient) new
				timeout: self defaultTimeout;
				httpGet: self url).
	response isSuccess
		ifFalse: [XMLHTTPException signal: response statusLine].
	aMaxSize
		ifNotNil: [
			response contentLength
				ifNil: [
					response content size > aMaxSize
						ifTrue: [XMLLimitException signal]]
				ifNotNil: [
					response contentLength > aMaxSize
						ifTrue: [XMLLimitException signal]]].
	aBoolean
		ifTrue: [response decodeContent].
	^ response.
]

{ #category : #defaults }
XMLWebClientHTTPRequest >> responseClass [
	^ XMLWebClientHTTPResponse
]

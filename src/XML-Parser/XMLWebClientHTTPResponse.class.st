"
This is a class for WebClient HTTP responses.
"
Class {
	#name : #XMLWebClientHTTPResponse,
	#superclass : #XMLHTTPResponse,
	#instVars : [
		'webClientResponse'
	],
	#category : #'XML-Parser-HTTP'
}

{ #category : #accessing }
XMLWebClientHTTPResponse >> content [
	^ self webClientResponse content
]

{ #category : #accessing }
XMLWebClientHTTPResponse >> contentLength [
	^ self webClientResponse contentLength
]

{ #category : #decoding }
XMLWebClientHTTPResponse >> decodeContent [
	| converter |

	(converter := self contentCharacterEncoding asXMLStreamConverter) isNull
		ifFalse: [
			"Zinc also does some additional encoding sniffing besides looking at
			the Content-Type charset like looking at BOMs, so to make the WebClient
			behavior more consistent with it, we use #detectEncoding before
			converting"
			self webClientResponse content:
				((XMLDecodingReadStreamAdapter
					on: self content readStream
					streamConverter: converter)
						detectEncoding;
						upToEnd)]
]

{ #category : #accessing }
XMLWebClientHTTPResponse >> headerAt: aKey ifAbsent: aBlock [
	^ self webClientResponse
		headerAt: aKey
		ifAbsent: aBlock
]

{ #category : #enumerating }
XMLWebClientHTTPResponse >> headerKeysAndValuesDo: aTwoArgumentBlock [
	self webClientResponse headersDo: aTwoArgumentBlock
]

{ #category : #enumerating }
XMLWebClientHTTPResponse >> headerValuesAt: aKey do: aBlock [
	self webClientResponse
		headersAt: aKey
		do: aBlock
]

{ #category : #testing }
XMLWebClientHTTPResponse >> isSuccess [
	^ self webClientResponse isSuccess
]

{ #category : #printing }
XMLWebClientHTTPResponse >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self webClientResponse;
		nextPut: $).
]

{ #category : #initialization }
XMLWebClientHTTPResponse >> setWebClientResponse: aWebClientResponse [
	webClientResponse := aWebClientResponse
]

{ #category : #accessing }
XMLWebClientHTTPResponse >> status [
	^ self webClientResponse code
]

{ #category : #accessing }
XMLWebClientHTTPResponse >> statusLine [
	^ self webClientResponse status ifNil: ['']
]

{ #category : #'private ' }
XMLWebClientHTTPResponse >> webClientResponse [
	^ webClientResponse
]

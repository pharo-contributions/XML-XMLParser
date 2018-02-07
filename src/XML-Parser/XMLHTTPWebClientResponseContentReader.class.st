"
A WebClient content reader.
"
Class {
	#name : #XMLHTTPWebClientResponseContentReader,
	#superclass : #XMLHTTPResponseContentReader,
	#category : #'XML-Parser-HTTP'
}

{ #category : #testing }
XMLHTTPWebClientResponseContentReader >> handlesDecompression [
	^ true
]

{ #category : #reading }
XMLHTTPWebClientResponseContentReader >> rawReadWithLength: aContentLength upToLimit: aMaxSize [
	| socketStream rawContentWriteStream |

	(socketStream := response webClientResponse stream) binary.
	rawContentWriteStream :=
		(ByteArray new:
			(aContentLength
				ifNil: [aMaxSize
					ifNil: [1024]])) writeStream.
	response webClientResponse
		streamFrom: socketStream
		to: rawContentWriteStream
		size: aContentLength
		progress:
			((aContentLength isNil
				and: [aMaxSize notNil])
				ifTrue: [
					[:ignored :total |
						total > aMaxSize
							ifTrue: [self errorContentLimitExceeded]]]
				ifFalse: [nil]).
	^ rawContentWriteStream contents.
]

"
A Zinc content reader. Zinc handles decompression automatically, so this class doesn't.
"
Class {
	#name : 'XMLHTTPZincResponseContentReader',
	#superclass : 'XMLHTTPResponseContentReader',
	#category : 'XML-Parser-HTTP',
	#package : 'XML-Parser',
	#tag : 'HTTP'
}

{ #category : 'reading' }
XMLHTTPZincResponseContentReader >> rawReadWithLength: aContentLength upToLimit: aMaxSize [
	^ [| entityStream |
		entityStream := response zincResponse entity stream.
		ZnUtils
			readUpToEnd: entityStream
			limit: aMaxSize]
		on: ZnEntityTooLarge
		do: [:error | self errorContentLimitExceeded]
]

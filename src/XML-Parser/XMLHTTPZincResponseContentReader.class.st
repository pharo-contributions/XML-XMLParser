"
A Zinc content reader. Zinc handles decompression automatically, so this class doesn't.
"
Class {
	#name : #XMLHTTPZincResponseContentReader,
	#superclass : #XMLHTTPResponseContentReader,
	#category : #'XML-Parser-HTTP'
}

{ #category : #testing }
XMLHTTPZincResponseContentReader >> handlesDecompression [
	"Zinc does this internally"
	^ false
]

{ #category : #reading }
XMLHTTPZincResponseContentReader >> rawReadWithLength: aContentLength upToLimit: aMaxSize [
	^ [
		ZnUtils
			readUpToEnd:
				(response zincResponse entity stream
					ascii;
					yourself)
			limit: aMaxSize]
		on: ZnEntityTooLarge
		do: [:error | self errorContentLimitExceeded]
]

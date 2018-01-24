"
A percent decoding read stream adapter for binary streams that implicitly converts bytes to character objects.
"
Class {
	#name : #XMLBinaryPercentDecodingReadStreamAdapter,
	#superclass : #XMLPercentDecodingReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #initialization }
XMLBinaryPercentDecodingReadStreamAdapter >> on: aStream [
	super on: (XMLBinaryReadStreamAdapter on: aStream)
]

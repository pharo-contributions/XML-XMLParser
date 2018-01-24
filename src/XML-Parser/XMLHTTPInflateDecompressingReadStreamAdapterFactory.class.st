"
A factory for decompressing the DEFLATE compression scheme. Uses the FastInflateStream class.
"
Class {
	#name : #XMLHTTPInflateDecompressingReadStreamAdapterFactory,
	#superclass : #XMLHTTPDecompressingReadStreamAdapterFactory,
	#category : #'XML-Parser-HTTP'
}

{ #category : #accessing }
XMLHTTPInflateDecompressingReadStreamAdapterFactory class >> compressionScheme [
	^ 'deflate'
]

{ #category : #accessing }
XMLHTTPInflateDecompressingReadStreamAdapterFactory class >> readStreamAdapterClass [
	^ XMLClassFinder classNamed: #FastInflateStream
]

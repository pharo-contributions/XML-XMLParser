"
A factory for decompressing the newer Brotli compression scheme. There is no support for this in Pharo or Squeak yet.
"
Class {
	#name : #XMLHTTPBrotliDecompressingReadStreamAdapterFactory,
	#superclass : #XMLHTTPDecompressingReadStreamAdapterFactory,
	#category : #'XML-Parser-HTTP'
}

{ #category : #accessing }
XMLHTTPBrotliDecompressingReadStreamAdapterFactory class >> compressionScheme [
	^ 'bl'
]

{ #category : #accessing }
XMLHTTPBrotliDecompressingReadStreamAdapterFactory class >> readStreamAdapterClass [
	^ XMLClassFinder classNamed: #BrotliReadStream
]

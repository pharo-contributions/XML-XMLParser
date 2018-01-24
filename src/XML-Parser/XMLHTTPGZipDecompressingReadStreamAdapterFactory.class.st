"
A factory for decompressing the GZip compression scheme.
"
Class {
	#name : #XMLHTTPGZipDecompressingReadStreamAdapterFactory,
	#superclass : #XMLHTTPDecompressingReadStreamAdapterFactory,
	#category : #'XML-Parser-HTTP'
}

{ #category : #accessing }
XMLHTTPGZipDecompressingReadStreamAdapterFactory class >> compressionScheme [
	^ 'gzip'
]

{ #category : #accessing }
XMLHTTPGZipDecompressingReadStreamAdapterFactory class >> readStreamAdapterClass [
	^ XMLClassFinder classNamed: #GZipReadStream
]

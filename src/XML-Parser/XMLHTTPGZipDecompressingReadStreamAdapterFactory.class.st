"
A read stram adapter factory for the GZip compression scheme. Uses GZipReadStream if available.
"
Class {
	#name : 'XMLHTTPGZipDecompressingReadStreamAdapterFactory',
	#superclass : 'XMLHTTPDecompressingReadStreamAdapterFactory',
	#category : 'XML-Parser-HTTP',
	#package : 'XML-Parser',
	#tag : 'HTTP'
}

{ #category : 'accessing' }
XMLHTTPGZipDecompressingReadStreamAdapterFactory class >> compressionScheme [
	^ 'gzip'
]

{ #category : 'accessing' }
XMLHTTPGZipDecompressingReadStreamAdapterFactory class >> decompressingReadStreamAdapterClass [
	^ XMLClassFinder classNamed: #GZipReadStream
]

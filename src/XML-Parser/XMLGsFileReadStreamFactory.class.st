"
A GsFile read stream factory. This stream is preferred for Gemstone because it does no decoding and returns byte characters, so XMLParser can do its own decoding.
"
Class {
	#name : #XMLGsFileReadStreamFactory,
	#superclass : #XMLFileReadStreamFactory,
	#category : #'XML-Parser-File'
}

{ #category : #'instance creation' }
XMLGsFileReadStreamFactory class >> fileReadStreamOnPath: aPath [
	^ (Smalltalk at: #GsFile)
		open: aPath
		mode: 'rb' "binary to avoid CRLF<->LF conversions on Windows"
		onClient: false "use server files by default"
]

{ #category : #testing }
XMLGsFileReadStreamFactory class >> isSupportedImplementation [
	^ (Smalltalk includesKey: #GsFile)
]

"
A GsFile write stream factory. This stream is preferred for Gemstone because it does no encoding and accepts byte characters, so XMLParser can do its own encoding.
"
Class {
	#name : #XMLGsFileWriteStreamFactory,
	#superclass : #XMLFileWriteStreamFactory,
	#category : #'XML-Parser-File'
}

{ #category : #'instance creation' }
XMLGsFileWriteStreamFactory class >> fileWriteStreamOnPath: aPath [
	^ (Smalltalk at: #GsFile)
		open: aPath
		mode: 'wb' "binary to avoid CRLF<->LF conversions on Windows"
		onClient: false "use server files by default"
]

{ #category : #testing }
XMLGsFileWriteStreamFactory class >> isSupported [
	^ (Smalltalk includesKey: #GsFile)
]

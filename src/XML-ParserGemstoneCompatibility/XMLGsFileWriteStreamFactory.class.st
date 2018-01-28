"
A GsFile write stream factory. This stream is preferred for Gemstone because it does no encoding and accepts byte characters so XMLParser can do its own encoding.
"
Class {
	#name : #XMLGsFileWriteStreamFactory,
	#superclass : #XMLFileWriteStreamFactory,
	#category : #'XML-ParserGemstoneCompatibility'
}

{ #category : #'instance creation' }
XMLGsFileWriteStreamFactory class >> basicOnPath: aPathString [
	^ (XMLClassFinder classNamed: #GsFile)
		open: aPathString
		mode: 'wb' "binary to avoid CRLF<->LF conversions on Windows"
		onClient: false "use server files by default"
]

{ #category : #testing }
XMLGsFileWriteStreamFactory class >> isSupportedImplementation [
	^ XMLClassFinder hasClassNamed: #GsFile
]

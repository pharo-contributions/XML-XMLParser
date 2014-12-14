"
A GsFile read stream factory. This stream is preferred for Gemstone because it does no encoding conversion so XMLParser can do its own.
"
Class {
	#name : #XMLGsFileReadStreamFactory,
	#superclass : #XMLFileReadStreamFactory,
	#category : #'XML-Parser-File'
}

{ #category : #testing }
XMLGsFileReadStreamFactory class >> isSupported [
	^ (Smalltalk includesKey: #GsFile)
]

{ #category : #'instance creation' }
XMLGsFileReadStreamFactory class >> on: aPath [
	^ (Smalltalk at: #GsFile) openRead: aPath
]

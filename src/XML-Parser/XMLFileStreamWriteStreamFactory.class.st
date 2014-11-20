"
A FileStream write stream factory, default for Pharo/Squeak.
"
Class {
	#name : #XMLFileStreamWriteStreamFactory,
	#superclass : #XMLFileWriteStreamFactory,
	#category : #'XML-Parser-File'
}

{ #category : #'instance creation' }
XMLFileStreamWriteStreamFactory class >> fileWriteStreamOn: aPath [
	^ (Smalltalk at: #FileStream) fileNamed: aPath
]

{ #category : #testing }
XMLFileStreamWriteStreamFactory class >> isSupported [
	^ (Smalltalk includesKey: #FileStream)
]

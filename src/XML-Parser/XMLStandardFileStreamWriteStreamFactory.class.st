"
A StandardFileStream write stream factory. This stream is preferred for Pharo/Squeak because it does no encoding and accepts byte characters so XMLParser can do its own encoding.
"
Class {
	#name : #XMLStandardFileStreamWriteStreamFactory,
	#superclass : #XMLFileWriteStreamFactory,
	#category : #'XML-Parser-Files'
}

{ #category : #basic }
XMLStandardFileStreamWriteStreamFactory class >> basicOnPath: aPathString [
	"Ensure that we delete the file if existingexistingContexts"
	
	aPathString asFileReference ensureDelete.
	^ ((XMLClassFinder classNamed: #File)
			named: aPathString) writeStream 
]

{ #category : #testing }
XMLStandardFileStreamWriteStreamFactory class >> isSupportedImplementation [
	^ XMLClassFinder hasClassNamed: #File
]

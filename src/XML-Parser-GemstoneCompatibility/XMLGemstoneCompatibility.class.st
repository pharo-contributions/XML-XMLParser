"
Used in development to copy String extension methods to CharacterCollection.
"
Class {
	#name : #XMLGemstoneCompatibility,
	#superclass : #Object,
	#category : #'XML-Parser-GemstoneCompatibility'
}

{ #category : #private }
XMLGemstoneCompatibility class >> copyXMLGSExtensionMethods [
	"
	self copyXMLGSExtensionMethods
	"
	(String selectorsInProtocol: #'*XML-Parser') do: [:each |
		CharacterCollection
			compile: (String sourceCodeAt: each)
			classified: #'*XML-Parser-GemstoneCompatibility'].
]

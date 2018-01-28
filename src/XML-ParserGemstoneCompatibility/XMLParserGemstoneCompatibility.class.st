"
Used in development to copy String extension methods to CharacterCollection.
"
Class {
	#name : #XMLParserGemstoneCompatibility,
	#superclass : #Object,
	#category : #'XML-ParserGemstoneCompatibility'
}

{ #category : #private }
XMLParserGemstoneCompatibility class >> copyXMLGSExtensionMethods [
	"
	self copyXMLGSExtensionMethods
	"
	(String selectorsInProtocol: #'*XML-Parser') do: [:each |
		CharacterCollection
			compile: (String sourceCodeAt: each)
			classified: #'*XML-ParserGemstoneCompatibility'].
]

"
Handler for the sample <person> <contacts> element.
"
Class {
	#name : 'SAX2HAuthorElementHandler',
	#superclass : 'SAX2ElementCharacterHandler',
	#category : 'XML-Parser-Tests-ElementHandlers',
	#package : 'XML-Parser-Tests',
	#tag : 'ElementHandlers'
}

{ #category : 'handling - content' }
SAX2HAuthorElementHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName [
	self parser parsingResult last addAuthor: self characters
]

"
Handler for the sample <books> element.
"
Class {
	#name : 'SAX2HBooksElementHandler',
	#superclass : 'SAX2ElementHandler',
	#category : 'XML-Parser-Tests-ElementHandlers',
	#package : 'XML-Parser-Tests',
	#tag : 'ElementHandlers'
}

{ #category : 'handling - content' }
SAX2HBooksElementHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: anAttributeDictionary [
	self parser parsingResult: OrderedCollection new
]

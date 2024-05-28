"
Handler for the sample <person> element.
"
Class {
	#name : 'SAX2HPersonElementHandler',
	#superclass : 'SAX2ElementHandler',
	#category : 'XML-Parser-Tests-ElementHandlers',
	#package : 'XML-Parser-Tests',
	#tag : 'ElementHandlers'
}

{ #category : 'handling - content' }
SAX2HPersonElementHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: anAttributeDictionary [
	self parser parsingResult: SAX2SamplePerson new
]

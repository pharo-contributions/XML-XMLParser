"
Handler for the sample <person> <contacts> <email> element.
"
Class {
	#name : 'SAX2HEmailElementHandler',
	#superclass : 'SAX2ElementHandler',
	#category : 'XML-Parser-Tests-ElementHandlers',
	#package : 'XML-Parser-Tests',
	#tag : 'ElementHandlers'
}

{ #category : 'handling - content' }
SAX2HEmailElementHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: anAttributeDictionary [
	self parser parsingResult addEmailAddress: (anAttributeDictionary at: 'address')
]

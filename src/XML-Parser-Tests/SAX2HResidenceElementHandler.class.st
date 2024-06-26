"
Handler for the sample <person> <residence> element.
"
Class {
	#name : 'SAX2HResidenceElementHandler',
	#superclass : 'SAX2ElementCharacterHandler',
	#category : 'XML-Parser-Tests-ElementHandlers',
	#package : 'XML-Parser-Tests',
	#tag : 'ElementHandlers'
}

{ #category : 'handling - content' }
SAX2HResidenceElementHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName [
	self parser parsingResult residence: self characters
]

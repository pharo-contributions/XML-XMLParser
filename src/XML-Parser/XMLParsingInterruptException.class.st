"
Used to interrupt parsing from a SAXHandler. Will be silently caught.
"
Class {
	#name : 'XMLParsingInterruptException',
	#superclass : 'XMLParserException',
	#category : 'XML-Parser-Exceptions',
	#package : 'XML-Parser',
	#tag : 'Exceptions'
}

{ #category : 'testing' }
XMLParsingInterruptException >> shouldPassOnWhenCaught [
	^ false
]

"
A validator of xml:id attributes.
"
Class {
	#name : #XMLXMLIDIDAttributeValidator,
	#superclass : #XMLIDAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLXMLIDIDAttributeValidator >> validateID: anId [
	(XMLWellFormedParserTokenizer isNCName: anId)
		ifFalse: [self errorInvalidID: anId]
]

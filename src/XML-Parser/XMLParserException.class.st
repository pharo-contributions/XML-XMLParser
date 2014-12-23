"
A base class for XML exceptions to make catching XML errors easier.
"
Class {
	#name : #XMLParserException,
	#superclass : #XMLException,
	#category : #'XML-Parser-Exceptions'
}

{ #category : #appending }
XMLParserException >> appendLineNumber: aLineNumber [
	self messageText:
		(self messageText ifNil: ['']),
			' (line ', aLineNumber printString, ')'
]

{ #category : #testing }
XMLParserException >> shouldPassOnWhenCaught [
	^ true
]

"
A base class for XML exceptions to make catching XML errors easier.
"
Class {
	#name : #XMLParserException,
	#superclass : #Error,
	#category : #'XML-Parser-Exceptions'
}

{ #category : #appending }
XMLParserException >> appendLineNumber: aLineNumber [
	self messageText: self messageText, ' (line ', aLineNumber printString, ')'
]

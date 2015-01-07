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
	self
		append: aLineNumber
		withDescription: 'line'
]

{ #category : #testing }
XMLParserException >> shouldPassOnWhenCaught [
	^ true
]

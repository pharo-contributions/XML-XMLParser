"
A base class for XML exceptions to make catching XML errors easier.
"
Class {
	#name : #XMLParserException,
	#superclass : #XMLException,
	#instVars : [
		'lineNumber'
	],
	#category : #'XML-Parser-Exceptions'
}

{ #category : #testing }
XMLParserException >> hasLineNumber [
	^ lineNumber notNil
]

{ #category : #accessing }
XMLParserException >> lineNumber [
	^ lineNumber
]

{ #category : #accessing }
XMLParserException >> lineNumber: aLineNumber [
	lineNumber := aLineNumber.
	self
		append: aLineNumber
		withDescription: 'line'.
]

{ #category : #testing }
XMLParserException >> shouldPassOnWhenCaught [
	^ true
]

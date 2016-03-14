"
A base class for XMLParser exceptions that supports line number error info and can be used with on:do: to catch any XMLParser-related errors.
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

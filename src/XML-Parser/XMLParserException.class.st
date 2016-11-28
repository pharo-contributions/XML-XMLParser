"
A base class for XMLParser exceptions that supports line number error info and can be used with on:do: to catch any XMLParser-related errors.
"
Class {
	#name : #XMLParserException,
	#superclass : #XMLException,
	#instVars : [
		'lineNumber',
		'columnNumber',
		'baseURI'
	],
	#category : #'XML-Parser-Exceptions'
}

{ #category : #accessing }
XMLParserException >> baseURI [
	^ baseURI ifNil: [baseURI := '']
]

{ #category : #accessing }
XMLParserException >> baseURI: aURIString [
	baseURI := aURIString.
	self messageTextAppend: aURIString.
]

{ #category : #accessing }
XMLParserException >> columnNumber [
	^ columnNumber
]

{ #category : #accessing }
XMLParserException >> columnNumber: aColumnNumber [
	columnNumber := aColumnNumber.
	self
		messageTextAppend: aColumnNumber
		withDescription: 'column'.
]

{ #category : #testing }
XMLParserException >> hasBaseURI [
	^ self baseURI notEmpty
]

{ #category : #testing }
XMLParserException >> hasColumnNumber [
	^ self columnNumber notNil
]

{ #category : #testing }
XMLParserException >> hasLineNumber [
	^ self lineNumber notNil
]

{ #category : #testing }
XMLParserException >> isXMLParserException [
	^ true
]

{ #category : #accessing }
XMLParserException >> lineNumber [
	^ lineNumber
]

{ #category : #accessing }
XMLParserException >> lineNumber: aLineNumber [
	lineNumber := aLineNumber.
	self
		messageTextAppend: aLineNumber
		withDescription: 'line'.
]

{ #category : #testing }
XMLParserException >> shouldPassOnWhenCaught [
	^ true
]

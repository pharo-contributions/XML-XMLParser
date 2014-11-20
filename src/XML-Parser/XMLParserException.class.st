"
A base class for XML exceptions to make catching XML errors easier.
"
Class {
	#name : #XMLParserException,
	#superclass : #Error,
	#category : #'XML-Parser-Exceptions'
}

{ #category : #signalling }
XMLParserException class >> formatSignal: aString with: aFirstValue [
	^ self
		formatSignal: aString
		withAll: (Array with: aFirstValue)
]

{ #category : #signalling }
XMLParserException class >> formatSignal: aString with: aFirstValue with: aSecondValue [
	^ self
		formatSignal: aString
		withAll: (Array with: aFirstValue with: aSecondValue)
]

{ #category : #signalling }
XMLParserException class >> formatSignal: aString with: aFirstValue with: aSecondValue with: aThirdValue [
	^ self
		formatSignal: aString
		withAll: (Array with: aFirstValue with: aSecondValue with: aThirdValue)
]

{ #category : #signalling }
XMLParserException class >> formatSignal: aString withAll: anArray [
	^ self signal: (aString format: anArray)
]

{ #category : #signalling }
XMLParserException class >> signalMessageFrom: anException [
	^ self signal: anException messageText
]

{ #category : #appending }
XMLParserException >> appendLineNumber: aLineNumber [
	self messageText: self messageText, ' (line ', aLineNumber printString, ')'
]

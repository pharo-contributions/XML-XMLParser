"
A generic exception class that supports message formatting. Used as a base class for exceptions in XMLParser and related packages.
"
Class {
	#name : #XMLException,
	#superclass : #Error,
	#category : #'XML-Parser-Exceptions'
}

{ #category : #signalling }
XMLException class >> formatSignal: aString with: aFirstValue [
	^ self
		formatSignal: aString
		withAll: (Array with: aFirstValue)
]

{ #category : #signalling }
XMLException class >> formatSignal: aString with: aFirstValue with: aSecondValue [
	^ self
		formatSignal: aString
		withAll: (Array with: aFirstValue with: aSecondValue)
]

{ #category : #signalling }
XMLException class >> formatSignal: aString with: aFirstValue with: aSecondValue with: aThirdValue [
	^ self
		formatSignal: aString
		withAll: (Array with: aFirstValue with: aSecondValue with: aThirdValue)
]

{ #category : #signalling }
XMLException class >> formatSignal: aString with: aFirstValue with: aSecondValue with: aThirdValue with: aFourthValue [
	^ self
		formatSignal: aString
		withAll:
			(Array
				with: aFirstValue
				with: aSecondValue
				with: aThirdValue
				with: aFourthValue)
]

{ #category : #signalling }
XMLException class >> formatSignal: aString withAll: anArray [
	^ self signal: (aString format: anArray)
]

{ #category : #signalling }
XMLException class >> signalMessageFrom: anException [
	^ self
		formatSignal: '({1}) {2}'
		with: anException class name
		with: anException messageText
]

{ #category : #private }
XMLException >> append: anObject withDescription: aDescription [
	self messageText:
		('{1} ({2} {3})' format:
			(Array "ifNil: for compatibility with older versions of messageText"
				with: (self messageText ifNil: [''])
				with: aDescription
				with: anObject))
]

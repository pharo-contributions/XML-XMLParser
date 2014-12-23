"
A generic exception class that supports message formatting.
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
	^ self signal: anException messageText
]

"
This class validates empty elements.

"
Class {
	#name : #XMLEmptyElementValidator,
	#superclass : #XMLElementValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLEmptyElementValidator >> atEnd [
	^ true
]

{ #category : #private }
XMLEmptyElementValidator >> errorMustBeEmpty [
	XMLValidationException
		formatSignal: 'Element <{1}> must be empty'
		with: self element
]

{ #category : #validation }
XMLEmptyElementValidator >> validatePCData: aString [
	self errorMustBeEmpty
]

{ #category : #validation }
XMLEmptyElementValidator >> validateStartTag: aName [
	self errorMustBeEmpty
]

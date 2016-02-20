"
This class validates ID attributes that must have unique (not repeated in the same document) values.
"
Class {
	#name : #XMLIDAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'elementIdValidator'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #private }
XMLIDAttributeValidator class >> classForAttribute: anAttribute [
	anAttribute = 'xml:id'
		ifTrue: [^ XMLIDAttributeXMLIDValidator]
		ifFalse: [^ XMLIDAttributeValidator]
]

{ #category : #'instance creation' }
XMLIDAttributeValidator class >> element: anElement attribute: anAttribute defaultValidator: aDefaultValidator [
	^ (self classForAttribute: anAttribute) new
		setElement: anElement
		attribute: anAttribute
		defaultValidator: aDefaultValidator
]

{ #category : #accessing }
XMLIDAttributeValidator >> elementIDValidator [
	^ elementIdValidator
]

{ #category : #accessing }
XMLIDAttributeValidator >> elementIDValidator: anElementIDValidator [
	elementIdValidator := anElementIDValidator
]

{ #category : #initialization }
XMLIDAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	elementIdValidator := aValidatorContainer elementIDValidator
]

{ #category : #validating }
XMLIDAttributeValidator >> validateAttributeValue: aValue [
	self elementIDValidator
		validateID: aValue
		inAttribute: self attribute
]

{ #category : #validating }
XMLIDAttributeValidator >> validateDeclaration [
	self elementIDValidator
		validateIDAttribute: self attribute
		forElement: self element.
	super validateDeclaration.
]

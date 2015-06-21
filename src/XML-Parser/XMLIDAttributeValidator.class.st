"
This class validates ID attributes that must have unique values.
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
XMLIDAttributeValidator class >> element: anElement attribute: anAttribute defaultValueValidator: aDefaultValueValidator [
	^ (self classForAttribute: anAttribute) new
		setElement: anElement
		attribute: anAttribute
		defaultValueValidator: aDefaultValueValidator
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
	(elementIdValidator := aValidatorContainer elementIDValidator)
		validateIDAttribute: self attribute
		forElement: self element.
	self validateReservedAttributeValidator.
]

{ #category : #testing }
XMLIDAttributeValidator >> isIDValidator [
	^ true
]

{ #category : #validating }
XMLIDAttributeValidator >> validateAttributeValue: aValue [
	self elementIDValidator
		validateID: aValue
		inAttribute: self attribute
]

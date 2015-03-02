"
This class validates ID attributes that must be unique in each element of the type.
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
		ifTrue: [^ XMLXMLIDIDAttributeValidator]
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
XMLIDAttributeValidator >> elementIDValidator: anElementIdValidator [
	elementIdValidator := anElementIdValidator
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

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

{ #category : #private }
XMLIDAttributeValidator >> errorIDAttributeMustBeRequiredOrImplied [
	XMLValidationException
		formatSignal:
			'Attribute "{1}" of element <{2}> is of ID type and must ',
			'be declared #REQUIRED or #IMPLIED'
		with: self attribute
		with: self element
]

{ #category : #initialization }
XMLIDAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	elementIdValidator := aValidatorContainer elementIDValidator
]

{ #category : #validating }
XMLIDAttributeValidator >> validateAttributeDeclaration [
	super validateAttributeDeclaration.
	self elementIDValidator
		validateIDAttribute: self attribute
		forElement: self element.
]

{ #category : #validating }
XMLIDAttributeValidator >> validateAttributeDefaultValue: aDefaultValue [
	self errorIDAttributeMustBeRequiredOrImplied
]

{ #category : #validating }
XMLIDAttributeValidator >> validateAttributeValue: aValue [
	self elementIDValidator
		validateID: aValue
		inAttribute: self attribute
]

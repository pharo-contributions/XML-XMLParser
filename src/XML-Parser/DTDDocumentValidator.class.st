"
This class validates documents using a DTD.
"
Class {
	#name : #DTDDocumentValidator,
	#superclass : #XMLDocumentValidator,
	#instVars : [
		'doctypeDefinition'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDDocumentValidator class >> doctypeDefinition: aDoctypeDefinition [
	^ self new doctypeDefinition: aDoctypeDefinition
]

{ #category : #accessing }
DTDDocumentValidator >> attributeValidatorsFor: anElement [
	^ self doctypeDefinition attributeValidators
		at: anElement
		ifAbsent: [nil]
]

{ #category : #accessing }
DTDDocumentValidator >> doctypeDefinition [
	^ doctypeDefinition
]

{ #category : #accessing }
DTDDocumentValidator >> doctypeDefinition: aDoctypeDefinition [
	doctypeDefinition := aDoctypeDefinition
]

{ #category : #accessing }
DTDDocumentValidator >> elementIDValidator [
	self doctypeDefinition elementIDValidator
]

{ #category : #accessing }
DTDDocumentValidator >> elementValidatorFor: aName [
	^ (self doctypeDefinition elementValidators
		at: aName
		ifAbsent: [nil]) copy
]

{ #category : #private }
DTDDocumentValidator >> errorInvalidRoot: anElementName [
	XMLValidationException
		formatSignal: 'Element <{1}> cannot be root'
		with: anElementName
]

{ #category : #testing }
DTDDocumentValidator >> hasAttributeValidators [
	^ self doctypeDefinition hasAttributeValidators
]

{ #category : #testing }
DTDDocumentValidator >> hasElementValidators [
	^ self doctypeDefinition hasElementValidators
]

{ #category : #validating }
DTDDocumentValidator >> unvalidatedAttributes: anAttributeCollection [
	XMLValidationException
		formatSignal: 'Undeclared attribute "{1}"'
		with: anAttributeCollection anyOne
]

{ #category : #validating }
DTDDocumentValidator >> unvalidatedElement: aName [
	XMLValidationException
		formatSignal: 'Undeclared element <{1}>'
		with: aName
]

{ #category : #validating }
DTDDocumentValidator >> validateIDReferences [
	self doctypeDefinition hasElementIDValidator
		ifTrue: [self doctypeDefinition elementIDValidator validateIDReferences]
]

{ #category : #validating }
DTDDocumentValidator >> validateRootElement: anElementName [
	(self doctypeDefinition root notEmpty
		and: [self doctypeDefinition root ~= anElementName])
		ifTrue: [self errorInvalidRoot: anElementName]
]

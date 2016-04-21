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
DTDDocumentValidator >> elementValidatorFor: anElement [
	^ (self doctypeDefinition elementValidators
		at: anElement
		ifAbsent: [nil]) copy
]

{ #category : #private }
DTDDocumentValidator >> errorInvalidRoot: anElementName [
	XMLValidationException
		formatSignal: 'Root element must be <{1}>, not <{2}>'
		with: self doctypeDefinition root
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
DTDDocumentValidator >> unvalidatedElement: anElement [
	XMLValidationException
		formatSignal: 'Undeclared element <{1}>'
		with: anElement
]

{ #category : #validating }
DTDDocumentValidator >> validateIDReferences [
	self doctypeDefinition hasElementIDValidator
		ifTrue: [self doctypeDefinition elementIDValidator validateIDReferences]
]

{ #category : #validating }
DTDDocumentValidator >> validateRootElement: anElement [
	(self doctypeDefinition hasRoot
		and: [self doctypeDefinition root ~= anElement])
		ifTrue: [self errorInvalidRoot: anElement]
]

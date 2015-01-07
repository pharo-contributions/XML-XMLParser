"
This class validates documents using a DTD.
"
Class {
	#name : #DTDDocumentValidator,
	#superclass : #XMLDocumentValidator,
	#instVars : [
		'dtd'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDDocumentValidator class >> dtd: aDtd [
	^ self new dtd: aDtd
]

{ #category : #accessing }
DTDDocumentValidator >> attributeValidatorsFor: anElement [
	^ self dtd attributeValidators
		at: anElement
		ifAbsent: [nil]
]

{ #category : #accessing }
DTDDocumentValidator >> dtd [
	^ dtd
]

{ #category : #accessing }
DTDDocumentValidator >> dtd: aDtd [
	dtd := aDtd
]

{ #category : #accessing }
DTDDocumentValidator >> elementIDValidator [
	self dtd elementIDValidator
]

{ #category : #accessing }
DTDDocumentValidator >> elementValidatorFor: aName [
	^ (self dtd elementValidators
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
	^ self dtd hasAttributeValidators
]

{ #category : #testing }
DTDDocumentValidator >> hasElementValidators [
	^ self dtd hasElementValidators
]

{ #category : #validation }
DTDDocumentValidator >> unvalidatedAttributes: anAttributeCollection [
	XMLValidationException
		formatSignal: 'Undeclared attribute "{1}"'
		with: anAttributeCollection anyOne
]

{ #category : #validation }
DTDDocumentValidator >> unvalidatedElement: aName [
	XMLValidationException
		formatSignal: 'Undeclared element <{1}>'
		with: aName
]

{ #category : #validation }
DTDDocumentValidator >> validateIDReferences [
	self dtd hasElementIDValidator
		ifTrue: [self dtd elementIDValidator validateIDReferences]
]

{ #category : #validation }
DTDDocumentValidator >> validateRootElement: anElementName [
	(self dtd rootElement notEmpty
		and: [self dtd rootElement ~= anElementName])
		ifTrue: [self errorInvalidRoot: anElementName]
]

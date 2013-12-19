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

{ #category : #enumerating }
DTDDocumentValidator >> allAttributeValidatorsDo: aBlock [
	^ self dtd attributeValidators valuesDo: [:each | each valuesDo: aBlock]
]

{ #category : #accessing }
DTDDocumentValidator >> attributeValidatorsFor: anElement [
	^ dtd attributeValidators
		at: anElement
		ifAbsent: [Dictionary new]
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
DTDDocumentValidator >> elementValidatorFor: aName [
	^ (dtd elementValidators
		at: aName
		ifAbsent: [nil]) copy
]

{ #category : #testing }
DTDDocumentValidator >> hasAttributeValidators [
	^ dtd hasAttributeValidators
]

{ #category : #testing }
DTDDocumentValidator >> hasElementValidators [
	^ dtd hasElementValidators
]

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
DTDDocumentValidator >> elementValidatorFor: aName [
	^ (self dtd elementValidators
		at: aName
		ifAbsent: [nil]) copy
]

{ #category : #private }
DTDDocumentValidator >> errorInvalidIDReference: anId [
	XMLValidationException
		formatSignal: 'Invalid ID reference "{1}"'
		with: anId
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

{ #category : #testing }
DTDDocumentValidator >> hasValidators [
	^ self dtd hasValidators
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
DTDDocumentValidator >> validateEndDocument [
	self hasAttributeValidators
		ifTrue: [self validateIDsAndReferences]	
]

{ #category : #validation }
DTDDocumentValidator >> validateIDsAndReferences [
	| ids references |

	ids := Set new.
	references := Set new.
	self allAttributeValidatorsDo: [:each |
		each hasIDs
			ifTrue: [ids addAll: each ids]
			ifFalse: [
				each hasIDRefs
					ifTrue: [references addAll: each idRefs]]].

	references do: [:each |
		(ids includes: each)
			ifFalse: [self errorInvalidIDReference: each]].
]

{ #category : #validation }
DTDDocumentValidator >> validateRootElement: anElementName [
	(self dtd rootElement notEmpty
		and: [self dtd rootElement ~= anElementName])
		ifTrue: [self errorInvalidRoot: anElementName]
]

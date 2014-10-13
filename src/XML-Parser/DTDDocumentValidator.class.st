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

{ #category : #validation }
DTDDocumentValidator >> unvalidatedAttributes: anAttributeCollection [
	XMLValidationException signal:
		'Undeclared attribute(s) ', (', ' join: anAttributeCollection)
]

{ #category : #validation }
DTDDocumentValidator >> unvalidatedElement: aName [
	XMLValidationException signal: 'Undeclared element <', aName, '>'
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
			ifFalse: [XMLValidationException signal: 'Invalid ID reference "', each, '"']].
]

{ #category : #validation }
DTDDocumentValidator >> validateRootElement: anElementName [
	(dtd rootElement notEmpty
		and: [dtd rootElement ~= anElementName])
		ifTrue: [
			XMLValidationException signal:
				'Element <', anElementName, '> cannot be root']
]

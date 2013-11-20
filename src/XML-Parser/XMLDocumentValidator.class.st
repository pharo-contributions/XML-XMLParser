"
This is a base class for XML document validators.
"
Class {
	#name : #XMLDocumentValidator,
	#superclass : #Object,
	#instVars : [
		'elementValidatorStack'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #enumerating }
XMLDocumentValidator >> allAttributeValidatorsDo: aBlock [
	self subclassResponsibility
]

{ #category : #accessing }
XMLDocumentValidator >> attributeValidatorsFor: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
XMLDocumentValidator >> currentElementValidator [
	^ self elementValidatorStack last
]

{ #category : #accessing }
XMLDocumentValidator >> defaultElementValidatorFor: aName [
	^ XMLAnyElementValidator name: aName
]

{ #category : #accessing }
XMLDocumentValidator >> elementValidatorFor: aName [
	self subclassResponsibility
]

{ #category : #accessing }
XMLDocumentValidator >> elementValidatorStack [
	^ elementValidatorStack ifNil: [elementValidatorStack := OrderedCollection new]
]

{ #category : #private }
XMLDocumentValidator >> errorMissingContentFor: aName [
	XMLValidationException signal: 'Element ', aName, ' terminated prematurely'
]

{ #category : #testing }
XMLDocumentValidator >> hasAttributeValidators [
	self subclassResponsibility
]

{ #category : #testing }
XMLDocumentValidator >> hasElementValidators [
	self subclassResponsibility
]

{ #category : #validation }
XMLDocumentValidator >> validateEndTag: aName [
	self hasElementValidators
		ifTrue: [
			(self currentElementValidator name = aName)
				ifTrue: [
					self currentElementValidator atEnd
						ifFalse: [self errorMissingContentFor: aName]].
			self elementValidatorStack removeLast]
]

{ #category : #validation }
XMLDocumentValidator >> validateIDsAndReferences [
	| ids references |

	self hasAttributeValidators
		ifFalse: [^ self].

	ids := Set new.
	references := Set new.
	self allAttributeValidatorsDo: [:each |
		(each respondsTo: #ids)
			ifTrue: [ids addAll: each ids]
			ifFalse: [
				(each respondsTo: #idrefs)
					ifTrue: [references addAll: each idrefs]]].

	references do: [:each |
		(ids includes: each)
			ifFalse: [XMLValidationException signal: 'Invalid ID reference ', each]].
]

{ #category : #validation }
XMLDocumentValidator >> validatePCData: aString [
	self hasElementValidators
		ifTrue: [self currentElementValidator validatePCData: aString]
]

{ #category : #validation }
XMLDocumentValidator >> validateStartTag: aName attributes: anAttributeDictionary [
	self hasElementValidators
		ifTrue: [
			self elementValidatorStack
				ifNotEmpty: [self currentElementValidator validateStartTag: aName].
			self elementValidatorStack
				addLast:
					((self elementValidatorFor: aName)
						ifNil: [self defaultElementValidatorFor: aName])].

	self hasAttributeValidators
		ifTrue: [
			(self attributeValidatorsFor: aName)
				do: [:each |
					each
						validateDefaultValueIn: anAttributeDictionary;
						validateAttributes: anAttributeDictionary]].
]

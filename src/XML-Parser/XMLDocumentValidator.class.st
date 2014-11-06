"
This is a base class for XML document validators.
"
Class {
	#name : #XMLDocumentValidator,
	#superclass : #Object,
	#instVars : [
		'elementValidatorStack',
		'xmlIdValidator'
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
	^ XMLAnyElementValidator element: aName
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
	XMLValidationException
		formatSignal: 'Element <{1}> terminated prematurely'
		with: aName
]

{ #category : #testing }
XMLDocumentValidator >> hasAttributeValidators [
	self subclassResponsibility
]

{ #category : #testing }
XMLDocumentValidator >> hasElementValidators [
	self subclassResponsibility
]

{ #category : #testing }
XMLDocumentValidator >> hasValidators [
	^ self hasElementValidators or: [self hasAttributeValidators]
]

{ #category : #validation }
XMLDocumentValidator >> unvalidatedAttributes: anAttributeCollection [
]

{ #category : #validation }
XMLDocumentValidator >> unvalidatedElement: aName [
]

{ #category : #validation }
XMLDocumentValidator >> validateAttributes: anAttributeDictionary with: aValidatorDictionary [
	| unvalidatedAttributes |

	unvalidatedAttributes := Set new: anAttributeDictionary size.
	anAttributeDictionary keysDo: [:each | unvalidatedAttributes add: each].
	aValidatorDictionary
		ifNotNil: [
			aValidatorDictionary keysAndValuesDo: [:attribute :validator |
				validator validateAttributes: anAttributeDictionary.
				unvalidatedAttributes
					remove: attribute
					ifAbsent: nil]].

	unvalidatedAttributes
		ifNotEmpty: [self unvalidatedAttributes: unvalidatedAttributes].
]

{ #category : #validation }
XMLDocumentValidator >> validateEndDocument [

]

{ #category : #validation }
XMLDocumentValidator >> validateEndTag: aName [
	self hasElementValidators
		ifTrue: [
			(self currentElementValidator element = aName)
				ifTrue: [
					self currentElementValidator atEnd
						ifFalse: [self errorMissingContentFor: aName]].
			self elementValidatorStack removeLast]
]

{ #category : #validation }
XMLDocumentValidator >> validatePCData: aString [
	self hasElementValidators
		ifTrue: [self currentElementValidator validatePCData: aString]
]

{ #category : #validation }
XMLDocumentValidator >> validateReservedAttributes: aDictionary for: aStartTag [
]

{ #category : #validation }
XMLDocumentValidator >> validateRootElement: anElementName [
]

{ #category : #validation }
XMLDocumentValidator >> validateStartTag: aName [
	self elementValidatorStack
		ifNotEmpty: [self currentElementValidator validateStartTag: aName].

	self elementValidatorStack addLast:
		((self elementValidatorFor: aName)
			ifNil: [
				self
					unvalidatedElement: aName;
					defaultElementValidatorFor: aName]).
]

{ #category : #validation }
XMLDocumentValidator >> validateStartTag: aName attributes: anAttributeDictionary [
	(self hasElementValidators or: [self hasAttributeValidators])
		ifFalse: [^ self].

	self validateStartTag: aName.
	self
		validateAttributes: anAttributeDictionary
		with: (self attributeValidatorsFor: aName).
]

{ #category : #private }
XMLDocumentValidator >> validateXMLIDAttributeIn: anAttributeDictionary [
	self xmlIDValidator validateAttributes: anAttributeDictionary
]

{ #category : #private }
XMLDocumentValidator >> xmlIDValidator [
	^ xmlIdValidator ifNil: [
		xmlIdValidator :=
			XMLIDAttributeValidator
				element: ''
				attribute: 'xml:id'
				defaultValueValidator:
					(XMLImpliedValueAttributeValidator attribute: 'xml:id')]
]

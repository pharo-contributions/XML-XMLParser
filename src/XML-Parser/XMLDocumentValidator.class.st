"
This is a base class for XML document validators.
"
Class {
	#name : #XMLDocumentValidator,
	#superclass : #Object,
	#instVars : [
		'elementValidatorStack',
		'defaultXMLIDValidator'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLDocumentValidator >> attributeValidatorsFor: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
XMLDocumentValidator >> currentElementValidator [
	^ self elementValidatorStack lastOrNil
]

{ #category : #accessing }
XMLDocumentValidator >> defaultElementValidatorFor: aName [
	^ XMLAnyElementValidator element: aName
]

{ #category : #private }
XMLDocumentValidator >> defaultXMLIDValidator [
	"used to validate xml:id attributes if there's no DTD or other validators"
	^ defaultXMLIDValidator
		ifNil: [
			defaultXMLIDValidator :=
				XMLIDAttributeXMLIDValidator
					element: ''
					attribute: 'xml:id'
					defaultValidator:
						(XMLAttributeDefaultImpliedValidator attribute: 'xml:id').
			defaultXMLIDValidator
				elementIDValidator: XMLElementIDValidator new;
				yourself]
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
XMLDocumentValidator >> hasCurrentElementValidator [
	^ self currentElementValidator notNil
]

{ #category : #testing }
XMLDocumentValidator >> hasElementValidators [
	self subclassResponsibility
]

{ #category : #testing }
XMLDocumentValidator >> hasValidators [
	^ self hasElementValidators or: [self hasAttributeValidators]
]

{ #category : #printing }
XMLDocumentValidator >> printOn: aStream [
	super printOn: aStream.
	self hasCurrentElementValidator
		ifTrue: [
			aStream
				nextPut: $(;
				print: self currentElementValidator;
				nextPut: $)].
]

{ #category : #validating }
XMLDocumentValidator >> unvalidatedAttributes: anAttributeCollection [
]

{ #category : #validating }
XMLDocumentValidator >> unvalidatedElement: aName [
]

{ #category : #validating }
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

	unvalidatedAttributes isEmpty
		ifFalse: [self unvalidatedAttributes: unvalidatedAttributes].
]

{ #category : #validating }
XMLDocumentValidator >> validateEndDocument [
	self validateIDReferences
]

{ #category : #validating }
XMLDocumentValidator >> validateEndTag: aName [
	self hasElementValidators
		ifTrue: [
			(self currentElementValidator element = aName)
				ifTrue: [
					self currentElementValidator atEnd
						ifFalse: [self errorMissingContentFor: aName]].
			self elementValidatorStack removeLast]
]

{ #category : #validating }
XMLDocumentValidator >> validateIDReferences [
	self subclassResponsibility
]

{ #category : #validating }
XMLDocumentValidator >> validatePCData: aString [
	self hasElementValidators
		ifTrue: [self currentElementValidator validatePCData: aString]
]

{ #category : #validating }
XMLDocumentValidator >> validateRootElement: anElementName [
]

{ #category : #validating }
XMLDocumentValidator >> validateStartTag: aName [
	self currentElementValidator
		ifNotNil: [:currentValidator | currentValidator validateStartTag: aName].

	self elementValidatorStack addLast:
		((self elementValidatorFor: aName)
			ifNil: [
				self
					unvalidatedElement: aName;
					defaultElementValidatorFor: aName]).
]

{ #category : #validating }
XMLDocumentValidator >> validateStartTag: aName attributes: anAttributeDictionary [
	(self hasElementValidators
		or: [self hasAttributeValidators])
		ifTrue: [
			self validateStartTag: aName.
			self
				validateAttributes: anAttributeDictionary
				with: (self attributeValidatorsFor: aName)]
]

{ #category : #validating }
XMLDocumentValidator >> validateXMLIDAttributeIn: anAttributeDictionary [
	self hasAttributeValidators
		ifFalse: [self defaultXMLIDValidator validateAttributes: anAttributeDictionary]
]

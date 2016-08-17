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
	^ self elementValidatorStack xmlLastOrNil
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
XMLDocumentValidator >> elementValidatorFor: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
XMLDocumentValidator >> elementValidatorStack [
	^ elementValidatorStack ifNil: [elementValidatorStack := OrderedCollection new]
]

{ #category : #private }
XMLDocumentValidator >> errorUnexpectEndOfElement: anElement [
	XMLValidationException
		formatSignal: 'Element <{1}> terminated prematurely'
		with: anElement
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
XMLDocumentValidator >> hasElementContent [
	self hasElementValidators
		ifTrue: [
			self currentElementValidator
				ifNotNil: [:elementValidator |
					^ elementValidator hasElementContent]].
	^ false.
]

{ #category : #testing }
XMLDocumentValidator >> hasElementValidators [
	self subclassResponsibility
]

{ #category : #testing }
XMLDocumentValidator >> hasValidators [
	^ self hasElementValidators
		or: [self hasAttributeValidators]
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
XMLDocumentValidator >> unvalidatedElement: anElement [
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
XMLDocumentValidator >> validateComment: aString [
	self hasElementValidators
		ifTrue: [
			self currentElementValidator
				ifNotNil: [:elementValidator |
					elementValidator validateComment: aString]]
]

{ #category : #validating }
XMLDocumentValidator >> validateEndDocument [
	self validateIDReferences
]

{ #category : #validating }
XMLDocumentValidator >> validateEndTag: anElement [
	self hasElementValidators
		ifTrue: [
			self currentElementValidator
				ifNotNil: [:elementValidator |
					elementValidator atEnd
						ifFalse: [self errorUnexpectEndOfElement: anElement].
					self elementValidatorStack removeLast]]
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
XMLDocumentValidator >> validatePI: aTargetString data: aDataString [
	self hasElementValidators
		ifTrue: [
			self currentElementValidator
				ifNotNil: [:elementValidator |
					elementValidator
						validatePI: aTargetString
						data: aDataString]]
]

{ #category : #validating }
XMLDocumentValidator >> validateRootElement: anElement [
]

{ #category : #validating }
XMLDocumentValidator >> validateStartTag: anElement [
	self currentElementValidator
		ifNotNil: [:elementValidator |
			elementValidator validateStartTag: anElement].

	self elementValidatorStack addLast:
		((self elementValidatorFor: anElement)
			ifNil: [
				self
					unvalidatedElement: anElement;
					defaultElementValidatorFor: anElement]).
]

{ #category : #validating }
XMLDocumentValidator >> validateStartTag: anElement attributes: aDictionary [
	(self hasElementValidators
		or: [self hasAttributeValidators])
		ifTrue: [
			self validateStartTag: anElement.
			self
				validateAttributes: aDictionary
				with: (self attributeValidatorsFor: anElement)]
]

{ #category : #validating }
XMLDocumentValidator >> validateXMLIDAttributeIn: aDictionary [
	self hasAttributeValidators
		ifFalse: [self defaultXMLIDValidator validateAttributes: aDictionary]
]

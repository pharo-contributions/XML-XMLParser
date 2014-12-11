"
This class parses an attribute definition in an ATTLIST declaration and creates a validator for it.
"
Class {
	#name : #DTDAttributeDefinitionParser,
	#superclass : #Object,
	#instVars : [
		'element',
		'attribute',
		'type',
		'defaultValueValidator'
	],
	#classVars : [
		'DefaultValueValidators',
		'NonEnumerationValidators'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDAttributeDefinitionParser class >> element: anElement attribute: anAttribute type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	^ self new
		setElement: anElement
		attribute: anAttribute
		type: aType
		defaultValueValidator:
			((DefaultValueValidators
				at: aDefaultPragma
				ifAbsent: [XMLDefaultValueAttributeValidator])
					attribute: anAttribute
					defaultValue: aDefaultValue).
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initialize [
	"self initialize"

	self
		initializeDefaultValueValidators;
		initializeNonEnumerationValidators.
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initializeDefaultValueValidators [
	(DefaultValueValidators := Dictionary new)
		at: 'FIXED' put: XMLFixedValueAttributeValidator;
		at: 'IMPLIED' put: XMLImpliedValueAttributeValidator;
		at: 'REQUIRED' put: XMLRequiredValueAttributeValidator
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initializeNonEnumerationValidators [
	(NonEnumerationValidators := Dictionary new)
		at: 'CDATA' put: XMLCDataAttributeValidator;
		at: 'ID' put: XMLIDAttributeValidator;
		at: 'IDREF' put: XMLIDRefAttributeValidator;
		at: 'IDREFS' put: XMLIDRefsAttributeValidator;
		at: 'ENTITY' put: XMLEntityAttributeValidator;
		at: 'ENTITIES' put: XMLEntitiesAttributeValidator;
		at: 'NMTOKEN' put: XMLNameAttributeValidator;
		at: 'NMTOKENS' put: XMLNamesAttributeValidator
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parse [
	| attributeValidator |

	attributeValidator :=
		self validatorClassForType
			element: element
			attribute: attribute
			defaultValueValidator: defaultValueValidator.
	attributeValidator isEnumerationValidator
		ifTrue: [attributeValidator setAllowedValuesFromString: type].

	^ attributeValidator.
]

{ #category : #initialization }
DTDAttributeDefinitionParser >> setElement: anElement attribute: anAttribute type: aType defaultValueValidator: aDefaultValueValidator [
	element := anElement.
	attribute := anAttribute.
	type := aType.
	defaultValueValidator := aDefaultValueValidator.
]

{ #category : #'private ' }
DTDAttributeDefinitionParser >> validatorClassForType [
	^ NonEnumerationValidators
		at: type
		ifAbsent: [
			type first == $N
				ifTrue: [XMLNotationEnumerationAttributeValidator]
				ifFalse: [XMLEnumerationAttributeValidator]]
]

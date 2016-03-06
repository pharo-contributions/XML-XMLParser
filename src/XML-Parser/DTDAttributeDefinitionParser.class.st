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
		'defaultValidator'
	],
	#classVars : [
		'AttributeDefaultValidatorClasses',
		'NonEnumerationAttributeValidatorClasses'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDAttributeDefinitionParser class >> element: anElement attribute: anAttribute type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	^ self new
		setElement: anElement
		attribute: anAttribute
		type: aType
		defaultValidator:
			((AttributeDefaultValidatorClasses at: aDefaultPragma)
				attribute: anAttribute
				defaultValue: aDefaultValue)
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initialize [
	"self initialize"

	self
		initializeAttributeDefaultValidatorClasses;
		initializeNonEnumerationAttributeValidatorClasses
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initializeAttributeDefaultValidatorClasses [
	(AttributeDefaultValidatorClasses := Dictionary new)
		at: '' put: XMLAttributeDefaultValueValidator;
		at: 'FIXED' put: XMLAttributeDefaultFixedValueValidator;
		at: 'IMPLIED' put: XMLAttributeDefaultImpliedValidator;
		at: 'REQUIRED' put: XMLAttributeDefaultRequiredValidator
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initializeNonEnumerationAttributeValidatorClasses [
	(NonEnumerationAttributeValidatorClasses := Dictionary new)
		at: 'CDATA' put: XMLCDataAttributeValidator;
		at: 'ID' put: XMLIDAttributeValidator;
		at: 'IDREF' put: XMLIDRefAttributeValidator;
		at: 'IDREFS' put: XMLIDRefsAttributeValidator;
		at: 'ENTITY' put: XMLEntityAttributeValidator;
		at: 'ENTITIES' put: XMLEntitiesAttributeValidator;
		at: 'NMTOKEN' put: XMLNmtokenAttributeValidator;
		at: 'NMTOKENS' put: XMLNmtokensAttributeValidator
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parse [
	^ (NonEnumerationAttributeValidatorClasses
		at: type
		ifAbsent: [^ self parseEnumerationAttributeDefinition])
		element: element
		attribute: attribute
		defaultValidator: defaultValidator
]

{ #category : #private }
DTDAttributeDefinitionParser >> parseEnumerationAttributeDefinition [
	| attributeValidatorClass enumerationListParserClass |

	"either a '(...)' or 'NOTATION (...)' enumeration type"
	(type at: 1) == $(
		ifTrue: [
			attributeValidatorClass := XMLEnumerationAttributeValidator.
			enumerationListParserClass := DTDEnumerationListParser]
		ifFalse: [
			attributeValidatorClass := XMLNotationEnumerationAttributeValidator.
			enumerationListParserClass := DTDNotationEnumerationListParser].

	^ (attributeValidatorClass
		element: element
		attribute: attribute
		defaultValidator: defaultValidator)
			allowedValues: (enumerationListParserClass on: type) parse.
]

{ #category : #initialization }
DTDAttributeDefinitionParser >> setElement: anElement attribute: anAttribute type: aType defaultValidator: aDefaultValidator [
	element := anElement.
	attribute := anAttribute.
	type := aType.
	defaultValidator := aDefaultValidator.
]

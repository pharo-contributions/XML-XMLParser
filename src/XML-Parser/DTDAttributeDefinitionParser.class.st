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
		'defaultPragma',
		'defaultValue'
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
		defaultPragma: aDefaultPragma
		defaultValue: aDefaultValue
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initialize [
	"self initialize"

	super initialize.
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

{ #category : #testing }
DTDAttributeDefinitionParser >> isNotationList: aType [
	^ aType beginsWith: 'NOTATION '
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parse [
	| defaultValueValidator attributeValidator |

	defaultValueValidator :=
		(DefaultValueValidators
			at: defaultPragma
			ifAbsent: [XMLDefaultValueAttributeValidator])
				attribute: attribute
				defaultValue: defaultValue.

	attributeValidator :=
		self validatorClassForType
			element: element
			attribute: attribute
			defaultValueValidator: defaultValueValidator.
	attributeValidator isValueListValidator
		ifTrue: [attributeValidator allowedValues: (self parseValueListType)].

	^ attributeValidator.
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parseValueListType [
	| listParserClass |

	listParserClass :=
		(self isNotationList: type)
			ifTrue: [DTDNotationListParser]
			ifFalse: [DTDEnumerationListParser].

	^ (listParserClass on: type) parse.
]

{ #category : #initialization }
DTDAttributeDefinitionParser >> setElement: anElement attribute: anAttribute type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	element := anElement.
	attribute := anAttribute.
	type := aType.
	defaultPragma := aDefaultPragma.
	defaultValue := aDefaultValue.
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> validatorClassForType [
	^ NonEnumerationValidators 
		at: (type ifEmpty: ['CDATA'])
		ifAbsent: [XMLValueListAttributeValidator]
]

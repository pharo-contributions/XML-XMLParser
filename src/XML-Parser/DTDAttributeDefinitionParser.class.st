"
This class parses an attribute definition in an ATTLIST declaration and creates a validator for it.
"
Class {
	#name : #DTDAttributeDefinitionParser,
	#superclass : #Object,
	#instVars : [
		'element',
		'type',
		'defaultDeclaration',
		'attribute'
	],
	#classVars : [
		'DefaultValueValidators',
		'NonEnumerationValidators'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDAttributeDefinitionParser class >> element: anElement attribute: anAttribute type: aType default: aDefaultDeclaration [
	^ self new
		setElement: anElement
		attribute: anAttribute
		type: aType
		default: aDefaultDeclaration
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initialize [
	"self initialize"

	super initialize.

	(DefaultValueValidators := Dictionary new)
		at: 'FIXED' put: XMLFixedValueAttributeValidator;
		at: 'IMPLIED' put: XMLImpliedValueAttributeValidator;
		at: 'REQUIRED' put: XMLRequiredValueAttributeValidator.

	(NonEnumerationValidators := Dictionary new)
		at: 'CDATA' put: XMLCDataAttributeValidator;
		at: 'ID' put: XMLIDAttributeValidator;
		at: 'IDREF' put: XMLIDRefAttributeValidator;
		at: 'IDREFS' put: XMLIDRefsAttributeValidator;
		at: 'ENTITY' put: XMLEntityAttributeValidator;
		at: 'ENTITIES' put: XMLEntitiesAttributeValidator;
		at: 'NMTOKEN' put: XMLNameAttributeValidator;
		at: 'NMTOKENS' put: XMLNamesAttributeValidator.
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
			at: self parseDefaultPragma
			ifAbsent: [XMLDefaultValueAttributeValidator])
				attribute: attribute
				defaultValue: self parseDefaultValue.

	attributeValidator :=
		self validatorClassForType
			element: element
			attribute: attribute
			defaultValueValidator: defaultValueValidator.
	attributeValidator isValueListValidator
		ifTrue: [attributeValidator allowedValues: (self parseEnumerationType)].

	^ attributeValidator.
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parseDefaultPragma [
	^ (defaultDeclaration beginsWith: '#')
		ifTrue: [defaultDeclaration allButFirst copyUpTo: Character space]
		ifFalse: [nil].
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parseDefaultValue [
	| quote start end |

	quote := nil.
	defaultDeclaration
		doWithIndex: [:each :i |
			(quote isNil and: [each == $" or: [each == $']])
				ifTrue: [
					quote := each.
					start := i].
			(quote notNil and: [each == quote])
				ifTrue: [end := i]].
	^ (start notNil and: [end notNil])
		ifTrue: [defaultDeclaration copyFrom: start + 1 to: end - 1]
		ifFalse: ['']
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parseEnumerationType [
	| listParserClass |

	listParserClass :=
		(self isNotationList: type)
			ifTrue: [DTDNotationListParser]
			ifFalse: [DTDEnumerationListParser].

	^ (listParserClass on: type) parse.
]

{ #category : #initialization }
DTDAttributeDefinitionParser >> setElement: anElement attribute: anAttribute type: aType default: aDefaultDeclaration [
	element := anElement.
	attribute := anAttribute.
	type := aType.
	defaultDeclaration := aDefaultDeclaration.
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> validatorClassForType [
	^ NonEnumerationValidators 
		at: (type ifEmpty: ['CDATA'])
		ifAbsent: [XMLValueListAttributeValidator]
]

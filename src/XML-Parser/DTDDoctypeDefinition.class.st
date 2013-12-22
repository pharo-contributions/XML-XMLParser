"
This class represents the parsed internal and external subset of a DTD.
"
Class {
	#name : #DTDDoctypeDefinition,
	#superclass : #Object,
	#instVars : [
		'rootElement',
		'isStandalone',
		'elementValidators',
		'attributeValidators',
		'generalEntities',
		'parameterEntities',
		'unparsedEntities',
		'notations'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #validators }
DTDDoctypeDefinition >> addAttributeValidator: aValidator [
	| attributeValidatorsForElement |

	attributeValidatorsForElement :=
		self attributeValidators
			at: aValidator element
			ifAbsentPut: [Dictionary new].

	"Subsequent declarations are ignored."
	(attributeValidatorsForElement includesKey: aValidator attribute)
		ifTrue: [^ self].

	aValidator isIDValidator
		ifTrue: [
			attributeValidatorsForElement valuesDo: [:each |
				each isIDValidator
					ifTrue: [
						XMLValidationException signal:
							'Element <', aValidator element, '> has multiple ID attributes']]].

	attributeValidatorsForElement
		at: aValidator attribute
		put: aValidator.
]

{ #category : #accessing }
DTDDoctypeDefinition >> addExternalGeneralEntity: aName resolver: aResolver uri: aSystemUri from: aDocumentOrEntityUri [
	self 
		generalEntityAt: aName
		put: (aResolver
			resolveGeneralEntity: aName
			uri: aSystemUri
			from: aDocumentOrEntityUri)
]

{ #category : #accessing }
DTDDoctypeDefinition >> addExternalParameterEntity: aName resolver: aResolver uri: aSystemUri from: aDocumentOrEntityUri [
	self 
		parameterEntityAt: aName
		put: (aResolver
			resolveParameterEntity: aName
			uri: aSystemUri
			from: aDocumentOrEntityUri)
]

{ #category : #accessing }
DTDDoctypeDefinition >> addGeneralEntity: aName replacement: aReplacement from: aDocumentOrEntityUri [
	self
		generalEntityAt: aName
		put:
			(DTDGeneralEntity 
				name: aName
				replacement: aReplacement
				uri: aDocumentOrEntityUri)
]

{ #category : #accessing }
DTDDoctypeDefinition >> addNotation: aName [
	self notations add: aName
]

{ #category : #accessing }
DTDDoctypeDefinition >> addParameterEntity: aName replacement: aReplacement from: aDocumentOrEntityUri [
	self 
		parameterEntityAt: aName
		put:
			(DTDParameterEntity
				name: aName
				replacement: aReplacement
				uri: aDocumentOrEntityUri).
]

{ #category : #accessing }
DTDDoctypeDefinition >> addUnparsedEntity: aName ndata: aNotation [
	self 
		unparsedEntityAt: aName
		put: aNotation
]

{ #category : #validators }
DTDDoctypeDefinition >> addValidatorForAttributeIn: anElement named: aName type: aType default: aDefaultDeclaration [
	| parser validator  |

	parser :=
		DTDAttributeDefinitionParser
			element:  anElement
			attribute: aName
			type: aType
			default: aDefaultDeclaration.
	validator := parser parse.

	(validator isValueListValidator and: [parser isNotationList: aType])
		ifTrue: [
			(validator allowedValues allSatisfy: [:each | self includesNotation: each])
				ifFalse: [XMLValidationException signal: 'Undeclared notation in enumeration']].
	validator isEntityValidator
		ifTrue: [validator unparsedEntities: self unparsedEntities].

	self addAttributeValidator: validator.
]

{ #category : #validators }
DTDDoctypeDefinition >> addValidatorForElement: anElement contentModel: aContentModel [
	self elementValidators
		at: anElement
		ifAbsentPut: [
			((DTDContentModelParser parserForContentModel: aContentModel)
				element: anElement
				contentModel: aContentModel) parse]
]

{ #category : #accessing }
DTDDoctypeDefinition >> attributeValidators [
	^ attributeValidators ifNil: [attributeValidators := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> elementValidators [
	^ elementValidators ifNil: [elementValidators := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> generalEntities [
	^ generalEntities ifNil: [generalEntities := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> generalEntityAt: aName [
	^ self generalEntities at: aName ifAbsent: [nil]
]

{ #category : #accessing }
DTDDoctypeDefinition >> generalEntityAt: aName put: anEntity [
	self generalEntities at: aName put: anEntity
]

{ #category : #testing }
DTDDoctypeDefinition >> hasAttributeValidators [
	^ attributeValidators notNil and: [attributeValidators notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasElementValidators [
	^ elementValidators notNil and: [elementValidators notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> includesNotation: aName [
	^ self notations includes: aName
]

{ #category : #testing }
DTDDoctypeDefinition >> isStandalone [
	^ isStandalone ifNil: [isStandalone := false]
]

{ #category : #accessing }
DTDDoctypeDefinition >> isStandalone: aBoolean [
	isStandalone := aBoolean
]

{ #category : #accessing }
DTDDoctypeDefinition >> notations [
	^ notations ifNil: [notations := Set new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> parameterEntities [
	^ parameterEntities ifNil: [parameterEntities := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> parameterEntityAt: aName [
	^ self parameterEntities at: aName ifAbsent: [nil]
]

{ #category : #accessing }
DTDDoctypeDefinition >> parameterEntityAt: aName put: anEntity [
	self parameterEntities at: aName put: anEntity
]

{ #category : #accessing }
DTDDoctypeDefinition >> rootElement [
	^ rootElement ifNil: ['']
]

{ #category : #accessing }
DTDDoctypeDefinition >> rootElement: aRootElement [
	rootElement := aRootElement
]

{ #category : #accessing }
DTDDoctypeDefinition >> unparsedEntities [
	^ unparsedEntities ifNil: [unparsedEntities := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> unparsedEntityAt: aName [
	^ self unparsedEntities at: aName ifAbsent: [nil]
]

{ #category : #accessing }
DTDDoctypeDefinition >> unparsedEntityAt: aName put: aNotation [
	self unparsedEntities at: aName put: aNotation
]

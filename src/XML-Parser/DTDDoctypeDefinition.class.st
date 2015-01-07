"
This class represents the parsed internal and external subset of a DTD.
"
Class {
	#name : #DTDDoctypeDefinition,
	#superclass : #Object,
	#instVars : [
		'rootElement',
		'externalSubsetUri',
		'isStandalone',
		'elementValidators',
		'attributeValidators',
		'generalEntities',
		'parameterEntities',
		'unparsedEntities',
		'notations',
		'elementIdValidator',
		'unparsedEntityValidator'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #adding }
DTDDoctypeDefinition >> addExternalGeneralEntity: aName resolver: aResolver uri: aSystemUri from: aDocumentOrEntityUri [
	self generalEntities
		at: aName
		ifAbsentPut: [
			aResolver
				resolveExternalGeneralEntity: aName
				uri: aSystemUri
				from: aDocumentOrEntityUri]
]

{ #category : #adding }
DTDDoctypeDefinition >> addExternalParameterEntity: aName resolver: aResolver uri: aSystemUri from: aDocumentOrEntityUri [
	self parameterEntities
		at: aName
		ifAbsentPut: [
			aResolver
				resolveExternalParameterEntity: aName
				uri: aSystemUri
				from: aDocumentOrEntityUri]
]

{ #category : #adding }
DTDDoctypeDefinition >> addGeneralEntity: aName replacement: aReplacement from: aDocumentOrEntityUri [
	self generalEntities
		at: aName
		ifAbsentPut: [
			DTDGeneralEntity 
				name: aName
				replacement: aReplacement
				uri: aDocumentOrEntityUri]
]

{ #category : #adding }
DTDDoctypeDefinition >> addNotation: aName [
	self notations add: aName
]

{ #category : #adding }
DTDDoctypeDefinition >> addParameterEntity: aName replacement: aReplacement from: aDocumentOrEntityUri [
	self parameterEntities
		at: aName
		ifAbsentPut: [
			DTDParameterEntity
				name: aName
				replacement: aReplacement
				uri: aDocumentOrEntityUri]
]

{ #category : #adding }
DTDDoctypeDefinition >> addUnparsedEntity: aName ndata: aNotation [
	self unparsedEntities
		at: aName
		ifAbsentPut: [aNotation]
]

{ #category : #adding }
DTDDoctypeDefinition >> addValidatorForAttributeIn: anElement named: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	| attributeValidatorsForElement |

	attributeValidatorsForElement :=
		self attributeValidators
			at: anElement
			ifAbsentPut: [Dictionary new].
	(attributeValidatorsForElement includesKey: aName)
		ifTrue: [^ self].

	attributeValidatorsForElement
		at: aName
		put: 
			((DTDAttributeDefinitionParser
				element:  anElement
				attribute: aName
				type: aType
				defaultPragma: aDefaultPragma
				defaultValue: aDefaultValue) parse
					initializeWithValidatorsFrom: self).
]

{ #category : #adding }
DTDDoctypeDefinition >> addValidatorForElement: anElement contentModel: aContentModel [
	self elementValidators
		at: anElement
		ifAbsentPut: [
			((DTDContentModelParser parserForContentModel: aContentModel)
				element: anElement
				contentModel: aContentModel) parse]
]

{ #category : #private }
DTDDoctypeDefinition >> attributeValidators [
	^ attributeValidators ifNil: [attributeValidators := Dictionary new]
]

{ #category : #private }
DTDDoctypeDefinition >> elementIDValidator [
	^ elementIdValidator ifNil: [elementIdValidator := XMLElementIDValidator new]
]

{ #category : #private }
DTDDoctypeDefinition >> elementValidators [
	^ elementValidators ifNil: [elementValidators := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> externalSubsetURI [
	^ externalSubsetUri ifNil: [externalSubsetUri := '']
]

{ #category : #private }
DTDDoctypeDefinition >> generalEntities [
	^ generalEntities ifNil: [generalEntities := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> generalEntityAt: aName [
	^ self
		generalEntityAt: aName
		ifAbsent: [nil]
]

{ #category : #accessing }
DTDDoctypeDefinition >> generalEntityAt: aName ifAbsent: aBlock [
	^ self generalEntities
		at: aName
		ifAbsent: aBlock
]

{ #category : #testing }
DTDDoctypeDefinition >> hasAttributeValidators [
	^ attributeValidators notNil and: [attributeValidators notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasElementIDValidator [
	^ elementIdValidator notNil
]

{ #category : #testing }
DTDDoctypeDefinition >> hasElementValidators [
	^ elementValidators notNil and: [elementValidators notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasExternalSubset [
	^ self isStandalone not and: [self externalSubsetURI notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasValidators [
	^ (attributeValidators notNil
		and: [attributeValidators notEmpty])
			or: [elementValidators notNil
				and: [elementValidators isEmpty]]
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

{ #category : #private }
DTDDoctypeDefinition >> notations [
	^ notations ifNil: [notations := Set new]
]

{ #category : #private }
DTDDoctypeDefinition >> parameterEntities [
	^ parameterEntities ifNil: [parameterEntities := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> parameterEntityAt: aName [
	^ self
		parameterEntityAt: aName
		ifAbsent: [nil]
]

{ #category : #accessing }
DTDDoctypeDefinition >> parameterEntityAt: aName ifAbsent: aBlock [
	^ self parameterEntities
		at: aName
		ifAbsent: aBlock
]

{ #category : #accessing }
DTDDoctypeDefinition >> rootElement [
	^ rootElement ifNil: ['']
]

{ #category : #accessing }
DTDDoctypeDefinition >> rootElement: aRootElement externalSubsetURI: aUri [
	rootElement := aRootElement.
	externalSubsetUri := aUri.
]

{ #category : #private }
DTDDoctypeDefinition >> unparsedEntities [
	^ unparsedEntities ifNil: [unparsedEntities := Dictionary new]
]

{ #category : #accessing }
DTDDoctypeDefinition >> unparsedEntityValidator [
	^ unparsedEntityValidator
		ifNil: [
			unparsedEntityValidator :=
				XMLUnparsedEntityValidator
					unparsedEntities: self unparsedEntities
					notations: self notations]
]

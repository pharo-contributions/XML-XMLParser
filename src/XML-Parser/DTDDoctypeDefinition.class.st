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
		'notations'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #adding }
DTDDoctypeDefinition >> addAttributeValidator: aValidator to: anAttributeValidatorDictionary [
	(aValidator isValueListValidator and: [aValidator hasNotationValues])
		ifTrue: [
			(aValidator allowedValues allSatisfy: [:each | self includesNotation: each])
				ifFalse: [XMLValidationException signal: 'Undeclared notation in enumeration']]
		ifFalse: [
			aValidator isEntityValidator
				ifTrue: [aValidator unparsedEntities: self unparsedEntities]].

	aValidator validateAndAddTo: anAttributeValidatorDictionary.
]

{ #category : #adding }
DTDDoctypeDefinition >> addExternalGeneralEntity: aName resolver: aResolver uri: aSystemUri from: aDocumentOrEntityUri [
	self generalEntities
		at: aName
		ifAbsentPut: [
			aResolver
				resolveGeneralEntity: aName
				uri: aSystemUri
				from: aDocumentOrEntityUri]
]

{ #category : #adding }
DTDDoctypeDefinition >> addExternalParameterEntity: aName resolver: aResolver uri: aSystemUri from: aDocumentOrEntityUri [
	self parameterEntities
		at: aName
		ifAbsentPut: [
			aResolver
				resolveParameterEntity: aName
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
	| parser attributeValidatorsForElement |

	attributeValidatorsForElement :=
		self attributeValidators
			at: anElement
			ifAbsentPut: [Dictionary new].
	(attributeValidatorsForElement includesKey: aName)
		ifTrue: [^ nil].

	parser :=
		DTDAttributeDefinitionParser
			element:  anElement
			attribute: aName
			type: aType
			defaultPragma: aDefaultPragma
			defaultValue: aDefaultValue.

	self
		addAttributeValidator: parser parse
		to: attributeValidatorsForElement.
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
	^ self generalEntities at: aName ifAbsent: [nil]
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
DTDDoctypeDefinition >> hasExternalSubset [
	^ self isStandalone not and: [self externalSubsetURI notEmpty]
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
	^ self parameterEntities at: aName ifAbsent: [nil]
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
DTDDoctypeDefinition >> unparsedEntityAt: aName [
	^ self unparsedEntities at: aName ifAbsent: [nil]
]

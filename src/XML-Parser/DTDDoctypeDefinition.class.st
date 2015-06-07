"
This class represents the parsed internal and external subset of a DTD taken together.
"
Class {
	#name : #DTDDoctypeDefinition,
	#superclass : #Object,
	#instVars : [
		'root',
		'elementValidators',
		'attributeValidators',
		'generalEntities',
		'parameterEntities',
		'unparsedEntities',
		'notations',
		'elementIDValidator',
		'unparsedEntityValidator'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #adding }
DTDDoctypeDefinition >> addExternalGeneralEntity: aName resolver: aResolver uri: aSystemURI from: aDocumentOrEntityURI [
	self generalEntities
		at: aName
		ifAbsentPut: [
			aResolver
				resolveExternalGeneralEntity: aName
				uri: aSystemURI
				from: aDocumentOrEntityURI]
]

{ #category : #adding }
DTDDoctypeDefinition >> addExternalParameterEntity: aName resolver: aResolver uri: aSystemURI from: aDocumentOrEntityURI [
	self parameterEntities
		at: aName
		ifAbsentPut: [
			aResolver
				resolveExternalParameterEntity: aName
				uri: aSystemURI
				from: aDocumentOrEntityURI]
]

{ #category : #adding }
DTDDoctypeDefinition >> addGeneralEntitiesFrom: aDoctypeDefinition [
	aDoctypeDefinition generalEntities keysAndValuesDo: [:name :entity |
		self generalEntities
			at: name
			ifAbsentPut: [entity]]
]

{ #category : #adding }
DTDDoctypeDefinition >> addGeneralEntity: aName replacement: aReplacement from: aDocumentOrEntityURIString [
	self generalEntities
		at: aName
		ifAbsentPut: [
			DTDGeneralEntity 
				name: aName
				replacement: aReplacement
				uri: aDocumentOrEntityURIString]
]

{ #category : #adding }
DTDDoctypeDefinition >> addNotation: aName [
	self notations add: aName
]

{ #category : #adding }
DTDDoctypeDefinition >> addParameterEntity: aName replacement: aReplacement from: aDocumentOrEntityURIString [
	self parameterEntities
		at: aName
		ifAbsentPut: [
			DTDParameterEntity
				name: aName
				replacement: aReplacement
				uri: aDocumentOrEntityURIString]
]

{ #category : #adding }
DTDDoctypeDefinition >> addUnparsedEntity: aName ndata: aNotation [
	self unparsedEntities
		at: aName
		ifAbsentPut: [aNotation]
]

{ #category : #adding }
DTDDoctypeDefinition >> addValidatorForAttributeIn: anElement named: anAttribute type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	| attributeValidatorsForElement |

	attributeValidatorsForElement :=
		self attributeValidators
			at: anElement
			ifAbsentPut: [Dictionary new].
	(attributeValidatorsForElement includesKey: anAttribute)
		ifTrue: [^ self].

	attributeValidatorsForElement
		at: anAttribute
		put: 
			((DTDAttributeDefinitionParser
				element:  anElement
				attribute: anAttribute
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

{ #category : #accessing }
DTDDoctypeDefinition >> clearIDsAndIDReferences [
	self hasElementIDValidator
		ifTrue: [self elementIDValidator clearIDsAndIDReferences]
]

{ #category : #private }
DTDDoctypeDefinition >> elementIDValidator [
	^ elementIDValidator ifNil: [elementIDValidator := XMLElementIDValidator new]
]

{ #category : #private }
DTDDoctypeDefinition >> elementValidators [
	^ elementValidators ifNil: [elementValidators := Dictionary new]
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
	^ elementIDValidator notNil
]

{ #category : #testing }
DTDDoctypeDefinition >> hasElementValidators [
	^ elementValidators notNil and: [elementValidators notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasEntities [
	^ self hasGeneralEntities
		or: [self hasParameterEntities
			or: [self hasUnparsedEntities]]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasGeneralEntities [
	^ generalEntities notNil and: [generalEntities notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasNotations [
	^ notations notNil and: [notations notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasParameterEntities [
	^ parameterEntities notNil and: [parameterEntities notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasRoot [
	^ root notNil and: [root notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasUnparsedEntities [
	^ unparsedEntities notNil and: [unparsedEntities notEmpty]
]

{ #category : #testing }
DTDDoctypeDefinition >> hasValidators [
	^ (attributeValidators notNil
		and: [attributeValidators notEmpty])
			or: [elementValidators notNil
				and: [elementValidators notEmpty]]
]

{ #category : #testing }
DTDDoctypeDefinition >> includesNotation: aName [
	^ self notations includes: aName
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
DTDDoctypeDefinition >> root [
	^ root ifNil: [root := '']
]

{ #category : #accessing }
DTDDoctypeDefinition >> root: aRootElement [
	root := aRootElement
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

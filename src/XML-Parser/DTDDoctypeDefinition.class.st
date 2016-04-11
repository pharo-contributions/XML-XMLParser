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
DTDDoctypeDefinition >> addExternalGeneralEntity: aName resolver: aResolver publicID: aPublicID systemID: aSystemID baseURI: aBaseURIString [
	self generalEntities
		at: aName
		ifAbsentPut: [
			DTDExternalGeneralEntity
				name: aName
				resolver: aResolver
				publicID: aPublicID
				systemID: aSystemID
				baseURI: aBaseURIString]
]

{ #category : #adding }
DTDDoctypeDefinition >> addExternalParameterEntity: aName resolver: aResolver publicID: aPublicID systemID: aSystemID baseURI: aBaseURIString [
	self parameterEntities
		at: aName
		ifAbsentPut: [
			DTDExternalParameterEntity
				name: aName
				resolver: aResolver
				publicID: aPublicID
				systemID: aSystemID
				baseURI: aBaseURIString]
]

{ #category : #adding }
DTDDoctypeDefinition >> addGeneralEntitiesFrom: aDoctypeDefinition [
	aDoctypeDefinition generalEntities keysAndValuesDo: [:name :entity |
		self generalEntities
			at: name
			ifAbsentPut: [entity]]
]

{ #category : #adding }
DTDDoctypeDefinition >> addInternalGeneralEntity: aName replacement: aReplacement baseURI: aBaseURIString [
	self generalEntities
		at: aName
		ifAbsentPut: [
			DTDInternalGeneralEntity 
				name: aName
				replacement: aReplacement
				uri: aBaseURIString]
]

{ #category : #adding }
DTDDoctypeDefinition >> addInternalParameterEntity: aName replacement: aReplacement baseURI: aBaseURIString [
	self parameterEntities
		at: aName
		ifAbsentPut: [
			DTDInternalParameterEntity
				name: aName
				replacement: aReplacement
				uri: aBaseURIString]
]

{ #category : #adding }
DTDDoctypeDefinition >> addNotation: aName [
	self notations add: aName
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

	"additional declarations for the same attribute are legal, unlike with
	element declarations, but are ignored"
	(attributeValidatorsForElement includesKey: anAttribute)
		ifFalse: [
			attributeValidatorsForElement
				at: anAttribute
				put: 
					((DTDAttributeDefinitionParser
						element:  anElement
						attribute: anAttribute
						type: aType
						defaultPragma: aDefaultPragma
						defaultValue: aDefaultValue) parse
							initializeWithValidatorsFrom: self;
							validateAttributeDeclaration)].
]

{ #category : #adding }
DTDDoctypeDefinition >> addValidatorForElement: anElement contentModel: aContentModel [
	| validator oldSize |

	validator :=
		((DTDContentModelParser parserForContentModel: aContentModel)
			element: anElement
			contentModel: aContentModel) parse.

	"testing the size after is faster than an includes: test before"
	oldSize := self elementValidators size.
	(self elementValidators
		at: anElement put: validator;
		size) > oldSize
		ifFalse: [self errorMultipleDeclarationsForElement: anElement]
]

{ #category : #private }
DTDDoctypeDefinition >> attributeValidators [
	^ attributeValidators ifNil: [attributeValidators := Dictionary new]
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
DTDDoctypeDefinition >> errorMultipleDeclarationsForElement: anElement [
	XMLValidationException
		formatSignal: 'Multiple declarations for <{1}> element'
		with: anElement
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
	"optimized to avoid lazy initialization"
	attributeValidators == nil
		ifTrue: [^ false].
	^ attributeValidators size > 0.
]

{ #category : #testing }
DTDDoctypeDefinition >> hasElementIDValidator [
	^ elementIDValidator notNil
]

{ #category : #testing }
DTDDoctypeDefinition >> hasElementValidators [
	"optimized to avoid lazy initialization"
	elementValidators == nil
		ifTrue: [^ false].
	^ elementValidators size > 0.
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
	^ self hasElementValidators
		or: [self hasAttributeValidators]
]

{ #category : #testing }
DTDDoctypeDefinition >> includesNotation: aName [
	^ self notations includes: aName
]

{ #category : #'instance creation' }
DTDDoctypeDefinition >> newValidator [
	^ DTDDocumentValidator doctypeDefinition: self
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

{ #category : #removing }
DTDDoctypeDefinition >> removeIDsAndIDReferences [
	self hasElementIDValidator
		ifTrue: [self elementIDValidator removeIDsAndIDReferences]
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

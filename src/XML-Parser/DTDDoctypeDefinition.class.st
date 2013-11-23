"
This class represents the parsed internal and external subset of a DTD.
"
Class {
	#name : #DTDDoctypeDefinition,
	#superclass : #Object,
	#instVars : [
		'rootElement',
		'isStandalone',
		'generalEntities',
		'parameterEntities',
		'unparsedEntities',
		'notations',
		'elementValidators',
		'attributeValidators'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDDoctypeDefinition >> addNotation: aName [
	self notations add: aName
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

{ #category : #validators }
DTDDoctypeDefinition >> parseAttributeDefinition: anElement name: aName type: aType default: aDefaultDeclaration [
	| parser validator |

	parser :=
		DTDAttributeDefinitionParser
			element:  anElement
			name: aName
			type: aType
			default: aDefaultDeclaration.
	validator := parser parse.

	(validator isEnumerationValidator and: [parser isNotationEnumeration: aType])
		ifTrue: [
			(validator values allSatisfy: [:each | self includesNotation: each])
				ifFalse: [XMLValidationException signal: 'Undeclared notation in enumeration']].
	validator isEntityValidator
		ifTrue: [validator unparsedEntities: self unparsedEntities].

	(self attributeValidators
		at: anElement
		ifAbsentPut: [Dictionary new]) 
			at: aName
			ifAbsentPut: [validator].
]

{ #category : #validators }
DTDDoctypeDefinition >> parseContentModel: aContentModel for: anElement [
	self elementValidators
		at: anElement
		ifAbsentPut: [
			(DTDContentModelParser
				name: anElement
				contentModel: aContentModel) parse]
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

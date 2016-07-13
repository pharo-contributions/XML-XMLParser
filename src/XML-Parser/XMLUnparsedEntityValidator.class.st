"
Used by attribute validators to validate attribute references to unparsed entities and notations.
"
Class {
	#name : #XMLUnparsedEntityValidator,
	#superclass : #Object,
	#instVars : [
		'unparsedEntities',
		'notations',
		'notationAttributeValidators'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLUnparsedEntityValidator class >> unparsedEntities: anUnparsedEntityDictionary notations: aNotationSet [
	^ self new
		setUnparsedEntities: anUnparsedEntityDictionary
		notations: aNotationSet
]

{ #category : #accessing }
XMLUnparsedEntityValidator >> addNotationAttributeValidator: aNotationAttributeValidator [
	| oldSize |

	"checking size after is faster than includes"
	oldSize := self notationAttributeValidators size.
	(self notationAttributeValidators
		at: aNotationAttributeValidator element
		put: aNotationAttributeValidator;
		size) > oldSize
		ifFalse: [
			self errorMultipleNotationAttributesForElement:
				aNotationAttributeValidator element].
]

{ #category : #private }
XMLUnparsedEntityValidator >> errorMultipleDeclarationsForNotation: aNotation [
	XMLValidationException
		formatSignal: 'Multiple declarations for notation "{1}"'
		with: aNotation
]

{ #category : #private }
XMLUnparsedEntityValidator >> errorMultipleNotationAttributesForElement: anElement [
	XMLValidationException
		formatSignal: 'Element <{1}> has multiple NOTATION list attributes'
		with: anElement
]

{ #category : #private }
XMLUnparsedEntityValidator >> errorUndeclaredNotation: aNotation inAttribute: anAttribute [
	XMLValidationException
		formatSignal: 'Undeclared notation "{1}" in NOTATION (...) attribute "{2}"'
		with: aNotation
		with: anAttribute
]

{ #category : #private }
XMLUnparsedEntityValidator >> errorUndeclaredNotation: aNotation inEntity: anEntity [
	XMLValidationException
		formatSignal: 'Undeclared notation "{1}" referenced by <!ENTITY {2} ...> declaration'
		with: aNotation
		with: anEntity
]

{ #category : #private }
XMLUnparsedEntityValidator >> errorUndeclaredUnparsedEntityReference: anEntity inAttribute: anAttriubute [
	XMLValidationException
		formatSignal: 'Undeclared unparsed entity "{1}" in "{2}" attribute'
		with: anEntity
		with: anAttriubute
]

{ #category : #testing }
XMLUnparsedEntityValidator >> hasNotationAttributeValidators [
	"direct access to avoid lazy initialization"
	^ notationAttributeValidators notNil
		and: [notationAttributeValidators notEmpty]
]

{ #category : #accessing }
XMLUnparsedEntityValidator >> notationAttributeValidators [
	^ notationAttributeValidators ifNil: [notationAttributeValidators := Dictionary new]
]

{ #category : #accessing }
XMLUnparsedEntityValidator >> notations [
	^ notations
]

{ #category : #initialization }
XMLUnparsedEntityValidator >> setUnparsedEntities: anUnparsedEntityDictionary notations: aNotationSet [
	unparsedEntities := anUnparsedEntityDictionary.
	notations := aNotationSet.
]

{ #category : #accessing }
XMLUnparsedEntityValidator >> unparsedEntities [
	^ unparsedEntities
]

{ #category : #validating }
XMLUnparsedEntityValidator >> validateEntityReference: anEntity inAttribute: anAttribute [
	(self unparsedEntities includesKey: anEntity)
		ifFalse: [
			self
				errorUndeclaredUnparsedEntityReference: anEntity
				inAttribute: anAttribute]
]

{ #category : #validating }
XMLUnparsedEntityValidator >> validateNotation: aNotation [
	"Unlike redundant entity declarations which are just ignored, redundant
	notation declarations are invalid"
	(self notations includes: aNotation)
		ifTrue: [self errorMultipleDeclarationsForNotation: aNotation]
]

{ #category : #validating }
XMLUnparsedEntityValidator >> validateNotationAttributes [
	"this validatin has to be delayed until the entire DTD
	is processed so NOTATION attributes can be declared before
	the notations in their enumeration are"
	self notationAttributeValidators valuesDo: [:validator |
		validator allowedValues do: [:each |
			(self notations includes: each)
				ifFalse: [
					self
						errorUndeclaredNotation: each
						inAttribute: validator attribute]]]
]

{ #category : #validating }
XMLUnparsedEntityValidator >> validateUnparsedEntities [
	"this validatin has to be delayed until the entire DTD
	is processed so unparsed entities can be declared before
	their notations"
	self unparsedEntities valuesDo: [:each |
		(self notations includes: each ndata)
			ifFalse: [
				self
					errorUndeclaredNotation: each ndata
					inEntity: each name]]
]

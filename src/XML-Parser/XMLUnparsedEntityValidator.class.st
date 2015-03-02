"
Used by attribute validators to validate attribute references to unparsed entities and notations.
"
Class {
	#name : #XMLUnparsedEntityValidator,
	#superclass : #Object,
	#instVars : [
		'elementsAndNotationAttributes',
		'unparsedEntities',
		'notations'
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
XMLUnparsedEntityValidator >> elementsAndNotationAttributes [
	^ elementsAndNotationAttributes ifNil: [elementsAndNotationAttributes := Dictionary new]
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
		formatSignal: 'Undeclared NOTATION "{1}" in "{2}" attribute'
		with: aNotation
		with: anAttribute
]

{ #category : #private }
XMLUnparsedEntityValidator >> errorUndeclaredNotation: aNotation inEntity: anEntity [
	XMLValidationException
		formatSignal: 'Undeclared notation "{1}" referenced by &{2}; entity'
		with: aNotation
		with: anEntity
]

{ #category : #private }
XMLUnparsedEntityValidator >> errorUndeclaredUnparsedEntityReference: aName inAttribute: anAttriubute [
	XMLValidationException
		formatSignal: 'Undeclared unparsed entity "{1}" in "{2}" attribute'
		with: aName
		with: anAttriubute
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
XMLUnparsedEntityValidator >> validateEntityReference: aName inAttribute: anAttribute [
	(self unparsedEntities includesKey: aName)
		ifFalse: [
			self
				errorUndeclaredUnparsedEntityReference: aName
				inAttribute: anAttribute]
]

{ #category : #validating }
XMLUnparsedEntityValidator >> validateNotationAttribute: anAttribute forElement: anElement [
	| oldSize |

	"checking size after is faster than includes"
	oldSize := self elementsAndNotationAttributes size.
	(self elementsAndNotationAttributes
		at: anElement
		put: anAttribute;
		size) > oldSize
		ifFalse: [self errorMultipleNotationAttributesForElement: anElement].
]

{ #category : #validating }
XMLUnparsedEntityValidator >> validateNotationReference: aNotation inAttribute: anAttribute [
	(self notations includes: aNotation)
		ifFalse: [
			self
				errorUndeclaredNotation: aNotation
				inAttribute: anAttribute]
]

{ #category : #validating }
XMLUnparsedEntityValidator >> validateUnparsedEntity: anEntity withNotation: aNotation [
	(self notations includes: aNotation)
		ifFalse: [
			self
				errorUndeclaredNotation: aNotation
				inEntity: anEntity]
]

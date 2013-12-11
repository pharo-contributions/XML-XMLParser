Class {
	#name : #XMLEntityAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'unparsedEntities'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLEntityAttributeValidator >> isEntityValidator [
	^ true
]

{ #category : #accessing }
XMLEntityAttributeValidator >> unparsedEntities [
	^ unparsedEntities ifNil: [unparsedEntities := Dictionary new]
]

{ #category : #accessing }
XMLEntityAttributeValidator >> unparsedEntities: aDictionary [
	unparsedEntities := aDictionary
]

{ #category : #validation }
XMLEntityAttributeValidator >> validateAttributeValue: aValue [
	self validateEntityReference: aValue
]

{ #category : #validation }
XMLEntityAttributeValidator >> validateEntityReference: aName [
	self validateName: aName.
	(self unparsedEntities includesKey: aName)
		ifFalse: [XMLValidationException signal: 'Unrecognized unpasred entity ', aName, ' in attribute "', attribute, '"']
]

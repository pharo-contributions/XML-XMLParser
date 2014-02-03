"
This class validates attributes that contain unparsed entity names (that must be declared).
"
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

{ #category : #validation }
XMLEntityAttributeValidator >> validateAndAddTo: anAttributeValidatorDictionary usingDeclarationsFrom: aDeclarationDelegate [
	unparsedEntities := aDeclarationDelegate unparsedEntities.
	super
		validateAndAddTo: anAttributeValidatorDictionary
		usingDeclarationsFrom: aDeclarationDelegate.
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

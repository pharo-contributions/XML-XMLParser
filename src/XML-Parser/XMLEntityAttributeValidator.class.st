"
This class validates attributes that contain unparsed entity names (that must be declared).
"
Class {
	#name : #XMLEntityAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'unparsedEntityValidator'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #initialization }
XMLEntityAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	unparsedEntityValidator := aValidatorContainer unparsedEntityValidator.
	self validateReservedAttributeValidator.
]

{ #category : #testing }
XMLEntityAttributeValidator >> isEntityValidator [
	^ true
]

{ #category : #accessing }
XMLEntityAttributeValidator >> unparsedEntityValidator [
	^ unparsedEntityValidator
]

{ #category : #validating }
XMLEntityAttributeValidator >> validateAttributeValue: aValue [
	self unparsedEntityValidator
		validateEntityReference: aValue
		inAttribute: self attribute
]

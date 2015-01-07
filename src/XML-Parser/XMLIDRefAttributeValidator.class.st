"
This class validates attributes that refer to an ID of another element with a ID attribute.
"
Class {
	#name : #XMLIDRefAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'elementIdValidator'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLIDRefAttributeValidator >> elementIDValidator [
	^ elementIdValidator
]

{ #category : #initialization }
XMLIDRefAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	elementIdValidator := aValidatorContainer elementIDValidator.
	self validateReservedAttributeValidator.
]

{ #category : #validation }
XMLIDRefAttributeValidator >> validateAttributeValue: aValue [
	self elementIDValidator
		validateIDReference: aValue
		inAttribute: self attribute
]

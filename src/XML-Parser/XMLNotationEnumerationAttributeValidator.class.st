"
This class validates attributes that can have NOTATION names from a list as values.
"
Class {
	#name : #XMLNotationEnumerationAttributeValidator,
	#superclass : #XMLEnumerationAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #initialization }
XMLNotationEnumerationAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	aValidatorContainer unparsedEntityValidator addNotationAttributeValidator: self
]

{ #category : #validating }
XMLNotationEnumerationAttributeValidator >> validateXMLSpaceAttributeValidator [
	self errorInvalidXMLSpaceAttributeValidator
]

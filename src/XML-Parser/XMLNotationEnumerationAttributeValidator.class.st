"
This class validates attributes that can have NOTATION names from a list as values.
"
Class {
	#name : #XMLNotationEnumerationAttributeValidator,
	#superclass : #XMLEnumerationAttributeValidator,
	#instVars : [
		'unparsedEntityValidator'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #initialization }
XMLNotationEnumerationAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	unparsedEntityValidator := aValidatorContainer unparsedEntityValidator
]

{ #category : #accessing }
XMLNotationEnumerationAttributeValidator >> unparsedEntityValidator [
	^ unparsedEntityValidator
]

{ #category : #validating }
XMLNotationEnumerationAttributeValidator >> validateAttributeValue: aValue [
	super validateAttributeValue: aValue.
	self unparsedEntityValidator
		validateNotationReference: aValue
		inAttribute: self attribute.
]

{ #category : #validating }
XMLNotationEnumerationAttributeValidator >> validateDeclaration [
	self unparsedEntityValidator
		validateNotationAttribute: self attribute
		forElement: self element.
	super validateDeclaration.
]

{ #category : #validating }
XMLNotationEnumerationAttributeValidator >> validateXMLSpaceAttributeValidator [
	self errorInvalidXMLSpaceAttributeValidator
]

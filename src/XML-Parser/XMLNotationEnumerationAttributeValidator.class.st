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

{ #category : #'private ' }
XMLNotationEnumerationAttributeValidator >> enumerationListParserClass [
	^ DTDNotationEnumerationListParser
]

{ #category : #testing }
XMLNotationEnumerationAttributeValidator >> hasNotationValues [
	^ true
]

{ #category : #initialization }
XMLNotationEnumerationAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	(unparsedEntityValidator := aValidatorContainer unparsedEntityValidator)
		validateNotationAttribute: self attribute
		forElement: self element.
	self validateReservedAttributeValidator.
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

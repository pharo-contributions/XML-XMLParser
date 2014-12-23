"
This class validates attributes that can have NOTATION names from a list as values.
"
Class {
	#name : #XMLNotationEnumerationAttributeValidator,
	#superclass : #XMLEnumerationAttributeValidator,
	#instVars : [
		'notations'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'private ' }
XMLNotationEnumerationAttributeValidator >> enumerationListParserClass [
	^ DTDNotationEnumerationListParser
]

{ #category : #'private ' }
XMLNotationEnumerationAttributeValidator >> errorMultipleNotationAttributes [
	XMLValidationException
		formatSignal: 'Element <{1}> has multiple NOTATION list attributes'
		with: self element
]

{ #category : #'private ' }
XMLNotationEnumerationAttributeValidator >> errorUndeclaredNotation: aNotation [
	XMLValidationException
		formatSignal: 'Undeclared NOTATION "{1}" in attribute "{2}"'
		with: aNotation
		with: self attribute
]

{ #category : #testing }
XMLNotationEnumerationAttributeValidator >> hasNotationValues [
	^ true
]

{ #category : #accessing }
XMLNotationEnumerationAttributeValidator >> notations [
	^ notations ifNil: [notations := Set new]
]

{ #category : #validation }
XMLNotationEnumerationAttributeValidator >> validateAttributeValue: aValue [
	super validateAttributeValue: aValue.

	(self notations includes: aValue)
		ifFalse: [self errorUndeclaredNotation: aValue]. 
]

{ #category : #validation }
XMLNotationEnumerationAttributeValidator >> validateBeforeAddingTo: anAttributeValidatorDictionary usingDeclarationsFrom: aDeclarationDelegate [
	anAttributeValidatorDictionary valuesDo: [:each |
		each hasNotationValues
			ifTrue: [self errorMultipleNotationAttributes]].
	notations := aDeclarationDelegate notations.
	self validateReservedAttributeValidator.
]

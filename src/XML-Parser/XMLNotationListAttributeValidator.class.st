"
This class validates attributes that can have NOTATION names from a list as values.
"
Class {
	#name : #XMLNotationListAttributeValidator,
	#superclass : #XMLValueListAttributeValidator,
	#instVars : [
		'notations'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'private ' }
XMLNotationListAttributeValidator >> errorMultipleNotationAttributes [
	XMLValidationException
		formatSignal: 'Element <{1}> has multiple NOTATION list attributes'
		with: self element
]

{ #category : #'private ' }
XMLNotationListAttributeValidator >> errorUndeclaredNotation: aNotation [
	XMLValidationException
		formatSignal: 'Undeclared NOTATION "{1}" in attribute "{2}"'
		with: aNotation
		with: self attribute
]

{ #category : #testing }
XMLNotationListAttributeValidator >> hasNotationValues [
	^ true
]

{ #category : #accessing }
XMLNotationListAttributeValidator >> notations [
	^ notations ifNil: [notations := Set new]
]

{ #category : #validation }
XMLNotationListAttributeValidator >> validateAndAddTo: anAttributeValidatorDictionary usingDeclarationsFrom: aDeclarationDelegate [
	anAttributeValidatorDictionary valuesDo: [:each |
		each hasNotationValues
			ifTrue: [self errorMultipleNotationAttributes]].

	notations := aDeclarationDelegate notations.
	super
		validateAndAddTo: anAttributeValidatorDictionary
		usingDeclarationsFrom: aDeclarationDelegate.
]

{ #category : #validation }
XMLNotationListAttributeValidator >> validateAttributeValue: aValue [
	super validateAttributeValue: aValue.

	(self notations includes: aValue)
		ifFalse: [self errorUndeclaredNotation: aValue]. 
]

{ #category : #'private ' }
XMLNotationListAttributeValidator >> valueListParserClass [
	^ DTDNotationListParser
]

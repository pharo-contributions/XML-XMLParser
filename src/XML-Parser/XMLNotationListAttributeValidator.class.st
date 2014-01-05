Class {
	#name : #XMLNotationListAttributeValidator,
	#superclass : #XMLValueListAttributeValidator,
	#instVars : [
		'notations'
	],
	#category : #'XML-Parser-Validation'
}

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
			ifTrue: [
				XMLValidationException signal:
					'Element <', element, '> has multiple NOTATION list attributes']].

	notations := aDeclarationDelegate notations.
	super
		validateAndAddTo: anAttributeValidatorDictionary
		usingDeclarationsFrom: aDeclarationDelegate.
]

{ #category : #validation }
XMLNotationListAttributeValidator >> validateAttributeValue: aValue [
	super validateAttributeValue: aValue.

	(self notations includes: aValue)
		ifFalse: [
			XMLValidationException signal:
				'Undeclared NOTATION "', aValue, '" in attribute "', attribute, '"'].
]

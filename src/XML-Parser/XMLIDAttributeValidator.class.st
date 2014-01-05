Class {
	#name : #XMLIDAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'ids'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLIDAttributeValidator >> hasIDs [
	^ self ids notEmpty
]

{ #category : #accessing }
XMLIDAttributeValidator >> ids [
	^ ids ifNil: [ids := Set new]
	
]

{ #category : #testing }
XMLIDAttributeValidator >> isIDValidator [
	^ true
]

{ #category : #validation }
XMLIDAttributeValidator >> validateAndAddTo: anAttributeValidatorDictionary usingDeclarationsFrom: aDeclarationDelegate [
	anAttributeValidatorDictionary valuesDo: [:each |
		each isIDValidator
			ifTrue: [
				XMLValidationException signal:
					'Element <', element, '> has multiple ID attributes']].
	
	super
		validateAndAddTo: anAttributeValidatorDictionary
		usingDeclarationsFrom: aDeclarationDelegate
]

{ #category : #validation }
XMLIDAttributeValidator >> validateAttributeValue: aValue [
	self validateID: aValue.
	(self ids includes: aValue)
		ifTrue: [
			XMLValidationException signal:
				'ID "', aValue, '" used more than once for <', element, '>'].

	self ids add: aValue.
]

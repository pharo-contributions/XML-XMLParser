Class {
	#name : #XMLValueListAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'allowedValues'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLValueListAttributeValidator >> allowedValues [
	^ allowedValues ifNil: [allowedValues := Set new]
]

{ #category : #accessing }
XMLValueListAttributeValidator >> allowedValues: aValueCollection [
	allowedValues := aValueCollection.
]

{ #category : #testing }
XMLValueListAttributeValidator >> isValueListValidator [
	^ true
]

{ #category : #validation }
XMLValueListAttributeValidator >> validateValue: aValue [
	(self allowedValues includes: aValue)
		ifFalse: [XMLValidationException signal: 'Invalid value "', aValue, '" for attribute "', attribute, '"']
]

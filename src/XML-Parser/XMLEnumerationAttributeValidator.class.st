"
This class validates attributes that can have any value taken from a list like ""(one|two|thee)"".
"
Class {
	#name : #XMLEnumerationAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'allowedValues'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLEnumerationAttributeValidator >> allowedValues [
	^ allowedValues ifNil: [allowedValues := Set new]
]

{ #category : #accessing }
XMLEnumerationAttributeValidator >> allowedValues: aSet [
	allowedValues := aSet
]

{ #category : #'private ' }
XMLEnumerationAttributeValidator >> errorInvalidValue: aValue [
	XMLValidationException
		formatSignal: 'Invalid value "{1}" for attribute "{2}" of element <{3}>'
		with: aValue
		with: self attribute
		with: self element
]

{ #category : #validating }
XMLEnumerationAttributeValidator >> validateAttributeDefaultValue: aDefaultValue [
	(self allowedValues includes: aDefaultValue)
		ifFalse: [self errorInvalidDefaultValue: aDefaultValue]
]

{ #category : #validating }
XMLEnumerationAttributeValidator >> validateAttributeValue: aValue [
	(self allowedValues includes: aValue)
		ifFalse: [self errorInvalidValue: aValue]
]

{ #category : #validating }
XMLEnumerationAttributeValidator >> validateXMLSpaceAttributeValidator [
	self allowedValues size > 2
		ifTrue: [self errorInvalidXMLSpaceAttributeValidator].
	self allowedValues do: [:each |
		((each = 'preserve')
			or: [each = 'default'])
			ifFalse: [self errorInvalidXMLSpaceAttributeValidator]].
]

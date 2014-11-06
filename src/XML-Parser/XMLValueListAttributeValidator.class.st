"
This class validates attributes that can have any value taken from a list like ""(one|two|thee)"".
"
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

{ #category : #'private ' }
XMLValueListAttributeValidator >> errorInvalidValue: aValue [
	XMLValidationException
		formatSignal: 'Invalid value "{1}" for attribute "{2}"'
		with: aValue
		with: self attribute
]

{ #category : #testing }
XMLValueListAttributeValidator >> isValueListValidator [
	^ true
]

{ #category : #accessing }
XMLValueListAttributeValidator >> setAllowedValuesFromString: aString [
	allowedValues := (self valueListParserClass on: aString) parse
]

{ #category : #validation }
XMLValueListAttributeValidator >> validateAttributeValue: aValue [
	(self allowedValues includes: aValue)
		ifFalse: [self errorInvalidValue: aValue]
]

{ #category : #'private ' }
XMLValueListAttributeValidator >> valueListParserClass [
	^ DTDEnumerationListParser
]

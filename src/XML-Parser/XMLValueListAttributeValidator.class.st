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
		ifFalse: [XMLValidationException signal: 'Invalid value "', aValue, '" for attribute "', attribute, '"']
]

{ #category : #'private ' }
XMLValueListAttributeValidator >> valueListParserClass [
	^ DTDEnumerationListParser
]

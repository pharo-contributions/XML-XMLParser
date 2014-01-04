Class {
	#name : #XMLValueListAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'allowedValues',
		'hasNotationValues'
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
XMLValueListAttributeValidator >> hasNotationValues [
	^ hasNotationValues ifNil: [hasNotationValues := false]
]

{ #category : #accessing }
XMLValueListAttributeValidator >> hasNotationValues: aBoolean [
	hasNotationValues := aBoolean
]

{ #category : #testing }
XMLValueListAttributeValidator >> isValueListValidator [
	^ true
]

{ #category : #validation }
XMLValueListAttributeValidator >> validateAndAddTo: anAttributeValidatorDictionary [
	self hasNotationValues
		ifTrue: [
			anAttributeValidatorDictionary valuesDo: [:each |
				(each isValueListValidator and: [each hasNotationValues])
					ifTrue: [
						XMLValidationException signal:
							'Element <', element, '> has multiple NOTATION list attributes']]].

	super validateAndAddTo: anAttributeValidatorDictionary.
]

{ #category : #validation }
XMLValueListAttributeValidator >> validateAttributeValue: aValue [
	(self allowedValues includes: aValue)
		ifFalse: [XMLValidationException signal: 'Invalid value "', aValue, '" for attribute "', attribute, '"']
]

Class {
	#name : #XMLEnumerationAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'values'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLEnumerationAttributeValidator >> isEnumerationValidator [
	^ true
]

{ #category : #validation }
XMLEnumerationAttributeValidator >> validateAttributes: anAttributeDictionary [
	| value |

	value := anAttributeDictionary at: name ifAbsent: [^ self].
	self validateValue: value.
]

{ #category : #validation }
XMLEnumerationAttributeValidator >> validateValue: aValue [
	(self values includes: aValue)
		ifFalse: [XMLValidationException signal: 'Invalid value "', aValue, '" for attribute "', name, '"']
]

{ #category : #accessing }
XMLEnumerationAttributeValidator >> values [
	^ values ifNil: [values := Set new]
]

{ #category : #accessing }
XMLEnumerationAttributeValidator >> values: aValueCollection [
	values := aValueCollection.
]

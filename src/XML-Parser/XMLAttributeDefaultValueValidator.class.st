"
This class will put a default value for an attribute if the attribute is absent.
"
Class {
	#name : #XMLAttributeDefaultValueValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#instVars : [
		'defaultValue'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLAttributeDefaultValueValidator >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
XMLAttributeDefaultValueValidator >> defaultValue: aDefaultValue [
	defaultValue := aDefaultValue
]

{ #category : #testing }
XMLAttributeDefaultValueValidator >> hasDefaultValue [
	^ true
]

{ #category : #initialization }
XMLAttributeDefaultValueValidator >> setAttribute: anAttribute defaultValue: aDefaultValue [
	attribute := anAttribute.
	defaultValue := aDefaultValue.
]

{ #category : #validating }
XMLAttributeDefaultValueValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	"unless the attribute is set (even just to an empty value), then it's set
	to the default value"
	anAttributeDictionary
		at: self attribute
		ifAbsentPut: [self defaultValue]
]

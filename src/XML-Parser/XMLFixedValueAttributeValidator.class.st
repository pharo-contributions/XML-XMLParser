"
This class fixes the value of an attribute to a default.
"
Class {
	#name : #XMLFixedValueAttributeValidator,
	#superclass : #XMLDefaultValueAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #private }
XMLFixedValueAttributeValidator >> errorNonDefaultValue [
	XMLValidationException
		formatSignal: '#FIXED attribute "{1}" can only have "{2}" as value'
		with: self attribute
		with: self defaultValue
]

{ #category : #validating }
XMLFixedValueAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	(anAttributeDictionary
		at: self attribute
		ifAbsentPut: [self defaultValue]) = self defaultValue
		ifFalse: [self errorNonDefaultValue]
]

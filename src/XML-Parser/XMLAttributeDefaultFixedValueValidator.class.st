"
This class will put a default value for an attribute if the attribute is absent and also makes sure that any value matches the default (the #FIXED constraint).
"
Class {
	#name : #XMLAttributeDefaultFixedValueValidator,
	#superclass : #XMLAttributeDefaultValueValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #private }
XMLAttributeDefaultFixedValueValidator >> errorNonDefaultValue [
	XMLValidationException
		formatSignal: 'Fixed attribute "{1}" can only have "{2}" as its value'
		with: self attribute
		with: self defaultValue
]

{ #category : #validating }
XMLAttributeDefaultFixedValueValidator >> validateAttributeDefaultIn: aDictionary [
	"unless the attribute is set (even just to an empty value), then it's set
	to the fixed default value, which it must match"
	(aDictionary
		at: self attribute
		ifAbsentPut: [self defaultValue]) = self defaultValue
		ifFalse: [self errorNonDefaultValue]
]

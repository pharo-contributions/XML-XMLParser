"
This class fixes the value of an attribute to a default.
"
Class {
	#name : #XMLFixedValueAttributeValidator,
	#superclass : #XMLDefaultValueAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLFixedValueAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	anAttributeDictionary at: attribute put: defaultValue
]

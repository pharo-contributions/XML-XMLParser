Class {
	#name : #XMLFixedValueAttributeValidator,
	#superclass : #XMLDefaultValueAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLFixedValueAttributeValidator >> validateDefaultValueIn: anAttributeDictionary [
	anAttributeDictionary at: attribute put: defaultValue
]

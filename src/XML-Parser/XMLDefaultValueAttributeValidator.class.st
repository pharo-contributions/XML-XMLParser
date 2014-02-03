"
This class will put a default value for an attribute if it has none.
"
Class {
	#name : #XMLDefaultValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLDefaultValueAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	((anAttributeDictionary at: attribute ifAbsent: ['']) isEmpty 
		and: [defaultValue notEmpty])
		ifTrue: [anAttributeDictionary at: attribute put: defaultValue]
]

Class {
	#name : #XMLDefaultValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLDefaultValueAttributeValidator >> validateDefaultValueIn: anAttributeDictionary [
	((anAttributeDictionary at: attribute ifAbsent: ['']) isEmpty 
		and: [defaultValue notEmpty])
		ifTrue: [anAttributeDictionary at: attribute put: defaultValue]
]

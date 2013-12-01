Class {
	#name : #XMLDefaultValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLDefaultValueAttributeValidator >> validateDefaultValueIn: anAttributeDictionary [
	((anAttributeDictionary at: name ifAbsent: ['']) isEmpty 
		and: [defaultValue notEmpty])
		ifTrue: [anAttributeDictionary at: name put: defaultValue]
]

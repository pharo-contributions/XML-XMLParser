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
	((anAttributeDictionary at: self attribute ifAbsent: ['']) isEmpty 
		and: [self defaultValue notEmpty])
		ifTrue: [anAttributeDictionary at: self attribute put: self defaultValue]
]

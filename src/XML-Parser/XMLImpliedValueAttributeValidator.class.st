Class {
	#name : #XMLImpliedValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLImpliedValueAttributeValidator >> validateDefaultValueIn: anAttributeDictionary [
	anAttributeDictionary at: name ifAbsentPut: ['']
]

Class {
	#name : #XMLImpliedValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLImpliedValueAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	anAttributeDictionary at: attribute ifAbsentPut: ['']
]

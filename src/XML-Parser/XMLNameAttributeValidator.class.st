Class {
	#name : #XMLNameAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLNameAttributeValidator >> validateAttributes: anAttributeDictionary [
	self validateName: (anAttributeDictionary at: name)
]

Class {
	#name : #XMLRequiredValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLRequiredValueAttributeValidator >> validateDefaultValueIn: anAttributeDictionary [
	(anAttributeDictionary includesKey: name)
		ifFalse: [XMLValidationException signal: 'Required attribute "', name, '" is missing']
]

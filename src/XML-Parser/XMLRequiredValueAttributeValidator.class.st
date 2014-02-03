"
Attributes declared #REQUIRED require values.
"
Class {
	#name : #XMLRequiredValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLRequiredValueAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	(anAttributeDictionary includesKey: attribute)
		ifFalse: [XMLValidationException signal: 'Required attribute "', attribute, '" is missing']
]

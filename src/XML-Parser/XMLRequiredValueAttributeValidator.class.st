"
Attributes declared #REQUIRED require values.
"
Class {
	#name : #XMLRequiredValueAttributeValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #private }
XMLRequiredValueAttributeValidator >> errorRequiredAttributeMissing [
	XMLValidationException
		formatSignal: 'Required attribute "{1}" is missing'
		with: self attribute
]

{ #category : #validating }
XMLRequiredValueAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	(anAttributeDictionary includesKey: self attribute)
		ifFalse: [self errorRequiredAttributeMissing]
]

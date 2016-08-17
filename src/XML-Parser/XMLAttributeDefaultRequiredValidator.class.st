"
This class makes sure an attribute is present (the #REQUIRED constrant).
"
Class {
	#name : #XMLAttributeDefaultRequiredValidator,
	#superclass : #XMLAttributeDefaultValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #private }
XMLAttributeDefaultRequiredValidator >> errorRequiredAttributeMissing [
	XMLValidationException
		formatSignal: 'Required attribute "{1}" is missing'
		with: self attribute
]

{ #category : #validating }
XMLAttributeDefaultRequiredValidator >> validateAttributeDefaultIn: aDictionary [
	(aDictionary includesKey: self attribute)
		ifFalse: [self errorRequiredAttributeMissing]
]

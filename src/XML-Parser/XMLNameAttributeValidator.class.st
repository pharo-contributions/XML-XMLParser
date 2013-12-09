Class {
	#name : #XMLNameAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLNameAttributeValidator >> validateValue: aValue [
	self validateName: aValue
]

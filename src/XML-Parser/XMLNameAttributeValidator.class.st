"
This class validates name attributes.
"
Class {
	#name : #XMLNameAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLNameAttributeValidator >> validateAttributeValue: aValue [
	self validateName: aValue
]

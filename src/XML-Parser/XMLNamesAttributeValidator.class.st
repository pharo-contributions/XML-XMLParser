"
This class validates attributes with lists of name values separated by spaces.
"
Class {
	#name : #XMLNamesAttributeValidator,
	#superclass : #XMLNameAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLNamesAttributeValidator >> validateAttributeValue: aValue [
	self
		spaceSeparatedValuesIn: aValue
		do: [:each | self validateName: each]
]

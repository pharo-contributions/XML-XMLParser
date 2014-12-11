"
This class validates attributes with lists of Nmtoken name values separated by spaces.
"
Class {
	#name : #XMLNmtokensAttributeValidator,
	#superclass : #XMLNmtokenAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLNmtokensAttributeValidator >> validateAttributeValue: aValue [
	self
		listValuesIn: aValue
		do: [:each | self validateNmtoken: each]
]

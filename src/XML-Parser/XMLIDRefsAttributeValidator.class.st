"
This class validates attributes with lists of ID ref values separated by spaces.
"
Class {
	#name : #XMLIDRefsAttributeValidator,
	#superclass : #XMLIDRefAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validating }
XMLIDRefsAttributeValidator >> validateAttributeValue: aValue [
	self
		listValuesIn: aValue
		do: [:each |
			self elementIDValidator
				validateIDReference: each
				inAttribute: self attribute]
]

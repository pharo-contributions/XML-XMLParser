"
This class validates attributes with lists of ID ref values separated by spaces.
"
Class {
	#name : #XMLIDRefsAttributeValidator,
	#superclass : #XMLIDRefAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLIDRefsAttributeValidator >> validateAttributeValue: aValue [
	self
		listValuesIn: aValue
		do: [:each |
			self validateID: each.
			self idRefs add: each].
]

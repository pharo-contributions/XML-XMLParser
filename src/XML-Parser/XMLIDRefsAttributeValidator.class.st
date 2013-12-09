Class {
	#name : #XMLIDRefsAttributeValidator,
	#superclass : #XMLIDRefAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLIDRefsAttributeValidator >> validateValue: aValue [
	Character space
		split: aValue
		do: [:each |
			self validateID: each.
			self idrefs add: each].
]

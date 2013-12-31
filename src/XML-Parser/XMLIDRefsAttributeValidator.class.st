Class {
	#name : #XMLIDRefsAttributeValidator,
	#superclass : #XMLIDRefAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLIDRefsAttributeValidator >> validateAttributeValue: aValue [
	Character space
		split: aValue
		do: [:each |
			self validateID: each.
			self idRefs add: each].
]

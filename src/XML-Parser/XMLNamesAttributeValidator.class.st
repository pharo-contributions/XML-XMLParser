Class {
	#name : #XMLNamesAttributeValidator,
	#superclass : #XMLNameAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLNamesAttributeValidator >> validateAttributeValue: aValue [
	Character space
		split: aValue
		do: [:each | self validateName: each]
]

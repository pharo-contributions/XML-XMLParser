Class {
	#name : #XMLEntitiesAttributeValidator,
	#superclass : #XMLEntityAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLEntitiesAttributeValidator >> validateAttributeValue: aValue [
	Character space
		split: aValue
		do: [:each | self validateEntityReference: each]
]

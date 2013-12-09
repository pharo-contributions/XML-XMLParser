Class {
	#name : #XMLEntitiesAttributeValidator,
	#superclass : #XMLEntityAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLEntitiesAttributeValidator >> validateValue: aValue [
	Character space
		split: aValue
		do: [:each | self validateEntityReference: each]
]

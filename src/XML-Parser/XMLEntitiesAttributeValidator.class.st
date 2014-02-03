"
This class validates attributes with lists of unparsed entity name values separated by spaces.
"
Class {
	#name : #XMLEntitiesAttributeValidator,
	#superclass : #XMLEntityAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLEntitiesAttributeValidator >> validateAttributeValue: aValue [
	self
		spaceSeparatedValuesIn: aValue
		do: [:each | self validateEntityReference: each]
]

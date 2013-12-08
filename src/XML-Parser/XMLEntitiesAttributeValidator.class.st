Class {
	#name : #XMLEntitiesAttributeValidator,
	#superclass : #XMLEntityAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLEntitiesAttributeValidator >> validateAttributes: anAttributeDictionary [
	Character space
		split: (anAttributeDictionary at: name ifAbsent: [^ self])
		do: [:each | self validateEntityReference: each]
]

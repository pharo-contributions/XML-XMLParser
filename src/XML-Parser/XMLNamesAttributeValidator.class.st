Class {
	#name : #XMLNamesAttributeValidator,
	#superclass : #XMLNameAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLNamesAttributeValidator >> validateAttributes: anAttributeDictionary [
	Character space
		split: (anAttributeDictionary at: name ifAbsent: [^ self])
		do: [:each | self validateName: each]
]

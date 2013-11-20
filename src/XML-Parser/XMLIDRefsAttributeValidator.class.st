Class {
	#name : #XMLIDRefsAttributeValidator,
	#superclass : #XMLIDRefAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLIDRefsAttributeValidator >> validateAttributes: anAttributeDictionary [
	(Character space split: (anAttributeDictionary at: name ifAbsent: [^ self]))
		do: [:each |
			self validateID: each.
			self idrefs add: each].
]

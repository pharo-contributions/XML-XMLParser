"
This class validates attributes with lists of unparsed entity name values (that must be declared) separated by spaces.
"
Class {
	#name : #XMLEntitiesAttributeValidator,
	#superclass : #XMLEntityAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validating }
XMLEntitiesAttributeValidator >> validateAttributeDefaultValue: aDefaultValue [
	self
		spaceSeparatedListValuesIn: aDefaultValue
		do: [:each |
			each isXMLName
				ifFalse: [self errorInvalidDefaultValue: aDefaultValue]]
]

{ #category : #validating }
XMLEntitiesAttributeValidator >> validateAttributeValue: aValue [
	self
		spaceSeparatedListValuesIn: aValue
		do: [:each |
			self unparsedEntityValidator
				validateEntityReference: each
				inAttribute: self attribute]
]

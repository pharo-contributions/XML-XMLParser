"
A validator for xml:id attributes.
"
Class {
	#name : #XMLReservedIDAttributeValidator,
	#superclass : #XMLIDAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLReservedIDAttributeValidator >> attribute [
	^ 'xml:id'
]

{ #category : #validation }
XMLReservedIDAttributeValidator >> validateAttributes: anAttributeDictionary [
	self validateAttributeValue:
		(anAttributeDictionary
			at: self attribute
			ifAbsent: [^ self])
]

{ #category : #validation }
XMLReservedIDAttributeValidator >> validateID: anId [
	((XMLWellFormedParserTokenizer isName: anId)
		and: [(anId indexOf: $:) = 0])
		ifFalse: [self errorInvalidID: anId]
]

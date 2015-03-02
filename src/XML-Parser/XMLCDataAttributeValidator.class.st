"
CDATA attribute values are left alone (whitespace is not normalized further).
"
Class {
	#name : #XMLCDataAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLCDataAttributeValidator >> shouldFurtherNormalizeAttributeValue [
	^ false
]

{ #category : #validating }
XMLCDataAttributeValidator >> validateAttributeValue: aValue [
	
]

"
This class validates CDATA attributes, which are not whitespace-normalized further.
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

"
This class validates xml:id ID attributes.
"
Class {
	#name : #XMLIDAttributeXMLIDValidator,
	#superclass : #XMLIDAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validating }
XMLIDAttributeXMLIDValidator >> validateAttributeValue: aValue [
	self elementIDValidator validateXMLID: aValue
]

{ #category : #validating }
XMLIDAttributeXMLIDValidator >> validateXMLIDAttributeValidator [

]

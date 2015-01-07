"
A validator of xml:id attributes.
"
Class {
	#name : #XMLXMLIDIDAttributeValidator,
	#superclass : #XMLIDAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validation }
XMLXMLIDIDAttributeValidator >> validateAttributeValue: aValue [
	self elementIDValidator validateXMLID: aValue
]

"
A validator of xml:id attributes.
"
Class {
	#name : #XMLXMLIDIDAttributeValidator,
	#superclass : #XMLIDAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #validating }
XMLXMLIDIDAttributeValidator >> validateAttributeValue: aValue [
	self elementIDValidator validateXMLID: aValue
]

{ #category : #validating }
XMLXMLIDIDAttributeValidator >> validateXMLIDAttributeValidator [

]

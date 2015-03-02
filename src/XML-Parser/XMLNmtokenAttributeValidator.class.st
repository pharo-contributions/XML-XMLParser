"
This class validates Nmtoken name attributes.
"
Class {
	#name : #XMLNmtokenAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #private }
XMLNmtokenAttributeValidator >> errorInvalidNmtoken: aName [
	XMLValidationException
		formatSignal: 'Invalid Nmtoken name "{1}" in attribute "{2}"'
		with: aName
		with: self attribute
]

{ #category : #validating }
XMLNmtokenAttributeValidator >> validateAttributeValue: aValue [
	self validateNmtoken: aValue
]

{ #category : #validating }
XMLNmtokenAttributeValidator >> validateNmtoken: aName [
	(XMLWellFormedParserTokenizer isNmtoken: aName)
		ifFalse: [self errorInvalidNmtoken: aName]
]

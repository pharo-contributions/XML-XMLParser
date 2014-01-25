"
This parses attribute value enumeration lists.
"
Class {
	#name : #DTDEnumerationListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDEnumerationListParser >> isValidListValue: aValue [
	^ true
]

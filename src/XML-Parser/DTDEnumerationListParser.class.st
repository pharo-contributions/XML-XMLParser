Class {
	#name : #DTDEnumerationListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDEnumerationListParser >> isValidListValue: aValue [
	^ XMLTokenizer isNmtoken: aValue
]

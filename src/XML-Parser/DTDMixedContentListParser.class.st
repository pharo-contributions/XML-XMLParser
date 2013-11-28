Class {
	#name : #DTDMixedContentListParser,
	#superclass : #DTDEnumerationListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDMixedContentListParser >> isValidListValue: aValue [
	^ aValue = '#PCDATA' or: [XMLTokenizer isName: aValue]
]

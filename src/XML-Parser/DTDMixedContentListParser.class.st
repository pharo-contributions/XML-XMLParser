Class {
	#name : #DTDMixedContentListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDMixedContentListParser >> isValidListValue: aValue [
	^ aValue = '#PCDATA' or: [XMLTokenizer isName: aValue]
]

Class {
	#name : #DTDNotationListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDNotationListParser >> isValidListValue: aValue [
	^ XMLTokenizer isName: aValue
]

{ #category : #accessing }
DTDNotationListParser >> valueList: aString [
	super valueList:
		(aString
			copyFrom: (aString indexOf: $()
			to: aString size)
]

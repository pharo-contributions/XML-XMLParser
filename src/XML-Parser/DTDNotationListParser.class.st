Class {
	#name : #DTDNotationListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDNotationListParser class >> on: aString [
	^ super on:
		(aString
			copyFrom: (aString indexOf: $()
			to: aString size)
]

{ #category : #testing }
DTDNotationListParser >> isValidListValue: aValue [
	^ XMLTokenizer isName: aValue
]

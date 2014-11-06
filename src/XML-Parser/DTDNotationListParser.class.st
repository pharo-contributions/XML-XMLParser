"
This class parses notation attribute value lists.
"
Class {
	#name : #DTDNotationListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDNotationListParser >> isValidListValue: aValue [
	^ XMLWellFormedParserTokenizer isName: aValue
]

{ #category : #initialization }
DTDNotationListParser >> on: aString [
	super on:
		(aString
			copyFrom: (aString indexOf: $()
			to: aString size)
]

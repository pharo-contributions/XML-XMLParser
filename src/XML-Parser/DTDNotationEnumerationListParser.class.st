"
This class parses notation attribute value lists.
"
Class {
	#name : #DTDNotationEnumerationListParser,
	#superclass : #DTDEnumerationListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #initialization }
DTDNotationEnumerationListParser >> on: aString [
	super on: aString.
	startIndex := 11. "'NOTATION (' size + 1"
]

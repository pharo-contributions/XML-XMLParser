Class {
	#name : #DTDNotationListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDNotationListParser class >> on: aString [
	^ super on: (aString copyAfter: Character space)
]

{ #category : #testing }
DTDNotationListParser >> isValidListValue: aValue [
	^ XMLTokenizer isName: aValue	
]

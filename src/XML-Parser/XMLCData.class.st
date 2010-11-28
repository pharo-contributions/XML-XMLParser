"
This class represents a preserved CDATA section in the document. It behaves like a string, but its printed form differs.
"
Class {
	#name : #XMLCData,
	#superclass : #XMLString,
	#category : #'XML-Parser-Nodes'
}

{ #category : #testing }
XMLCData >> isCData [
	^ true
]

{ #category : #printing }
XMLCData >> writeXMLWith: aWriter [
	aWriter cdata: self string
]

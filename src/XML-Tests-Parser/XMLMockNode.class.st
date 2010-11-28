Class {
	#name : #XMLMockNode,
	#superclass : #XMLNode,
	#category : #'XML-Tests-Parser-Nodes'
}

{ #category : #printing }
XMLMockNode >> writeXMLWith: aWriter [
	aWriter string: self class name asString, '(', self identityHash printString, ') '
]

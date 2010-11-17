Class {
	#name : #XMLMockNode,
	#superclass : #XMLNode,
	#category : #'XML-Tests-Parser-Nodes'
}

{ #category : #printing }
XMLMockNode >> printXMLOn: aWriter [
	aWriter string: self class name asString, '(', self identityHash printString, ') '
]

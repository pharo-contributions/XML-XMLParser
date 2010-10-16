Class {
	#name : #XMLMockNode,
	#superclass : #XMLNode,
	#category : #'XML-Parser-Tests'
}

{ #category : #printing }
XMLMockNode >> printXMLOn: aWriter [
	aWriter string: 'XMLMockNode(', self identityHash asString, ') '
]

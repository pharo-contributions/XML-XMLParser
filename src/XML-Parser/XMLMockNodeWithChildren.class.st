Class {
	#name : #XMLMockNodeWithChildren,
	#superclass : #XMLNodeWithChildren,
	#category : #'XML-Parser-Tests'
}

{ #category : #private }
XMLMockNodeWithChildren >> nodesClass [
	^ XMLNodeList
]

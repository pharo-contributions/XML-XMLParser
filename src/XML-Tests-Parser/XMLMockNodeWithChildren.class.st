Class {
	#name : #XMLMockNodeWithChildren,
	#superclass : #XMLNodeWithChildren,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #private }
XMLMockNodeWithChildren >> nodeListClass [
	^ XMLNodeList
]

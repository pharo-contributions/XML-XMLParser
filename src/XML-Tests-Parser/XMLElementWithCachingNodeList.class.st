"
A class for testing elements that use XMLCachingNodeList instead of XMLNodeList.
"
Class {
	#name : #XMLElementWithCachingNodeList,
	#superclass : #XMLElement,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #private }
XMLElementWithCachingNodeList >> nodeListClass [
	^ XMLCachingNodeList
]

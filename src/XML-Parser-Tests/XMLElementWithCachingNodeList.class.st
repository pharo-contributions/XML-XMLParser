"
A class for testing elements that use XMLCachingNodeList instead of XMLNodeList.
"
Class {
	#name : #XMLElementWithCachingNodeList,
	#superclass : #XMLElement,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #defaults }
XMLElementWithCachingNodeList >> nodeListClass [
	^ XMLCachingNodeList
]

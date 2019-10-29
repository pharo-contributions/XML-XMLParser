"
A class for testing documents that use XMLCachingNodeList instead of XMLNodeList.
"
Class {
	#name : #XMLDocumentWithCachingNodeList,
	#superclass : #XMLDocument,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #defaults }
XMLDocumentWithCachingNodeList >> nodeListClass [
	^ XMLCachingNodeList
]

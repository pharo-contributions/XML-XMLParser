"
A class for testing documents that use XMLCachingNodeList instead of XMLNodeList.
"
Class {
	#name : 'XMLDocumentWithCachingNodeList',
	#superclass : 'XMLDocument',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'defaults' }
XMLDocumentWithCachingNodeList >> nodeListClass [
	^ XMLCachingNodeList
]

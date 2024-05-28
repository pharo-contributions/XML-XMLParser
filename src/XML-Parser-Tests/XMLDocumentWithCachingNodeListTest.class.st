Class {
	#name : 'XMLDocumentWithCachingNodeListTest',
	#superclass : 'XMLDocumentTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'accessing' }
XMLDocumentWithCachingNodeListTest >> elementClass [
	^ XMLElementWithCachingNodeList
]

{ #category : 'accessing' }
XMLDocumentWithCachingNodeListTest >> nodeClass [
	^ XMLDocumentWithCachingNodeList
]

{ #category : 'accessing' }
XMLDocumentWithCachingNodeListTest >> nodeListClass [
	^ XMLCachingNodeList
]

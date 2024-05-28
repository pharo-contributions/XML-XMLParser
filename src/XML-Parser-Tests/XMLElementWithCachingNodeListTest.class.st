Class {
	#name : 'XMLElementWithCachingNodeListTest',
	#superclass : 'XMLElementTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'accessing' }
XMLElementWithCachingNodeListTest >> elementClass [
	^ XMLElementWithCachingNodeList
]

{ #category : 'accessing' }
XMLElementWithCachingNodeListTest >> nodeClass [
	^ XMLElementWithCachingNodeList
]

{ #category : 'accessing' }
XMLElementWithCachingNodeListTest >> nodeListClass [
	^ XMLCachingNodeList
]

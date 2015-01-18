Class {
	#name : #XMLCachingNodeListTest,
	#superclass : #XMLNodeListTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLCachingNodeListTest >> listClass [
	^ XMLCachingNodeList
]

{ #category : #accessing }
XMLCachingNodeListTest >> listCopyClass [
	^ XMLNodeList
]

Class {
	#name : #XMLElementWithCachingNodeListTest,
	#superclass : #XMLElementTest,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #accessing }
XMLElementWithCachingNodeListTest >> elementClass [
	^ XMLElementWithCachingNodeList
]

{ #category : #accessing }
XMLElementWithCachingNodeListTest >> nodeClass [
	^ XMLElementWithCachingNodeList
]

{ #category : #accessing }
XMLElementWithCachingNodeListTest >> nodeListClass [
	^ XMLCachingNodeList
]

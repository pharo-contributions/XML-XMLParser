Class {
	#name : #XMLElementWithoutCachingAttributeListTest,
	#superclass : #XMLElementTest,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #accessing }
XMLElementWithoutCachingAttributeListTest >> attributeListClass [
	^ XMLAttributeList
]

{ #category : #accessing }
XMLElementWithoutCachingAttributeListTest >> elementClass [
	^ XMLElementWithoutCachingAttributeList
]

{ #category : #accessing }
XMLElementWithoutCachingAttributeListTest >> nodeClass [
	^ XMLElementWithoutCachingAttributeList
]

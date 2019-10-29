"
A class for testing elements that use XMLAttributeList instead of XMLCachingAttributeList.
"
Class {
	#name : #XMLElementWithoutCachingAttributeList,
	#superclass : #XMLElement,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #defaults }
XMLElementWithoutCachingAttributeList >> attributeListClass [
	^ XMLAttributeList
]

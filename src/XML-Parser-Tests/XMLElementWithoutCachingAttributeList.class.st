"
A class for testing elements that use XMLAttributeList instead of XMLCachingAttributeList.
"
Class {
	#name : 'XMLElementWithoutCachingAttributeList',
	#superclass : 'XMLElement',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'defaults' }
XMLElementWithoutCachingAttributeList >> attributeListClass [
	^ XMLAttributeList
]

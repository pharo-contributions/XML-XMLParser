Class {
	#name : #XMLCachingAttributeListTest,
	#superclass : #XMLAttributeListTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #assertions }
XMLCachingAttributeListTest >> assertList: aList copiedFrom: aSecondList equals: aThirdList [
	super
		assertList: aList
		copiedFrom: aSecondList
		equals: aThirdList.
	"internal dictionary must be copied"
	self
		assert: aList attributeNodesByName = aThirdList attributeNodesByName;
		deny: aList attributeNodesByName == aSecondList attributeNodesByName.
]

{ #category : #assertions }
XMLCachingAttributeListTest >> assertList: aList isCopyOf: aSecondList [
	super assertList: aList isCopyOf: aSecondList.
	"internal dictionary must be copied"
	self
		assert: aList attributeNodesByName = aSecondList attributeNodesByName;
		deny: aList attributeNodesByName == aSecondList attributeNodesByName.
]

{ #category : #accessing }
XMLCachingAttributeListTest >> listClass [
	^ XMLCachingAttributeList
]

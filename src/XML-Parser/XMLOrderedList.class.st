"
This class functions as an OrderedCollection that will not raise exceptions when attempts are made to access absent objects. This means messages like #at:, #after:, and #first will return nil when the requested object cannot be retrieved. Messages that modify the collection based on the presence or absence of other objects such as #add:after: or #at:put: will still raise exceptions as usual.


"
Class {
	#name : #XMLOrderedList,
	#superclass : #SequenceableCollection,
	#instVars : [
		'collection'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLOrderedList class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
XMLOrderedList class >> new: aSize [
	^ self basicNew setCollection: (OrderedCollection new: aSize)
]

{ #category : #'instance creation' }
XMLOrderedList class >> new: aSize withAll: anObject [
	^ self basicNew setCollection: (OrderedCollection new: aSize withAll: anObject)
]

{ #category : #'instance creation' }
XMLOrderedList class >> newFrom: aCollection [
	^ self basicNew setCollection: (OrderedCollection newFrom: aCollection)
]

{ #category : #'instance creation' }
XMLOrderedList class >> ofSize: aSize [
	^ self new: aSize withAll: nil
]

{ #category : #adding }
XMLOrderedList >> add: anObject [
	^ self addLast: anObject
]

{ #category : #adding }
XMLOrderedList >> add: anObject after: aPriorObject [
	^ collection add: anObject after: aPriorObject
]

{ #category : #adding }
XMLOrderedList >> add: anObject afterIndex: anIndex [
	^ collection add: anObject afterIndex: anIndex
]

{ #category : #adding }
XMLOrderedList >> add: anObject before: aSubsequentObject [
	^ collection add: anObject before: aSubsequentObject
]

{ #category : #adding }
XMLOrderedList >> add: anObject beforeIndex: anIndex [
	^ collection add: anObject beforeIndex: anIndex
]

{ #category : #adding }
XMLOrderedList >> addAll: aCollection [
	^ self addAllLast: aCollection
]

{ #category : #adding }
XMLOrderedList >> addAllFirst: aCollection [
	aCollection reverseDo: [:each | self addFirst: each].
	^ aCollection.
]

{ #category : #adding }
XMLOrderedList >> addAllLast: aCollection [
	aCollection do: [:each | self addLast: each].
	^ aCollection.
]

{ #category : #adding }
XMLOrderedList >> addFirst: anObject [
	^ collection addFirst: anObject
]

{ #category : #adding }
XMLOrderedList >> addLast: anObject [
	^ collection addLast: anObject
]

{ #category : #accessing }
XMLOrderedList >> after: anObject [
	^ collection after: anObject ifAbsent: [self defaultValue]
]

{ #category : #converting }
XMLOrderedList >> asArray [
	^ collection asArray
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex [
	^ collection at: anIndex ifAbsent: [self defaultValue]
]

{ #category : #adding }
XMLOrderedList >> at: anIndex ifAbsentPut: aValue [
	^ self
		at: anIndex
		ifAbsent: [self at: anIndex put: aValue]
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex put: aValue [
	^ collection at: anIndex put: aValue
]

{ #category : #accessing }
XMLOrderedList >> atLast: anIndexFromEnd [
	^ self atLast: anIndexFromEnd ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> before: anObject [
	^ collection before: anObject ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> capacity [
	^ collection capacity
]

{ #category : #enumerating }
XMLOrderedList >> collect: aBlock [
	^ self copyThenSetCollection: (collection collect: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> collect: aBlock from: aStartIndex to: anEndIndex [
	^ self copyThenSetCollection:
		(collection collect: aBlock from: aStartIndex to: anEndIndex)
]

{ #category : #enumerating }
XMLOrderedList >> collect: aCollectBlock thenSelect: aSelectBlock [
	^ self copyThenSetCollection:
		(collection collect: aCollectBlock thenSelect: aSelectBlock)
]

{ #category : #copying }
XMLOrderedList >> copy [
	^ self species basicNew setCollection: collection copy
]

{ #category : #copying }
XMLOrderedList >> copyEmpty [
	^ self species new: self size
]

{ #category : #copying }
XMLOrderedList >> copyFrom: aStart to: anEnd [
	^ self copyThenSetCollection:
		(collection copyFrom: (aStart max: 1) to: (self size min: anEnd))
]

{ #category : #private }
XMLOrderedList >> copyThenSetCollection: aCollection [
	^ self class basicNew setCollection: aCollection
]

{ #category : #defaults }
XMLOrderedList >> defaultValue [
	^ nil
]

{ #category : #enumerating }
XMLOrderedList >> do: aBlock [
	collection do: aBlock
]

{ #category : #inspecting }
XMLOrderedList >> inspectorClass [
	^ OrderedCollectionInspector
]

{ #category : #removing }
XMLOrderedList >> remove: anObject ifAbsent: aBlock [
	^ collection remove: anObject ifAbsent: aBlock
]

{ #category : #removing }
XMLOrderedList >> removeAll [
	[self isEmpty] whileFalse: [self removeLast]
]

{ #category : #removing }
XMLOrderedList >> removeAt: anIndex [
	^ collection removeAt: anIndex
]

{ #category : #removing }
XMLOrderedList >> removeFirst [
	^ collection removeFirst
]

{ #category : #removing }
XMLOrderedList >> removeFirst: aNumber [
	^ collection removeFirst: aNumber
]

{ #category : #removing }
XMLOrderedList >> removeLast [
	^ collection removeLast
]

{ #category : #removing }
XMLOrderedList >> removeLast: aNumber [
	^ collection removeLast: aNumber
]

{ #category : #accessing }
XMLOrderedList >> replaceFrom: aStartingIndex to: anEndingIndex with: aCollection startingAt: aReplacementStart [
	collection
		replaceFrom: aStartingIndex
		to: anEndingIndex
		with: aCollection
		startingAt: aReplacementStart
]

{ #category : #enumerating }
XMLOrderedList >> reverseDo: aBlock [
	collection reverseDo: aBlock
]

{ #category : #enumerating }
XMLOrderedList >> select: aBlock [
	^ self copyThenSetCollection: (collection select: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> select: aSelectBlock thenCollect: aCollectBlock [
	^ self copyThenSetCollection:
		(collection select: aSelectBlock thenCollect: aCollectBlock)
]

{ #category : #private }
XMLOrderedList >> setCollection: aCollection [
	collection := aCollection
]

{ #category : #accessing }
XMLOrderedList >> size [
	^ collection size
]

{ #category : #enumerating }
XMLOrderedList >> sort [
	collection sort
]

{ #category : #enumerating }
XMLOrderedList >> sort: aSortBlock [
	collection sort: aSortBlock
]

{ #category : #private }
XMLOrderedList >> species [
	^ XMLOrderedList
]

{ #category : #enumerating }
XMLOrderedList >> with: aCollection collect: aBlock [
	^ self copyThenSetCollection: (collection with: aCollection collect: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> withIndexCollect: aTwoArgumentBlock [
	^ self copyThenSetCollection: (collection withIndexCollect: aTwoArgumentBlock)
]

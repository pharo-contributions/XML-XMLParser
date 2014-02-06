"
This class functions as an OrderedCollection that will not raise exceptions when attempts are made to access absent objects. This means messages like #at:, #after:, and #first will return nil when the requested object cannot be retrieved. Messages that modify the collection based on the presence or absence of other objects such as #add:after: or #at:put: will still raise exceptions as usual.


"
Class {
	#name : #XMLOrderedList,
	#superclass : #SequenceableCollection,
	#instVars : [
		'collection'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #private }
XMLOrderedList class >> collectionClass [
	^ OrderedCollection
]

{ #category : #'instance creation' }
XMLOrderedList class >> new [
	^ self new: 5
]

{ #category : #'instance creation' }
XMLOrderedList class >> new: aSize [
	^ self basicNew setCollection: (self collectionClass new: aSize)
]

{ #category : #'instance creation' }
XMLOrderedList class >> new: aSize withAll: anObject [
	^ self basicNew setCollection: (self collectionClass new: aSize withAll: anObject)
]

{ #category : #'instance creation' }
XMLOrderedList class >> newFrom: aCollection [
	^ self basicNew setCollection: (self collectionClass newFrom: aCollection)
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
	^ self newWithCollection: (collection collect: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> collect: aBlock from: aStartIndex to: anEndIndex [
	^ self newWithCollection:
		(collection collect: aBlock from: aStartIndex to: anEndIndex)
]

{ #category : #enumerating }
XMLOrderedList >> collect: aCollectBlock thenSelect: aSelectBlock [
	^ self newWithCollection:
		(collection collect: aCollectBlock thenSelect: aSelectBlock)
]

{ #category : #private }
XMLOrderedList >> collection [
	^ collection
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
	^ self newWithCollection:
		(collection copyFrom: (aStart max: 1) to: (self size min: anEnd))
]

{ #category : #copying }
XMLOrderedList >> copyWith: anElement [ 
	^ self copy
	 	add: anElement;
		yourself
]

{ #category : #defaults }
XMLOrderedList >> defaultValue [
	^ nil
]

{ #category : #enumerating }
XMLOrderedList >> do: aBlock [
	collection do: aBlock
]

{ #category : #private }
XMLOrderedList >> newWithCollection: aCollection [
	^ self species basicNew setCollection: aCollection
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
	^ self removeAt: 1
]

{ #category : #removing }
XMLOrderedList >> removeFirst: aNumber [
	| removed |

	removed := self copyFrom: 1 to: aNumber.
	aNumber timesRepeat: [self removeFirst].
	^ removed.
]

{ #category : #removing }
XMLOrderedList >> removeLast [
	^ self removeAt: self size
]

{ #category : #removing }
XMLOrderedList >> removeLast: aNumber [
	| removed |

	removed := self copyFrom: self size - (aNumber - 1) to: self size.
	aNumber timesRepeat: [self removeLast].
	^ removed.
]

{ #category : #accessing }
XMLOrderedList >> replaceFrom: aStartingIndex to: anEndingIndex with: aReplacementCollection startingAt: aReplacementIndex [
	| offset |

	offset := 0.
	[aStartingIndex + offset <= anEndingIndex]
		whileTrue: [
			self
				at: aStartingIndex + offset
				put: (aReplacementCollection at: aReplacementIndex + offset).
			offset := offset + 1].
]

{ #category : #enumerating }
XMLOrderedList >> reverseDo: aBlock [
	collection reverseDo: aBlock
]

{ #category : #converting }
XMLOrderedList >> reversed [
	| reversed |

	reversed := self species new.
	self reverseDo: [:each | reversed addLast: each].
	^ reversed.

]

{ #category : #enumerating }
XMLOrderedList >> select: aBlock [
	^ self newWithCollection: (collection select: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> select: aSelectBlock thenCollect: aCollectBlock [
	^ self newWithCollection:
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

{ #category : #sorting }
XMLOrderedList >> sort [
	collection sort
]

{ #category : #sorting }
XMLOrderedList >> sort: aSortBlock [
	collection sort: aSortBlock
]

{ #category : #private }
XMLOrderedList >> species [
	^ XMLOrderedList
]

{ #category : #private }
XMLOrderedList >> speciesForCollect [
	^ self species
]

{ #category : #enumerating }
XMLOrderedList >> with: aCollection collect: aBlock [
	^ self newWithCollection: (collection with: aCollection collect: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> withIndexCollect: aTwoArgumentBlock [
	^ self newWithCollection: (collection withIndexCollect: aTwoArgumentBlock)
]

"
This class functions as an OrderedCollection that will not raise exceptions when attempts are made to access absent objects. This means messages like #at:, #after:, and #first will return nil when the requested object cannot be retrieved. Messages that modify the collection based on the presence or absence of other objects such as #add:after: or #at:put: will still raise exceptions as usual.


"
Class {
	#name : #XMLOrderedList,
	#superclass : #Collection,
	#instVars : [
		'collection'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #private }
XMLOrderedList class >> collectionClass [
	^ OrderedCollection
]

{ #category : #private }
XMLOrderedList class >> inspectorClass [
	^ self collectionClass inspectorClass
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

{ #category : #copying }
XMLOrderedList >> , aCollection [ 
	^ self
		copyReplaceFrom: self size + 1
		to: self size
		with: aCollection
]

{ #category : #comparing }
XMLOrderedList >> = aCollection [
	^ self == aCollection
		or: [self species == aCollection species
			and: [collection = aCollection collection]]
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
	^ self after: anObject ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> after: anObject ifAbsent: aBlock [
	^ collection after: anObject ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderedList >> allButFirst [
	^ self allButFirst: 1
]

{ #category : #accessing }
XMLOrderedList >> allButFirst: anInteger [
	^ self copyFrom: anInteger + 1 to: self size
]

{ #category : #enumerating }
XMLOrderedList >> allButFirstDo: aBlock [
	collection allButFirstDo: aBlock
]

{ #category : #accessing }
XMLOrderedList >> allButLast [
	^ self allButLast: 1
]

{ #category : #accessing }
XMLOrderedList >> allButLast: anInteger [
	^ self copyFrom: 1 to: self size - anInteger
]

{ #category : #enumerating }
XMLOrderedList >> allButLastDo: aBlock [
	collection allButLastDo: aBlock
]

{ #category : #accessing }
XMLOrderedList >> anyOne [
	^ self first
]

{ #category : #converting }
XMLOrderedList >> asArray [
	^ Array newFrom: collection
]

{ #category : #converting }
XMLOrderedList >> asOrderedCollection [
	^ OrderedCollection newFrom: collection
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex [
	^ self at: anIndex ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex ifAbsent: aBlock [
	^ collection at: anIndex ifAbsent: aBlock
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
XMLOrderedList >> atLast: anIndexFromEnd ifAbsent: aBlock [
	^ collection atLast: anIndexFromEnd ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderedList >> before: anObject [
	^ self before: anObject ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> before: anObject ifAbsent: aBlock [
	 ^ collection before: anObject ifAbsent: aBlock
]

{ #category : #testing }
XMLOrderedList >> beginsWith: aCollection [
	^ collection beginsWith: aCollection
]

{ #category : #accessing }
XMLOrderedList >> capacity [
	^ collection capacity
]

{ #category : #enumerating }
XMLOrderedList >> collect: aBlock [
	^ self speciesNewWithCollection: (collection collect: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> collect: aCollectBlock thenSelect: aSelectBlock [
	^ self speciesNewWithCollection:
		(collection
			collect: aCollectBlock
			thenSelect: aSelectBlock)
]

{ #category : #private }
XMLOrderedList >> collection [
	^ collection
]

{ #category : #copying }
XMLOrderedList >> copy [
	^ self newWithCollection: collection copy
]

{ #category : #copying }
XMLOrderedList >> copyAfter: anObject [
	^ self newWithCollection: (collection copyAfter: anObject)
]

{ #category : #copying }
XMLOrderedList >> copyAfterLast: anObject [
	^ self newWithCollection: (collection copyAfterLast: anObject)
]

{ #category : #copying }
XMLOrderedList >> copyEmpty [
	^ self newWithCollection: collection copyEmpty
]

{ #category : #copying }
XMLOrderedList >> copyFrom: aStart to: anEnd [
	^ self newWithCollection:
		(collection
			copyFrom: (aStart max: 1)
			to: (anEnd min: self size))
]

{ #category : #copying }
XMLOrderedList >> copyReplaceAll: anOldCollection with: aNewCollection [
	| copy |

	"workaround so the interal collection is always copied"
	^ self newWithCollection:
		((copy :=
			collection
				copyReplaceAll: anOldCollection
				with: aNewCollection) == collection
			ifTrue: [collection copy]
			ifFalse: [copy])
]

{ #category : #copying }
XMLOrderedList >> copyReplaceFrom: aStart to: aStop with: aReplacementCollection [
	| start stop |

	"bound the start and stop so they are always in range"
	start := (aStart max: 1) min: self size + 1.
	stop := (aStop max: start - 1) min: self size.
	^ self newWithCollection:
		(collection
			copyReplaceFrom: start
			to: stop
			with: aReplacementCollection)
]

{ #category : #copying }
XMLOrderedList >> copyUpTo: anObject [
	^ self newWithCollection: (collection copyUpTo: anObject)
]

{ #category : #copying }
XMLOrderedList >> copyUpToLast: anObject [
	^ self newWithCollection: (collection copyUpToLast: anObject)
]

{ #category : #copying }
XMLOrderedList >> copyWith: anElement [ 
	^ self newWithCollection: (collection copyWith: anElement)
]

{ #category : #copying }
XMLOrderedList >> copyWithFirst: anObject [
	^ self newWithCollection: (collection copyWithFirst: anObject)
]

{ #category : #private }
XMLOrderedList >> defaultValue [
	^ nil
]

{ #category : #enumerating }
XMLOrderedList >> do: aBlock [
	collection do: aBlock
]

{ #category : #enumerating }
XMLOrderedList >> doWithIndex: aBlock [
	^ self withIndexDo: aBlock
]

{ #category : #accessing }
XMLOrderedList >> eighth [
	^ self at: 8
]

{ #category : #testing }
XMLOrderedList >> endsWith: aCollection [
	^ collection endsWith: aCollection
]

{ #category : #accessing }
XMLOrderedList >> fifth [
	^ self at: 5
]

{ #category : #accessing }
XMLOrderedList >> first [
	^ self at: 1
]

{ #category : #accessing }
XMLOrderedList >> first: anInteger [
	^ self copyFrom: 1 to: anInteger
]

{ #category : #accessing }
XMLOrderedList >> fourth [
	^ self at: 4
]

{ #category : #copying }
XMLOrderedList >> grownBy: aSize [
	^ self newWithCollection: (collection grownBy: aSize)
]

{ #category : #comparing }
XMLOrderedList >> hash [
	^ collection hash
]

{ #category : #accessing }
XMLOrderedList >> identityIndexOf: anObject [
	^ self identityIndexOf: anObject ifAbsent: [0]
]

{ #category : #accessing }
XMLOrderedList >> identityIndexOf: anObject ifAbsent: aBlock [
	^ collection identityIndexOf: anObject ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderedList >> indexOf: anObject [
	^ self indexOf: anObject ifAbsent: [0]
]

{ #category : #accessing }
XMLOrderedList >> indexOf: anObject ifAbsent: aBlock [
	^ collection indexOf: anObject ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderedList >> indexOf: anObject startingAt: anIndex [ 
	^ self indexOf: anObject startingAt: anIndex ifAbsent: [0]
]

{ #category : #accessing }
XMLOrderedList >> indexOf: anObject startingAt: anIndex ifAbsent: aBlock [
	^ collection
		indexOf: anObject
		startingAt: (anIndex max: 1)
		ifAbsent: aBlock
]

{ #category : #testing }
XMLOrderedList >> isSequenceable [
	^ true
]

{ #category : #accessing }
XMLOrderedList >> last [
	^ self at: self size
]

{ #category : #accessing }
XMLOrderedList >> last: anInteger [
	^ self copyFrom: self size - anInteger + 1 to: self size
]

{ #category : #accessing }
XMLOrderedList >> lastIndexOf: anObject [
	^ self lastIndexOf: anObject ifAbsent: [0]
]

{ #category : #accessing }
XMLOrderedList >> lastIndexOf: anObject ifAbsent: aBlock [
	^ collection lastIndexOf: anObject ifAbsent: aBlock
]

{ #category : #private }
XMLOrderedList >> newWithCollection: aCollection [
	^ self class basicNew setCollection: aCollection
]

{ #category : #accessing }
XMLOrderedList >> ninth [
	^ self at: 9
]

{ #category : #enumerating }
XMLOrderedList >> pairsDo: aBlock [
	collection pairsDo: aBlock
]

{ #category : #converting }
XMLOrderedList >> readStream [
	^ ReadStream on: self
]

{ #category : #enumerating }
XMLOrderedList >> reject: aBlock [
	^ self newWithCollection: (collection reject: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> reject: aRejectBlock thenCollect: aCollectBlock [
	^ self "squeak doesnt have reject:thenCollect:"
		select: [:each | (aRejectBlock value: each) not]
		thenCollect: aCollectBlock
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
XMLOrderedList >> replaceFrom: aStart to: aStop with: aReplacementCollection [
	^ self
		replaceFrom: aStart
		to: aStop
		with: aReplacementCollection
		startingAt: 1
]

{ #category : #accessing }
XMLOrderedList >> replaceFrom: aStart to: aStop with: aReplacementCollection startingAt: aReplacementStart [
	| offset |

	offset := 0.
	[aStart + offset <= aStop]
		whileTrue: [
			self
				at: aStart + offset
				put: (aReplacementCollection at: aReplacementStart + offset).
			offset := offset + 1].
]

{ #category : #removing }
XMLOrderedList >> reset [
	collection reset
]

{ #category : #converting }
XMLOrderedList >> reverse [
	^ self reversed
]

{ #category : #enumerating }
XMLOrderedList >> reverseDo: aBlock [
	collection reverseDo: aBlock
]

{ #category : #converting }
XMLOrderedList >> reversed [
	^ self newWithCollection: collection reversed
]

{ #category : #accessing }
XMLOrderedList >> second [
	^ self at: 2
]

{ #category : #enumerating }
XMLOrderedList >> select: aBlock [
	^ self newWithCollection: (collection select: aBlock)
]

{ #category : #enumerating }
XMLOrderedList >> select: aSelectBlock thenCollect: aCollectBlock [
	^ self speciesNewWithCollection:
		(collection
			select: aSelectBlock
			thenCollect: aCollectBlock)
]

{ #category : #private }
XMLOrderedList >> setCollection: aCollection [
	collection := aCollection
]

{ #category : #accessing }
XMLOrderedList >> seventh [
	^ self at: 7
]

{ #category : #accessing }
XMLOrderedList >> sixth [
	^ self at: 6
]

{ #category : #accessing }
XMLOrderedList >> size [
	^ collection size
]

{ #category : #sorting }
XMLOrderedList >> sort [
	self sort: [:a :b | a <= b]
]

{ #category : #sorting }
XMLOrderedList >> sort: aSortBlock [
	collection sort: aSortBlock
]

{ #category : #sorting }
XMLOrderedList >> sorted [
	^ self sorted: [:a :b | a <= b]
]

{ #category : #sorting }
XMLOrderedList >> sorted: aSortBlock [
	^ self copy sort: aSortBlock
]

{ #category : #private }
XMLOrderedList >> species [
	^ XMLOrderedList
]

{ #category : #private }
XMLOrderedList >> speciesNewWithCollection: aCollection [
	^ self species basicNew setCollection: aCollection
]

{ #category : #accessing }
XMLOrderedList >> third [
	^ self at: 3
]

{ #category : #enumerating }
XMLOrderedList >> with: aCollection collect: aBlock [
	| newCollection |

	newCollection := self species new: self size.
	1 to: (self size min: aCollection size) do: [:i |
		newCollection addLast:
			(aBlock
				value: (self at: i)
				value: (aCollection at: i))].
	^ newCollection.
]

{ #category : #enumerating }
XMLOrderedList >> with: aCollection do: aBlock [
	1 to: (self size min: aCollection size) do: [:i |
		(aBlock
			value: (self at: i)
			value: (aCollection at: i))]
]

{ #category : #enumerating }
XMLOrderedList >> withIndexCollect: aTwoArgumentBlock [
	^ self speciesNewWithCollection: (collection withIndexCollect: aTwoArgumentBlock)
]

{ #category : #enumerating }
XMLOrderedList >> withIndexDo: aBlock [
	collection withIndexDo: aBlock
]

{ #category : #converting }
XMLOrderedList >> writeStream [
	^ WriteStream on: self
]

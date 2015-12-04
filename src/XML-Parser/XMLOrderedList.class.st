"
This class functions as an OrderedCollection that will not raise exceptions when attempts are made to access absent objects. This means messages like #at:, #after:, and #first will return nil when the requested object cannot be retrieved. Messages that modify the collection will still raise exceptions as usual.


"
Class {
	#name : #XMLOrderedList,
	#superclass : #Collection,
	#instVars : [
		'collection'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLOrderedList class >> collection: aCollection [
	^ self basicNew setCollection: aCollection
]

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
	^ self new: 10
]

{ #category : #'instance creation' }
XMLOrderedList class >> new: aCapacity [
	^ self basicNew setCollection: (self collectionClass new: aCapacity)
]

{ #category : #'instance creation' }
XMLOrderedList class >> new: aSize withAll: anObject [
	| newList |

	"reimplement for portability"
	newList := self new: aSize.
	1 to: aSize do: [:i | newList addLast: anObject].
	^ newList.
]

{ #category : #'instance creation' }
XMLOrderedList class >> newFrom: aCollection [
	^ (self new: aCollection size)
		addAll: aCollection;
		yourself
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
	self == aCollection
		ifTrue: [^ true].

	(self species == aCollection species
		and: [self size = aCollection size])
		ifFalse: [^ false].

	"to:do: used for speed"
	1 to: self size do: [:i |
		(self at: i) = (aCollection at: i)
			ifFalse: [^ false]].
	^ true.
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
	"reimplemented for portability"
	2 to: self size do: [:i | aBlock value: (self at: i)]
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
	"reimplemented for portability"
	1 to: self size - 1 do: [:i | aBlock value: (self at: i)]
]

{ #category : #accessing }
XMLOrderedList >> anyOne [
	^ self first
]

{ #category : #converting }
XMLOrderedList >> asArray [
	"use withAll: not newFrom: for portability"
	^ Array withAll: collection
]

{ #category : #converting }
XMLOrderedList >> asOrderedCollection [
	"use withAll: not newFrom: for portability"
	^ OrderedCollection withAll: collection
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex [
	"optimized"
	(anIndex > 0 and: [anIndex <= collection size])
		ifTrue: [^ collection at: anIndex]
		ifFalse: [^ self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex ifAbsent: aBlock [
	^ collection at: anIndex ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex put: aValue [
	"treats index = size + 1 as addLast: gemstone compatibility"
	anIndex = (collection size + 1)
		ifTrue: [^ collection addLast: aValue]
		ifFalse: [^ collection at: anIndex put: aValue]
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
	"overridden in GS version to use collection size"
	^ collection capacity
]

{ #category : #enumerating }
XMLOrderedList >> collect: aBlock [
	| collected |

	collected := self species new: self size.
	self do: [:each | collected addLast: (aBlock value: each)].
	^ collected.
]

{ #category : #enumerating }
XMLOrderedList >> collect: aCollectBlock thenSelect: aSelectBlock [
	| collected |

	collected := self species new.
	self do: [:each | | collectedObject |
		(aSelectBlock value: (collectedObject := aCollectBlock value: each))
			ifTrue: [collected addLast: collectedObject]].
	^ collected.
]

{ #category : #private }
XMLOrderedList >> collection [
	^ collection
]

{ #category : #copying }
XMLOrderedList >> copy [
	^ self copyEmpty
		addAll: self;
		yourself
]

{ #category : #copying }
XMLOrderedList >> copyAfter: anObject [
	| copy |

	copy := self copyEmpty.
	(self
		indexOf: anObject
		ifAbsent: [^ copy]) + 1
			to: self size
			do: [:i | copy addLast: (self at: i)].
	^ copy.
]

{ #category : #copying }
XMLOrderedList >> copyAfterLast: anObject [
	| copy |

	copy := self copyEmpty.
	(self
		lastIndexOf: anObject
		ifAbsent: [^ copy]) + 1
			to: self size
			do: [:i | copy addLast: (self at: i)].
	^ copy.
]

{ #category : #private }
XMLOrderedList >> copyClass [
	^ self class
]

{ #category : #copying }
XMLOrderedList >> copyEmpty [
	^ self copyClass collection: collection copyEmpty
]

{ #category : #copying }
XMLOrderedList >> copyFrom: aStart to: anEnd [
	| copy |

	copy := self copyEmpty.
	(aStart max: 1)
		to: (anEnd min: self size)
		do: [:i | copy addLast: (self at: i)].
	^ copy.
]

{ #category : #copying }
XMLOrderedList >> copyReplaceAll: aSearchCollection with: aReplacementCollection [
	| copy index size searchCollectionSize |

	"this implementation always returns a copy, even if it doesn't replace"
	(searchCollectionSize := aSearchCollection size) > 0
		ifFalse: [^ self copy].

	copy := self copyEmpty.
	index := 1.
	size := self size.
	[index <= size]
		whileTrue: [
			(self at: index) = (aSearchCollection at: 1)
				ifTrue: [| searchCollectionIndex |
					searchCollectionIndex := 2.
					[searchCollectionIndex <= searchCollectionSize
						and: [
							(self at: index + searchCollectionIndex - 1) =
								(aSearchCollection at: searchCollectionIndex)]]
						whileTrue: [searchCollectionIndex := searchCollectionIndex + 1].
					searchCollectionIndex > searchCollectionSize
						ifTrue: [
							copy addAll: aReplacementCollection.
							index := index + searchCollectionSize]
						ifFalse: [
							copy addLast: (self at: index).
							index := index + 1]]
				ifFalse: [ 
					copy addLast: (self at: index).
					index := index + 1]].
	^ copy.
]

{ #category : #copying }
XMLOrderedList >> copyReplaceFrom: aStart to: aStop with: aReplacementCollection [
	| copy start stop |

	(self size < 1
		or: [self size < aStart])
		ifTrue: [
			^ self copy
				addAll: aReplacementCollection;
				yourself].
	copy := self copyEmpty.
	start := aStart max: 1.
	stop := aStop min: self size.
	1 to: self size do: [:i |
		(i = start)
			ifTrue: [
				copy addAll: aReplacementCollection.
				start > stop
					ifTrue: [copy addLast: (self at: i)]]
			ifFalse: [
				(i > start and: [i <= stop])
					ifFalse: [copy addLast: (self at: i)]]].
	^ copy.
]

{ #category : #copying }
XMLOrderedList >> copyUpTo: anObject [
	| copy |

	copy := self copyEmpty.
	1
		to:
			(self
				indexOf: anObject
				ifAbsent: [self size + 1]) - 1
		do: [:i | copy addLast: (self at: i)].
	^ copy.
]

{ #category : #copying }
XMLOrderedList >> copyUpToLast: anObject [
	| copy |

	copy := self copyEmpty.
	1
		to:
			(self
				lastIndexOf: anObject
				ifAbsent: [collection size + 1]) - 1
		do: [:i | copy addLast: (self at: i)].
	^ copy.
]

{ #category : #copying }
XMLOrderedList >> copyWith: anObject [
	^ self copy
		addLast: anObject;
		yourself
]

{ #category : #copying }
XMLOrderedList >> copyWithFirst: anObject [
	^ self copyEmpty
		addLast: anObject;
		addAll: self;
		yourself
]

{ #category : #copying }
XMLOrderedList >> copyWithout: anObject [
	^ self copy
		remove: anObject ifAbsent: [nil];
		yourself
]

{ #category : #copying }
XMLOrderedList >> copyWithoutAll: aCollection [
	| copy |

	copy := self copy.
	aCollection do: [:each | copy remove: each ifAbsent: [nil]].
	^ copy.
]

{ #category : #private }
XMLOrderedList >> defaultValue [
	^ nil
]

{ #category : #enumerating }
XMLOrderedList >> detect: aBlock [
	^ self detect: aBlock ifNone: [self defaultValue]
]

{ #category : #enumerating }
XMLOrderedList >> detect: aBlock ifNone: anExceptionBlock [
	^ collection detect: aBlock ifNone: anExceptionBlock
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
	^ self copyClass collection: (collection grownBy: aSize)
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

{ #category : #accessing }
XMLOrderedList >> lastOrNil [
	^ self last
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
	| selected |

	selected := self copyEmpty.
	self do: [:each |
		(aBlock value: each)
			ifFalse: [selected addLast: each]].
	^ selected.
]

{ #category : #enumerating }
XMLOrderedList >> reject: aRejectBlock thenCollect: aCollectBlock [
	| collected |

	collected := self species new.
	self do: [:each |
		(aRejectBlock value: each)
			ifFalse: [collected addLast: (aCollectBlock value: each)]].
	^ collected.
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
	| reversed |

	reversed := self copyEmpty.
	self reverseDo: [:each | reversed addLast: each].
	^ reversed.
]

{ #category : #accessing }
XMLOrderedList >> second [
	^ self at: 2
]

{ #category : #enumerating }
XMLOrderedList >> select: aBlock [
	| selected |

	selected := self copyEmpty.
	self do: [:each |
		(aBlock value: each)
			ifTrue: [selected addLast: each]].
	^ selected.
]

{ #category : #enumerating }
XMLOrderedList >> select: aSelectBlock thenCollect: aCollectBlock [
	| collected |

	collected := self species new.
	self do: [:each |
		(aSelectBlock value: each)
			ifTrue: [collected addLast: (aCollectBlock value: each)]].
	^ collected.
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
	^ self copy sort
]

{ #category : #sorting }
XMLOrderedList >> sorted: aSortBlock [
	^ self copy sort: aSortBlock
]

{ #category : #private }
XMLOrderedList >> species [
	^ XMLOrderedList
]

{ #category : #accessing }
XMLOrderedList >> swap: aFirstIndex with: aSecondIndex [
	| temp |

	temp := collection at: aFirstIndex.
	collection
		at: aFirstIndex
		put: (collection at: aSecondIndex).
	collection
		at: aSecondIndex
		put: temp.
]

{ #category : #accessing }
XMLOrderedList >> third [
	^ self at: 3
]

{ #category : #enumerating }
XMLOrderedList >> with: aCollection collect: aBlock [
	| collected |

	collected := self species new: self size.
	1 to: (self size min: aCollection size) do: [:i |
		collected addLast:
			(aBlock
				value: (self at: i)
				value: (aCollection at: i))].
	^ collected.
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
	| collected |

	collected := self species new: self size.
	1 to: self size do: [:i |
		collected addLast:
			(aTwoArgumentBlock
				value: (self at: i)
				value: i)].
	^ collected.
]

{ #category : #enumerating }
XMLOrderedList >> withIndexDo: aBlock [
	collection withIndexDo: aBlock
]

{ #category : #converting }
XMLOrderedList >> writeStream [
	^ WriteStream on: self
]

Class {
	#name : #XMLOrderedListTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLOrderedListTest >> absentElement [
	^ 'absent'
]

{ #category : #testing }
XMLOrderedListTest >> allowsDuplicates [
	^ true
]

{ #category : #assertions }
XMLOrderedListTest >> assertList: aList collectedFrom: aSecondList equals: aThirdList [
	self
		assert: aList = aThirdList;
		assert: aList class = aSecondList species;
		deny: aList == aSecondList;
		deny: aList collection == aSecondList collection
]

{ #category : #assertions }
XMLOrderedListTest >> assertList: aList copiedFrom: aSecondList equals: aThirdList [
	self
		assert: aList = aThirdList;
		assert: aList class == self listCopyClass;
		deny: aList == aSecondList;
		deny: aList collection == aSecondList collection
]

{ #category : #assertions }
XMLOrderedListTest >> assertList: aFirstList equals: aSecondList [
	self
		assert: aFirstList = aFirstList;
		assert: aSecondList = aSecondList;
		assert: aFirstList = aSecondList;
		assert: aSecondList = aFirstList
]

{ #category : #assertions }
XMLOrderedListTest >> assertList: aList isCopyOf: aSecondList [
	self
		assert: aList = aSecondList;
		assert: aList class == self listCopyClass;
		deny: aList == aSecondList;
		deny: aList collection == aSecondList collection
]

{ #category : #accessing }
XMLOrderedListTest >> changeElement: anObject [
	^ anObject asUppercase
]

{ #category : #accessing }
XMLOrderedListTest >> changedListElements [
	^ self listElements collect: [:each | self changeElement: each]
]

{ #category : #accessing }
XMLOrderedListTest >> changedSingleElement [
	^ self changeElement: self singleElement
]

{ #category : #accessing }
XMLOrderedListTest >> defaultValue [
	^ nil
]

{ #category : #assertions }
XMLOrderedListTest >> denyList: aFirstList equals: aSecondList [
	self
		deny: aFirstList = aSecondList;
		deny: aSecondList = aFirstList
]

{ #category : #accessing }
XMLOrderedListTest >> emptyList [
	^ self listClass new
]

{ #category : #testing }
XMLOrderedListTest >> hasCapacity [
	"for portability"
	^ self listClass collectionClass includesSelector: #capacity
]

{ #category : #accessing }
XMLOrderedListTest >> listClass [
	^ XMLOrderedList
]

{ #category : #accessing }
XMLOrderedListTest >> listCopyClass [
	^ self listClass
]

{ #category : #accessing }
XMLOrderedListTest >> listElements [
	^ #('one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine') copy
]

{ #category : #accessing }
XMLOrderedListTest >> listElementsFirst: anInteger [
	"first: is not portable"
	^ self listElements
		copyFrom: 1
		to: ((anInteger max: 0) min: self listElements size)
]

{ #category : #accessing }
XMLOrderedListTest >> listElementsLast: anInteger [
	"last: is not portable"
	anInteger > 0
		ifFalse: [^ #()].
	^ self listElements
		copyFrom: (((self listElements size - anInteger) + 1) max: 1)
		to: self listElements size.
]

{ #category : #accessing }
XMLOrderedListTest >> listSpecies [
	^ XMLOrderedList
]

{ #category : #accessing }
XMLOrderedListTest >> listWithElements [
	^ self listClass new
		addAll: self listElements;
		yourself
]

{ #category : #accessing }
XMLOrderedListTest >> listWithSingleElement [
	^ self listClass new
		add: self singleElement;
		yourself
]

{ #category : #accessing }
XMLOrderedListTest >> newElement [
	^ 'newElement'
]

{ #category : #accessing }
XMLOrderedListTest >> reverseSortBlock [
	^ [:a :b | a > b]
]

{ #category : #assertions }
XMLOrderedListTest >> should: aBlock enumerate: aCollection [
	| enumerated |

	enumerated := OrderedCollection new.
	aBlock value: [:each | enumerated add: each].
	self assert: enumerated = aCollection asOrderedCollection.
]

{ #category : #accessing }
XMLOrderedListTest >> singleElement [
	^ self listElements first
]

{ #category : #accessing }
XMLOrderedListTest >> sortBlock [
	^ [:a :b | a <= b]
]

{ #category : #tests }
XMLOrderedListTest >> testAdd [
	| list |

	list := self emptyList.
	self
		deny: list = self listWithElements;
		assert: (self listElements allSatisfy: [:each | (list add: each) == each]);
		assert: (list = self listWithElements).
]

{ #category : #tests }
XMLOrderedListTest >> testAddAfter [
	| list |

	list := self listWithSingleElement.
	self
		assert:
			(self listElements allButFirst reversed
				allSatisfy: [:each | (list add: each after: self singleElement) = each]);
		assert: list = self listWithElements;
		should: [list add: self newElement after: self absentElement] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testAddAfterIndex [
	| list |

	list := self listWithSingleElement.
	self
		assert:
			(self listElements allButFirst reversed
				allSatisfy: [:each | (list add: each afterIndex: 1) = each]);
		assert: list = self listWithElements;
		should: [list add: self newElement afterIndex: self listElements size + 1] raise: Error;
		should: [list add: self newElement afterIndex: -1] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testAddAll [
	| list |

	list := self emptyList.
	self
		deny: list = self listWithElements;
		assert: (list addAll: self listElements) = self listElements;
		assert: list = self listWithElements;
		assert: (list addAll: self changedListElements) = self changedListElements;
		assert: list = (self listClass newFrom: (self listElements, self changedListElements)).
]

{ #category : #tests }
XMLOrderedListTest >> testAddAllFirst [
	| list |

	list := self emptyList.
	self
		assert: (list addAllFirst: self listElements) = self listElements;
		assert: list = self listWithElements;
		assert: (list addAllFirst: self changedListElements) = self changedListElements;
		assert: list = (self listClass newFrom: self changedListElements, self listElements).
]

{ #category : #tests }
XMLOrderedListTest >> testAddAllLast [
	| list |

	list := self emptyList.
	self
		assert: (list addAllLast: self listElements) = self listElements;
		assert: list = self listWithElements;
		assert: (list addAllLast: self changedListElements) = self changedListElements;
		assert: list = (self listClass newFrom: self listElements, self changedListElements).
]

{ #category : #tests }
XMLOrderedListTest >> testAddBefore [
	| list last |

	last := self listElements last.
	(list := self emptyList) add: last.
	self
		assert:
			(self listElements allButLast
				allSatisfy: [:each | (list add: each before: last) = each]);
		assert: list = self listWithElements;
		should: [list add: self newElement before: self absentElement] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testAddBeforeIndex [
	| list |

	(list := self emptyList) add: self listElements last.
	self listElements allButLast withIndexDo: [:each :i |
		self assert: (list add: each beforeIndex: i) = each].
	self
		assert: list = self listWithElements;
		should: [list add: self newElement beforeIndex: self listElements size + 2] raise: Error;
		should: [list add: self newElement beforeIndex: 0] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testAddFirst [
	| list |

	list := self emptyList.
	self
		assert: (self listElements reversed allSatisfy: [:each | (list addFirst: each) = each]);
		assert: list = self listWithElements.

	self assert: (self listElements allSatisfy: [:each | (list addFirst: each) = each]).
	self assert:
		list =
			(self listClass newFrom: 
				(self allowsDuplicates
					ifTrue: [self listElements reversed, self listElements]
					ifFalse: [self listElements reversed])).
]

{ #category : #tests }
XMLOrderedListTest >> testAddLast [
	| list |

	list := self emptyList.
	self
		assert: (self listElements allSatisfy: [:each | (list addLast: each) = each]);
		assert: list = self listWithElements.

	self assert: (self listElements allSatisfy: [:each | (list addLast: each) = each]).
	self assert:
		list =
			(self listClass newFrom: 
				(self allowsDuplicates
					ifTrue: [self listElements, self listElements]
					ifFalse: [self listElements])).
]

{ #category : #tests }
XMLOrderedListTest >> testAfter [
	| list |

	list := self listWithElements.
	self assert:
		(self listElements allSatisfy: [:each |
			(list after: each) = (self listElements after: each ifAbsent: [self defaultValue])]).
	self assert: (list after: self absentElement) = self defaultValue.
]

{ #category : #tests }
XMLOrderedListTest >> testAfterIfAbsent [
	| list |

	list := self listWithElements.
	self assert:
		(self listElements allSatisfy: [:each |
			(list after: each ifAbsent: [self newElement]) =
				(self listElements after: each ifAbsent: [self newElement])]).
	self assert: (list after: self absentElement ifAbsent: [self newElement]) = self newElement.
]

{ #category : #tests }
XMLOrderedListTest >> testAllButFirst [
	| list |

	self assert: self emptyList allButFirst = self emptyList.

	list := self listWithElements.
	self
		assertList: list allButFirst
		copiedFrom: list
		equals: (self listClass newFrom: self listElements allButFirst).
]

{ #category : #tests }
XMLOrderedListTest >> testAllButFirstDo [
	self
		should: [:block | self emptyList allButFirstDo: block]
		enumerate: #().
	self
		should: [:block | self listWithElements allButFirstDo: block]
		enumerate: self listElements allButFirst.
]

{ #category : #tests }
XMLOrderedListTest >> testAllButFirstFew [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assertList: (list allButFirst: i)
			copiedFrom: list
			equals: (self listClass newFrom: (self listElements allButFirst: i)).
		self
			assertList: (list allButFirst: i + list size)
			copiedFrom: list
			equals: self emptyList.
		self
			assertList: (list allButFirst: i * -1)
			copiedFrom: list
			equals: list.
		self assert: (self emptyList allButFirst: i) = self emptyList].
	self
		assertList: (list allButFirst: 0)
		copiedFrom: list
		equals: list.
]

{ #category : #tests }
XMLOrderedListTest >> testAllButLast [
	| list |

	self assert: self emptyList allButLast = self emptyList.

	list := self listWithElements.
	self
		assertList: list allButLast
		copiedFrom: list
		equals: (self listClass newFrom: self listElements allButLast).
]

{ #category : #tests }
XMLOrderedListTest >> testAllButLastDo [
	self
		should: [:block | self emptyList allButLastDo: block]
		enumerate: #().
	self
		should: [:block | self listWithElements allButLastDo: block]
		enumerate: self listElements allButLast.
]

{ #category : #tests }
XMLOrderedListTest >> testAllButLastFew [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assertList: (list allButLast: i)
			copiedFrom: list
			equals: (self listClass newFrom: (self listElements allButLast: i)).
		self
			assertList: (list allButLast: i + list size)
			copiedFrom: list
			equals: self emptyList.
		self
			assertList: (list allButLast: i * -1)
			copiedFrom: list
			equals: list.
		self assert: (self emptyList allButLast: i) = self emptyList].
	self
		assertList: (list allButLast: 0)
		copiedFrom: list
		equals: list.
]

{ #category : #tests }
XMLOrderedListTest >> testAnyOne [
	self
		assert: self emptyList anyOne = self defaultValue;
		assert: self listWithElements anyOne = self listElements first.
]

{ #category : #tests }
XMLOrderedListTest >> testAsArray [
	self
		assert: self emptyList asArray = #();
		assert: self listWithElements asArray = self listElements asArray
]

{ #category : #tests }
XMLOrderedListTest >> testAsOrderedCollection [
	| list |

	list := self listWithElements.
	self
		assert: self emptyList asOrderedCollection = OrderedCollection new;
		assert: list asOrderedCollection = self listElements asOrderedCollection;
		deny: list asOrderedCollection == list collection.
]

{ #category : #tests }
XMLOrderedListTest >> testAt [
	| list |

	list := self listWithElements.
	self
		assert: ((1 to: list size) allSatisfy: [:i | (list at: i) = (self listElements at: i)]);
		assert: (list at: 0) = self defaultValue;
		assert: (list at: list size + 1) = self defaultValue.
]

{ #category : #tests }
XMLOrderedListTest >> testAtIfAbsent [
	| list |

	list := self listWithElements.
	self
		assert: ((1 to: list size) allSatisfy: [:i | (list at: i ifAbsent: [self newElement]) = (self listElements at: i)]);
		assert: (list at: 0 ifAbsent: [self newElement]) = self newElement;
		assert: (list at: list size + 1 ifAbsent: [self newElement]) = self newElement.
]

{ #category : #tests }
XMLOrderedListTest >> testAtLast [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i | self assert: (list atLast: i) = (self listElements atLast: i)].
	self
		assert: (list atLast: 0) = self defaultValue;
		assert: (list atLast: list size + 1) = self defaultValue.
]

{ #category : #tests }
XMLOrderedListTest >> testAtLastIfAbsent [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self assert: (list atLast: i ifAbsent: [self newElement]) = (self listElements atLast: i)].
	self
		assert: (list atLast: 0 ifAbsent: [self newElement]) = self newElement;
		assert: (list atLast: list size + 1 ifAbsent: [self newElement]) = self newElement.
]

{ #category : #tests }
XMLOrderedListTest >> testAtPut [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i | | replacement |
		replacement := list at: i.
		self
			assert: (list at: i put: replacement) == replacement;
			assert: (list at: i) == replacement].
	self assert: list = self listWithElements.

	self assert: (list at: list size + 1 put: self newElement) = self newElement.
	self assert:
		list =
			(self listClass newFrom: (self listElements copyWith: self newElement)).

	list := self listWithElements.
	1 to: list size do: [:i | | replacement |
		replacement := self changedListElements at: i.
		self
			assert: (list at: i put: replacement) == replacement;
			assert: (list at: i) == replacement].
	self assert: list = (self listClass newFrom: self changedListElements).

	list := self listWithElements.
	self listElements do: [:each |
		self assert: (list at: list size + 1 put: each) == each].
	self assert:
		list =
			(self allowsDuplicates
				ifTrue: [self listClass newFrom: self listElements, self listElements]
				ifFalse: [self listWithElements]).
	self
		should: [list at: 0 put: self newElement]
		raise: Error.
	self
		should: [list at: list size + 2 put: self newElement]
		raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testBefore [
	| list |

	list := self listWithElements.
	self assert:
		(self listElements allSatisfy: [:each |
			(list before: each) = (self listElements before: each ifAbsent: [self defaultValue])]).
	self assert: (list before: self absentElement) = self defaultValue.
]

{ #category : #tests }
XMLOrderedListTest >> testBeforeIfAbsent [
	| list |

	list := self listWithElements.
	self assert:
		(self listElements allSatisfy: [:each |
			(list before: each ifAbsent: [self newElement]) =
				(self listElements before: each ifAbsent: [self newElement])]).
	self assert: (list before: self absentElement ifAbsent: [self newElement]) = self newElement.
]

{ #category : #tests }
XMLOrderedListTest >> testBeginsWith [
	| list |

	self deny: (self emptyList beginsWith: self listElements).
	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list beginsWith: (self listElements copyFrom: 1 to: i));
			deny: (list beginsWith: ((self listElements copyFrom: 1 to: i) copyWith: self absentElement));
			deny: (list beginsWith: ((self listElements copyFrom: 1 to: i) copyWithFirst: self absentElement))].
]

{ #category : #tests }
XMLOrderedListTest >> testCapacity [
	self hasCapacity
		ifTrue: [
			self
				assert: self emptyList capacity >= 0;
				assert: self listWithSingleElement capacity >= 1;
				assert: self listWithElements capacity >= self listElements size]
]

{ #category : #tests }
XMLOrderedListTest >> testCollect [
	| list |

	list := self listWithElements.
	self
		assertList: (list collect: [:each | self changeElement: each])
		collectedFrom: list
		equals: (self listSpecies newFrom: self changedListElements).
]

{ #category : #tests }
XMLOrderedListTest >> testCollectThenSelect [
	| list |

	list := self listWithElements.
	self
		assertList:
			(list
				collect: [:each | self changeElement: each]
				thenSelect: [:each | each ~= self changedSingleElement])
		collectedFrom: list
		equals:
			(self listSpecies newFrom:
				(self changedListElements copyWithout: self changedSingleElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testConcatenation [
	| list |

	list := self emptyList.
	self
		assertList: (list, self emptyList) copiedFrom: list equals: self emptyList;
		assertList: (list, self listWithElements) copiedFrom: list equals: self listWithElements.

	list := self listWithElements.
	self assertList: (list, self emptyList) copiedFrom: list equals: self listWithElements.
	self
		assertList: (list, self listWithElements)
		copiedFrom: list
		equals: (self listClass newFrom: (self listElements, self listElements)).
]

{ #category : #tests }
XMLOrderedListTest >> testCopy [
	| list |

	list := self emptyList.
	self assertList: list copy isCopyOf: list.

	list := self listWithSingleElement.
	self assertList: list copy isCopyOf: list.

	list := self listWithElements.
	self assertList: list copy isCopyOf: list.
]

{ #category : #tests }
XMLOrderedListTest >> testCopyAfter [
	| list |

	list := self listWithElements.
	list do: [:each |
		self
			assertList: (list copyAfter: each)
			copiedFrom: list
			equals: (self listClass newFrom: (self listElements copyAfter: each)).
		self assert: (self emptyList copyAfter: each) = self emptyList].
]

{ #category : #tests }
XMLOrderedListTest >> testCopyAfterLast [
	| list |

	list := self listWithElements.
	list do: [:each |
		self
			assertList: (list copyAfterLast: each)
			copiedFrom: list
			equals: (self listClass newFrom: (self listElements copyAfterLast: each)).
		self assert: (self emptyList copyAfterLast: each) = self emptyList].
]

{ #category : #tests }
XMLOrderedListTest >> testCopyEmpty [
	| list |

	list := self emptyList.
	self assertList: list copyEmpty copiedFrom: list equals: self emptyList.

	list := self listWithSingleElement.
	self assertList: list copyEmpty copiedFrom: list equals: self emptyList.

	list := self listWithElements.
	self assertList: list copyEmpty copiedFrom: list equals: self emptyList.
]

{ #category : #tests }
XMLOrderedListTest >> testCopyFromTo [
	| list emptyList |

	list := self listWithElements.
	emptyList  := self emptyList.
	-1 to: list size + 1 do: [:start |
		start to: list size + 1 do: [:stop |
			self
				assertList: (list copyFrom: start to: stop)
				copiedFrom: list
				equals: (self listWithElements copyFrom: (start max: 1) to: (stop min: list size)).
			self
				assertList: (list copyFrom: start to: start - 1)
				copiedFrom: list
				equals: self emptyList.
			self
				assertList: (list copyFrom: start to: start - 2)
				copiedFrom: list
				equals: self emptyList.
			self
				assertList: (emptyList copyFrom: start to: stop)
				copiedFrom: list
				equals: self emptyList]].
]

{ #category : #tests }
XMLOrderedListTest >> testCopyReplaceAllWith [
	| list |

	list := self listClass newFrom: self listElements, self listElements.
	1 to: self listElements size do: [:i | | replacedElements |
		replacedElements := self listElementsLast: i.
		self
			assertList:
				(list
					copyReplaceAll: replacedElements
					with: (replacedElements collect: [:each | self changeElement: each]))
			copiedFrom: list
			equals: 
				(self listClass newFrom:
					((self listElements, self listElements) 
						copyReplaceAll: replacedElements
						with: (replacedElements collect: [:each | self changeElement: each]))).
		self
			assertList:
				(list
					copyReplaceAll: (Array with: self absentElement)
					with: (Array with: self newElement))
			copiedFrom: list
			equals: list.	
		self
			assertList: (list copyReplaceAll: #() with: (Array with: self newElement))
			copiedFrom: list
			equals: list.
		self
			assertList: (list copyReplaceAll: (self listElements copyWith: self absentElement) with: #())
			copiedFrom: list
			equals: list].
]

{ #category : #tests }
XMLOrderedListTest >> testCopyReplaceFromToWith [
	| list emptyList |

	list := self listWithElements.
	emptyList := self emptyList.
	-1 to: list size + 1 do: [:start |
		start to: list size + 1 do: [:stop |
			self
				assertList: (list copyReplaceFrom: start to: stop with: self changedListElements)
				copiedFrom: list
				equals:
					(self listClass newFrom:
						(self listElementsFirst: start - 1),
						(self changedListElements),
						(self listElementsLast: list size - stop)).
			self
				assertList: (emptyList copyReplaceFrom: start to: stop with: self listElements)
				copiedFrom: emptyList
				equals: self listWithElements]].
]

{ #category : #tests }
XMLOrderedListTest >> testCopyUpTo [
	| list |

	list := self listWithElements.
	list do: [:each |
		self
			assertList: (list copyUpTo: each)
			copiedFrom: list
			equals: (self listClass newFrom: (self listElements copyUpTo: each))].
	self
		assertList: (list copyUpTo: self absentElement)
		copiedFrom: list
		equals: self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testCopyUpToLast [
	| list |

	list := self listClass newFrom: self listElements, self listElements.
	list do: [:each |
		self
			assertList: (list copyUpToLast: each)
			copiedFrom: list
			equals:
				(self listClass newFrom:
					(self allowsDuplicates
						ifTrue: [self listElements, self listElements copyUpToLast: each]
						ifFalse: [self listElements copyUpToLast: each]))].
	self
		assertList: (list copyUpToLast: self absentElement)
		copiedFrom: list
		equals:
			(self listClass newFrom:
				(self allowsDuplicates
					ifTrue: [self listElements, self listElements]
					ifFalse: [self listElements])).
]

{ #category : #tests }
XMLOrderedListTest >> testCopyWith [
	| list |

	list := self emptyList.
	self
		assertList: (list copyWith: self singleElement)
		copiedFrom: list
		equals: self listWithSingleElement.

	list := self listWithElements.
	self
		assertList: (list copyWith: self newElement)
		copiedFrom: list
		equals: (self listClass newFrom: (self listElements copyWith: self newElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testCopyWithFirst [
	| list |

	list := self emptyList.
	self
		assertList: (list copyWithFirst: self singleElement)
		copiedFrom: list
		equals: self listWithSingleElement.

	list := self listWithElements.
	self
		assertList: (list copyWithFirst: self newElement)
		copiedFrom: list
		equals:
			(self listClass newFrom:
				(self listElements copyWithFirst: self newElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testCopyWithout [
	| list |

	list := self emptyList.
	self
		assertList: (list copyWithout: self singleElement)
		copiedFrom: list
		equals: self emptyList.

	list := self listWithElements.
	self
		assertList: (list copyWithout: self singleElement)
		copiedFrom: list
		equals: (self listClass newFrom: (self listElements copyWithout: self singleElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testCopyWithoutAll [
	| list |

	list := self emptyList.
	self
		assertList: (list copyWithoutAll: self listElements)
		copiedFrom: list
		equals: self emptyList.

	list := self listWithElements.
	self
		assertList: (list copyWithoutAll: (Array with: self absentElement))
		copiedFrom: list
		equals: self listWithElements.
	self
		assertList: (list copyWithoutAll: self listElements)
		copiedFrom: list
		equals: self emptyList.
]

{ #category : #tests }
XMLOrderedListTest >> testDefaultValue [
	self assert: self emptyList defaultValue = self defaultValue
]

{ #category : #tests }
XMLOrderedListTest >> testDetect [
	| list |

	list := self listWithElements.
	self listElements do: [:element |
		self assert: (list detect: [:each | each = element]) = element].
	self assert: (list detect: [:each | each = self absentElement]) = self defaultValue.
]

{ #category : #tests }
XMLOrderedListTest >> testDetectIfNone [
	| list |

	list := self listWithElements.
	self listElements do: [:element |
		self assert:
			(list
				detect: [:each | each = element]
				ifNone: [self newElement]) = element].
	self assert:
		(list
			detect: [:each | each = self absentElement]
			ifNone: [self newElement]) = self newElement.
]

{ #category : #tests }
XMLOrderedListTest >> testDo [
	self
		should: [:block | self emptyList do: block] enumerate: #();
		should: [:block | self listWithElements do: block] enumerate: self listElements
]

{ #category : #tests }
XMLOrderedListTest >> testDoWithIndex [
	| list enumerated |

	list := self listWithElements.
	enumerated := OrderedCollection new.
	list withIndexDo: [:each :i | enumerated addLast: each -> i].
	self assert:
		enumerated =
			(self listElements withIndexCollect: [:each : i | each -> i ])
				asOrderedCollection.
]

{ #category : #tests }
XMLOrderedListTest >> testEighth [
	self
		assert: self emptyList eighth = self defaultValue;
		assert: self listWithElements eighth = (self listElements at: 8).
]

{ #category : #tests }
XMLOrderedListTest >> testEndsWith [
	| list |

	self deny: (self emptyList endsWith: self listElements).
	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list endsWith: (self listElements copyFrom: i to: list size));
			deny: (list endsWith: ((self listElements copyFrom: i to: list size) copyWith: self absentElement));
			deny: (list endsWith: ((self listElements copyFrom: i to: list size) copyWithFirst: self absentElement))].
]

{ #category : #tests }
XMLOrderedListTest >> testEquals [
	self
		assertList: self emptyList equals: self emptyList;
		assertList: self listWithSingleElement equals: self listWithSingleElement;
		assertList: self listWithElements equals: self listWithElements;
		denyList: self emptyList equals: self listWithSingleElement;
		denyList: self emptyList equals: self listWithElements;
		denyList: self listWithSingleElement equals: self listWithElements
]

{ #category : #tests }
XMLOrderedListTest >> testEqualsInternalCollections [
	| emptyArrayList emptyOCList arrayListWithSingleElement ocListWithSingleElement arrayListWithElements ocListWithElements |

	emptyArrayList := self listClass collection: #().
	emptyOCList := self listClass collection: OrderedCollection new.
	arrayListWithSingleElement := self listClass collection: (Array with: self singleElement).
	ocListWithSingleElement := self listClass collection: (OrderedCollection with: self singleElement).
	arrayListWithElements := self listClass collection: (Array newFrom: self listElements).
	ocListWithElements := self listClass collection: (OrderedCollection newFrom: self listElements).

	self
		assertList: emptyArrayList equals: emptyOCList;
		assertList: arrayListWithSingleElement equals: ocListWithSingleElement;
		assertList: arrayListWithElements equals: ocListWithElements;
		denyList: emptyArrayList equals: ocListWithSingleElement;
		denyList: emptyArrayList equals: ocListWithElements;
		denyList: arrayListWithSingleElement equals: emptyOCList;
		denyList: arrayListWithSingleElement equals: ocListWithElements;
		denyList: arrayListWithElements equals: emptyOCList;
		denyList: arrayListWithElements equals: ocListWithSingleElement.
]

{ #category : #tests }
XMLOrderedListTest >> testEqualsSpecies [
	| emptySpeciesList speciesListWithSingleElement speciesListWithElements |

	emptySpeciesList := self listSpecies new.
	speciesListWithSingleElement := self listSpecies with: self singleElement.
	speciesListWithElements := self listSpecies newFrom: self listElements.
	self
		assertList: self emptyList equals: emptySpeciesList;
		assertList: self listWithSingleElement equals: speciesListWithSingleElement;
		assertList: self listWithElements equals: speciesListWithElements;
		denyList: self emptyList equals: speciesListWithSingleElement;
		denyList: self emptyList equals: speciesListWithElements;
		denyList: self listWithSingleElement equals: emptySpeciesList;
		denyList: self listWithSingleElement equals: speciesListWithElements;
		denyList: self listWithElements equals: emptySpeciesList;
		denyList: self listWithElements equals: speciesListWithSingleElement.
]

{ #category : #tests }
XMLOrderedListTest >> testFifth [
	self
		assert: self emptyList fifth = self defaultValue;
		assert: self listWithElements fifth = (self listElements at: 5).
]

{ #category : #tests }
XMLOrderedListTest >> testFirst [
	self
		assert: self emptyList first = self defaultValue;
		assert: self listWithElements first = (self listElements at: 1).
]

{ #category : #tests }
XMLOrderedListTest >> testFirstFew [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assertList: (list first: i)
			copiedFrom: list
			equals: (self listClass newFrom: (self listElementsFirst: i)).
		self
			assertList: (list first: list size + i)
			copiedFrom: list
			equals: self listWithElements.
		self
			assertList: (list first: (i * -1))
			copiedFrom: list
			equals: self emptyList].
	self
		assertList: (list first: 0)
		copiedFrom: list
		equals: self emptyList.
]

{ #category : #tests }
XMLOrderedListTest >> testFourth [
	self
		assert: self emptyList fourth = self defaultValue;
		assert: self listWithElements fourth = (self listElements at: 4).
]

{ #category : #tests }
XMLOrderedListTest >> testIdentityIndexOf [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list identityIndexOf: (list at: i)) = i;
			assert: (list identityIndexOf: (list at: i) copy) isZero].
]

{ #category : #tests }
XMLOrderedListTest >> testIdentityIndexOfIfAbsent [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list identityIndexOf: (list at: i) ifAbsent: [-1]) = i;
			assert: (list identityIndexOf: (list at: i) copy ifAbsent: [-1]) = -1].
]

{ #category : #tests }
XMLOrderedListTest >> testIndexOf [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list indexOf: (list at: i)) = i;
			assert: (list indexOf: (self listElements at: i)) = i].
	self assert: (list indexOf: self absentElement) isZero.
]

{ #category : #tests }
XMLOrderedListTest >> testIndexOfIfAbsent [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list indexOf: (list at: i) ifAbsent: [-1]) = i;
			assert: (list indexOf: (self listElements at: i) ifAbsent: [-1]) = i].
	self assert: (list indexOf: self absentElement ifAbsent: [-1]) = -1.
]

{ #category : #tests }
XMLOrderedListTest >> testIndexOfStartingAt [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list indexOf: (list at: i) startingAt: i) = i;
			assert: (list indexOf: (list at: i) startingAt: i + 1) isZero].
]

{ #category : #tests }
XMLOrderedListTest >> testIndexOfStartingAtIfAbsent [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assert: (list indexOf: (list at: i) startingAt: i ifAbsent: [-1]) = i;
			assert: (list indexOf: (list at: i) startingAt: i + 1 ifAbsent: [-1]) = -1].
]

{ #category : #tests }
XMLOrderedListTest >> testLast [
	self
		assert: self emptyList last = self defaultValue;
		assert: self listWithElements last = self listElements last.
]

{ #category : #tests }
XMLOrderedListTest >> testLastFew [
	| list |

	list := self listWithElements.
	1 to: list size do: [:i |
		self
			assertList: (list last: i)
			copiedFrom: list
			equals: (self listClass newFrom: (self listElementsLast: i)).
		self
			assertList: (list last: list size + i)
			copiedFrom: list
			equals: self listWithElements.
		self
			assertList: (list last: (i * -1))
			copiedFrom: list
			equals: self emptyList].
	self
		assertList: (list last: 0)
		copiedFrom: list
		equals: self emptyList.
]

{ #category : #tests }
XMLOrderedListTest >> testLastIndexOf [
	| list |

	list := self listClass newFrom: self listElements, self listElements.
	list do: [:each |
		self assert:
			(list lastIndexOf: each) =
				(self allowsDuplicates
					ifTrue: [self listElements, self listElements lastIndexOf: each]
					ifFalse: [self listElements lastIndexOf: each])].
	self assert: (list lastIndexOf: self newElement) isZero.
]

{ #category : #tests }
XMLOrderedListTest >> testLastIndexOfIfAbsent [
	| list |

	list := self listClass newFrom: self listElements, self listElements.
	list do: [:each |
		self assert:
			(list lastIndexOf: each ifAbsent: [-1]) =
				(self allowsDuplicates
					ifTrue: [self listElements, self listElements lastIndexOf: each]
					ifFalse: [self listElements lastIndexOf: each])].
	self assert: (list lastIndexOf: self newElement ifAbsent: [-1])  = -1.
]

{ #category : #tests }
XMLOrderedListTest >> testNew [
	| list |

	list := self listClass new: 20.
	self assert: list = self emptyList.
	self hasCapacity
		ifTrue: [self assert: list capacity >= 20].
]

{ #category : #tests }
XMLOrderedListTest >> testNewFrom [
	self assert: (self listClass newFrom: self listElements) = self listWithElements
]

{ #category : #tests }
XMLOrderedListTest >> testNewWithAll [
	| list |

	list := self listClass new: 10 withAll: self singleElement.
	self allowsDuplicates
		ifTrue: [self assert: list size = 10]
		ifFalse: [self assert: list size = 1].
	self assert: (list allSatisfy: [:each | each = self singleElement]).
]

{ #category : #tests }
XMLOrderedListTest >> testNinth [
	self
		assert: self emptyList ninth = self defaultValue;
		assert: self listWithElements ninth = (self listElements at: 9).
]

{ #category : #tests }
XMLOrderedListTest >> testOfSize [
	self assert: (self listClass ofSize: 10) size = 10
]

{ #category : #tests }
XMLOrderedListTest >> testPairsDo [
	| pairs |

	0 to: self listElements size do: [:i |
		pairs := OrderedCollection new.
		(self listClass newFrom: (self listElements allButLast: i))
			pairsDo: [:a :b | pairs addLast: a -> b].
		
		(self listElements allButLast: i) pairsDo: [:a :b |
			self assert: pairs removeFirst = (a -> b)].
		self assert: pairs isEmpty].
]

{ #category : #tests }
XMLOrderedListTest >> testReadStream [
	| list stream elements |

	list := self listWithElements.
	stream := list readStream.
	self assert: (stream isKindOf: ReadStream).

	elements := self listElements asOrderedCollection.
	[stream atEnd]
		whileFalse: [self assert: stream next = elements removeFirst].
	self assert: elements isEmpty.
]

{ #category : #tests }
XMLOrderedListTest >> testReject [
	| list |

	list := self listWithElements.
	self
		assertList: (list reject: [:each | each = self singleElement])
		copiedFrom: list
		equals:
			(self listClass newFrom:
				(self listWithElements copyWithout: self singleElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testRejectThenCollect [
	| list |

	list := self listWithElements.
	self
		assertList:
			(list
				reject: [:each | each = self singleElement]
				thenCollect: [:each | self changeElement: each])
		collectedFrom: list
		equals:
			(self listSpecies newFrom:
				(self changedListElements copyWithout: self changedSingleElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveAll [
	| list |

	list := self listWithElements.
	self
		assert: (list removeAll) == list;
		assert: list isEmpty.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveAt [
	self listElements withIndexDo: [:each :i | | list |
		list := self listWithElements.
		self
			assert: (list removeAt: i) = each;
			assert: (list = (self listClass newFrom: (self listElements copyWithout: each)))].
	self
		should: [self listWithElements removeAt: 0] raise: Error;
		should: [self listWithElements removeAt: self listElements size + 1] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveFirst [
	| list |

	list := self listWithElements.
	self listElements do: [:each | 
	self
		assert: list removeFirst = each;
		assert: list = (self listClass newFrom: (self listElements copyAfter: each))].
	self should: [list removeFirst] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveFirstFew [
	1 to: self listElements size do: [:i | | list removedElements |
		list := self listWithElements.
		removedElements := list removeFirst: i.
		self
			assert: removedElements asArray = (self listElementsFirst: i);
			assert: list = (self listClass newFrom: (self listElements allButFirst: i));
			assert: (list removeFirst: 0) isEmpty;
			should: [self emptyList removeFirst: i] raise: Error].
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveIfAbsent [
	| list |

	list := self listWithElements.
	self
		assert: (list remove: self singleElement ifAbsent: [nil]) = self singleElement;
		deny: (list includes: self singleElement);
		assert: (list remove: self absentElement ifAbsent: [nil]) isNil.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveLast [
	| list |

	list := self listWithElements.
	self listElements reverseDo: [:each |
		self
			assert: list removeLast = each;
			assert: list = (self listClass newFrom: (self listElements copyUpTo: each))].
	self should: [list removeLast] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveLastFew [
	| list removedElements |

	1 to: self listElements size do: [:i |
		list := self listWithElements.
		removedElements := list removeLast: i.
		self
			assert: removedElements asArray = (self listElementsLast: i) asArray;
			assert: list = (self listClass newFrom: (self listElements allButLast: i));
			assert: (list removeLast: 0) isEmpty;
			should: [self emptyList removeLast: i] raise: Error].
]

{ #category : #tests }
XMLOrderedListTest >> testReplaceFromToWith [
	| list |

	1 to: self listElements size do: [:start |
		start to: self listElements size do: [:stop |
			list := self listWithElements.
			self assert:
				(list
					replaceFrom: start
					to: stop
					with: (self changedListElements allButFirst: start - 1)) == list.

			1 to: start - 1 do: [:i | self assert: (list at: i) = (self listElements at: i)].
			start to: stop do: [:i | self assert: (list at: i) = (self changedListElements at: i)].
			stop + 1 to: list size do: [:i | self assert: (list at: i) = (self listElements at: i)].

			start > 1
				ifTrue: [
					self
						should: [
							self emptyList
								replaceFrom: start
								to: stop
								with: self listElements]
						raise: Error]
				ifFalse: [
					self assert:
						(self emptyList
							replaceFrom: start
							to: stop
							with: self listElements) =
								(self listClass newFrom:
									(self listElementsFirst: (stop - start) + 1))]]].
]

{ #category : #tests }
XMLOrderedListTest >> testReplaceFromToWithStartingAt [
	1 to: self listElements size do: [:start |
		start to: self listElements size do: [:stop | | list |
			list := self listWithElements.
			self assert:
				(list
					replaceFrom: start
					to: stop
					with: self changedListElements
					startingAt: start) == list.

			1 to: start - 1 do: [:i | self assert: (list at: i) = (self listElements at: i)].
			start to: stop do: [:i | self assert: (list at: i) = (self changedListElements at: i)].
			stop + 1 to: list size do: [:i | self assert: (list at: i) = (self listElements at: i)].

			start > 1
				ifTrue: [
					self
						should: [
							self emptyList
								replaceFrom: start
								to: stop
								with: self listElements
								startingAt: start]
						raise: Error]
				ifFalse: [
					self assert:
						(self emptyList
							replaceFrom: start
							to: stop
							with: self listElements
							startingAt: start) =
								(self listClass newFrom:
									(self listElementsFirst: (stop - start) + 1))]]].
]

{ #category : #tests }
XMLOrderedListTest >> testReset [
	| list oldCapacity |

	list := self listWithElements.
	self hasCapacity
		ifTrue: [oldCapacity := list capacity].
	list reset.
	self assert: list isEmpty.
	oldCapacity
		ifNotNil: [self assert: list capacity >= oldCapacity].
]

{ #category : #tests }
XMLOrderedListTest >> testReverse [
	| list |

	list := self listWithElements.
	self
		assertList: list reverse
		copiedFrom: list
		equals: (self listClass newFrom: self listElements reverse).
]

{ #category : #tests }
XMLOrderedListTest >> testReverseDo [
	self
		should: [:block | self emptyList reverseDo: block] enumerate: #();
		should: [:block | self listWithElements reverseDo: block] enumerate: self listElements reversed.
]

{ #category : #tests }
XMLOrderedListTest >> testReversed [
	| list |

	list := self listWithElements.
	self
		assertList: list reversed
		copiedFrom: list
		equals: (self listClass newFrom: self listElements reversed).
]

{ #category : #tests }
XMLOrderedListTest >> testSecond [
	self
		assert: self emptyList second = self defaultValue;
		assert: self listWithElements second = (self listElements at: 2).
]

{ #category : #tests }
XMLOrderedListTest >> testSelect [
	| list |

	list := self listWithElements.
	self
		assertList: (list select: [:each | each ~= self singleElement])
		copiedFrom: list
		equals:
			(self listClass newFrom:
				(self listWithElements copyWithout: self singleElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testSelectThenCollect [
	| list |

	list := self listWithElements.
	self
		assertList:
			(list
				select: [:each | each ~= self singleElement]
				thenCollect: [:each | self changeElement: each])
		collectedFrom: list
		equals:
			(self listSpecies newFrom:
				(self changedListElements copyWithout: self changedSingleElement)).
]

{ #category : #tests }
XMLOrderedListTest >> testSeventh [
	self
		assert: self emptyList seventh = self defaultValue;
		assert: self listWithElements seventh = (self listElements at: 7).
]

{ #category : #tests }
XMLOrderedListTest >> testSixth [
	self
		assert: self emptyList sixth = self defaultValue;
		assert: self listWithElements sixth = (self listElements at: 6).
]

{ #category : #tests }
XMLOrderedListTest >> testSize [
	self
		assert: self emptyList size isZero;
		assert: self listWithSingleElement size = 1;
		assert: self listWithElements size = self listElements size
]

{ #category : #tests }
XMLOrderedListTest >> testSort [
	| list |

	list := self listWithElements.
	self
		assert: list sort == list;
		assert: list = (self listClass newFrom: (self listElements copy sort: self sortBlock));
		assert: (list sort: self reverseSortBlock) == list;
		assert: list = (self listClass newFrom: (self listElements copy sort: self reverseSortBlock)).
]

{ #category : #tests }
XMLOrderedListTest >> testSorted [
	| list |

	list := self listWithElements.
	self
		assertList: list sorted
		copiedFrom: list
		equals: (self listClass newFrom: (self listElements copy sorted: self sortBlock)).
	self
		assertList: (list sorted: self reverseSortBlock)
		copiedFrom: list
		equals: (self listClass newFrom: (self listElements copy sorted: self reverseSortBlock)).
]

{ #category : #tests }
XMLOrderedListTest >> testSpecies [
	self
		assert: self emptyList species = self listSpecies
]

{ #category : #tests }
XMLOrderedListTest >> testSwapWith [
	| list start end |

	list := self listWithElements.

	start := 1.
	end := list size.
	[start < end]
		whileTrue: [
			list swap: start with: end.
			start := start + 1.
			end := end - 1].
	self assert: list = (self listClass newFrom: self listElements reversed).

	start := 1.
	end := list size.
	[start < end]
		whileTrue: [
			list swap: end with: start.
			start := start + 1.
			end := end - 1].
	self assert: list = self listWithElements.

	1 to: list size do: [:i | list swap: i with: i].
	self assert: list = self listWithElements.

	self
		should: [list swap: 0 with: 1]
		raise: Error.
	self
		should: [list swap: list size + 1 with: list size]
		raise: Error.
	self assert: list = self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testThird [
	self
		assert: self emptyList third = self defaultValue;
		assert: self listWithElements third = (self listElements at: 3).
]

{ #category : #tests }
XMLOrderedListTest >> testWithCollect [
	| list |

	list := self listWithElements.
	self
		assertList: (list with: (1 to: list size + 1) collect: [:each :i | each -> i])
		collectedFrom: list
		equals:
			(self listSpecies newFrom:
				(self listElements withIndexCollect: [:each :i | each -> i])).
	self
		assertList: (list with: (1 to: list size - 1) collect: [:each :i | each -> i])
		collectedFrom: list
		equals:
			(self listSpecies newFrom:
				(self listElements allButLast
					withIndexCollect: [:each :i | each -> i])).
]

{ #category : #tests }
XMLOrderedListTest >> testWithDo [
	| list enumerated |

	list := self listWithElements.
	enumerated := OrderedCollection new.
	list with: (1 to: list size + 1) do: [:each :i | enumerated addLast: each -> i].
	self assert:
		enumerated =
			(self listElements withIndexCollect: [:each : i | each -> i ])
				asOrderedCollection.

	enumerated removeAll.
	list with: (1 to: list size - 1) do: [:each :i | enumerated addLast: each -> i].
	self assert:
		enumerated =
			(self listElements allButLast
				withIndexCollect: [:each : i | each -> i ])
					asOrderedCollection.
]

{ #category : #tests }
XMLOrderedListTest >> testWithIndexCollect [
	| list |

	list := self listWithElements.
	self
		assertList: (list withIndexCollect: [:each :i | each -> i])
		collectedFrom: list
		equals:
			(self listSpecies newFrom:
				(self listElements withIndexCollect: [:each :i | each -> i])).
]

{ #category : #tests }
XMLOrderedListTest >> testWithIndexDo [
	| enumerated |

	enumerated := OrderedCollection new.
	self listWithElements withIndexDo: [:each :i | enumerated addLast: each -> i].
	self assert:
		enumerated =
			(self listElements withIndexCollect: [:each : i | each -> i ]) asOrderedCollection.
]

{ #category : #tests }
XMLOrderedListTest >> testWriteStream [
	| list stream |

	list := self emptyList.
	stream := list writeStream.
	self assert: (stream isKindOf: WriteStream).

	self listElements do: [:each | stream nextPut: each].
	self assert:
		(stream contents) asOrderedCollection =
			self listElements asOrderedCollection.
]

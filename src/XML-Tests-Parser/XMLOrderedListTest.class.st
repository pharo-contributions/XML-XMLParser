Class {
	#name : #XMLOrderedListTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLOrderedListTest >> absentElement [
	^ 'absent'
]

{ #category : #assertions }
XMLOrderedListTest >> assertList: aList isCopyOf: aSecondList [
	self
		assert: aList = aSecondList;
		assertList: aList isNotIdentityEqualTo: aSecondList
]

{ #category : #assertions }
XMLOrderedListTest >> assertList: aList isNotIdentityEqualTo: aSecondList [
	self
		deny: aList == aSecondList;
		deny: aSecondList == aList;
		deny: aList collection == aSecondList collection;
		deny: aSecondList collection == aList collection
]

{ #category : #assertions }
XMLOrderedListTest >> assertList: aList isPartialCopyOf: aSecondList equalTo: aThirdList [
	self
		assert: aList = aThirdList;
		assertList: aList isNotIdentityEqualTo: aSecondList
]

{ #category : #accessing }
XMLOrderedListTest >> defaultValue [
	^ nil
]

{ #category : #accessing }
XMLOrderedListTest >> emptyList [
	^ self listClass new
]

{ #category : #accessing }
XMLOrderedListTest >> listClass [
	^ XMLOrderedList
]

{ #category : #accessing }
XMLOrderedListTest >> listElements [
	^ #('one' 'two' 'three' 'four' 'five')
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

{ #category : #tests }
XMLOrderedListTest >> testAdd [
	| list |

	list := self emptyList.
	self
		deny: list = self listWithElements;
		assert: (self listElements allSatisfy: [:each | (list add: each) = each]);
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
		should: [list add: self singleElement after: self absentElement] raise: Error.
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
		should: [list add: self singleElement afterIndex: self listElements size + 1] raise: Error;
		should: [list add: self singleElement afterIndex: -1] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testAddAll [
	| list |

	list := self emptyList.
	self
		deny: list = self listWithElements;
		assert: (list addAll: self listElements) = self listElements;
		assert: list = self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testAddAllFirst [
	| list |

	(list := self emptyList) add: self listElements last.
	self
		assert: (list addAllFirst: self listElements allButLast) = self listElements allButLast;
		assert: list = self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testAddAllLast [
	| list |

	list := self listWithSingleElement.
	self
		assert: (list addAllLast: self listElements allButFirst) = self listElements allButFirst;
		assert: list = self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testAddBefore [
	| list |

	(list := self emptyList) add: self listElements last.
	self
		assert:
			(self listElements allButLast
				allSatisfy: [:each | (list add: each before: self listElements last) = each]);
		assert: list = self listWithElements;
		should: [list add: self singleElement before: self absentElement] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testAddBeforeIndex [
	| list i |

	(list := self emptyList) add: self listElements last.
	i := 0.
	self
		assert:
			(self listElements allButLast
				allSatisfy: [:each |
					i := i + 1.
					(list add: each beforeIndex: i) = each]);
		assert: list = self listWithElements;
		should: [list add: self singleElement beforeIndex: self listElements size + 2] raise: Error;
		should: [list add: self singleElement beforeIndex: 0] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testAddFirst [
	| list |

	list := self emptyList.
	self
		assert: (self listElements reversed allSatisfy: [:each | (list addFirst: each) = each]);
		assert: list = self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testAddLast [
	| list |

	list := self emptyList.
	self
		assert: (self listElements allSatisfy: [:each | (list addLast: each) = each]);
		assert: list = self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testAfter [
	| list |

	list := self listWithElements.
	self
		assert:
			(self listElements allSatisfy: [:each |
				(list after: each) = (self listElements after: each ifAbsent: [self defaultValue])]).
]

{ #category : #tests }
XMLOrderedListTest >> testAsArray [
	self
		assert: self emptyList asArray = #();
		assert: self listWithElements asArray = self listElements asArray
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
XMLOrderedListTest >> testAtLast [
	self
		assert: (self emptyList atLast: 1) = self defaultValue;
		assert: (self listWithSingleElement atLast: 1) = self singleElement;
		assert: (self listWithElements atLast: 2) = (self listElements atLast: 2);
		assert: (self listWithElements atLast: self listWithElements size + 1) = self defaultValue.
]

{ #category : #tests }
XMLOrderedListTest >> testAtPut [
	| list |

	list := self listWithElements.
	self
		assert:
			((1 to: list size) allSatisfy: [:i | | replacement |
				replacement := self listElements reversed at: i.
				(list at: i put: replacement) = replacement]);
		assert: list = self listWithElements reversed;
		should: [list at: 0 put: self absentElement] raise: Error;
		should: [list at: list size + 1 put: self absentElement] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testBefore [
	| list |

	list := self listWithElements.
	self
		assert:
			(self listElements allSatisfy: [:each |
				(list before: each) = (self listElements before: each ifAbsent: [self defaultValue])]).
]

{ #category : #tests }
XMLOrderedListTest >> testCapacity [
	self
		assert: self emptyList capacity >= 0;
		assert: self listWithSingleElement capacity >= 1;
		assert: self listWithElements capacity >= self listElements size
]

{ #category : #tests }
XMLOrderedListTest >> testCollect [
	self assert:
		(self listWithElements collect: [:each | each asUppercase]) =
			(self listClass newFrom: (self listElements collect: [:each | each asUppercase]))
]

{ #category : #tests }
XMLOrderedListTest >> testCollectFromTo [
	| list copySize |

	list := self listWithElements.
	copySize := list size // 2.
	self assert:
		(list collect: [:each | each asUppercase] from: 1 to: copySize) =
			(self listClass newFrom: (self listElements collect: [:each | each asUppercase] from: 1 to: copySize))
]

{ #category : #tests }
XMLOrderedListTest >> testCollectThenSelect [
	| list |

	list := self listWithElements.
	self assert:
		(list collect: [:each | each asUppercase] thenSelect: [:each | each ~= 'ONE']) =
			(self listWithElements collect: [:each | each asUppercase]) allButFirst
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
XMLOrderedListTest >> testCopyEmpty [
	| list |

	list := self emptyList.
	self assertList: list copyEmpty isPartialCopyOf: list equalTo: self emptyList.

	list := self listWithSingleElement.
	self assertList: list copyEmpty isPartialCopyOf: list equalTo: self emptyList.

	list := self listWithElements.
	self assertList: list copyEmpty isPartialCopyOf: list equalTo: self emptyList.
]

{ #category : #tests }
XMLOrderedListTest >> testCopyFromTo [
	| list |

	list := self emptyList.
	self
		assertList: (list copyFrom: 1 to: 10)
		isPartialCopyOf: list
		equalTo: self emptyList.

	list := self listWithElements.
	self
		assertList: (list copyFrom: 1 to: list size)
		isPartialCopyOf: list
		equalTo: self listWithElements.
	self
		assertList: (list copyFrom: 1 to: (list size / 2) asInteger)
		isPartialCopyOf: list
		equalTo: (self listClass newFrom: (self listElements copyFrom: 1 to: (list size / 2) asInteger)).
	self
		assertList: (list copyFrom: 1 to: (list size * 2) asInteger)
		isPartialCopyOf: list
		equalTo: self listWithElements.
]

{ #category : #tests }
XMLOrderedListTest >> testCopyWith [
	self assert: (self emptyList copyWith: self singleElement) = self listWithSingleElement.
]

{ #category : #tests }
XMLOrderedListTest >> testDefaultValue [
	self assert: self emptyList defaultValue = self defaultValue
]

{ #category : #tests }
XMLOrderedListTest >> testDo [
	self
		should: [:block | self emptyList do: block] enumerate: #();
		should: [:block | self listWithElements do: block] enumerate: self listElements
]

{ #category : #tests }
XMLOrderedListTest >> testNew [
	self assert: (self listClass new: 20) capacity >= 20
]

{ #category : #tests }
XMLOrderedListTest >> testNewFrom [
	self assert: (self listClass newFrom: self listElements) = self listWithElements
]

{ #category : #tests }
XMLOrderedListTest >> testNewWithAll [
	| list |

	list := self listClass new: 10 withAll: self singleElement.
	self
		assert: list size = 10;
		assert: (list allSatisfy: [:each | each = self singleElement]).
]

{ #category : #tests }
XMLOrderedListTest >> testOfSize [
	self assert: (self listClass ofSize: 10) size = 10
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
	| list |

	list := self listWithElements.
	self
		assert: (list removeAt: (list indexOf: self singleElement)) = self singleElement;
		assert: (list = (self listWithElements copyWithout: self singleElement));
		should: [list removeAt: 0] raise: Error;
		should: [list removeAt: list size + 1] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveFirst [
	| list |

	list := self listWithElements.
	self
		assert: list removeFirst = self listWithElements first;
		assert: list = self listWithElements allButFirst;
		should: [self emptyList removeFirst] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveFirstFew [
	| list removedElements |

	list := self listWithElements.
	removedElements := list removeFirst: 2.
	self
		assert: removedElements asArray = (self listElements copyFrom: 1 to: 2);
		assert: list = (self listWithElements allButFirst: 2);
		assert: (list removeFirst: 0) isEmpty;
		should: [list removeFirst: list size + 1] raise: Error.
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
	self
		assert: list removeLast = self listWithElements last;
		assert: list = self listWithElements allButLast;
		should: [self emptyList removeLast] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testRemoveLastFew [
	| list removedElements |

	list := self listWithElements.
	removedElements := list removeLast: 2.
	self
		assert: removedElements asArray = (self listElements last: 2);
		assert: list = (self listWithElements allButLast: 2);
		assert: (list removeLast: 0) isEmpty;
		should: [list removeLast: list size + 1] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testReplaceFromToWithStartingAt [
	"self debug: #testReplaceFromToWithStartingAt"
	| list |
	list := self listClass new: 5 withAll: 'zzz'.
	self
		assert: (list replaceFrom: 1 to: self listElements size with: self listElements startingAt: 1) == list;
		assert: list = self listWithElements;
		assert: (list replaceFrom: 1 to: self listElements size with: self listElements reversed startingAt: 1) == list;
		assert: list = self listWithElements reversed;
		should: [list replaceFrom: 1 to: self listElements size + 1 with: self listElements startingAt: 1] raise: Error.
]

{ #category : #tests }
XMLOrderedListTest >> testReverseDo [
	self
		should: [:block | self emptyList reverseDo: block] enumerate: #();
		should: [:block | self listWithElements reverseDo: block] enumerate: self listElements reversed.
]

{ #category : #tests }
XMLOrderedListTest >> testSelect [
	| list |

	list := self listWithElements.
	self assert:
		(list select: [:each | each ~= self singleElement]) =
			((self listClass newFrom: self listWithElements) copyWithout: self singleElement).
]

{ #category : #tests }
XMLOrderedListTest >> testSelectThenCollect [
	| list |

	list := self listWithElements.
	self assert:
		(list select: [:each | each ~= self singleElement] thenCollect: [:each | each asUppercase]) =
			(self listClass newFrom:
				((self listElements copyWithout: self singleElement) collect: [:each | each asUppercase])).
]

{ #category : #tests }
XMLOrderedListTest >> testSize [
	self
		assert: self emptyList size isZero;
		assert: self listWithSingleElement size = 1;
		assert: self listWithElements size = self listElements size
]

{ #category : #tests }
XMLOrderedListTest >> testSpecies [
	self
		assert: self emptyList species = self listSpecies;
		assert: self emptyList speciesForCollect = self listSpecies
]

{ #category : #tests }
XMLOrderedListTest >> testWithCollect [
	| interval |

	interval := 1 to: self listElements size.
	self assert:
		(self listWithElements with: interval collect: [:each :i | each -> i]) =
			(self listClass newFrom: (self listElements with: interval collect: [:each :i | each -> i])).
]

{ #category : #tests }
XMLOrderedListTest >> testWithIndexCollect [
	| interval |

	interval := 1 to: self listElements size.
	self assert:
		(self listWithElements withIndexCollect: [:each :i | each -> i]) =
			(self listClass newFrom: (self listElements with: interval collect: [:each :i | each -> i])).
]

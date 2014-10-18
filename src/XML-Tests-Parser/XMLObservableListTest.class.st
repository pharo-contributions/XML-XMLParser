Class {
	#name : #XMLObservableListTest,
	#superclass : #XMLOrderedListTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLObservableListTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
XMLObservableListTest >> afterAddingToNotification [
	^ #added:to:
]

{ #category : #accessing }
XMLObservableListTest >> afterRemovingFromNotification [
	^ #removed:from:
]

{ #category : #assertions }
XMLObservableListTest >> assertObserver: anObserver receivedNotificationOfAdding: anElement to: aList [
	| firstNotification secondNotification |

	firstNotification := anObserver notifications removeFirst.
	secondNotification := anObserver notifications removeFirst.
	self
		assert:firstNotification selector = self beforeAddingToNotification;
		assert: firstNotification arguments = (Array with: anElement with: aList);
		assert: secondNotification selector = self afterAddingToNotification;
		assert: secondNotification arguments = (Array with: anElement with: aList)
]

{ #category : #assertions }
XMLObservableListTest >> assertObserver: anObserver receivedNotificationOfRemoving: anElement from: aList [
	| notification |

	notification := anObserver notifications removeFirst.
	self
		assert: notification selector = self afterRemovingFromNotification;
		assert: notification arguments = (Array with: anElement with: aList)
]

{ #category : #accessing }
XMLObservableListTest >> beforeAddingToNotification [
	^ #adding:to:
]

{ #category : #accessing }
XMLObservableListTest >> listClass [
	^ XMLObservableList
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock add: anElement toAndNotifyOf: aList [
	self
		should: aBlock
		addAll: (Array with: anElement)
		toAndNotifyOf: aList
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock addAll: anElementCollection toAndNotifyOf: aList [
	| observer |

	observer := XMLStubListObserver new.
	aList observer: observer.
	aBlock value.
	anElementCollection do: [:each |
		self assert: (aList includes: each).
		self 
			assertObserver: observer
			receivedNotificationOfAdding: each
			to: aList].
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock remove: anElement fromAndNotifyOf: aList [
	self
		should: aBlock
		removeAll: (Array with: anElement)
		fromAndNotifyOf: aList
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock removeAll: anElementCollection fromAndNotifyOf: aList [
	| observer |

	observer := XMLStubListObserver new.
	aList observer: observer.
	aBlock value.
	anElementCollection do: [:each |
		self deny: (aList includes: each).
		self
			assertObserver: observer
			receivedNotificationOfRemoving: each
			from: aList].
]

{ #category : #tests }
XMLObservableListTest >> testAdd [
	| list |

	super testAdd.

	list := self emptyList.
	self
		should: [list add: self singleElement]
		add: self singleElement
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddAfter [
	| list |

	super testAddAfter.

	list := self listWithSingleElement.
	self
		should: [list add: self absentElement after: self singleElement]
		add: self absentElement
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddAfterIndex [
	| list |

	super testAddAfterIndex.

	list := self listWithSingleElement.
	self
		should: [list add: self absentElement afterIndex: (list indexOf: self singleElement)]
		add: self absentElement 
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddAll [
	| list |

	super testAddAll.
	list := self emptyList.
	self
		should: [list addAll: self listElements]
		addAll: self listElements
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddAllFirst [
	| list |

	super testAddAllFirst.
	list := self emptyList.
	self
		should: [list addAllFirst: self listElements]
		addAll: self listElements reversed
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddAllLast [
	| list |

	super testAddAllLast.
	list := self emptyList.
	self
		should: [list addAllLast: self listElements]
		addAll: self listElements
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddBefore [
	| list |

	super testAddBefore.

	list := self listWithSingleElement.
	self
		should: [list add: self absentElement before: self singleElement]
		add: self absentElement 
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddBeforeIndex [
	| list |

	super testAddBeforeIndex.

	list := self listWithSingleElement.
	self
		should: [list add: self absentElement beforeIndex: (list indexOf: self singleElement)]
		add: self absentElement 
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddFirst [
	| list |

	super testAddFirst.

	list := self listWithSingleElement.
	self
		should: [list addFirst: self absentElement]
		add: self absentElement
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddLast [
	| list |

	super testAddLast.

	list := self listWithSingleElement.
	self
		should: [list addLast: self absentElement]
		add: self absentElement
		toAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testAtPut [
	| list observer |

	super testAtPut.

	list := self listWithSingleElement.
	observer := XMLStubListObserver new.
	list observer: observer.
	list at: 1 put: self absentElement.
	self
		assertObserver: observer
		receivedNotificationOfRemoving: self singleElement
		from: list.
	self
		assertObserver: observer
		receivedNotificationOfAdding: self absentElement
		to: list.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveAll [
	| list |

	super testRemoveAll.
	list := self listWithElements.
	self
		should: [list removeAll]
		removeAll: self listElements reversed
		fromAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveAt [
	| list observer |

	super testRemoveAt.

	list := self listWithSingleElement.
	self
		should: [list removeAt: 1]
		remove: self singleElement
		fromAndNotifyOf: list.

	observer := XMLStubListObserver new.
	list observer: observer.
	self
		should: [list removeAt: 1] raise: Error;
		assert: observer notifications isEmpty.
	
]

{ #category : #tests }
XMLObservableListTest >> testRemoveFirst [
	| list observer |

	super testRemoveFirst.

	list := self listWithSingleElement.
	self
		should: [list removeFirst]
		remove: self singleElement
		fromAndNotifyOf: list.

	observer := XMLStubListObserver new.
	list observer: observer.
	self
		should: [list removeFirst] raise: Error;
		assert: observer notifications isEmpty.
	
]

{ #category : #tests }
XMLObservableListTest >> testRemoveFirstFew [
	| list  |

	super testRemoveFirstFew.
	
	list := self listWithElements.
	self
		should: [list removeFirst: 2]
		removeAll: (self listElements first: 2)
		fromAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveIfAbsent [
	| list observer |

	super testRemoveIfAbsent.

	list := self listWithSingleElement.
	self
		should: [list remove: self singleElement ifAbsent: [nil]]
		remove: self singleElement
		fromAndNotifyOf: list.

	observer := XMLStubListObserver new.
	list observer: observer.
	self
		assert: (list remove: self singleElement ifAbsent: [nil]) isNil;
		assert: observer notifications isEmpty.
	
]

{ #category : #tests }
XMLObservableListTest >> testRemoveLast [
	| list observer |

	super testRemoveLast.

	list := self listWithSingleElement.
	self
		should: [list removeLast]
		remove: self singleElement
		fromAndNotifyOf: list.

	observer := XMLStubListObserver new.
	list observer: observer.
	self
		should: [list removeLast] raise: Error;
		assert: observer notifications isEmpty.
	
]

{ #category : #tests }
XMLObservableListTest >> testRemoveLastFew [
	| list  |

	super testRemoveLastFew.
	
	list := self listWithElements.
	self
		should: [list removeLast: 2]
		removeAll: (self listElements last: 2) reversed
		fromAndNotifyOf: list.
]

{ #category : #tests }
XMLObservableListTest >> testReplaceFromToWithStartingAt [
	| list observer |

	super testReplaceFromToWithStartingAt.

	list := self listWithElements.
	observer := XMLStubListObserver new.
	list observer: observer.
	list
		replaceFrom: 2
		to: 3
		with: #('new1' 'new2' 'new3')
		startingAt: 2.
	
	self
		assertObserver: observer
		receivedNotificationOfRemoving: (self listElements at: 2)
		from: list.
	self
		assertObserver: observer
		receivedNotificationOfAdding: 'new2'
		to: list.
	self
		assertObserver: observer
		receivedNotificationOfRemoving: (self listElements at: 3)
		from: list.
	self
		assertObserver: observer
		receivedNotificationOfAdding: 'new3'
		to: list.
]

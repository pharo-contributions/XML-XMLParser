Class {
	#name : #XMLObservableListTest,
	#superclass : #XMLOrderedListTest,
	#category : #'XML-Tests-Parser-Nodes'
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
	self
		assert: anObserver notifications first selector = self beforeAddingToNotification;
		assert: anObserver notifications first arguments = (Array with: anElement with: aList);
		assert: anObserver notifications second selector = self afterAddingToNotification;
		assert: anObserver notifications second arguments = (Array with: anElement with: aList)
]

{ #category : #assertions }
XMLObservableListTest >> assertObserver: anObserver receivedNotificationOfRemoving: anElement from: aList [
	self
		assert: anObserver notifications first selector = self afterRemovingFromNotification;
		assert: anObserver notifications first arguments = (Array with: anElement with: aList)
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
	| observer |

	observer := XMLStubListObserver new.
	aList addObserver: observer.
	aBlock value.
	self
		assert: (aList includes: anElement);
		assertObserver: observer receivedNotificationOfAdding: anElement to: aList.
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock remove: anElement fromAndNotifyOf: aList [
	| observer |

	observer := XMLStubListObserver new.
	aList addObserver: observer.
	aBlock value.
	self
		deny: (aList includes: anElement);
		assertObserver: observer receivedNotificationOfRemoving: anElement from: aList.
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
	list addObserver: observer.
	list at: 1 put: self absentElement.
	self
		assertObserver: observer
		receivedNotificationOfRemoving: self singleElement
		from: list.
	observer notifications removeFirst.
	self
		assertObserver: observer
		receivedNotificationOfAdding: self absentElement
		to: list.
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
	list addObserver: observer.
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
	list addObserver: observer.
	self
		should: [list removeFirst] raise: Error;
		assert: observer notifications isEmpty.
	
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
	list addObserver: observer.
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
	list addObserver: observer.
	self
		should: [list removeLast] raise: Error;
		assert: observer notifications isEmpty.
	
]

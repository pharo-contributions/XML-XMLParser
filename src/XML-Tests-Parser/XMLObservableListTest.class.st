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
XMLObservableListTest >> afterAddingToNotifications [
	^ #(added:to:)
]

{ #category : #accessing }
XMLObservableListTest >> afterRemovingFromNotifications [
	^ #(removed:from:)
]

{ #category : #assertions }
XMLObservableListTest >> assertList: aList copiedFrom: aSecondList equals: aThirdList [
	super
		assertList: aList
		copiedFrom: aSecondList
		equals: aThirdList.
	self denyList: aList sharesObserverWith: aSecondList.
]

{ #category : #assertions }
XMLObservableListTest >> assertList: aList isCopyOf: aSecondList [
	super assertList: aList isCopyOf: aSecondList.
	self denyList: aList sharesObserverWith: aSecondList.
]

{ #category : #assertions }
XMLObservableListTest >> assertList: aList receivedNotificationOfAdding: anElement [
	self
		assertNotification: aList observer nextNotification
		forElement: anElement
		andList: aList
		hasType: self beforeAddingToNotifications.
	self
		assertNotification: aList observer nextNotification
		forElement: anElement
		andList: aList
		hasType: self afterAddingToNotifications.
]

{ #category : #assertions }
XMLObservableListTest >> assertList: aList receivedNotificationOfRemoving: anElement [
	self
		assertNotification: aList observer nextNotification
		forElement: anElement
		andList: aList
		hasType: self afterRemovingFromNotifications
]

{ #category : #assertions }
XMLObservableListTest >> assertNotification: aNotification forElement: anElement andList: aList hasType: aSelectorColleciton [
	self assert: (aSelectorColleciton includes: aNotification selector).
	self assert:
		aNotification arguments =
			((Array with: anElement with: aList)
				copyFrom: 1
				to: (aNotification selector asString occurrencesOf: $:)).
]

{ #category : #accessing }
XMLObservableListTest >> beforeAddingToNotifications [
	^ #(adding:to:)
]

{ #category : #assertions }
XMLObservableListTest >> denyList: aList sharesObserverWith: aSecondList [
	self deny:
		(aList observer notNil
			and: [aSecondList observer notNil
				and: [aList observer == aSecondList observer]])
]

{ #category : #accessing }
XMLObservableListTest >> emptyList [
	| list |

	list := super emptyList.
	self observerOnList: list.
	^ list.
]

{ #category : #accessing }
XMLObservableListTest >> listClass [
	^ XMLObservableList
]

{ #category : #accessing }
XMLObservableListTest >> listWithElements [
	| list |

	list := super listWithElements.
	self observerOnList: list.
	^ list.
]

{ #category : #accessing }
XMLObservableListTest >> listWithSingleElement [
	| list |

	list := super listWithSingleElement.
	self observerOnList: list.
	^ list.
]

{ #category : #accessing }
XMLObservableListTest >> observerClass [
	^ XMLRecordingListObserver
]

{ #category : #accessing }
XMLObservableListTest >> observerOnList: aList [
	| observer |

	observer := self observerClass new.
	aList observer: observer.
	^ observer.
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock add: anElement toAndNotify: aList [
	self
		should: aBlock
		addAll: (Array with: anElement)
		toAndNotify: aList
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock addAll: anElementCollection toAndNotify: aList [
	aList observer clearNotifications.
	aBlock value.
	anElementCollection do: [:each |
		self assert: (aList includes: each).
		self 
			assertList: aList
			receivedNotificationOfAdding: each].
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock remove: anElement fromAndNotify: aList [
	self
		should: aBlock
		removeAll: (Array with: anElement)
		fromAndNotify: aList
]

{ #category : #assertions }
XMLObservableListTest >> should: aBlock removeAll: anElementCollection fromAndNotify: aList [
	aList observer clearNotifications.
	aBlock value.
	anElementCollection do: [:each |
		self deny: (aList includes: each).
		self
			assertList: aList
			receivedNotificationOfRemoving: each].
]

{ #category : #tests }
XMLObservableListTest >> testAdd [
	| list |

	super testAdd.

	list := self emptyList.
	self listElements do: [:each |
		self
			should: [list add: each]
			add: each
			toAndNotify: list].
]

{ #category : #tests }
XMLObservableListTest >> testAddAfter [
	| list |

	super testAddAfter.

	list := self listWithSingleElement.
	self listElements allButFirst reverseDo: [:each |
		self
			should: [list add: each after: self singleElement]
			add: each
			toAndNotify: list].
]

{ #category : #tests }
XMLObservableListTest >> testAddAfterIndex [
	| list |

	super testAddAfterIndex.

	list := self listWithSingleElement.
	self listElements allButFirst reverseDo: [:each |
		self
			should: [list add: each afterIndex: 1]
			add: each
			toAndNotify: list].
]

{ #category : #tests }
XMLObservableListTest >> testAddAll [
	| list |

	super testAddAll.

	list := self emptyList.
	self
		should: [list addAll: self listElements]
		addAll: self listElements
		toAndNotify: list.
	self
		should: [list addAll: self changedListElements]
		addAll: self changedListElements
		toAndNotify: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddAllFirst [
	| list |

	super testAddAllFirst.

	list := self emptyList.
	self
		should: [list addAllFirst: self listElements]
		addAll: self listElements reversed
		toAndNotify: list.
	self
		should: [list addAllFirst: self changedListElements]
		addAll: self changedListElements reversed
		toAndNotify: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddAllLast [
	| list |

	super testAddAllLast.

	list := self emptyList.
	self
		should: [list addAllLast: self listElements]
		addAll: self listElements
		toAndNotify: list.
	self
		should: [list addAllLast: self changedListElements]
		addAll: self changedListElements
		toAndNotify: list.
]

{ #category : #tests }
XMLObservableListTest >> testAddBefore [
	| list last |

	super testAddBefore.

	last := self listElements last.
	(list := self emptyList) add: last.
	"allButLastDo: is not portable"
	self listElements allButLast do: [:each |
		self
			should: [list add: each before: last]
			add: each
			toAndNotify: list].
]

{ #category : #tests }
XMLObservableListTest >> testAddBeforeIndex [
	| list |

	super testAddBeforeIndex.

	(list := self emptyList) add: self listElements last.
	self listElements allButLast withIndexDo: [:each :i |
		self
			should: [list add: each beforeIndex: i]
			add: each
			toAndNotify: list].
]

{ #category : #tests }
XMLObservableListTest >> testAddFirst [
	| list |

	super testAddFirst.

	list := self emptyList.
	self listElements reverseDo: [:each |
		self
			should: [list addFirst: each]
			add: each
			toAndNotify: list].
]

{ #category : #tests }
XMLObservableListTest >> testAddLast [
	| list |

	super testAddLast.

	list := self emptyList.
	self listElements do: [:each |
		self
			should: [list addLast: each]
			add: each
			toAndNotify: list].
]

{ #category : #tests }
XMLObservableListTest >> testAtPut [
	| list |

	super testAtPut.

	list := self listWithElements.
	1 to: list size do: [:i | | old new |
		old := list at: i.
		new := self changedListElements at: i.
		list at: i put: new.
		self
			assertList: list
			receivedNotificationOfRemoving: old.
		self
			assertList: list
			receivedNotificationOfAdding: new].
	self
		should: [list at: list size + 2 put: self newElement]
		raise: Error.
	self
		assert: list observer hasNotifications;
		assert:
			(self beforeAddingToNotifications includes:
				list observer nextNotification selector);
		deny: list observer hasNotifications.
]

{ #category : #tests }
XMLObservableListTest >> testOfSize [
	self
		should: [self listClass ofSize: 10]
		raise: Error
]

{ #category : #tests }
XMLObservableListTest >> testRemoveAll [
	| list |

	super testRemoveAll.

	list := self listWithElements.
	self
		should: [list removeAll]
		removeAll: self listElements reversed
		fromAndNotify: list.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveAt [
	super testRemoveAt.

	self listElements withIndexDo: [:each :i | | list |
		list := self listWithElements.
		self
			should: [list removeAt: i]
			remove: each
			fromAndNotify: list.
		self
			should: [list removeAt: 0] raise: Error;
			should: [list removeAt: list size + 1] raise: Error;
			deny: list observer hasNotifications].
]

{ #category : #tests }
XMLObservableListTest >> testRemoveFirst [
	| list |

	super testRemoveFirst.

	list := self listWithElements.
	self listElements do: [:each |
		self
			should: [list removeFirst]
			remove: each
			fromAndNotify: list].
	self
		should: [list removeFirst] raise: Error;
		deny: list observer hasNotifications.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveFirstFew [
	| list |

	super testRemoveFirstFew.

	1 to: self listElements size do: [:i |
		list := self listWithElements.
		self
			should: [list removeFirst: i]
			removeAll: (self listElementsFirst: i)
			fromAndNotify: list].
	list := self emptyList.
	self
		should: [list removeFirst: list size + 1] raise: Error;
		deny: list observer hasNotifications.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveIfAbsent [
	| list |

	super testRemoveIfAbsent.

	list := self listWithElements.
	self
		should: [list remove: self singleElement ifAbsent: [nil]]
		remove: self singleElement
		fromAndNotify: list.
	self
		assert: (list remove: self singleElement ifAbsent: [nil]) isNil;
		deny: list observer hasNotifications.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveLast [
	| list |

	super testRemoveLast.

	list := self listWithElements.
	self listElements reverseDo: [:each |
		self
			should: [list removeLast]
			remove: each
			fromAndNotify: list].
	self
		should: [list removeFirst] raise: Error;
		deny: list observer hasNotifications.
]

{ #category : #tests }
XMLObservableListTest >> testRemoveLastFew [
	| list |
	
	super testRemoveLastFew.

	1 to: self listElements size do: [:i |
		list := self listWithElements.
		self
			should: [list removeLast: i]
			removeAll: (self listElementsLast: i) reversed
			fromAndNotify: list].
	list := self emptyList.
	self
		should: [list removeFirst: list size + 1] raise: Error;
		deny: list observer hasNotifications.
]

{ #category : #tests }
XMLObservableListTest >> testReplaceFromToWith [
	super testReplaceFromToWith.

	1 to: self listElements size do: [:start |
		start to: self listElements size do: [:stop | | list old new |
			list := self listWithElements.
			old := self listElements copyFrom: start to: stop.
			new := self changedListElements copyFrom: 1 to: stop - start + 1.
			list
				replaceFrom: start
				to: stop
				with: self changedListElements.
			old with: new do: [:oldElement :newElement |
				self
					assertList: list
					receivedNotificationOfRemoving: oldElement.
				self
					assertList: list
					receivedNotificationOfAdding: newElement].
			self deny: list observer hasNotifications]].
]

{ #category : #tests }
XMLObservableListTest >> testReplaceFromToWithStartingAt [
	super testReplaceFromToWithStartingAt.

	1 to: self listElements size do: [:start |
		start to: self listElements size do: [:stop | | list old new |
			list := self listWithElements.
			old := self listElements copyFrom: start to: stop.
			new := self changedListElements copyFrom: start to: stop.
			list
				replaceFrom: start
				to: stop
				with: self changedListElements
				startingAt: start.
			old with: new do: [:oldElement :newElement |
				self
					assertList: list
					receivedNotificationOfRemoving: oldElement.
				self
					assertList: list
					receivedNotificationOfAdding: newElement].
			self deny: list observer hasNotifications]].
]

{ #category : #tests }
XMLObservableListTest >> testReset [
	| list |

	super testReset.
	list := self listWithElements.
	self
		should: [list reset]
		removeAll: self listElements
		fromAndNotify: list.
]

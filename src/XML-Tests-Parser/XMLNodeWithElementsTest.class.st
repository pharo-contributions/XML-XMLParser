"
Abstract, do not run.
"
Class {
	#name : #XMLNodeWithElementsTest,
	#superclass : #XMLNodeWithChildrenTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLNodeWithElementsTest class >> isAbstract [
	^ true
]

{ #category : #assertions }
XMLNodeWithElementsTest >> assertNode: aNode hasElements: anElementCollection [
	self assert: aNode elements asArray = anElementCollection asArray
]

{ #category : #assertions }
XMLNodeWithElementsTest >> assertNodeHasNoChildren: aNode [
	super assertNodeHasNoChildren: aNode.
	self assertNodeHasNoContentNodes: aNode
]

{ #category : #assertions }
XMLNodeWithElementsTest >> assertNodeHasNoContentNodes: aNode [
	self
		deny: aNode hasContentNodes;
		assert: aNode contentNodes isEmpty;
		assert: aNode contentString isEmpty;
		assertNodeHasNoElements: aNode;
		assertNodeHasNoStringNodes: aNode.
]

{ #category : #assertions }
XMLNodeWithElementsTest >> assertNodeHasNoElements: aNode [
	self
		deny: aNode hasElements;
		assert: aNode elements isEmpty;
		assert: aNode firstElement isNil;
		assert: aNode lastElement isNil
]

{ #category : #assertions }
XMLNodeWithElementsTest >> assertNodeHasNoStringNodes: aNode [
	self
		deny: aNode hasStringNodes;
		assert: aNode stringNodes isEmpty;
		assert: aNode strings isEmpty
	
]

{ #category : #accessing }
XMLNodeWithElementsTest >> newElements: aNumber [
	^ self
		createNodes: aNumber
		with: [:i | XMLElement named: 'testElement', i printString]
]

{ #category : #accessing }
XMLNodeWithElementsTest >> newElementsNamed: aNameArray [
	| names qualifiedName element |

	names := aNameArray asOrderedCollection.
	^ XMLOrderedList newFrom:
		(self
			createNodes: aNameArray size
			with: [
				((qualifiedName := names removeFirst) includes: $:)
					ifTrue: [
						element := XMLElement
							name: qualifiedName
							namespaceURI: 'http://', (qualifiedName qualifiedNamePrefix)]
					ifFalse: [element := XMLElement named: qualifiedName].
				element]).
]

{ #category : #accessing }
XMLNodeWithElementsTest >> newNodeWithElements [
	^ self nodeClass new
		addNode: (XMLComment string: 'before');
		addNode:
			((XMLElement name: 'root')
				addNode:
					((XMLElement named: 'one')
						addNode: (XMLString string: 'testing one');
						addNode: (XMLElement named: 'two');
						addNode: (XMLPI target: 'target' data: 'data');
						yourself);
				addNode:
					((XMLElement name: 'three' namespaceURI: 'testNS')
						addNode: (XMLElement name: 'four');
						addNode: (XMLCData string: 'testing two');
						yourself);
				addNode:
					((XMLElement name: 'prefix:four' namespaceURI: 'testNS')
						addNode: (XMLElement name: 'prefix:five' namespaceURI: 'testNS');
						yourself);
				addNode: (XMLElement name: 'four');
				yourself);
		addNode: (XMLComment string: 'after');
		yourself.
]

{ #category : #accessing }
XMLNodeWithElementsTest >> newNodeWithNodes [
	^ self newNodeWithElements
]

{ #category : #accessing }
XMLNodeWithElementsTest >> nodeClass [
	^ XMLNodeWithElements
]

{ #category : #assertions }
XMLNodeWithElementsTest >> should: aBlock addElement: anElement to: aParent [
	self should: aBlock addElements: (Array with: anElement) to: aParent
]

{ #category : #assertions }
XMLNodeWithElementsTest >> should: aBlock addElements: anElementCollection to: aParent [
	| elementsAdded |

	self deny: (anElementCollection anySatisfy: [:each | aParent elements includes: each]).
	self
		should: [elementsAdded := aBlock value]
		addNodes: anElementCollection
		to: aParent.
	elementsAdded isCollection
		ifFalse: [elementsAdded := Array with: elementsAdded].
	self
		assert: elementsAdded asArray = anElementCollection asArray;
		assert: (elementsAdded allSatisfy: [:each | aParent elements includes: each]).
]

{ #category : #assertions }
XMLNodeWithElementsTest >> should: aBlock removeElement: anElement from: aParent [
	self should: aBlock removeElements: (Array with: anElement) from: aParent
]

{ #category : #assertions }
XMLNodeWithElementsTest >> should: aBlock removeElements: anElementCollection from: aParent [
	| elementsRemoved |

	self assert: (anElementCollection allSatisfy: [:each | aParent elements includes: each]).
	self
		should: [elementsRemoved := aBlock value]
		removeNodes: anElementCollection
		from: aParent.
	elementsRemoved isCollection
		ifFalse: [elementsRemoved := Array with: elementsRemoved].
	self
		assert: elementsRemoved asArray = anElementCollection asArray;
		deny: (elementsRemoved anySatisfy: [:each | aParent elements includes: each]).
]

{ #category : #tests }
XMLNodeWithElementsTest >> test01emptyNodeWithElements [
	self assertNodeHasNoChildren: self nodeClass new
]

{ #category : #tests }
XMLNodeWithElementsTest >> test02addingElements [
	| node nodes elements children |

	node := self nodeClass new.
	elements := self newElements: 6.
	nodes := self newStrings: 6.
	children := self intersperse: elements with: nodes.

	self
		should: [node addNodes: (elements copyFrom: 2 to: 3)]
		addElements: (elements copyFrom: 2 to: 3)
		to: node.
	self
		should: [node addNode: nodes second after: elements second]
		addNode: nodes second
		to: node.
	self
		should: [node addNode: nodes third after: elements third]
		addNode: nodes third
		to: node.
	self
		should: [node addNodeFirst: elements first]
		addElement: elements first
		to: node.
	self
		should: [node addNode: nodes first before: elements second]
		addNode: nodes first
		to: node.
	self
		should: [node nodes add: elements fourth]
		addElement: elements fourth
		to: node.
	self
		should: [node addNode: nodes fourth after: elements fourth]
		addNode: nodes fourth
		to: node.
	self
		should: [node addNode: elements fifth after: nodes fourth]
		addElement: elements fifth
		to: node.
	self
		should: [node addNodes: (nodes allButFirst: 4)]
		addNodes: (nodes allButFirst: 4)
		to: node.
	self
		should: [node addNode: (elements sixth) before: nodes sixth]
		addElement: elements sixth
		to: node.

	self
		assertNode: node hasChildren: children;
		assertNode: node hasElements: elements.

	self
		should: [node addNode: (XMLElement new parent: self nodeClass new)] raise: Error;
		should: [node addNode: elements first] raise: Error.
]

{ #category : #tests }
XMLNodeWithElementsTest >> test03removingElements [
	| node elements |

	node := self nodeClass new.
	elements := self newElementsNamed: #('testOne' 'testPrefix:testTwo' 'testTwo' 'testThree').
	node addNodes: (self intersperseWithNodes: elements).
	self
		assert: (node removeNode: elements first) == elements first;
		assert: node elements = elements allButFirst;
		assert: (node elementAt: 'testOne') isNil;
		assert: (node elementsAt: 'testOne') isEmpty;
		assert: (node removeNode: elements second) = elements second;
		assert: node elements = (elements last: 2);
		assert: (node elementAt: 'testTwo' namespaceURI: 'http://testPrefix') isNil;
		assert: (node elementsAt: 'testTwo' namespaceURI: 'http://testPrefix') isEmpty;
		assert: (node elementAt: 'testTwo') == elements third;
		assert: (node elementsAt: 'testTwo') = (XMLOrderedList with: elements third);
		assert: (node removeNode: elements third) == elements third;
		assert: node elements = (elements last: 1);
		assert: (node elementAt: 'bar') isNil;
		assert: (node elementsAt: 'bar') isEmpty;
		assert: node firstElement = elements last;
		assert: (node removeNode: elements last) = elements last;
		deny: node hasElements;
		assert: node firstElement isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> test04accessingAdjacentElements [
	| node elements |

	node := self nodeClass new.
	elements := self newElements: 3.
	node addNodes: (self intersperseWithNodes: elements).
	elements do: [:each | | next previous |
		next := elements after: each ifAbsent: [nil].
		previous := elements before: each ifAbsent: [nil].
		
		self
			assert: each nextElement == next;
			assert: each previousElement == previous;
			assert: (node elementAfter: each) == next;
			assert: (node elementBefore: each) == previous].

	self
		assert: (node elementAfter: XMLElement new) isNil;
		assert: (node elementBefore: XMLElement new) isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> test05accessingFirstAndLastElements [
	| node elements |

	node := self nodeClass new.
	self
		assert: node firstElement isNil;
		assert: node lastElement isNil.

	elements := self newElements: 3.
	node addNode: elements first.
	self
		assert: node firstElement == elements first;
		assert: node lastElement == elements first.

	node addNodes: elements allButFirst.
	self
		assert: node firstElement == elements first;
		assert: node lastElement == elements last.

	node removeNode: elements first.
	self
		assert: node firstElement == elements second;
		assert: node lastElement == elements last.

	node removeNodes.
	node addNodes: (self intersperseWithNodes: elements).
	self
		assert: node firstElement == elements first;
		assert: node lastElement == elements last.
]

{ #category : #tests }
XMLNodeWithElementsTest >> test06chlidNodeAndElementEnumeration [
	| node nodes elements |

	node := self nodeClass new.
	self
		should: [:block | node nodesDo: block] enumerate: #();
		should: [:block | node elementsDo: block] enumerate: #().

	elements := self newElements: 3.
	nodes := self intersperseWithNodes: elements.
	node addNodes: nodes.
	self
		should: [:block | node nodesDo: block] enumerate: nodes;
		should: [:block | node elementsDo: block] enumerate: elements.
]

{ #category : #tests }
XMLNodeWithElementsTest >> test07elementAccessing [
	| node elements |

	node := self nodeClass new.
	elements := self newElementsNamed: #('testOne' 'testTwo' 'testPrefix:testOne' 'testThree').
	node addNodes: (self intersperseWithNodes: elements).
	self
		assert: (node elementAt: 'absent') isNil;
		assert: (node elementAt: 'absent' ifAbsent: ['absent']) = 'absent';
		assert: (node elementsAt: 'absent') isEmpty;
		assert: (node elementAt: 'testOne') == elements first;
		assert: (node elementAt: 'testTwo') == elements second;
		assert: (node elementsAt: 'testOne') = ((elements first: 3) copyWithout: elements second);
		assert: (node elementAt: 'testPrefix:testOne') == elements third;
		assert: (node elementsAt: 'testPrefix:testOne') = (XMLOrderedList with: elements third);
		assert: (node elementAt: 'testOne' namespaceURI: 'absent') isNil;
		assert: (node elementAt: 'absent' namespaceURI: 'http://testPrefix') isNil;
		assert: (node elementAt: 'testOne' namespaceURI: 'absent' ifAbsent: ['absent']) = 'absent';
		assert: (node elementAt: 'absent' namespaceURI: 'http://testPrefix' ifAbsent: ['absent']) = 'absent';
		assert: (node elementAt: 'testOne' namespaceURI: 'http://testPrefix') == elements third;
		assert: (node elementsAt: 'testOne' namespaceURI: 'absent') isEmpty;
		assert: (node elementsAt: 'absent' namespaceURI: 'http://testPrefix') isEmpty;
		assert: (node elementsAt: 'testOne' namespaceURI: 'http://testPrefix') = (elements copyFrom: 3 to: 3)
]

{ #category : #tests }
XMLNodeWithElementsTest >> test08firstTagSearching [
	| node elements |

	node := self nodeClass new.
	elements := self newElementsNamed: #('foo' 'bar' 'prefix:foo' 'prefix:bar' 'bar' 'baz').
	node addNodes: (elements first: 2).
	node nodes first addNodes: (elements copyFrom: 3 to: 4).
	node nodes second addNodes: (elements copyFrom: 5 to: 6).
	self
		assert: (node findElementNamed: 'absent') isNil;
		assert: (node findElementNamed: 'foo' with: [:each | false]) isNil.

	self
		assert: (node findElementNamed: 'foo') = elements first;
		assert: (node findElementNamed: 'prefix:bar') = elements fourth;
		assert: (elements first findElementNamed: 'foo') = elements first.
	self assert: (node
		findElementNamed: 'bar'
		with: [:each | each = elements fifth]) = elements fifth.
	self assert: (elements first
		findElementNamed: 'foo'
		with: [:each | each = elements third]) = elements third.
]

{ #category : #tests }
XMLNodeWithElementsTest >> test09tagsNamedSearching [
	| node elements |

	node := self nodeClass new.
	elements := self newElementsNamed: #('foo' 'bar' 'prefix:foo' 'bar' 'prefix:bar' 'baz').
	node addNodes: (elements first: 2).
	node nodes first addNodes: (elements copyFrom: 3 to: 4).
	node nodes second addNodes: (elements copyFrom: 5 to: 6).
	self
		should: [:block | node allElementsNamed: 'absent' do: block] enumerate: #();
		should: [:block | node elementsAt: 'absent' do: block] enumerate: #().

	self
		should: [:block | node allElementsNamed: 'foo' do: block]
		enumerate: (Array with: elements first with: elements third).
	self
		should: [:block | node allElementsNamed: 'prefix:foo' do: block]
		enumerate: (Array with: elements third).
	self
		should: [:block | node firstElement elementsAt: 'foo' do: block]
		enumerate: (Array with: elements third).
]

{ #category : #tests }
XMLNodeWithElementsTest >> test10elementRenaming [
	| node elements |

	node := self nodeClass new.
	elements := self newElementsNamed: #('foo' 'prefix:bar' 'bar' 'baz').
	node addNodes: (self intersperseWithNodes: elements).

	elements first name: 'notfoo'.
	self
		deny: (node includesElement: 'foo');
		assert: (node elementAt: 'foo') isNil;
		assert: (node elementsAt: 'foo') isEmpty;
		assert: (node elementAt: 'notfoo') = elements first.

	elements third name: 'prefix:bar' namespaceURI: 'http://bar'.
	self assert: (node elementsAt: 'prefix:bar') = (elements copyFrom: 2 to: 3).

	elements fourth name: 'bar'.
	self assert: (node elementsAt: 'bar') = elements allButFirst.

	elements fourth name: 'foo'.
	self assert: (node elementAt: 'foo') = elements last.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAddElementNamed [
	| node element |

	node := self nodeClass new.
	(element := node addElementNamed: 'test')
		addElementNamed: 'first';
		declarePrefix: 'prefix' uri: 'ns';
		addElementNamed: 'prefix:second'.
	self assert: element elementNames asArray = #('first' 'prefix:second').
	self
		should: [element addElementNamed: 'undeclared:fourth']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAddElementNamedNamespaceURI [
	| node element |

	node := self nodeClass new.
	(element := node addElementNamed: 'test' namespaceURI: 'defaultNS')
		addElementNamed: 'prefix:first' namespaceURI: 'firstNS';
		addElementNamed: 'second' namespaceURI: 'secondNS'.
	self
		assert: element namespaceURI = 'defaultNS';
		assert: element nodes first name = 'prefix:first';
		assert: element nodes first namespaceURI = 'firstNS';
		assert: element nodes second name = 'second';
		assert: element nodes second namespaceURI = 'secondNS'.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElements [
	| nodeWithElements allElements |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	nodeWithElements isElement
		ifTrue: [
			self assert: allElements first == nodeWithElements.
			allElements removeFirst].
	self assert:
		allElements elementNames asArray =
			#('root' 'one' 'two' 'three' 'four' 'prefix:four' 'prefix:five' 'four').
	self
		assertList: allElements first allElements selects: (allElements copyFrom: 1 to: 8);
		assertList: allElements second allElements selects: (allElements copyFrom: 2 to: 3);
		assertList: allElements third allElements selects: (allElements copyFrom: 3 to: 3);
		assertList: allElements fourth allElements selects: (allElements copyFrom: 4 to: 5);
		assertList: allElements fifth allElements selects: (allElements copyFrom: 5 to: 5);
		assertList: allElements sixth allElements selects: (allElements copyFrom: 6 to: 7);
		assertList: allElements seventh allElements selects: (allElements copyFrom: 7 to: 7);
		assertList: allElements eighth allElements selects: (allElements copyFrom: 8 to: 8).
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsCollect [
	| nodeWithElements allElements |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	self
		assertList: (nodeWithElements allElementsCollect: [:each | each identityHash])
		collects: (allElements collect: [:each | each identityHash]).

	allElements do: [:node |
		self
			assertList: (node allElementsCollect: [:each | each identityHash])
			collects: (node allElements collect: [:each | each identityHash])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsDetect [
	| nodeWithElements allElements detectedElement |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	detectedElement := nodeWithElements allElementsDetect: [:each | each isNamed: 'prefix:four'].
	self
		assert: detectedElement notNil;
		assert: (detectedElement isNamed: 'prefix:four');
		assert: detectedElement == (allElements detect: [:each | each isNamed: 'prefix:four']);
		assert: (nodeWithElements allElementsDetect: [:each | each isNamed: 'absent']) isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsDetectIfNone [
	| nodeWithElements allElements detectedElement |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	detectedElement :=
		nodeWithElements
			allElementsDetect: [:each | each isNamed: 'prefix:four']
			ifNone: [#absent].
	self
		deny: detectedElement = #absent;
		assert: (detectedElement isNamed: 'prefix:four').
	self assert:	
		detectedElement ==
			(allElements
				detect: [:each | each isNamed: 'prefix:four']
				ifNone: [#absent]).
	self assert:
		(nodeWithElements
			allElementsDetect: [:each | each isNamed: 'absent']
			ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsDo [
	| nodeWithElements allElements |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	self
		should: [:block | nodeWithElements allElementsDo: block]
		enumerate: allElements.

	allElements do: [:element |
		self
			should: [:block | element allElementsDo: block]
			enumerate: element allElements].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsNamed [
	| nodeWithElements allElements namedElements |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	namedElements := nodeWithElements allElementsNamed: 'four'. 
	self
		assert: namedElements size = 3;
		assertList: namedElements selects: (allElements select: [:each | each isNamed: 'four']).
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsNamedDo [
	| nodeWithElements allElements namedElements |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	namedElements := nodeWithElements allElementsNamed: 'four'. 
	self
		should: [:block | nodeWithElements allElementsNamed: 'four' do: block]
		enumerate: namedElements.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsNamedNamespaceURI [
	| nodeWithElements allElements namedElements |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	namedElements := nodeWithElements allElementsNamed: 'four' namespaceURI: 'testNS'. 
	self
		assert: namedElements size = 2;
		assertList: namedElements
		selects:
			(allElements select: [:each |
				(each isNamed: 'four')
					and: [each namespaceURI = 'testNS']]).
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllElementsSelect [
	| nodeWithElements allElements |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	self
		assertList: (nodeWithElements allElementsSelect: [:each | each hasChildren])
		selects: (allElements select: [:each | each hasChildren]).

	allElements do: [:node |
		self
			assertList: (node allElementsSelect: [:each | each hasChildren])
			selects: (node allElements select: [:each | each hasChildren])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAllNodes [
	| nodeWithElements allNodes |

	nodeWithElements := self newNodeWithElements.
	allNodes := nodeWithElements allNodes.
	self
		assert: allNodes size = 14;
		assert: (allNodes at: 1) == nodeWithElements;
		assert: (allNodes at: 2) isComment;
		assert: ((allNodes at: 3) isElementNamed: 'root');
		assert: ((allNodes at: 4) isElementNamed: 'one');
		assert: ((allNodes at: 5) isStringNode: 'testing one');
		assert: ((allNodes at: 6) isElementNamed: 'two');
		assert: (allNodes at: 7) isPI;
		assert: ((allNodes at: 8) isElementNamed: 'three');
		assert: ((allNodes at: 9) isElementNamed: 'four');
		assert: ((allNodes at: 10) isStringNode: 'testing two');
		assert: ((allNodes at: 11) isElementNamed: 'prefix:four');
		assert: ((allNodes at: 12) isElementNamed: 'prefix:five');
		assert: ((allNodes at: 13) isElementNamed: 'four');
		assert: (allNodes at: 14) isComment.
	self
		assertList: (allNodes at: 3) allNodes selects: (allNodes copyFrom: 3 to: 13);
		assertList: (allNodes at: 4) allNodes selects: (allNodes copyFrom: 4 to: 7);
		assertList: (allNodes at: 6) allNodes selects: (allNodes copyFrom: 6 to: 6);
		assertList: (allNodes at: 8) allNodes selects: (allNodes copyFrom: 8 to: 10);
		assertList: (allNodes at: 9) allNodes selects: (allNodes copyFrom: 9 to: 9);
		assertList: (allNodes at: 11) allNodes selects: (allNodes copyFrom: 11 to: 12);
		assertList: (allNodes at: 12) allNodes selects: (allNodes copyFrom: 12 to: 12);
		assertList: (allNodes at: 13) allNodes selects: (allNodes copyFrom: 13 to: 13).
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElements [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	self assert:
		descendentElements elementNames asArray =
			#('root' 'one' 'two' 'three' 'four' 'prefix:four' 'prefix:five' 'four').
	self
		assertList: descendentElements first descendentElements selects: (descendentElements copyFrom: 2 to: 8);
		assertList: descendentElements second descendentElements selects: (descendentElements copyFrom: 3 to: 3);
		assertList: descendentElements third descendentElements selects: descendentElements copyEmpty;
		assertList: descendentElements fourth descendentElements selects: (descendentElements copyFrom: 5 to: 5);
		assertList: descendentElements fifth descendentElements selects: descendentElements copyEmpty;
		assertList: descendentElements sixth descendentElements selects: (descendentElements copyFrom: 7 to: 7);
		assertList: descendentElements seventh descendentElements selects: descendentElements copyEmpty;
		assertList: descendentElements eighth descendentElements selects: descendentElements copyEmpty.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsCollect [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	self
		assertList: (nodeWithElements descendentElementsCollect: [:each | each identityHash])
		collects: (descendentElements collect: [:each | each identityHash]).

	descendentElements do: [:node |
		self
			assertList: (node descendentElementsCollect: [:each | each identityHash])
			collects: (node descendentElements collect: [:each | each identityHash])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsDetect [
	| nodeWithElements descendentElements detectedElement |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	detectedElement := nodeWithElements descendentElementsDetect: [:each | each isNamed: 'prefix:four'].
	self
		assert: detectedElement notNil;
		assert: (detectedElement isNamed: 'prefix:four');
		assert: detectedElement == (descendentElements detect: [:each | each isNamed: 'prefix:four']);
		assert: (detectedElement descendentElementsDetect: [:each | each isNamed: 'prefix:four']) isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsDetectIfNone [
	| nodeWithElements descendentElements detectedElement |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	detectedElement :=
		nodeWithElements
			descendentElementsDetect: [:each | each isNamed: 'prefix:four']
			ifNone: [#absent].
	self
		deny: detectedElement = #absent;
		assert: (detectedElement isNamed: 'prefix:four').
	self assert:	
		detectedElement ==
			(descendentElements
				detect: [:each | each isNamed: 'prefix:four'] 
				ifNone: [#absent]).
	self assert:
		(detectedElement
			descendentElementsDetect: [:each | each isNamed: 'prefix:four']
			ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsDo [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	self
		should: [:block | nodeWithElements descendentElementsDo: block]
		enumerate: descendentElements.

	descendentElements do: [:element |
		self
			should: [:block | element descendentElementsDo: block]
			enumerate: element descendentElements].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsNamed [
	| nodeWithElements descendentElements namedElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	namedElements := nodeWithElements descendentElementsNamed: 'four'. 
	self
		assert: namedElements size = 3;
		assertList: namedElements selects: (descendentElements
		select: [:each | each isNamed: 'four']).

	namedElements do: [:each |
		self assert: (each descendentElementsNamed: 'four') isEmpty]
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsNamedDo [
	| nodeWithElements descendentElements namedElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	namedElements := nodeWithElements descendentElementsNamed: 'four'. 
	self
		should: [:block | nodeWithElements descendentElementsNamed: 'four' do: block]
		enumerate: namedElements.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsNamedNamespaceURI [
	| nodeWithElements descendentElements namedElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	namedElements :=
		nodeWithElements
			descendentElementsNamed: 'four'
			namespaceURI: 'testNS'. 
	self
		assert: namedElements size = 2;
		assertList: namedElements
		selects:
			(descendentElements select: [:each |
				(each isNamed: 'four')
					and: [each namespaceURI = 'testNS']]).
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsSelect [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	self
		assertList: (nodeWithElements descendentElementsSelect: [:each | each hasChildren])
		selects: (descendentElements select: [:each | each hasChildren]).

	descendentElements do: [:node |
		self
			assertList: (node descendentElementsSelect: [:each | each hasChildren])
			selects: (node descendentElements select: [:each | each hasChildren])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testInnerXML [
	| node element |

	node := self nodeClass new.
	element :=
		node addNode:
			(XMLElement name: 'test' namespaces: (Array with: 'prefix'-> 'ns')).
	element innerXML: '<prefix:inner></prefix:inner>'.
	element firstNode innerXML: 'test<!--comment-->'.
	self
		assert: element nodes size = 1;
		assert: (element firstNode isNamed: 'prefix:inner');
		assert: (element firstNode contentString = 'test');
		assert: node innerXML = '<test xmlns:prefix="ns"><prefix:inner>test</prefix:inner></test>';
		assert: element innerXML = '<prefix:inner xmlns:prefix="ns">test</prefix:inner>';
		assert: element firstNode innerXML = 'test'.
]

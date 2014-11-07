"
Abstract, do not run.
"
Class {
	#name : #XMLNodesWithElementsTest,
	#superclass : #XMLNodesWithChildrenTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLNodesWithElementsTest class >> isAbstract [
	^ true
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertList: aList collects: aSecondList [
	self
		assert: aList = aSecondList;
		assert: aList class == self collectNodeListClass.
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertList: aList selects: aSecondList [
	self
		assert: aList = aSecondList;
		assert: aList class == self selectNodeListClass.
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertNode: aNode hasElements: anElementCollection [
	self assert: aNode elements asArray = anElementCollection asArray
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertNodeHasNoChildren: aNode [
	super assertNodeHasNoChildren: aNode.
	self assertNodeHasNoContentNodes: aNode
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertNodeHasNoContentNodes: aNode [
	self
		deny: aNode hasContentNodes;
		assert: aNode contentNodes isEmpty;
		assert: aNode contentString isEmpty;
		assertNodeHasNoElements: aNode;
		assertNodeHasNoStringNodes: aNode.
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertNodeHasNoElements: aNode [
	self
		deny: aNode hasElements;
		assert: aNode elements isEmpty;
		assert: aNode firstElement isNil;
		assert: aNode lastElement isNil
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertNodeHasNoStringNodes: aNode [
	self
		deny: aNode hasStringNodes;
		assert: aNode stringNodes isEmpty;
		assert: aNode strings isEmpty
	
]

{ #category : #accessing }
XMLNodesWithElementsTest >> collectNodeListClass [
	^ XMLOrderedList
]

{ #category : #accessing }
XMLNodesWithElementsTest >> newElements: aNumber [
	^ self
		createNodes: aNumber
		with: [:i | XMLElement named: 'testElement', i printString]
]

{ #category : #accessing }
XMLNodesWithElementsTest >> newElementsNamed: aNameArray [
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
XMLNodesWithElementsTest >> newNodesWithElements [
	| node |

	(node := self nodeClass new)
		addNode: (XMLComment string: 'comment');
		addNode:
			((XMLElement name: 'root')
				addNode:
					((XMLElement named: 'a1')
						addNode: (XMLString string: 'test1');
						addNode: (XMLElement named: 'a2');
						addNode: (XMLPI target: 'a3' data: 'data');
						yourself);
				addNode:
					((XMLElement name: 'b1' namespaceURI: 'testNS')
						addNode: (XMLElement name: 'b2');
						addNode: (XMLCData string: 'test2');
						yourself);
				addNode:
					((XMLElement name: 'prefix:c1' namespaceURI: 'testNS')
						addNode: (XMLElement name: 'prefix:c2' namespaceURI: 'testNS');
						yourself);
				addNode: (XMLElement name: 'c1');
				yourself).
	^ node.
]

{ #category : #accessing }
XMLNodesWithElementsTest >> nodeClass [
	^ XMLNodeWithElements
]

{ #category : #accessing }
XMLNodesWithElementsTest >> selectNodeListClass [
	^ XMLNodeList
]

{ #category : #assertions }
XMLNodesWithElementsTest >> should: aBlock addElement: anElement to: aParent [
	self should: aBlock addElements: (Array with: anElement) to: aParent
]

{ #category : #assertions }
XMLNodesWithElementsTest >> should: aBlock addElements: anElementCollection to: aParent [
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
XMLNodesWithElementsTest >> should: aBlock removeElement: anElement from: aParent [
	self should: aBlock removeElements: (Array with: anElement) from: aParent
]

{ #category : #assertions }
XMLNodesWithElementsTest >> should: aBlock removeElements: anElementCollection from: aParent [
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
XMLNodesWithElementsTest >> test01emptyNodeWithElements [
	self assertNodeHasNoChildren: self nodeClass new
]

{ #category : #tests }
XMLNodesWithElementsTest >> test02addingElements [
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
XMLNodesWithElementsTest >> test03removingElements [
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
XMLNodesWithElementsTest >> test04accessingAdjacentElements [
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
XMLNodesWithElementsTest >> test05accessingFirstAndLastElements [
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
XMLNodesWithElementsTest >> test06chlidNodeAndElementEnumeration [
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
XMLNodesWithElementsTest >> test07elementAccessing [
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
XMLNodesWithElementsTest >> test08firstTagSearching [
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
XMLNodesWithElementsTest >> test09tagsNamedSearching [
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
XMLNodesWithElementsTest >> test10elementRenaming [
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
XMLNodesWithElementsTest >> testAddElement [
	| node element |

	node := self nodeClass new.
	(element := node addElementNamed: 'test')
		addElementNamed: 'first';
		declarePrefix: 'prefix' uri: 'ns';
		addElementNamed: 'prefix:second';
		addElementNamed: 'newprefix:third' namespaceURI: 'newNS'.
	self assert: (element elementNames) asArray = #('first' 'prefix:second' 'newprefix:third').

	self
		should: [element addElementNamed: 'undeclared:fourth']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllElements [
	| nodeWithElements allElements |

	nodeWithElements := self newNodesWithElements.
	allElements := nodeWithElements allElements.
	nodeWithElements isElement
		ifTrue: [
			self assert: allElements first == nodeWithElements.
			allElements removeFirst].
	self assert:
		allElements elementNames asArray =
			#('root' 'a1' 'a2' 'b1' 'b2' 'prefix:c1' 'prefix:c2' 'c1').
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
XMLNodesWithElementsTest >> testAllElementsCollect [
	| nodeWithElements allElements |

	nodeWithElements := self newNodesWithElements.
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
XMLNodesWithElementsTest >> testAllElementsDetect [
	| nodeWithElements allElements detectedElement |

	nodeWithElements := self newNodesWithElements.
	allElements := nodeWithElements allElements.
	detectedElement := nodeWithElements allElementsDetect: [:each | each isNamed: 'prefix:c1'].
	self
		assert: detectedElement notNil;
		assert: (detectedElement isNamed: 'prefix:c1');
		assert: detectedElement == (allElements detect: [:each | each isNamed: 'prefix:c1']);
		assert: (nodeWithElements allElementsDetect: [:each | each isNamed: 'absent']) isNil.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllElementsDetectIfNone [
	| nodeWithElements allElements detectedElement |

	nodeWithElements := self newNodesWithElements.
	allElements := nodeWithElements allElements.
	detectedElement :=
		nodeWithElements
			allElementsDetect: [:each | each isNamed: 'prefix:c1']
			ifNone: ['absent'].
	self
		deny: detectedElement = 'absent';
		assert: (detectedElement isNamed: 'prefix:c1').
	self assert:	
		detectedElement ==
			(allElements
				detect: [:each | each isNamed: 'prefix:c1']
				ifNone: ['absent']).
	self assert:
		(nodeWithElements
			allElementsDetect: [:each | each isNamed: 'absent']
			ifNone: ['absent']) = 'absent'.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllElementsDo [
	| nodeWithElements allElements |

	nodeWithElements := self newNodesWithElements.
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
XMLNodesWithElementsTest >> testAllElementsNamed [
	| nodeWithElements allElements namedElements |

	nodeWithElements := self newNodesWithElements.
	allElements := nodeWithElements allElements.
	namedElements := nodeWithElements allElementsNamed: 'c1'. 
	self
		assert: namedElements size = 2;
		assertList: namedElements selects: (allElements select: [:each | each isNamed: 'c1']).
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllElementsNamedDo [
	| nodeWithElements allElements namedElements |

	nodeWithElements := self newNodesWithElements.
	allElements := nodeWithElements allElements.
	namedElements := nodeWithElements allElementsNamed: 'c1'. 
	self
		should: [:block | nodeWithElements allElementsNamed: 'c1' do: block]
		enumerate: namedElements.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllElementsNamedNamespaceURI [
	| nodeWithElements allElements namedElements |

	nodeWithElements := self newNodesWithElements.
	allElements := nodeWithElements allElements.
	namedElements := nodeWithElements allElementsNamed: 'c1' namespaceURI: 'testNS'. 
	self
		assert: namedElements size = 1;
		assertList: namedElements
		selects:
			(allElements select: [:each |
				(each isNamed: 'c1')
					and: [each namespaceURI = 'testNS']]).
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllElementsSelect [
	| nodeWithElements allElements |

	nodeWithElements := self newNodesWithElements.
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
XMLNodesWithElementsTest >> testAllNodes [
	| nodeWithElements allNodes |

	nodeWithElements := self newNodesWithElements.
	allNodes := nodeWithElements allNodes.
	self
		assert: allNodes size = 13;
		assert: (allNodes at: 1) == nodeWithElements;
		assert: (allNodes at: 2) isComment;
		assert: ((allNodes at: 3) isElementNamed: 'root');
		assert: ((allNodes at: 4) isElementNamed: 'a1');
		assert: ((allNodes at: 5) isStringNode: 'test1');
		assert: ((allNodes at: 6) isElementNamed: 'a2');
		assert: (allNodes at: 7) isPI;
		assert: ((allNodes at: 8) isElementNamed: 'b1');
		assert: ((allNodes at: 9) isElementNamed: 'b2');
		assert: ((allNodes at: 10) isStringNode: 'test2');
		assert: ((allNodes at: 11) isElementNamed: 'prefix:c1');
		assert: ((allNodes at: 12) isElementNamed: 'prefix:c2');
		assert: ((allNodes at: 13) isElementNamed: 'c1').
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
XMLNodesWithElementsTest >> testAllNodesCollect [
	| nodeWithElements allNodes |

	nodeWithElements := self newNodesWithElements.
	allNodes := nodeWithElements allNodes.
	self
		assertList: (nodeWithElements allNodesCollect: [:each | each identityHash])
		collects: (allNodes collect: [:each | each identityHash]).

	allNodes do: [:node |
		node isElement
			ifTrue: [
				self
					assertList: (node allNodesCollect: [:each | each identityHash])
					collects: (node allNodes collect: [:each | each identityHash])]].
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllNodesDetect [
	| nodeWithElements allNodes detectedNode |

	nodeWithElements := self newNodesWithElements.
	allNodes := nodeWithElements allNodes.
	detectedNode := nodeWithElements allNodesDetect: [:each | each isCData].
	self
		assert: detectedNode notNil;
		assert: detectedNode isCData;
		assert: detectedNode == (allNodes detect: [:each | each isCData]);
		assert: (nodeWithElements allNodesDetect: [:each | each isDeclaration]) isNil.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllNodesDetectIfNone [
	| nodeWithElements allNodes detectedNode |

	nodeWithElements := self newNodesWithElements.
	allNodes := nodeWithElements allNodes.
	detectedNode :=
		nodeWithElements
			allNodesDetect: [:each | each isCData]
			ifNone: ['absent'].
	self
		deny: detectedNode = 'absent';
		assert: detectedNode isCData;
		assert: detectedNode == (allNodes detect: [:each | each isCData] ifNone: ['absent']);
		assert:
			(nodeWithElements
				allNodesDetect: [:each | each isDeclaration]
				ifNone: ['absent']) = 'absent'.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllNodesDo [
	| nodeWithElements allNodes |

	nodeWithElements := self newNodesWithElements.
	allNodes := nodeWithElements allNodes.
	self
		should: [:block | nodeWithElements allNodesDo: block]
		enumerate: allNodes.

	allNodes do: [:node |
		node isElement
			ifTrue: [
				self
					should: [:block | node allNodesDo: block]
					enumerate: node allNodes]].
]

{ #category : #tests }
XMLNodesWithElementsTest >> testAllNodesSelect [
	| nodeWithElements allNodes |

	nodeWithElements := self newNodesWithElements.
	allNodes := nodeWithElements allNodes.
	self
		assertList: (nodeWithElements allNodesSelect: [:each | each isElement])
		selects: (allNodes select: [:each | each isElement]).

	allNodes do: [:node |
		node isElement
			ifTrue: [
				self
					assertList: (node allNodesSelect: [:each | each isElement])
					selects: (node allNodes select: [:each | each isElement])]].
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentElements [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodesWithElements.
	descendentElements := nodeWithElements descendentElements.
	self assert:
		descendentElements elementNames asArray =
			#('root' 'a1' 'a2' 'b1' 'b2' 'prefix:c1' 'prefix:c2' 'c1').
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
XMLNodesWithElementsTest >> testDescendentElementsCollect [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodesWithElements.
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
XMLNodesWithElementsTest >> testDescendentElementsDetect [
	| nodeWithElements descendentElements detectedElement |

	nodeWithElements := self newNodesWithElements.
	descendentElements := nodeWithElements descendentElements.
	detectedElement := nodeWithElements descendentElementsDetect: [:each | each isNamed: 'prefix:c1'].
	self
		assert: detectedElement notNil;
		assert: (detectedElement isNamed: 'prefix:c1');
		assert: detectedElement == (descendentElements detect: [:each | each isNamed: 'prefix:c1']);
		assert: (detectedElement descendentElementsDetect: [:each | each isNamed: 'prefix:c1']) isNil.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentElementsDetectIfNone [
	| nodeWithElements descendentElements detectedElement |

	nodeWithElements := self newNodesWithElements.
	descendentElements := nodeWithElements descendentElements.
	detectedElement :=
		nodeWithElements
			descendentElementsDetect: [:each | each isNamed: 'prefix:c1']
			ifNone: ['absent'].
	self
		deny: detectedElement = 'absent';
		assert: (detectedElement isNamed: 'prefix:c1').
	self assert:	
		detectedElement ==
			(descendentElements
				detect: [:each | each isNamed: 'prefix:c1'] 
				ifNone: ['absent']).
	self assert:
		(detectedElement
			descendentElementsDetect: [:each | each isNamed: 'prefix:c1']
			ifNone: ['absent']) = 'absent'.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentElementsDo [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodesWithElements.
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
XMLNodesWithElementsTest >> testDescendentElementsNamed [
	| nodeWithElements descendentElements namedElements |

	nodeWithElements := self newNodesWithElements.
	descendentElements := nodeWithElements descendentElements.
	namedElements := nodeWithElements descendentElementsNamed: 'c1'. 
	self
		assert: namedElements size = 2;
		assertList: namedElements selects: (descendentElements
		select: [:each | each isNamed: 'c1']).

	namedElements do: [:each |
		self assert: (each descendentElementsNamed: 'c1') isEmpty]
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentElementsNamedDo [
	| nodeWithElements descendentElements namedElements |

	nodeWithElements := self newNodesWithElements.
	descendentElements := nodeWithElements descendentElements.
	namedElements := nodeWithElements descendentElementsNamed: 'c1'. 
	self
		should: [:block | nodeWithElements descendentElementsNamed: 'c1' do: block]
		enumerate: namedElements.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentElementsNamedNamespaceURI [
	| nodeWithElements descendentElements namedElements |

	nodeWithElements := self newNodesWithElements.
	descendentElements := nodeWithElements descendentElements.
	namedElements := nodeWithElements descendentElementsNamed: 'c1' namespaceURI: 'testNS'. 
	self
		assert: namedElements size = 1;
		assertList: namedElements
		selects:
			(descendentElements select: [:each |
				(each isNamed: 'c1')
					and: [each namespaceURI = 'testNS']]).
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentElementsSelect [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodesWithElements.
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
XMLNodesWithElementsTest >> testDescendentNodes [
	| nodeWithElements descendentNodes |

	nodeWithElements := self newNodesWithElements.
	descendentNodes := nodeWithElements descendentNodes.
	self
		assertList: descendentNodes
		selects: nodeWithElements allNodes allButFirst.

	descendentNodes do: [:node |
		node isElement
			ifTrue: [
				self
					assertList: node descendentNodes
					selects: node allNodes allButFirst]].
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentNodesCollect [
	| nodeWithElements descendentNodes |

	nodeWithElements := self newNodesWithElements.
	descendentNodes := nodeWithElements descendentNodes.
	self
		assertList: (nodeWithElements descendentNodesCollect: [:each | each identityHash])
		collects: (descendentNodes collect: [:each | each identityHash]).

	descendentNodes do: [:node |
		node isElement
			ifTrue: [
				self
					assertList: (node descendentNodesCollect: [:each | each identityHash])
					collects: (node descendentNodes collect: [:each | each identityHash])]].
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentNodesDetect [
	| nodeWithElements descendentNodes detectedNode |

	nodeWithElements := self newNodesWithElements.
	descendentNodes := nodeWithElements descendentNodes.
	detectedNode := nodeWithElements descendentNodesDetect: [:each | each isPI].
	self
		assert: detectedNode notNil;
		assert: detectedNode isPI;
		assert: detectedNode == (descendentNodes detect: [:each | each isPI]);
		assert: (nodeWithElements descendentNodesDetect: [:each | each isDeclaration]) isNil.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentNodesDetectIfNone [
	| nodeWithElements descendentNodes detectedNode |

	nodeWithElements := self newNodesWithElements.
	descendentNodes := nodeWithElements descendentNodes.
	detectedNode :=
		nodeWithElements
			descendentNodesDetect: [:each | each isPI]
			ifNone: ['absent'].
	self
		deny: detectedNode = 'absent';
		assert: detectedNode isPI;
		assert: detectedNode == (descendentNodes detect: [:each | each isPI] ifNone: ['absent']);
		assert:
			(nodeWithElements
				descendentNodesDetect: [:each | each isDeclaration]
				ifNone: ['absent']) = 'absent'.
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentNodesDo [
	| nodeWithElements descendentNodes |

	nodeWithElements := self newNodesWithElements.
	descendentNodes := nodeWithElements descendentNodes.
	self
		should: [:block | nodeWithElements descendentNodesDo: block]
		enumerate: descendentNodes.

	descendentNodes do: [:node |
		node isElement
			ifTrue: [
				self
					should: [:block | node descendentNodesDo: block]
					enumerate: node descendentNodes]].
]

{ #category : #tests }
XMLNodesWithElementsTest >> testDescendentNodesSelect [
	| nodeWithElements descendentNodes |

	nodeWithElements := self newNodesWithElements.
	descendentNodes := nodeWithElements descendentNodes.
	self
		assertList: (nodeWithElements descendentNodesSelect: [:each | each isElement])
		selects: (descendentNodes select: [:each | each isElement]).

	descendentNodes do: [:node |
		node isElement
			ifTrue: [
				self
					assertList: (node descendentNodesSelect: [:each | each isElement])
					selects: (node descendentNodes select: [:each | each isElement])]].
]

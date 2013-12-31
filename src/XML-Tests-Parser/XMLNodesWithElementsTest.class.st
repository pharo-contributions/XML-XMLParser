Class {
	#name : #XMLNodesWithElementsTest,
	#superclass : #XMLNodesWithChildrenTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #assertions }
XMLNodesWithElementsTest >> assertDocument: aDocument hasDoctype: aDoctype version: aVersion encoding: anEncoding [
	self
		assert: aDocument doctypeDeclaration = aDoctype;
		assert: aDocument version = aVersion;
		assert: aDocument encoding = anEncoding
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
		assertNodeHasNoElements: aNode
]

{ #category : #assertions }
XMLNodesWithElementsTest >> assertNodeHasNoElements: aNode [
	self
		deny: aNode hasElements;
		assert: aNode elements isEmpty;
		assert: aNode firstElement isNil;
		assert: aNode lastElement isNil
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
						qualifiedName splitQualifiedNameInto: [:prefix :localPart |
							element := XMLElement
								name: qualifiedName
								namespaceURI: 'http://', prefix]]
					ifFalse: [element := XMLElement named: qualifiedName].
				element]).
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
	self assertNodeHasNoChildren: XMLMockNodeWithElements new
]

{ #category : #tests }
XMLNodesWithElementsTest >> test02addingElements [
	| node nodes elements children |

	node := XMLMockNodeWithElements new.
	elements := self newElements: 6.
	nodes := self newNodes: 6.
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
		should: [node addElement: elements fourth. elements fourth]
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
		should: [node addNode: (XMLElement new parent: XMLMockNode new)] raise: Error;
		should: [node addNode: elements first] raise: Error.
]

{ #category : #tests }
XMLNodesWithElementsTest >> test03removingElements [
	| node nodes elements |

	node := XMLMockNodeWithElements new.
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

	node := XMLMockNodeWithElements new.
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

	node := XMLMockNodeWithElements new.
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

	node := XMLMockNodeWithElements new.
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
	| node nodes elements |

	node := XMLMockNodeWithElements new.
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

	node := XMLMockNodeWithElements new.
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

	node := XMLMockNodeWithElements new.
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
	| node nodes elements |

	node := XMLMockNodeWithElements new.
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
XMLNodesWithElementsTest >> test11documentTest [
	| doc root doctype |

	doc := XMLDocument new.
	root := XMLElement new.
	doctype := XMLDoctypeDeclaration root: 'root' publicID: 'public' systemID: 'system'.
	self
		assert: doc isDocument;
		assert: doc root isNil;
		assert: (doc addElement: root) root = root;
		assertDocument: doc hasDoctype: nil version: nil encoding: 'UTF-8'.

	self
		assertDocument: (doc doctypeDeclaration: doctype)
		hasDoctype: doctype
		version: nil
		encoding: 'UTF-8'.
	self
		assertDocument: (doc version: 1.0)
		hasDoctype: doctype
		version: 1.0
		encoding: 'UTF-8'.
	self
		assertDocument: (doc encoding: 'ISO Latin-1')
		hasDoctype: doctype
		version: 1.0
		encoding: 'ISO Latin-1'.
]

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

{ #category : #'instance creation' }
XMLNodeWithElementsTest >> newNodeWithElements [
	^ self nodeClass new
		addNode: (XMLComment string: 'before');
		addNode:
			((XMLElement name: 'root')
				addNode: (XMLComment string: 'before');
				addNode:
					((XMLElement named: 'one')
						attributeAt: 'one' put: '1';
						addNode: (XMLString string: 'testing one');
						addNode: (XMLElement named: 'two');
						addNode: (XMLPI target: 'target' data: 'data');
						yourself);
				addNode: (XMLString string: 'testing two');
				addNode:
					((XMLElement name: 'three' namespaceURI: 'testNS')
						addNode: (XMLElement name: 'four');
						addNode: (XMLCData string: 'testing three');
						yourself);
				addNode:
					((XMLElement name: 'prefix:four' namespaceURI: 'testNS')
						attributeAt: 'four' put: '4';
						addNode: (XMLElement name: 'prefix:five' namespaceURI: 'testNS');
						yourself);
				addNode: (XMLElement name: 'four');
				yourself);
		addNode: (XMLComment string: 'after');
		yourself.
]

{ #category : #'instance creation' }
XMLNodeWithElementsTest >> newNodeWithNodes [
	^ self newNodeWithElements
]

{ #category : #accessing }
XMLNodeWithElementsTest >> nodeClass [
	^ XMLNodeWithElements
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAddContent [
	| node |

	node := self nodeClass new.
	node addContent: 'one'.
	self
		assert: node nodes size = 1;
		assert: (node firstNode isStringNode: 'one').
	node addContent: 'two' asXMLString.
	self
		assert: node nodes size = 1;
		assert: (node firstNode isStringNode: 'onetwo').

	node addNode: (XMLElement named: 'three').
	self
		assert: node nodes size = 2;
		assert: (node firstNode isStringNode: 'onetwo');
		assert: (node nodes second isElementNamed: 'three').

	node
		addContent: (XMLCData string: 'four');
		addContent: (XMLString string: 'five').
	self
		assert: node nodes size = 4;
		assert: (node firstNode isStringNode: 'onetwo');
		assert: (node nodes second isElementNamed: 'three');
		assert: (node nodes third isCData and: [node nodes third string = 'four']);
		assert: (node nodes fourth isStringNode: 'five').
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
		(allElements collect: [:each | each name]) asArray =
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
	self assert: (nodeWithElements allElementsNamed: 'absent') isEmpty.

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
	self
		should: [:block | nodeWithElements allElementsNamed: 'absent' do: block]
		enumerate: #().

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
	self assert: (nodeWithElements allElementsNamed: 'four' namespaceURI: 'absent') isEmpty.

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
		assert: allNodes size = 16;
		assert: (allNodes at: 1) == nodeWithElements;
		assert: (allNodes at: 2) isComment;
		assert: ((allNodes at: 3) isElementNamed: 'root');
		assert: (allNodes at: 4) isComment;
		assert: ((allNodes at: 5) isElementNamed: 'one');
		assert: ((allNodes at: 6) isStringNode: 'testing one');
		assert: ((allNodes at: 7) isElementNamed: 'two');
		assert: (allNodes at: 8) isPI;
		assert: ((allNodes at: 9) isStringNode: 'testing two');
		assert: ((allNodes at: 10) isElementNamed: 'three');
		assert: ((allNodes at: 11) isElementNamed: 'four');
		assert: ((allNodes at: 12) isStringNode: 'testing three');
		assert: ((allNodes at: 13) isElementNamed: 'prefix:four');
		assert: ((allNodes at: 14) isElementNamed: 'prefix:five');
		assert: ((allNodes at: 15) isElementNamed: 'four');
		assert: (allNodes at: 16) isComment.
	self
		assertList: (allNodes at: 3) allNodes selects: (allNodes copyFrom: 3 to: 15);
		assertList: (allNodes at: 5) allNodes selects: (allNodes copyFrom: 5 to: 8);
		assertList: (allNodes at: 7) allNodes selects: (allNodes copyFrom: 7 to: 7);
		assertList: (allNodes at: 10) allNodes selects: (allNodes copyFrom: 10 to: 12);
		assertList: (allNodes at: 11) allNodes selects: (allNodes copyFrom: 11 to: 11);
		assertList: (allNodes at: 13) allNodes selects: (allNodes copyFrom: 13 to: 14);
		assertList: (allNodes at: 14) allNodes selects: (allNodes copyFrom: 14 to: 14);
		assertList: (allNodes at: 15) allNodes selects: (allNodes copyFrom: 15 to: 15).
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAncestorElements [
	| nodeWithElements ancestorStack |

	super testAncestorElements.

	nodeWithElements := self newNodeWithElements.
	ancestorStack := OrderedCollection new.
	nodeWithElements allNodesDo: [:each |
		[ancestorStack isEmpty
			or: [ancestorStack last == each parent]]
			whileFalse: [ancestorStack removeLast].
		self assert:
			each ancestorElements asOrderedCollection =
				ancestorStack reversed.
		each isElement
			ifTrue: [ancestorStack addLast: each]].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testAncestorElementsDo [
	| nodeWithElements |

	super testAncestorElementsDo.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each |
		self
			should: [:block | each ancestorElementsDo: block]
			enumerate: each ancestorElements].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testConfiguration [
	| nodeWithElements configuration newConfiguration |

	nodeWithElements := self newNodeWithElements.
	configuration := nodeWithElements configuration.
	self assert: configuration class == XMLDOMConfiguration.
	nodeWithElements allElementsDo: [:element |
		self assert: element configuration == configuration.
		element attributeNodes do: [:each |
			self assert: each configuration == configuration]].

	newConfiguration := XMLDOMConfiguration new.
	nodeWithElements configuration: newConfiguration.
	self assert: nodeWithElements configuration == newConfiguration.
	nodeWithElements allElementsDo: [:element |
		self assert: element configuration == newConfiguration.
		element attributeNodes do: [:each |
			self assert: each configuration == newConfiguration]].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testContentNodes [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		assertList: nodeWithElements contentNodes
		selects: (nodeWithElements nodes select: [:each | each isContentNode]).
	nodeWithElements allElementsDo: [:element |
		self
			assertList: element contentNodes
			selects: (element nodes select: [:each | each isContentNode])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testContentNodesDo [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		should: [:block | nodeWithElements contentNodesDo: block]
		enumerate: nodeWithElements contentNodes.
	nodeWithElements allElementsDo: [:each |
		self
			should: [:block | each contentNodesDo: block]
			enumerate: each contentNodes].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testContentString [
	self
		assert: self newNodeWithElements contentString = 'testing one testing two testing three';
		assert: (self newNodeWithElements contentString: 'new') contentString = 'new'
]

{ #category : #tests }
XMLNodeWithElementsTest >> testContentStringAt [
	| root |

	root := self newNodeWithElements firstElement.
	root elementsDo: [:each |
		self assert: (root contentStringAt: each name) = each contentString].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElements [
	| nodeWithElements descendentElements |

	nodeWithElements := self newNodeWithElements.
	descendentElements := nodeWithElements descendentElements.
	self assert:
		(descendentElements collect: [:each | each name]) asArray =
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
	self assert: (nodeWithElements descendentElementsNamed: 'absent') isEmpty.

	descendentElements := nodeWithElements descendentElements.
	namedElements := nodeWithElements descendentElementsNamed: 'four'. 
	self assert: namedElements size = 3.
	self
		assertList: namedElements
		selects: (descendentElements select: [:each | each isNamed: 'four']).

	namedElements do: [:each |
		self assert: (each descendentElementsNamed: 'four') isEmpty]
]

{ #category : #tests }
XMLNodeWithElementsTest >> testDescendentElementsNamedDo [
	| nodeWithElements descendentElements namedElements |

	nodeWithElements := self newNodeWithElements.
	self
		should: [:block | nodeWithElements descendentElementsNamed: 'absent' do: block]
		enumerate: #().

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
	self assert:
		(nodeWithElements
			descendentElementsNamed: 'four'
			namespaceURI: 'absent') isEmpty.

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
XMLNodeWithElementsTest >> testElementAfter [
	| root elementAfter |

	root := self newNodeWithElements firstElement.
	elementAfter := nil.
	root elements reverseDo: [:each |
		self assert: (root elementAfter: each) == elementAfter.
		elementAfter := each].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementAt [
	| root  |

	root := self newNodeWithElements firstElement.
	self assert: (root elementAt: 'absent') isNil.
	root elements do: [:each |
		self assert:
			(root elementAt: each name) ==
				(root elements detect: [:element | element isNamed: each name])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementAtIfAbsent [
	| root  |

	root := self newNodeWithElements firstElement.
	self assert: (root elementAt: 'absent' ifAbsent: [#absent]) = #absent.
	root elements do: [:each |
		self assert:
			(root elementAt: each name ifAbsent: [#absent]) ==
				(root elements detect: [:element | element isNamed: each name])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementAtNamespaceURI [
	| root element |

	root := self newNodeWithElements firstElement.
	self assert: (root elementAt: 'four' namespaceURI: 'absent') isNil.

	element := root elementAt: 'four' namespaceURI: 'testNS'.
	self deny: element isNil.
	self assert:
		element ==
			(root elements detect: [:each |
				(each isNamed: 'four') and: [each namespaceURI = 'testNS']]).

	root removeNode: element.
	self deny: (root elementAt: 'four' namespaceURI: 'testNS') == element.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementAtNamespaceURIIfAbsent [
	| root element |

	root := self newNodeWithElements firstElement.
	self assert:
		(root
			elementAt: 'four'
			namespaceURI: 'absent'
			ifAbsent: [#absent]) = #absent.

	element := root elementAt: 'four' namespaceURI: 'testNS' ifAbsent: [#absent].
	self deny: element = #absent.
	self assert:
		element ==
			(root elements
				detect: [:each |
					(each isNamed: 'four')
						and: [each namespaceURI = 'testNS']]
				ifNone: [#absent]).

	root removeNode: element.
	self assert:
		(root
			elementAt: 'four'
			namespaceURI: 'testNS'
			ifAbsent: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementBefore [
	| root elementBefore |

	root := self newNodeWithElements firstElement.
	elementBefore := nil.
	root elements do: [:each |
		self assert: (root elementBefore: each) == elementBefore.
		elementBefore := each].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementNames [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		assertList: nodeWithElements elementNames
		collects: (nodeWithElements elements collect: [:each | each name]).
	nodeWithElements allElementsDo: [:element |
		self
			assertList: element elementNames
			collects: (element elements collect: [:each | each name])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementRenamingToNext [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements
		usesNamespaces: false;
		allElementsDo: [:each |
		| parent oldName oldLocalName nextElement |

		((parent := each parent) notNil
			and: [(nextElement := each nextElement) notNil])
			ifTrue: [
				oldName := each name.
				oldLocalName := each localName.
				
				each name: nextElement name.
				each name = oldName
					ifFalse: [
						self
							deny: ((parent elementAt: oldName) == each);
							deny: ((parent elementsAt: oldName) includes: each)].
				each localName = oldLocalName
					ifFalse: [
						self
							deny: ((parent elementAt: oldLocalName) == each);
							deny: ((parent elementsAt: oldLocalName) includes: each)].
				self
					assert: ((parent elementsAt: each name) after: each) == nextElement;
					assert: ((parent elementsAt: each localName) after: each) == nextElement]].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementRenamingToPrevious [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements
		usesNamespaces: false;
		allElementsDo: [:each |
		| parent oldName oldLocalName previousElement |

		((parent := each parent) notNil
			and: [(previousElement := each previousElement) notNil])
			ifTrue: [
				oldName := each name.
				oldLocalName := each localName.
				
				each name: previousElement name.
				each name = oldName
					ifFalse: [
						self
							deny: ((parent elementAt: oldName) == each);
							deny: ((parent elementsAt: oldName) includes: each)].
				each localName = oldLocalName
					ifFalse: [
						self
							deny: ((parent elementAt: oldLocalName) == each);
							deny: ((parent elementsAt: oldLocalName) includes: each)].
				self
					assert: ((parent elementsAt: each name) before: each) == previousElement;
					assert: ((parent elementsAt: each localName) before: each) == previousElement]].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElements [
	| nodeWithElmeents |

	nodeWithElmeents := self newNodeWithElements.
	self
		assertList: nodeWithElmeents elements 
		selects: (nodeWithElmeents nodes select: [:each | each isElement]).
	nodeWithElmeents allElementsDo: [:element |
		self
			assertList: element elements 
			selects: (element nodes select: [:each | each isElement])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsAt [
	| root namedElements |

	root := self newNodeWithElements firstElement.
	self assert: (root elementsAt: 'absent') isEmpty.

	namedElements := root elementsAt: 'four'.
	self assert: namedElements size = 2.
	self
		assertList: namedElements
		selects: (root elements select: [:each | each isNamed: 'four']).

	(namedElements := namedElements copy) do: [:each |
		root removeNode: each.
		self
			assertList: (root elementsAt: 'four')
			selects: (namedElements copyAfter: each)].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsAtDo [
	| root namedElements |

	root := self newNodeWithElements firstElement.
	self
		should: [:block | root elementsAt: 'absent' do: block]
		enumerate: #().
	namedElements := root elementsAt: 'four'.
	self
		should: [:block | root elementsAt: 'four' do: block]
		enumerate: namedElements.

	(namedElements := namedElements copy) do: [:each |
		root removeNode: each.
		self
			should: [:block | root elementsAt: 'four' do: block]
			enumerate: (namedElements copyAfter: each)].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsAtNamespaceURI [
	| root namedElements |

	root := self newNodeWithElements firstElement.
	self assert: (root elementsAt: 'four' namespaceURI: 'absent') isEmpty.

	namedElements := root elementsAt: 'four' namespaceURI: 'testNS'.
	self assert: namedElements size = 1.
	self
		assertList: namedElements
		selects:
			(root elements select: [:each |
				(each isNamed: 'four') and: [each namespaceURI = 'testNS']]).

	root removeNode: namedElements first.
	self assert: (root elementsAt: 'four' namespaceURI: 'testNS') isEmpty.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsCollect [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		assertList: (nodeWithElements elementsCollect: [:each | each name])
		collects: (nodeWithElements elements collect: [:each | each name]).
	nodeWithElements allElementsDo: [:element |
		self
			assertList: (element elementsCollect: [:each | each name])
			collects: (element elements collect: [:each | each name])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsDetect [
	| root element |

	root := self newNodeWithElements firstElement.
	element :=
		root elementsDetect: [:each |
			(each isNamed: 'four') and: [each namespaceURI = 'testNS']].
	self deny: element isNil.
	self assert:
		element == 
			(root elements detect: [:each |
				(each isNamed: 'four') and: [each namespaceURI = 'testNS']]).
	self assert:
		(root elementsDetect: [:each |
			(each isNamed: 'four') and: [each namespaceURI = 'absentNS']]) isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsDetectIfNone [
	| root element |

	root := self newNodeWithElements firstElement.
	element :=
		root
			elementsDetect: [:each |
				(each isNamed: 'four') and: [each namespaceURI = 'testNS']]
			ifNone: [#absent].
	self deny: element = #absent.
	self assert:
		element == 
			(root elements
				detect: [:each |
					(each isNamed: 'four') and: [each namespaceURI = 'testNS']]
				ifNone: [#absent]).
	self assert:
		(root
			elementsDetect: [:each |
				(each isNamed: 'four') and: [each namespaceURI = 'absentNS']]
			ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsDo [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		should: [:block | nodeWithElements elementsDo: block]
		enumerate: nodeWithElements elements.

	nodeWithElements allElementsDo: [:each |
		self
			should: [:block | each elementsDo: block]
			enumerate: each elements].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testElementsSelect [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		assertList: (nodeWithElements elementsSelect: [:each | each hasChildren])
		selects: (nodeWithElements elements select: [:each | each hasChildren]).
	nodeWithElements allElementsDo: [:element |
		self
			assertList: (element elementsSelect: [:each | each hasChildren])
			selects: (element elements select: [:each | each hasChildren])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testFindElementNamed [
	| nodeWithElements allElements foundElement |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	foundElement := nodeWithElements findElementNamed: 'four'.
	self
		assert: foundElement notNil;
		assert: (foundElement isNamed: 'four');
		assert: foundElement == (allElements detect: [:each | each isNamed: 'four']);
		assert: (foundElement findElementNamed: 'four') == foundElement;
		assert: (nodeWithElements findElementNamed: 'absent') isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testFindElementNamedNamespaceURI [
	| nodeWithElements allElements foundElement |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	foundElement := nodeWithElements findElementNamed: 'four' namespaceURI: 'testNS'.
	self
		assert: foundElement notNil;
		assert: (foundElement isNamed: 'four').
	self assert:
		foundElement ==
			(allElements detect: [:each |
				(each isNamed: 'four') and: [each namespaceURI = 'testNS']]).
	self
		assert: (foundElement findElementNamed: 'four' namespaceURI: 'testNS') == foundElement;
		assert: (nodeWithElements findElementNamed: 'four' namespaceURI: 'absentNS') isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testFindElementNamedNamespaceURIWith [
	| nodeWithElements allElements foundElement |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	foundElement :=
		nodeWithElements
			findElementNamed: 'four'
			namespaceURI: 'testNS'
			with: [:each | each hasChildren].
	self
		assert: foundElement notNil;
		assert: (foundElement isNamed: 'prefix:four').
	self assert:
		foundElement ==
			(allElements detect: [:each |
				(each isNamed: 'four')
					and: [(each namespaceURI = 'testNS')
						and: [each hasChildren]]]).
	self assert:
		(foundElement
			findElementNamed: 'four'
			namespaceURI: 'testNS'
			with: [:each | each hasChildren]) == foundElement.
	self assert:
		(nodeWithElements 
			findElementNamed: 'four'
			namespaceURI: 'testNS'
			with: [:each | false]) isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testFindElementNamedWith [
	| nodeWithElements allElements foundElement |

	nodeWithElements := self newNodeWithElements.
	allElements := nodeWithElements allElements.
	foundElement := nodeWithElements findElementNamed: 'four' with: [:each | each hasChildren].
	self
		assert: foundElement notNil;
		assert: (foundElement isNamed: 'four').
	self assert:
		foundElement ==
			(allElements detect: [:each | (each isNamed: 'four') and: [each hasChildren]]).
	self
		assert: (foundElement findElementNamed: 'four' with: [:each | each hasChildren]) == foundElement;
		assert: (nodeWithElements findElementNamed: 'four' with: [:each | false]) isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testFirstElement [
	| root |

	root := self newNodeWithElements nodeAt: 2.
	root elements copy do: [:each |
		self  assert: root firstElement == each.
		root removeNode: each].
	self assert: root firstElement isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testHasContentNodes [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self assert: nodeWithElements hasContentNodes.
	nodeWithElements allElementsDo: [:element |
		self assert: element hasContentNodes = element contentNodes notEmpty].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testHasElements [
	self
		deny: self nodeClass new hasElements;
		assert: self newNodeWithElements hasElements;
		deny: self newNodeWithElements removeNodes hasElements
]

{ #category : #tests }
XMLNodeWithElementsTest >> testHasStringNodes [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self deny: nodeWithElements hasStringNodes.
	nodeWithElements allElementsDo: [:element |
		self assert: element hasStringNodes = element stringNodes notEmpty].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testIncludesElement [
	| root |
	
	root := self newNodeWithElements firstElement.
	self deny: (root includesElement: 'absent').
	root elements copy do: [:each |
		self assert: (root includesElement: each name).
		root removeNode: each.
		self deny: (root includesElement: each name)].
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

{ #category : #tests }
XMLNodeWithElementsTest >> testInnerXMLResetting [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		should: [nodeWithElements firstElement innerXML: '<one><two></one></two>']
		raise: XMLWellFormednessException.
	self assert: nodeWithElements printString = self newNodeWithNodes printString.

	self
		should: [nodeWithElements firstElement innerXML: '<one>&invalid;</one>']
		raise: XMLValidationException.
	self assert: nodeWithElements printString = self newNodeWithNodes printString.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testIsContentNode [
	self assert: self nodeClass new isContentNode
]

{ #category : #tests }
XMLNodeWithElementsTest >> testLastElement [
	| root |

	root := self newNodeWithElements nodeAt: 2.
	root elements reversed do: [:each |
		self  assert: root lastElement == each.
		root removeNode: each].
	self assert: root lastElement isNil.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewCData [
	| cdata |

	cdata := self nodeClass new newCData: 'test'.
	self
		assert: cdata isCData;
		assert: cdata string = 'test'.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewComment [
	| comment |

	comment := self nodeClass new newComment: 'test'.
	self
		assert: comment isComment;
		assert: comment string = 'test'.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewDocument [
	| node document |

	node := self nodeClass new.
	document := node newDocument.
	self
		assert: document isDocument;
		assert: document configuration == node configuration;
		assert: document nodeFactory == node nodeFactory.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewElement [
	| node element |

	node := self nodeClass new.
	element := node newElement.
	self
		assert: element isElement;
		assert: element configuration == node configuration;
		assert: element nodeFactory == node nodeFactory.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewElementNamed [
	| node element |

	node := self nodeClass new.
	element := node newElementNamed: 'test'.
	self
		assert: element isElement;
		assert: element configuration == node configuration;
		assert: element nodeFactory == node nodeFactory;
		assert: element name = 'test'.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewElementNamedNamespaceURI [
	| node element |

	node := self nodeClass new.
	element := node newElementNamed: 'prefix:test' namespaceURI: 'prefixNS'.
	self
		assert: element isElement;
		assert: element configuration == node configuration;
		assert: element nodeFactory == node nodeFactory;
		assert: element name = 'prefix:test';
		assert: element namespaceURI = 'prefixNS'.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewPI [
	self assert: self nodeClass new newPI isPI
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNewString [
	| string |

	string := self nodeClass new newString: 'test'.
	self
		assert: string isStringNode;
		assert: string string = 'test'.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testNodeFactory [
	| nodeWithElements newFactory |

	nodeWithElements := self newNodeWithElements.
	newFactory := XMLPluggableNodeFactory new.
	self
		assert: (nodeWithElements nodeFactory isKindOf: XMLNodeFactory);
		assert: (nodeWithElements nodeFactory: newFactory) nodeFactory == newFactory.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testOuterXMLForNode [
	| nodeWithElements root nodes |

	nodeWithElements := self newNodeWithElements.
	root := nodeWithElements firstElement.
	nodes := root nodes copy.
	nodes copy withIndexDo: [:each :i | | innerXML newNode |
		innerXML := '<new', i printString, '>test</new', i printString, '>'.
		root outerXML: innerXML forNode: each.
		newNode := root nodeAt: i.
		self
			assert: newNode printString = innerXML;
			deny: root nodes = nodes.
		nodes at: i put: newNode.
		self assert: root nodes = nodes].

	nodes copy do: [:each |
		root outerXML: '' forNode: each.
		self deny: root nodes = nodes.
		nodes remove: each.
		self assert: root nodes = nodes].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testOuterXMLForNodeResetting [
	| nodeWithElements root |

	nodeWithElements := self newNodeWithElements.
	root := nodeWithElements firstElement.
	self
		should: [
			root
				outerXML: '<one><two></one></two>'
				forNode: root firstNode]
		raise: XMLWellFormednessException.
	self assert: nodeWithElements printString = self newNodeWithNodes printString.

	self
		should: [
			root
				outerXML: '<one>&invalid;</one>'
				forNode: root firstNode]
		raise: XMLValidationException.
	self assert: nodeWithElements printString = self newNodeWithNodes printString.

	self
		should: [
			root
				outerXML: '<one />'
				forNode: self nodeClass new]
		raise: XMLDOMException.
	self assert: nodeWithElements printString = self newNodeWithNodes printString.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testPrintedWithoutSelfClosingTags [
	| nodeWithElements printString |

	nodeWithElements := self newNodeWithElements.
	printString := nodeWithElements printString.
	self deny: printString = nodeWithElements printedWithoutSelfClosingTags.

	nodeWithElements allElementsDo: [:each |
		each hasChildren
			ifFalse: [
				printString :=
					printString
						copyReplaceAll: '<', each name, ' />'
						with: '<', each name, '></', each name, '>']].
	self assert: printString = nodeWithElements printedWithoutSelfClosingTags.
]

{ #category : #tests }
XMLNodeWithElementsTest >> testRawContentString [
	self assert: self newNodeWithElements rawContentString = 'testing onetesting twotesting three'
]

{ #category : #tests }
XMLNodeWithElementsTest >> testStringNodes [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		assertList: nodeWithElements stringNodes
		selects: (nodeWithElements nodes select: [:each | each isStringNode]).
	nodeWithElements allElementsDo: [:element |
		self
			assertList: element stringNodes
			selects: (element nodes select: [:each | each isStringNode])].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testStringNodesDo [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		should: [:block | nodeWithElements stringNodesDo: block]
		enumerate: nodeWithElements stringNodes.
	nodeWithElements allElementsDo: [:each |
		self
			should: [:block | each stringNodesDo: block]
			enumerate: each stringNodes].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testStrings [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		assertList: nodeWithElements strings
		collects: (nodeWithElements stringNodes collect: [:each | each string]).
	nodeWithElements allElementsDo: [:element |
		self
			assertList: element strings
			collects: (element stringNodes collect: [:each | each string]).].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testStringsDo [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self
		should: [:block | nodeWithElements stringsDo: block]
		enumerate: nodeWithElements strings.
	nodeWithElements allElementsDo: [:each |
		self
			should: [:block | each stringsDo: block]
			enumerate: each strings].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testUsesNamespaces [
	| nodeWithElements |

	nodeWithElements := self newNodeWithElements.
	self assert: nodeWithElements usesNamespaces.
	nodeWithElements allElementsDo: [:each |
		self assert: each usesNamespaces].

	nodeWithElements usesNamespaces: false.
	self deny: nodeWithElements usesNamespaces.
	nodeWithElements allElementsDo: [:each |
		self deny: each usesNamespaces.
		self
			shouldnt: [each prefix: 'undeclared']
			raise: XMLNamespaceException].
]

{ #category : #tests }
XMLNodeWithElementsTest >> testValidate [
	super testValidate.
	self
		shouldnt: [self newNodeWithNodes validate]
		raise: XMLValidationException.
]

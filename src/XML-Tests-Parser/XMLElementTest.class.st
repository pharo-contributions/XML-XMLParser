Class {
	#name : #XMLElementTest,
	#superclass : #XMLNodeWithElementsTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLElementTest class >> isAbstract [
	^ false
]

{ #category : #assertions }
XMLElementTest >> assertElement: anElement hasAttributes: anAssociationCollection [
	| attributeNodes |

	self assert: anElement attributeNodes size = anAssociationCollection size.
	attributeNodes := anElement attributeNodes copy.
	anAssociationCollection associationsDo: [:each | | attributeNode |
		attributeNode := attributeNodes removeFirst.
		self
			assert: attributeNode name = each key;
			assert: attributeNode value = each value.]
]

{ #category : #'instance creation' }
XMLElementTest >> newNodeWithElements [
	^ super newNodeWithElements
		name: 'root';
		yourself
]

{ #category : #accessing }
XMLElementTest >> nodeClass [
	^ XMLElement
]

{ #category : #tests }
XMLElementTest >> testAttributeAssociations [
	| element |

	element := self newElementWithAttributes.
	self
		assertList: element attributeAssociations
		collects: (element attributeNodes collect: [:each | each name -> each value]).
]

{ #category : #tests }
XMLElementTest >> testAttributeAt [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes do: [:each |
		self assert: (element attributeAt: each name) == each value].
	self assert: (element attributeAt: 'absent') isEmpty.
]

{ #category : #tests }
XMLElementTest >> testAttributeAtIfAbsent [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes do: [:each |
		self assert:
			(element
				attributeAt: each name
				ifAbsent: [#absent]) == each value].
	self assert: (element attributeAt: 'absent' ifAbsent: [#absent]) = #absent.
]

{ #category : #tests }
XMLElementTest >> testAttributeAtIfAbsentPut [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes do: [:each |
		self assert:
			(element
				attributeAt: each name
				ifAbsentPut: ['newValue']) == each value].
	self
		assert: (element attributeAt: 'newName' ifAbsentPut: ['newValue']) = 'newValue';
		assert: (element attributeAt: 'newName') = 'newValue'.
]

{ #category : #tests }
XMLElementTest >> testAttributeAtPut [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes do: [:each | | newValue |
		newValue := 'new', each value.
		self
			assert: (element attributeAt: each name put: newValue) = newValue;
			assert: (element attributeAt: each name) = newValue].
	self
		assert: (element attributeAt: 'newName' put: 'newValue') = 'newValue';
		assert: (element attributeAt: 'newName') = 'newValue'.
]

{ #category : #tests }
XMLElementTest >> testAttributeListCopying [
	| element attributeListCopy |

	element := self newElementWithAttributes.
	attributeListCopy := element attributeNodes copy.
	self
		assert: attributeListCopy = element attributeNodes;
		deny: attributeListCopy == element attributeNodes;
		assert: attributeListCopy attributeNodesByName = element attributeNodes attributeNodesByName;
		deny: attributeListCopy attributeNodesByName == element attributeNodes attributeNodesByName;
		assert: element attributeNodes observer == element;
		assert: attributeListCopy observer isNil.
]

{ #category : #tests }
XMLElementTest >> testAttributeNames [
	| element |

	element := self newElementWithAttributes.
	self
		assertList: element attributeNames
		collects: (element attributeNodes collect: [:each | each name])
]

{ #category : #tests }
XMLElementTest >> testAttributeNamesAndValuesDo [
	| element pairs |

	pairs := OrderedCollection new.
	XMLElement new attributeNamesAndValuesDo: [:attributeName :attributeValue|
		pairs add: attributeName -> attributeValue].
	self assert: pairs isEmpty.

	element := self newElementWithAttributes.
	element attributeNamesAndValuesDo: [:attributeName :attributeValue|
		pairs add: attributeName -> attributeValue].
	self assert:
		pairs =
			((element attributeNodes collect: [:each |
				each name -> each value]) asOrderedCollection).
]

{ #category : #tests }
XMLElementTest >> testAttributeNamesDo [
	| element |

	element := XMLElement new.
	self
		should: [:block | element attributeNamesDo: block]
		enumerate: #().

	element := self newElementWithAttributes.
	self
		should: [:block | element attributeNamesDo: block]
		enumerate: element attributeNames.
]

{ #category : #tests }
XMLElementTest >> testAttributeNodeAt [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes do: [:each |
		self assert: (element attributeNodeAt: each name) = each].
	self assert:
		(element attributeNodeAt: 'two') = element attributeNodes second.
	self assert:
		(element attributeNodeAt: 'absent') isNil.
]

{ #category : #tests }
XMLElementTest >> testAttributeNodeAtIfAbsent [
	| element  |

	element := self newElementWithAttributes.
	element attributeNodes do: [:each |
		self assert:
			(element
				attributeNodeAt: each name
				ifAbsent: [#absent]) = each].
	self assert:
		(element
			attributeNodeAt: 'two'
			ifAbsent: [#absent]) = element attributeNodes second.
	self assert:
		(element
			attributeNodeAt: 'absent'
			ifAbsent: [#absent]) = #absent.
]

{ #category : #tests }
XMLElementTest >> testAttributeNodeAtNamespaceURI [
	| element |

	element := self newElementWithAttributes.
	self assert:
		(element attributeNodeAt: 'prefix:two' namespaceURI: 'prefixNS') =
			(element attributeNodes third).
	self assert:
		(element attributeNodeAt: 'two' namespaceURI: 'prefixNS') =
			(element attributeNodes third).
	self assert:
		(element attributeNodeAt: 'prefix:two' namespaceURI: 'absent') isNil.
]

{ #category : #tests }
XMLElementTest >> testAttributeNodeAtNamespaceURIIfAbsent [
	| element |

	element := self newElementWithAttributes.
	self assert:
		(element
			attributeNodeAt: 'prefix:two'
			namespaceURI: 'prefixNS'
			ifAbsent: [#absent]) =
				element attributeNodes third.
	self assert:
		(element
			attributeNodeAt: 'two'
			namespaceURI: 'prefixNS'
			ifAbsent: [#absent]) =
				element attributeNodes third.
	self assert:
		(element
			attributeNodeAt: 'prefix:two'
			namespaceURI: 'absent'
			ifAbsent: [#absent]) = #absent.
]

{ #category : #tests }
XMLElementTest >> testAttributeNodes [
	| element nodes |

	element := self newElementWithAttributes.
	nodes := element attributeNodes.
	self
		assert: (nodes isKindOf: XMLAttributeList);
		assert: nodes size = 4.
	self assert:
		(nodes collect: [:each | each name]) asArray =
			#('one' 'two' 'prefix:two' 'prefix:four').
	self assert:
		(nodes collect: [:each | each value]) asArray =
			#('1' '2' '3' '4').
]

{ #category : #tests }
XMLElementTest >> testAttributeNodesAdding [
	| element attributeNodesCopy |

	element := self newElementWithAttributes.
	attributeNodesCopy := element attributeNodes copy.
	attributeNodesCopy do: [:each |
		element attributeNodes addLast: each].
	self assert: element attributeNodes = attributeNodesCopy.

	attributeNodesCopy do: [:each |
		self
			should: [
				self newElementWithAttributes attributeNodes addLast: each]
			raise: XMLDOMException].
]

{ #category : #tests }
XMLElementTest >> testAttributeNodesDo [
	| element |

	element := self nodeClass new.
	self should: [:block | element attributeNodesDo: block] enumerate: #().

	element := self newElementWithAttributes.
	self
		should: [:block | element attributeNodesDo: block]
		enumerate: element attributeNodes.
]

{ #category : #tests }
XMLElementTest >> testAttributeRenaming [
	| elementWithAttributes attributeNodes attributeNode oldSize oldNames oldName |

	elementWithAttributes := self newElementWithAttributes.
	attributeNodes := elementWithAttributes attributeNodes.

	attributeNode := attributeNodes first.
	oldSize := attributeNodes size.
	oldNames := elementWithAttributes attributeNames.
	oldName := attributeNode name.
	attributeNode name: 'newName'.
	self
		assert: attributeNodes size = oldSize;
		assert: attributeNodes first == attributeNode;
		assert: elementWithAttributes attributeNames = (oldNames allButFirst copyWithFirst: 'newName');
		deny: (elementWithAttributes includesAttribute: oldName);
		assert: (elementWithAttributes attributeNodeAt: 'newName') == attributeNode.

	oldNames := elementWithAttributes attributeNames.
	oldName := attributeNode name.
	attributeNode name: oldNames last.
	self
		assert: attributeNodes size = (oldSize - 1);
		assert: attributeNodes first == attributeNode;
		assert:
			elementWithAttributes attributeNames =
				((oldNames copyFrom: 2 to: oldNames size - 1) copyWithFirst: oldNames last);
		deny: (elementWithAttributes includesAttribute: oldName);
		assert: (elementWithAttributes attributeNodeAt: attributeNode name) == attributeNode.

	self should: [attributeNode name: 'undeclared:newName'] raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testAttributeSorting [
	| element |

	element :=
		XMLElement
			name: 'sorted'
			attributes: (Array with: 'c' -> '3' with: 'b' -> '2' with: 'a' -> '1').
	self assert:
		(element attributeNodes sorted
			collect: [:each | each name]) asArray = #('a' 'b' 'c').
	self assert:
		((element attributeNodes sorted: [:a :b | a name <= b name])
			collect: [:each | each name]) asArray = #('a' 'b' 'c').
	"sorted/sorted: should sort copies"
	self assert: element attributeNames asArray = #('c' 'b' 'a').

	element attributeNodes sort.
	self assert: element attributeNames asArray = #('a' 'b' 'c').
	element attributeNodes sort: [:a :b | a name > b name].
	self assert: element attributeNames asArray = #('c' 'b' 'a').
]

{ #category : #tests }
XMLElementTest >> testAttributes [
	| element attributeDictionary |

	element := self newElementWithAttributes.
	attributeDictionary := element attributes.
	self
		assert: attributeDictionary isDictionary;
		assert: attributeDictionary size = element attributeNodes size.
	self assert:
		(element attributeNodes allSatisfy: [:each |
			(attributeDictionary at: each name) = each value]).
]

{ #category : #tests }
XMLElementTest >> testCanonicalPrinting [
	| element |

	element :=
		XMLElement
			name: 'test'
			namespaces: (Array with: 'b' -> 'ns2' with: 'a' -> 'ns1' with: '' -> 'default')
			attributes: (Array with: 'c' -> '3' with: 'b' -> '2' with: 'a' -> '1').

	self assert:
		element printString =
			'<test xmlns:b="ns2" xmlns:a="ns1" xmlns="default" c="3" b="2" a="1" />'.
	self assert:
		element canonicallyPrinted =
			'<test xmlns="default" xmlns:a="ns1" xmlns:b="ns2" a="1" b="2" c="3"></test>'.
]

{ #category : #tests }
XMLElementTest >> testDeclareNamespaces [
	| element |

	element := self nodeClass new.
	element declareNamespaces: self namespaces.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element isDeclaredPrefix: prefix uri: uri)].

	element := self nodeClass new.
	element declareNamespaces: self namespaces associations.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element isDeclaredPrefix: prefix uri: uri)]
]

{ #category : #tests }
XMLElementTest >> testDeclarePrefixURI [
	| element elementsWithDeclaredPrefix |

	(element := self newNodeWithElements)
		declarePrefix: 'newPrefix' uri: 'prefixNS';
		allElementsDo: [:each | self assert: (each isDeclaredPrefix: 'newPrefix' uri: 'prefixNS')];
		declarePrefix: 'newPrefix' uri: 'newPrefixNS';
		allElementsDo: [:each | self assert: (each isDeclaredPrefix: 'newPrefix' uri: 'newPrefixNS')].

	elementsWithDeclaredPrefix :=
		element allElementsSelect: [:each | each prefix = 'prefix'].
	element
		declarePrefix: 'prefix' uri: 'newPrefixNS';
		allElementsDo: [:each |
			(elementsWithDeclaredPrefix includes: each)
				ifTrue: [
					self
						assert: (each isDeclaredPrefix: 'prefix');
						deny: (each isDeclaredPrefix: 'prefix' uri: 'newPrefixNS')]
				ifFalse: [self assert: (each isDeclaredPrefix: 'prefix' uri: 'newPrefixNS')]].

	self
		should: [element declarePrefix: 'nonDefault' uri: '']
		raise: XMLNamespaceException.
	"cannot rebind the xml prefix to a new NS"
	self 
		should: [element declarePrefix: 'xml' uri: 'newNS']
		raise: XMLNamespaceException.
	"cannot rebind the xmlns prefix, even to the same NS"
	self
		should: [element declarePrefix: 'xmlns' uri: XMLNamespaceScope xmlnsNamespaceURI]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testDeclaredPrefixes [
	| element prefixes |

	element := self nodeClass new.
	prefixes := OrderedCollection new.
	self namespaces keysAndValuesDo: [:prefix :uri |
		element
			declarePrefix: prefix
			uri: uri.
		prefixes addLast: prefix.
		self assert: element declaredPrefixes = prefixes asArray].
]

{ #category : #tests }
XMLElementTest >> testDeclaresDefaultNamespace [
	| element |

	element := self newNodeWithElements.
	self deny: element declaresDefaultNamespace.

	element defaultNamespace: 'defaultNS'.
	self assert: element declaresDefaultNamespace.
	element elementsDo: [:each |
		self deny: each declaresDefaultNamespace].

	element elementsDo: [:each |
		each defaultNamespace: 'newDefaultNS'.
		self assert: each declaresDefaultNamespace].

	self assert: element declaresDefaultNamespace.	
	element undeclarePrefix: ''.
	self deny: element declaresDefaultNamespace.
	element elementsDo: [:each |
		self assert: each declaresDefaultNamespace].
]

{ #category : #tests }
XMLElementTest >> testDeclaresPrefixURI [
	| element |

	element := self newNodeWithElements.
	self deny: element declaresDefaultNamespace.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	self assert: (element declaresPrefix: 'prefix' uri: 'prefixNS').
	element elementsDo: [:each |
		self deny: (each declaresPrefix: 'prefix' uri: 'prefixNS')].

	element elementsDo: [:each |
		each declarePrefix: 'prefix' uri: 'newPrefixNS'.
		self assert: (each declaresPrefix: 'prefix' uri: 'newPrefixNS')].

	self assert: (element declaresPrefix: 'prefix' uri: 'prefixNS').
	element undeclarePrefix: 'prefix'.
	self deny: (element declaresPrefix: 'prefix' uri: 'prefixNS').
	element elementsDo: [:each |
		self assert: (each declaresPrefix: 'prefix' uri: 'newPrefixNS')].
]

{ #category : #tests }
XMLElementTest >> testDefaultNamespace [
	| element elementsWithDefaultNamespace |

	element := self newNodeWithElements.
	elementsWithDefaultNamespace :=
		element allElementsSelect: [:each |
			each defaultNamespace notEmpty].

	element
		defaultNamespace: 'newDefaultNS';
		allElementsDo: [:each |
			(elementsWithDefaultNamespace includes: each)
				ifTrue: [self deny: (each defaultNamespace = 'newDefaultNS')]
				ifFalse: [self assert: (each defaultNamespace = 'newDefaultNS')]].

	element
		defaultNamespace: '';
		allElementsDo: [:each |
			(elementsWithDefaultNamespace includes: each)
				ifTrue: [self assert: each defaultNamespace notEmpty]
				ifFalse: [self assert: each defaultNamespace isEmpty]].
]

{ #category : #tests }
XMLElementTest >> testElementSorting [
	| element |

	(element := XMLElement name: 'sorted')
		addElementNamed: 'c';
		addElementNamed: 'b';
		addElementNamed: 'a'.

	self assert: (element nodes sorted collect: [:each | each name]) asArray = #('a' 'b' 'c').
	self assert:
		((element nodes sorted: [:a :b | a name <= b name])
			collect: [:each | each name]) asArray = #('a' 'b' 'c').

	self assert: (element nodesCollect: [:each | each name]) asArray = #('c' 'b' 'a').
	element nodes sort.
	self assert: (element nodesCollect: [:each | each name]) asArray = #('a' 'b' 'c').
	element nodes sort: [:a :b | a name > b name].
	self assert: (element nodesCollect: [:each | each name]) asArray = #('c' 'b' 'a').
]

{ #category : #tests }
XMLElementTest >> testExpandedName [
	| element |

	element := self nodeClass named: 'test'.
	self assert: (element expandedName = 'test').

	element defaultNamespace: 'defaultNS'.
	self assert: (element expandedName = 'Q{defaultNS}test').

	element name: 'prefix:test' namespaceURI: 'prefixNS'.
	self assert: (element expandedName = 'Q{prefixNS}test').

	element
		defaultNamespace: '';
		name: 'test'.
	self assert: (element expandedName = 'test').
]

{ #category : #tests }
XMLElementTest >> testHasAttributes [
	self
		deny: self nodeClass new hasAttributes;
		assert: self newElementWithAttributes hasAttributes;
		deny: self newElementWithAttributes removeAttributes hasAttributes
]

{ #category : #tests }
XMLElementTest >> testHasNamespaceURI [
	| element |

	element := self nodeClass named: 'test'.
	self deny: element hasNamespaceURI.

	element defaultNamespace: 'defaultNS'.
	self assert: element hasNamespaceURI.

	element defaultNamespace: ''.
	self deny: element hasNamespaceURI.

	element name: 'prefix:test' namespaceURI: 'prefixNS'.
	self assert: element hasNamespaceURI.

	element name: 'test'.
	self deny: element hasNamespaceURI.
]

{ #category : #tests }
XMLElementTest >> testHasNamespaces [
	| element |

	element := self nodeClass new.
	self deny: element hasNamespaces.

	element defaultNamespace: 'defaultNS'.
	self assert: element hasNamespaces.

	element undeclarePrefix: ''.
	self deny: element hasNamespaces.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	self assert: element hasNamespaces.

	element undeclarePrefix: 'prefix'.
	self deny: element hasNamespaces.
]

{ #category : #tests }
XMLElementTest >> testHasPrefix [
	| element |

	element := self nodeClass new.
	self deny: element hasPrefix.

	element name: 'one'.
	self deny: element hasPrefix.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	element name: 'prefix:two'.
	self assert: element hasPrefix.

	element name: 'three'.
	self deny: element hasPrefix.
]

{ #category : #tests }
XMLElementTest >> testIncludesAttribute [
	| element |

	element := self newElementWithAttributes.
	element attributeNames do: [:each |
		self assert: (element includesAttribute: each).
		element removeAttribute: each.
		self deny: (element includesAttribute: each)].
]

{ #category : #tests }
XMLElementTest >> testIsDeclaredPrefix [
	| element elementsWithDeclaredPrefix |

	element := self newNodeWithElements.
	elementsWithDeclaredPrefix :=
		element allElementsSelect: [:each | each isDeclaredPrefix: 'prefix'].
	self assert: elementsWithDeclaredPrefix size = 2.

	element allElementsDo: [:each |
		(elementsWithDeclaredPrefix includes: each )
			ifFalse: [self deny: (each isDeclaredPrefix: 'prefix')]].

	element declarePrefix: 'prefix' uri: 'newPrefixNS'.
	element allElementsDo: [:each | self assert: (each isDeclaredPrefix: 'prefix')].

	element undeclarePrefix: 'prefix'.
	element allElementsDo: [:each |
		(elementsWithDeclaredPrefix includes: each )
			ifTrue: [self assert: (each isDeclaredPrefix: 'prefix')]
			ifFalse: [self deny: (each isDeclaredPrefix: 'prefix')]].
]

{ #category : #tests }
XMLElementTest >> testIsDeclaredPrefixURI [
	| element elementsWithDeclaredPrefix oldNamespace |

	element := self newNodeWithElements.
	elementsWithDeclaredPrefix :=
		element allElementsSelect: [:each | each isDeclaredPrefix: 'prefix'].
	oldNamespace := elementsWithDeclaredPrefix anyOne resolvePrefix: 'prefix'.
	self assert: elementsWithDeclaredPrefix size = 2.

	element allElementsDo: [:each |
		self deny: (each isDeclaredPrefix: 'prefix' uri: 'newPrefixNS')].

	element declarePrefix: 'prefix' uri: 'newPrefixNS'.
	element allElementsDo: [:each |
		(elementsWithDeclaredPrefix includes: each )
			ifTrue: [self assert: (each isDeclaredPrefix: 'prefix' uri: oldNamespace)]
			ifFalse: [self assert: (each isDeclaredPrefix: 'prefix' uri: 'newPrefixNS')]].

	element undeclarePrefix: 'prefix'.
	element allElementsDo: [:each |
		(elementsWithDeclaredPrefix includes: each )
			ifTrue: [self assert: (each isDeclaredPrefix: 'prefix' uri: oldNamespace)]
			ifFalse: [self deny: (each isDeclaredPrefix: 'prefix')]].
]

{ #category : #tests }
XMLElementTest >> testIsElement [
	self assert: self nodeClass new isElement
]

{ #category : #tests }
XMLElementTest >> testIsElementNamed [
	| element |

	element := self nodeClass named: 'one'.
	self
		assert: (element isElementNamed: 'one');
		deny: (element isElementNamed: 'two').
	element name: 'one:two' namespaceURI: 'testNS'.
	self
		assert: (element isElementNamed: 'one:two');
		assert: (element isElementNamed: 'two');
		deny: (element isElementNamed: 'one').
]

{ #category : #tests }
XMLElementTest >> testIsElementNamedAny [
	| element |

	element := self nodeClass named: 'one'.
	self
		assert: (element isElementNamedAny: #('two' 'one' 'three'));
		deny: (element isElementNamedAny: #('two' 'three')).
	element name: 'one:two' namespaceURI: 'testNS'.
	self
		assert: (element isElementNamedAny: #('one' 'one:two' 'three'));
		assert: (element isElementNamedAny: #('one' 'two' 'three'));
		deny: (element isElementNamedAny: #('one' 'three')).
]

{ #category : #tests }
XMLElementTest >> testIsInLanguage [
	| nodeWithElements |

	super testIsInLanguage.
	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each |
		self
			deny: (each isInLanguage: 'en-us');
			deny: (each isInLanguage: 'EN-US');
			deny: (each isInLanguage: 'En');
			deny: (each isInLanguage: 'de-de');
			deny: (each isInLanguage: 'DE-DE');
			deny: (each isInLanguage: 'De')].

	nodeWithElements attributeAt: 'xml:lang' put: 'En-Us'.
	nodeWithElements allNodesDo: [:each |
		self
			assert: (each isInLanguage: 'en-us');
			assert: (each isInLanguage: 'EN-US');
			assert: (each isInLanguage: 'En');
			deny: (each isInLanguage: 'de-de');
			deny: (each isInLanguage: 'DE-DE');
			deny: (each isInLanguage: 'De')].
]

{ #category : #tests }
XMLElementTest >> testIsNamed [
	| element |

	element := self nodeClass named: 'one'.
	self
		assert: (element isNamed: 'one');
		deny: (element isNamed: 'two').
	element name: 'one:two' namespaceURI: 'testNS'.
	self
		assert: (element isNamed: 'one:two');
		assert: (element isNamed: 'two');
		deny: (element isNamed: 'one').
]

{ #category : #tests }
XMLElementTest >> testIsNamedAny [
	| element |

	element := self nodeClass named: 'one'.
	self
		assert: (element isNamedAny: #('two' 'one' 'three') asSet);
		deny: (element isNamedAny: #('two' 'three') asSet).

	element name: 'one:two' namespaceURI: 'testNS'.
	self
		assert: (element isNamedAny: #('one' 'one:two' 'three'));
		assert: (element isNamedAny: #('one' 'two' 'three'));
		deny: (element isNamedAny: #('one' 'three')).
]

{ #category : #tests }
XMLElementTest >> testIsRoot [
	| element |

	element := self newNodeWithElements.
	self assert: element allElements first isRoot.
	element descendantElementsDo: [:each |
		self deny: each isRoot].
	(element removeNodes: element elements copy) do: [:each |
		self assert: each isRoot].
]

{ #category : #tests }
XMLElementTest >> testLocalName [
	| element |

	element := self nodeClass new.
	self assert: element name isEmpty.

	element name: 'one'.
	self assert: element localName = 'one'.

	element name: 'two'.
	self assert: element localName = 'two'.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	element name: 'prefix:three'.
	self assert: element localName = 'three'.

	element name: 'four'.
	self assert: element localName = 'four'.
]

{ #category : #tests }
XMLElementTest >> testName [
	| element |

	self
		assert: (self nodeClass name: 'one') name = 'one';
		should: [self nodeClass name: 'unmapped:two'] raise: XMLNamespaceException.
	
	element := self nodeClass new.
	self assert: element name isEmpty.

	element name: 'one'.
	self assert: element name = 'one'.

	element name: 'two'.
	self assert: element name = 'two'.
	self should: [element name: 'unmapped:two'] raise: XMLNamespaceException.

	element usesNamespaces: false.
	self shouldnt: [element name: 'unmapped:three'] raise: XMLNamespaceException.
	self assert: element name = 'unmapped:three'.
]

{ #category : #tests }
XMLElementTest >> testNameAttributes [
	| attributes unprefixedAttributes element |

	attributes := self attributes.
	unprefixedAttributes := self unprefixedAttributes.
	element :=
		self nodeClass
			name: 'one'
			attributes: self unprefixedAttributeAssociations.
	self
		assert: element name = 'one';
		assertElement: element hasAttributes: unprefixedAttributes.

	element := self nodeClass name: 'two' attributes: unprefixedAttributes associations.
	self
		assert: element name = 'two';
		assertElement: element hasAttributes: unprefixedAttributes.

	self
		should: [self nodeClass name: 'undeclared:three' attributes: unprefixedAttributes]
		raise: XMLNamespaceException.
	self
		should: [self nodeClass name: 'four' attributes: attributes]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testNameNamespaceURI [
	| element |

	element := self nodeClass new.
	element name: 'one' namespaceURI: 'defaultNS'.
	self
		assert: element name = 'one';
		assert: element namespaceURI = 'defaultNS'.

	element := self nodeClass name: 'prefix:two' namespaceURI: 'prefixNS'.
	self
		assert: element name = 'prefix:two';
		assert: element namespaceURI = 'prefixNS'.
]

{ #category : #tests }
XMLElementTest >> testNameNamespaceURIAttributes [
	| attributes unprefixedAttributes element |

	attributes := self attributes.
	unprefixedAttributes := self unprefixedAttributes.
	element :=
		self nodeClass
			name: 'prefix:one'
			namespaceURI: 'prefixNS'
			attributes: self attributeAssociations.
	self
		assert: element name = 'prefix:one';
		assert: element namespaceURI = 'prefixNS';
		assertElement: element hasAttributes: attributes.

	element :=
		self nodeClass
			name: 'two'
			namespaceURI: 'prefixNS'
			attributes: unprefixedAttributes.
	self
		assert: element name = 'two';
		assert: element namespaceURI = 'prefixNS';
		assertElement: element hasAttributes: unprefixedAttributes.

	self
		should: [self nodeClass name: 'three' namespaceURI: '' attributes: attributes]
		raise: XMLNamespaceException.
	self
		should: [self nodeClass name: 'four' namespaceURI: 'prefixNS' attributes: attributes]
		raise: XMLNamespaceException.
	self
		should: [self nodeClass name: 'prefix:five' namespaceURI: '' attributes: unprefixedAttributes]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testNameNamespaces [
	| element |
	
	element := self nodeClass name: 'one' namespaces: self namespaces.
	self assert: element namespaceURI = 'defaultNS'.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element isDeclaredPrefix: prefix uri: uri)].

	element := self nodeClass name: 'two' namespaces: self namespaces associations.
	self assert: element namespaceURI = 'defaultNS'.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element isDeclaredPrefix: prefix uri: uri)].

	self
		should: [
			self nodeClass
				name: 'undeclared:three'
				namespaces: self namespaces]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testNameNamespacesAttributes [
	| element |

	element :=
		self nodeClass
			name: 'one'
			namespaces: self namespaces
			attributes: self attributes.
	self
		assert: element namespaceURI = 'defaultNS';
		assertElement: element hasAttributes: self attributes.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element isDeclaredPrefix: prefix uri: uri)].

	element :=
		self nodeClass
			name: 'two'
			namespaces: self namespaces associations
			attributes: self attributes associations.
	self
		assert: element namespaceURI = 'defaultNS';
		assertElement: element hasAttributes: self attributes.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element isDeclaredPrefix: prefix uri: uri)].

	self
		should: [
			self nodeClass
				name: 'undeclared:three'
				namespaces: self namespaces
				attributes: self attributes]
		raise: XMLNamespaceException.
	self
		should: [
			self nodeClass
				name: 'four'
				namespaces: #()
				attributes: self attributes]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testNamed [
	self
		assert: (self nodeClass named: 'test') name = 'test';
		should: [self nodeClass named: 'undeclared:test'] raise: XMLNamespaceException
]

{ #category : #tests }
XMLElementTest >> testNamespaceURI [
	| element |

	element := self nodeClass new.
	self assert: element namespaceURI isEmpty.

	element defaultNamespace: 'defaultNS'.
	self assert: element namespaceURI = 'defaultNS'.

	element name: 'prefix:test' namespaceURI: 'prefixNS'.
	self assert: element namespaceURI = 'prefixNS'.
	
	element
		defaultNamespace: '';
		name: 'test'.
	self assert: element namespaceURI isEmpty.
]

{ #category : #tests }
XMLElementTest >> testNextElement [ 
	| root nextElement |

	root := self newNodeWithElements firstElement.
	nextElement := nil.
	root elements reverseDo: [:each |
		self assert: each nextElement == nextElement.
		nextElement := each].
]

{ #category : #tests }
XMLElementTest >> testPrefix [
	| element |

	element := self nodeClass new.
	self assert: element prefix isEmpty.

	element name: 'one'.
	self assert: element prefix isEmpty.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	element name: 'prefix:two'.
	self assert: element prefix = 'prefix'.

	element name: 'three'.
	self assert: element prefix isEmpty.
]

{ #category : #tests }
XMLElementTest >> testPreviousElement [ 
	| root previousElement |

	root := self newNodeWithElements firstElement.
	previousElement := nil.
	root elements do: [:each |
		self assert: each previousElement == previousElement.
		previousElement := each].
]

{ #category : #tests }
XMLElementTest >> testPrintingDefaultNamespaces [
	| element |

	element :=
		XMLElement
			name: 'element'
			namespaceURI: 'default'.
	element addNode:
		((XMLElement
			name: 'element'
			namespaceURI: '')
			addElementNamed: 'empty';
			yourself).

	self assert:
		element printString =
			('<element xmlns="default">',
			'<element xmlns=""><empty /></element>',
			'</element>').
]

{ #category : #tests }
XMLElementTest >> testPrintingNonRootNamespaces [
	| element |

	element :=
		XMLElement
			name: 'element'.
	element addNode:
		(XMLElement
			name: 'used:empty'
			namespaces: (Array with: '' -> 'defaultNS' with: 'used' -> 'usedNS')).

	self assert:
		element printString =
			('<element>',
			'<used:empty xmlns="defaultNS" xmlns:used="usedNS" />',
			'</element>').
]

{ #category : #tests }
XMLElementTest >> testPrintingRootNamespaces [
	| element |

	element :=
		XMLElement
			name: 'used:element'
			namespaces: (Array with: '' -> 'defaultNS' with: 'used' -> 'usedNS').
	element addElementNamed: 'empty'.

	self assert:
		element printString =
			('<used:element xmlns="defaultNS" xmlns:used="usedNS">',
			'<empty />',
			'</used:element>').
]

{ #category : #tests }
XMLElementTest >> testRemoveAttribute [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes copy do: [:each |
		self
			assert: (element removeAttribute: each name) = each value;
			should: [element removeAttribute: each name] raise: Error;
			deny: (element includesAttribute: each name)].
	self assert: element attributeNodes isEmpty.
]

{ #category : #tests }
XMLElementTest >> testRemoveAttributeIfAbsent [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes copy do: [:each |
		self
			assert: (element removeAttribute: each name ifAbsent: [#absent]) = each value;
			assert: (element removeAttribute: each name ifAbsent: [#absent]) = #absent;
			deny: (element includesAttribute: each name)].
	self assert: element attributeNodes isEmpty.
]

{ #category : #tests }
XMLElementTest >> testRemoveAttributeNode [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes copy do: [:each |
		self
			assert: (element removeAttributeNode: each) == each ;
			should: [element removeAttribute: each] raise: Error;
			deny: (element attributeNodes includes: each)].
	self assert: element attributeNodes isEmpty.
]

{ #category : #tests }
XMLElementTest >> testRemoveAttributeNodeIfAbsent [
	| element |

	element := self newElementWithAttributes.
	element attributeNodes copy do: [:each |
		self
			assert: (element removeAttributeNode: each ifAbsent: [#absent]) == each ;
			assert: (element removeAttributeNode: each ifAbsent: [#absent]) = #absent;
			deny: (element attributeNodes includes: each)].
	self assert: element attributeNodes isEmpty.
]

{ #category : #tests }
XMLElementTest >> testRemoveAttributes [
	| element |

	element := self newElementWithAttributes.
	self
		assert: element removeAttributes == element;
		assert: element attributeNodes isEmpty;
		deny: element hasAttributes.
]

{ #category : #tests }
XMLElementTest >> testResolvePrefix [
	| element |

	element := self nodeClass new.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element resolvePrefix: prefix) = ''.
		element declarePrefix: prefix uri: uri.
		self assert: (element resolvePrefix: prefix) = uri].

	self assert:
		(element resolvePrefix: 'xml') = XMLNamespaceScope xmlNamespaceURI.

	self assert:
		(element resolvePrefix: 'xmlns') = XMLNamespaceScope xmlnsNamespaceURI.
]

{ #category : #tests }
XMLElementTest >> testResolvePrefixIfUnresolvable [
	| element |

	element := self nodeClass new.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert:
			(element
				resolvePrefix: prefix
				ifUnresolvable: [#absent]) = #absent.
		element declarePrefix: prefix uri: uri.
		self assert:
			(element
				resolvePrefix: prefix
				ifUnresolvable: [#absent]) = uri].

	self assert:
		(element
			resolvePrefix: 'xml'
			ifUnresolvable: [#absent]) = XMLNamespaceScope xmlNamespaceURI.
	
	self assert:
		(element
			resolvePrefix: 'xmlns'
			ifUnresolvable: [#absent]) = XMLNamespaceScope xmlnsNamespaceURI.
]

{ #category : #tests }
XMLElementTest >> testResolvePrefixesOfNamespaceURI [
	| element |

	element := self nodeClass new.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (element resolvePrefixesOfNamespaceURI: uri) isEmpty.

		element
			declarePrefix: prefix
			uri: uri.
		self assert:
			(element resolvePrefixesOfNamespaceURI: uri) =
				(Set with: prefix).

		element
			declarePrefix: 'newPrefix'
			uri: uri.
		self assert:
			(element resolvePrefixesOfNamespaceURI: uri) =
				(Set with: prefix with: 'newPrefix')].

	self assert:
		(element resolvePrefixesOfNamespaceURI:
			XMLNamespaceScope xmlNamespaceURI) =
				(Set with: 'xml').

	self assert:
		(element resolvePrefixesOfNamespaceURI:
			XMLNamespaceScope xmlnsNamespaceURI) =
				(Set with: 'xmlns').
]

{ #category : #tests }
XMLElementTest >> testSetAttributes [
	| element newAttributeAssociations |

	element := self newElementWithAttributes.
	newAttributeAssociations :=
		Array
			with: 'newName' -> 'newValue'
			with: 'newName2' -> 'newValue2'.
	element setAttributes: newAttributeAssociations.

	self assert:
		(element attributeNodes collect: [:each |
			each name -> each value]) asArray =
				newAttributeAssociations.
]

{ #category : #tests }
XMLElementTest >> testSortKey [
	self assert: (self nodeClass named: 'test') sortKey = 'test'
]

{ #category : #tests }
XMLElementTest >> testUndeclareDefaultNamespace [
	| element elementsWithDefaultNamespace |

	element := self newNodeWithElements.
	elementsWithDefaultNamespace :=
		element allElementsSelect: [:each | each defaultNamespace notEmpty].

	element
		defaultNamespace: 'defaultNS';
		undeclareDefaultNamespace;
		allElementsDo: [:each |
			(elementsWithDefaultNamespace includes: each)
				ifTrue: [self assert: each defaultNamespace notEmpty]
				ifFalse: [self assert: each defaultNamespace isEmpty]].
]

{ #category : #tests }
XMLElementTest >> testUndeclarePrefix [
	| element |

	element := self newElementWithAttributes.
	element addElementNamed: 'prefix:inner'.

	self
		assert: (element undeclarePrefix: '') == element;
		assert: (element undeclarePrefix: 'prefixTwo') == element.
	element allElementsDo: [:each |
		self
			deny: (each isDeclaredPrefix: '');
			deny: (each isDeclaredPrefix: 'prefixTwo')].
	self
		should: [element undeclarePrefix: 'prefix']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testUndeclarePrefixes [
	| element innerElement |

	element :=
		self nodeClass
			name: 'outer'
			namespaces: self namespaces
			attributes: self unprefixedAttributes.
	(innerElement := element addElementNamed: 'prefixTwo:inner')
		declarePrefix: 'prefixTwo'
		uri: 'newNS'.

	self
		assert: (element undeclarePrefixes) == element;
		deny: element hasNamespaces;
		assert: innerElement hasNamespaces;
		assert: innerElement declaredPrefixes asArray = #('prefixTwo');
		assert: (innerElement resolvePrefix: 'prefixTwo') = 'newNS'.

	self
		should: [innerElement undeclarePrefixes]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testUndeclaringAttributePrefixes [
	| element |

	element := self newElementWithAttributes.
	self
		shouldnt: [element undeclarePrefix: '']
		raise: XMLNamespaceException.
	self
		shouldnt: [element undeclarePrefix: 'prefixTwo']
		raise: XMLNamespaceException.
	self
		should: [element undeclarePrefix: 'prefix']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testWriteXMLOn [
	| element attributes |

	element := XMLElement named: 'element'.
	attributes := OrderPreservingDictionary with: 'b'->'two' with: 'a'->'one'.
	self
		assert: element printString = '<element />';
		assert: (element contentString: 'test') printString = '<element>test</element>';
		assert: (element setAttributes: attributes) printString = '<element b="two" a="one">test</element>'
]

Class {
	#name : #XMLElementTest,
	#superclass : #XMLNodesWithElementsTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLElementTest class >> isAbstract [
	^ false
]

{ #category : #assertions }
XMLElementTest >> assertElement: anElement hasAttribute: anAttributeName equalTo: anAttributeValue [
	self
		assert: (anElement includesAttribute: anAttributeName);
		assert: (anElement attributeAt: anAttributeName) = anAttributeValue;
		assert: (anElement attributeNodeAt: anAttributeName) notNil;
		assert: (anElement attributeNodeAt: anAttributeName) value = anAttributeValue
]

{ #category : #assertions }
XMLElementTest >> assertElement: anElement hasAttributes: aDictionary [
	self assert:
		(Dictionary newFrom: anElement attributes) =
			(Dictionary newFrom: aDictionary)
]

{ #category : #assertions }
XMLElementTest >> assertElement: anElement hasContentString: aContentString withStrings: aStringArray [
	| combinedStrings |

	self assert: anElement contentString = aContentString.
	combinedStrings := anElement stringNodes collect: [:each | each string].
	self assert: combinedStrings asArray = aStringArray asArray.
]

{ #category : #assertions }
XMLElementTest >> assertElement: anElement hasName: aName attributes: aDictionary contentString: aString [
	self
		assert: (anElement isNamed: aName);
		assertElement: anElement hasAttributes: aDictionary;
		assert: anElement contentString = aString
]

{ #category : #accessing }
XMLElementTest >> nodeClass [
	^ XMLElement
]

{ #category : #accessing }
XMLElementTest >> nodeTypes [
	^ #(isElement isContentNode)
]

{ #category : #tests }
XMLElementTest >> test1emptyElement [
	self assertNodeHasNoChildren: XMLElement new
]

{ #category : #tests }
XMLElementTest >> test2elementNaming [
	| element |

	element := XMLElement new.
	self
		assertNode: element hasName: '' namespaceURI: '';
		assertNode: (element name: 'testElement') hasName: 'testElement' namespaceURI: ''.
	self
		assertNode: (element name: 'testPrefix:testElement' namespaceURI: 'http://test/')
		hasName: 'testPrefix:testElement'
		namespaceURI: 'http://test/'.
]

{ #category : #tests }
XMLElementTest >> test3elementContentString [
	| element str |

	str := self markupString.
	(element := XMLElement new) contentString: str.
	self
		assert: element hasChildren;
		assert: element hasContentNodes;
		assert: element hasStringNodes;
		assert: element contentString = str.

	"Intersperse between text"
	element addNode: self nodeClass new.
	self
		assertElement: (element addContent: str)
		hasContentString: str, ' ', str
		withStrings: (Array with: str with: str).

	"addContent: should combine neighboring string nodes"
	self
		assertElement: (element addContent: (XMLString string: str))
		hasContentString: str, ' ', str, str
		withStrings: (Array with: str with: str, str).

	element addNode: ((XMLElement named: 'childElementWithContent') addContent: 'test content').
	self assert: (element contentStringAt: 'childElementWithContent') = 'test content'.
]

{ #category : #tests }
XMLElementTest >> test4elementAttributes [
	| element attrs |

	element := XMLElement new.
	self
		assert: (element attributeAt: 'foo') isEmpty;
		assert: (element attributeAt: 'foo' ifAbsent: ['absent']) = 'absent';
		deny: (element includesAttribute: 'foo').

	self
		assert: (element attributeAt: 'foo' put: 'test') = 'test';
		assert: element hasAttributes;
		assertElement: element hasAttribute: 'foo' equalTo: 'test';
		assert: (element attributeAt: 'bar' ifAbsentPut: ['test2']) = 'test2';
		assertElement: element hasAttribute: 'bar' equalTo: 'test2';
		assert: element attributeNames asArray =  #('foo' 'bar').

	self
		assert: element attributeAssociations asArray =
			(Array with: 'foo'->'test' with: 'bar'->'test2').
	self
		assertElement: element
		hasAttributes:
			(OrderPreservingDictionary
				with: 'foo'->'test'
				with: 'bar'->'test2').

	self
		assert: (element removeAttribute: 'foo') = 'test';
		assert: (element removeAttribute: 'bar') = 'test2';
		deny: element hasAttributes.
]

{ #category : #tests }
XMLElementTest >> test5elementConstructors [
	| noAttributes attributes str element |

	noAttributes := OrderPreservingDictionary new.
	self
		assertElement: (XMLElement named: 'foo')
		hasName: 'foo'
		attributes: noAttributes
		contentString: ''.

	attributes := OrderPreservingDictionary with: 'foo'->'test1' with: 'bar'->'test2'.
	self
		assertElement: (XMLElement name: 'foo' attributes: attributes)
		hasName: 'foo'
		attributes: attributes
		contentString: ''.

	str := self markupString.
	self
		assertElement: (XMLElement named: 'foo')
		hasName: 'foo'
		attributes: noAttributes
		contentString: ''.
	self
		assertElement: (XMLElement name: 'foo' attributes: attributes)
		hasName: 'foo'
		attributes: attributes
		contentString: ''.

	element := XMLElement
		name: 'prefix:foo'
		namespaceURI: 'http://foo'
		attributes: attributes.
	self
		assertElement: element hasName: 'prefix:foo' attributes: attributes contentString: '';
		assertNode: element hasPrefix: 'prefix' uri: 'http://foo'.
]

{ #category : #tests }
XMLElementTest >> test6elementPrinting [
	| element attributes |

	element := (XMLElement named: 'element').
	attributes := OrderPreservingDictionary with: 'b'->'two' with: 'a'->'one'.
	self
		assert: element printString = '<element />';
		assert: (element contentString: 'test') printString = '<element>test</element>';
		assert: (element setAttributes: attributes) printString = '<element b="two" a="one">test</element>'
]

{ #category : #tests }
XMLElementTest >> test7contentNodeEnumeration [
	| node elements stringNodes contentNodes |

	node := XMLElement new.
	elements := self newElements: 3.
	stringNodes := self newStrings: 3.
	contentNodes := self intersperse: elements with: stringNodes.
	node addNodes: (self intersperse: contentNodes with: (Array with: XMLComment new with: XMLPI new)).

	self
		assert: node contentNodes = contentNodes;
		should: [:block | node contentNodesDo: block] enumerate: contentNodes;
		should: [:block | node stringNodesDo: block] enumerate: stringNodes.
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
XMLElementTest >> testInnerXML [
	| element |

	element := XMLElement name: 'test' namespaces: (Array with: 'prefix'-> 'ns').
	element innerXML: '<prefix:inner></prefix:inner>'.
	element firstNode innerXML: 'test<!--comment-->'.

	self
		assert: element nodes size = 1;
		assert: (element firstNode isNamed: 'prefix:inner');
		assert: (element firstNode contentString = 'test').
]

{ #category : #tests }
XMLElementTest >> testIsElementNamed [
	self
		assert: ((self nodeClass named: 'one') isElementNamed: 'one');
		deny: ((self nodeClass named: 'two') isElementNamed: 'one')
]

{ #category : #tests }
XMLElementTest >> testIsElementNamedAny [
	self
		assert: ((self nodeClass named: 'one') isElementNamedAny: #('two' 'one' 'three'));
		deny: ((self nodeClass named: 'two') isElementNamedAny: #('three' 'four' 'five'))
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
XMLElementTest >> testSortingAttributes [
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

	self assert: element attributeNames asArray = #('c' 'b' 'a').
	element attributeNodes sort.
	self assert: element attributeNames asArray = #('a' 'b' 'c').
	element attributeNodes sort: [:a :b | a name > b name].
	self assert: element attributeNames asArray = #('c' 'b' 'a').
]

{ #category : #tests }
XMLElementTest >> testUndeclaringAttributePrefixes [
	| element |

	element :=
		XMLElement
			name: 'element'
			namespaces: (Array with: '' -> 'defaultNS' with: 'unused' -> 'unusedNS' with: 'used' -> 'usedNS')
			attributes: (Array with: 'name' -> 'value' with: 'used:name' -> 'value').

	self
		shouldnt: [element undeclarePrefix: '']
		raise: XMLNamespaceException.
	self
		shouldnt: [element undeclarePrefix: 'unused']
		raise: XMLNamespaceException.
	self
		should: [element undeclarePrefix: 'used']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLElementTest >> testUndeclaringElementPrefixes [
	| element |

	element :=
		XMLElement
			name: 'outer'
			namespaces: (Array with: '' -> 'defaultNS' with: 'unused' -> 'unusedNS' with: 'used' -> 'usedNS').
	element addElementNamed: 'used:inner'.

	self
		shouldnt: [element undeclarePrefix: '']
		raise: XMLNamespaceException.
	self
		shouldnt: [element undeclarePrefix: 'unused']
		raise: XMLNamespaceException.
	element allElementsDo: [:each |
		self
			deny: (each isDeclaredPrefix: '');
			deny: (each isDeclaredPrefix: 'unused')].
	self
		should: [element undeclarePrefix: 'used']
		raise: XMLNamespaceException.
]

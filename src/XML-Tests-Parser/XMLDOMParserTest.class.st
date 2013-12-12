Class {
	#name : #XMLDOMParserTest,
	#superclass : #XMLParserTest,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
XMLDOMParserTest >> addressBookNamespacesXML [
	^ '<root xmlns="defaultNS" xmlns:ps="personNS">',
		self addressBookXML,
		'</root>'
]

{ #category : #tests }
XMLDOMParserTest >> testCDATASection [
	| document element unescaped escaped xml |

	unescaped := 'this is CDATA test content 1 < 2 & 5 > 3'.
	escaped := 'this is CDATA test content 1 &lt; 2 &amp; 5 &gt; 3'.
	xml := 
		'<?xml version="1.0" encoding="UTF-8"?>
		<test-data><![CDATA[', unescaped, ']]></test-data>'.
	document := XMLDOMParser parse: xml.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size = 1;
		assert: element firstNode isStringNode;
		assert: element firstNode printString = escaped.

	document :=
		(XMLDOMParser on: xml)
			preservesCDataNodes: true;
			parseDocument.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size = 1;
		assert: element firstNode isCData;
		assert: element firstNode printString = ('<![CDATA[', unescaped, ']]>').
]

{ #category : #tests }
XMLDOMParserTest >> testInnerXML [
	| document contactInfo address1 address2 innerXml |

	document := XMLDOMParser parse: self addressBookXML.
	document allElementsNamed: 'person' do: [:person |
		address1 := (person attributeAt: 'first-name'), '@example.com'.
		address2 := (person attributeAt: 'first-name'), '@users.example.com'.
		innerXml := '<email>', address1, '</email><email2>', address2, '</email2>'.
		(contactInfo := person elementAt: 'contact-info') innerXML: innerXml.

		self
			assert: contactInfo innerXML = innerXml;
			assert: contactInfo elements size = 2;
			assert: (contactInfo elements first isNamed: 'email');
			assert: (contactInfo elements first contentString = address1);
			assert: (contactInfo elements second isNamed: 'email2');
			assert: (contactInfo elements second contentString = address2)].

	self assert: ((document innerXML: '<new-root/>') root isNamed: 'new-root').
	self
		should: [document innerXML: '<root1/><root2/>']
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLDOMParserTest >> testNodeListClass [
	| document parser listClass |

	listClass := XMLCachingNodeList.
	document :=
		(parser := XMLDOMParser on: self addressBookXML)
			nodeListClass: listClass;
			parseDocument.

	self
		assert: parser nodeListClass == listClass;
		assert: document nodes class == listClass;
		assert: (document allElements allSatisfy: [:each | each nodes class == listClass]).
]

{ #category : #tests }
XMLDOMParserTest >> testParsingAllElementsNamespaceURIs [
	| document people |

	document := XMLDOMParser parse: self addressBookNamespacesXML.

	people :=
		document
			allElementsNamed: 'person'
			namespaceURI: 'defaultNS'.
	self
		assert: people size = 4;
		assert:
			(document
				allElementsNamed: 'person'
				namespaceURI: 'undeclaredNS') isEmpty.
]

{ #category : #tests }
XMLDOMParserTest >> testParsingAttributes [
	| document firstPerson  |

	document := XMLDOMParser parse: self addressBookXML.
	firstPerson := document findElementNamed: 'person'.
	self
		assert: (firstPerson attributeAt: 'employee-number') = 'A0000';
		assert: (firstPerson attributeAt: 'family-name') = 'Gates';
		assert: (firstPerson attributeAt: 'first-name') = 'Bob';
		assert:
			firstPerson attributeNames asArray =
				#('employee-number' 'family-name' 'first-name');
		assert: firstPerson attributeAssociations asArray =
			{('employee-number'->'A0000'). ('family-name'->'Gates'). ('first-name'->'Bob').}.
]

{ #category : #tests }
XMLDOMParserTest >> testParsingChangingNamespaces [
	| document people person |

	document := XMLDOMParser parse: self addressBookNamespacesXML.

	people := document allElementsNamed: 'person' namespaceURI: 'defaultNS'.
	(person := people third) prefix: 'ps'.
	self assert:
		person == (document findElementNamed: 'person' namespaceURI: 'personNS').
	self assert:
		(people copyWithout: person) =
			((document findElementNamed: 'addressbook') nodesSelect: [:each |
				each isElement and: [each namespaceURI = 'defaultNS']]).
]

{ #category : #tests }
XMLDOMParserTest >> testParsingCollecting [
	| document firstPerson allNames |
	"self debug: #testParsing"

	document := XMLDOMParser parse: self addressBookXML.
	firstPerson := document findElementNamed: 'person'.

	allNames := #('person' 'contact-info' 'address' 'job-info' 'manager').
	self
		assert: (firstPerson allElementsCollect: [:each | each name]) asArray = allNames;
		assert: (firstPerson allElements collect: [:each | each name]) asArray = allNames;
		assert: (firstPerson nodesCollect: [:each | each name]) asArray = allNames allButFirst;
		assert: (firstPerson nodes collect: [:each | each name]) asArray = allNames allButFirst.
]

{ #category : #tests }
XMLDOMParserTest >> testParsingElementNames [
	| document root  persons |

	document := XMLDOMParser parse: self addressBookXML.
	root := document root.

	persons := 	root allNodesSelect: [:each |
			each isElement and: [each isNamedAny: #('Person' 'person')]].
	self assert: persons size = 4.

	root allElementsNamed: 'person' do: [:p |
		self assert: (persons includes: p).
		persons remove: p].
	self assert: persons isEmpty.
]

{ #category : #tests }
XMLDOMParserTest >> testParsingFindElementNamespaceURI [
	| document people |

	document := XMLDOMParser parse: self addressBookNamespacesXML.

	people := document allElementsNamed: 'person' namespaceURI: 'defaultNS'.
	self assert:
		(document
			findElementNamed: 'person'
			namespaceURI: 'defaultNS'
			with: [:each | (each attributeAt: 'employee-number') = 'A7987']) == people last.
	self assert:
		(document
			findElementNamed: 'person'
			namespaceURI: 'defaultNS'
			with: [:each | (each attributeAt: 'family-name') = 'Brown']) == people second.
]

{ #category : #tests }
XMLDOMParserTest >> testParsingNodeDetecting [
	| document people |

	document := XMLDOMParser parse: self addressBookXML.
	people := document root elementsAt: 'person'.
	self assert:
		((document findElementNamed: 'addressbook') nodesDetect: [:each |
			each isElement and: [(each attributeAt: 'family-name') = 'Brown']]) == people second.
	self assert:
		((document findElementNamed: 'addressbook')
			nodesDetect: [:each | each isElement and: [(each attributeAt: 'unknown') = 'Brown']]
			ifNone: ['not found']) = 'not found'.
]

{ #category : #tests }
XMLDOMParserTest >> testParsingRoot [
	| document root  |

	document := XMLDOMParser parse: self addressBookXML.
	self assert: (document isKindOf: XMLDocument).
	root := document root.
	self assert: (root class == XMLElement).

	self assert:
		(root allNodesDetect: [:each |
			each isElement
				and: [each isNamedAny: #('AddressBook' 'addressbook')]]) == root.
	self assert: (root findElementNamed: 'addressbook') == root.
]

{ #category : #tests }
XMLDOMParserTest >> testXMLComment [
	| document comment|

	document := XMLDOMParser parse: self addressBookXML.
	self deny: (document findElementNamed: 'contact-info') hasChildren.

	document :=
		(XMLDOMParser on: self addressBookXML)
			preservesCommentNodes: true;
			parseDocument.
	comment := (document findElementNamed: 'contact-info') firstNode.
	self
		assert: comment notNil;
		assert: comment string = 'Confidential'.
]

Class {
	#name : #XMLDOMParserTest,
	#superclass : #XMLParserTest,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
XMLDOMParserTest class >> addressBookNamespacePrefixedXML [
	"
	self addressBookNamespacePrefixedXML
	"
	| xmlWithPrefixes |

	xmlWithPrefixes := self addressBookNamespacedXML.
	#('<addressbook' '</addressbook' '<person' '</person' 'family-name=' 'first-name=')
		with: #('<book:addressbook' '</book:addressbook' '<ps:person' '</ps:person' 'ps:family-name=' 'ps:first-name=')
		do: [:source :replacement |
			xmlWithPrefixes := xmlWithPrefixes copyReplaceAll: source with: replacement].
	^ xmlWithPrefixes.
]

{ #category : #source }
XMLDOMParserTest class >> addressBookNamespacedXML [
	"
	self addressBookNamespacedXML
	"
	^ '<addressbook xmlns="defaultNS" xmlns:book="bookNS" xmlns:ps="personNS">',
		(self addressBookXML copyAfter:  $>)
]

{ #category : #source }
XMLDOMParserTest >> addressBookNamespacePrefixedXML [
	^ self class addressBookNamespacePrefixedXML
]

{ #category : #source }
XMLDOMParserTest >> addressBookNamespacedXML [
	^ self class addressBookNamespacedXML
]

{ #category : #source }
XMLDOMParserTest >> internalSubsetWithDeclarations [
	^ '<!DOCTYPE root PUBLIC "pubid" "external.dtd" [
		<!ELEMENT root ( #PCDATA | one | two)* >
		<!ATTLIST root
					name CDATA #IMPLIED
					number ( one | two | three ) "three">
		<!ENTITY general "replacement">
		<!ENTITY externalGeneral PUBLIC "pubid2" "external1.dtd">
		<!ENTITY % parameter "replacement">
		<!ENTITY % externalParameter SYSTEM "external2.dtd">
		<!NOTATION notation SYSTEM "note.doc">]>'
]

{ #category : #tests }
XMLDOMParserTest >> testAllElementsNamespaceURIs [
	| document people |

	document := XMLDOMParser parse: self addressBookNamespacedXML.

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
XMLDOMParserTest >> testAttributeNamespaces [
	| document  people |

	document := XMLDOMParser parse: self addressBookNamespacePrefixedXML.
	people := document allElementsNamed: 'person' namespaceURI: 'personNS'.
	self assert: people notEmpty.
	
	people do: [:each |
		self
			assert: each hasAttributes;
			deny: each attributeNames isEmpty;
			assert:
				(each attributeNames allSatisfy: [:name |
					(each attributeNodeAt: name namespaceURI: 'defaultNS') isNil]);
			assert: (each attributeNodeAt: 'ps:family-name' namespaceURI: 'personNS') notNil;
			assert: (each attributeNodeAt: 'ps:first-name' namespaceURI: 'personNS') notNil].
]

{ #category : #tests }
XMLDOMParserTest >> testAttributeNamespacesDisabled [
	| document  people |

	document :=
		XMLDOMParser
			parse: self addressBookNamespacePrefixedXML
			usingNamespaces: false.
	people := document allElementsNamed: 'person'.
	self assert: people notEmpty.
	people do: [:each |
		self
			assert: each hasAttributes;
			deny: each attributeNames isEmpty;
			assert: (each attributeNodeAt: 'ps:family-name' namespaceURI: 'personNS') isNil;
			assert: (each attributeNodeAt: 'ps:first-name' namespaceURI: 'personNS') isNil].
]

{ #category : #tests }
XMLDOMParserTest >> testAttributesExcludingDeclarations [
	| document   |

	document := XMLDOMParser parse: self addressBookNamespacedXML.
	self deny: document root hasAttributes.
]

{ #category : #tests }
XMLDOMParserTest >> testAttributesIncludingDeclarations [
	| document  root |

	document :=
		XMLDOMParser
			parse: self addressBookNamespacedXML
			usingNamespaces: false.
	root := document root.
	self
		assert: root hasAttributes;
		assert: (root attributeAt: 'xmlns') = 'defaultNS';
		assert: (root attributeAt: 'xmlns:book') = 'bookNS';
		assert: (root attributeAt: 'xmlns:ps') = 'personNS'.
]

{ #category : #tests }
XMLDOMParserTest >> testCDATASection [
	| document element unescaped escaped xml |

	unescaped := 'this is CDATA test content 1 < 2 & 5 > 3'.
	escaped := 'this is CDATA test content 1 &lt; 2 &amp; 5 > 3'.
	xml := 
		'<?xml version="1.0" encoding="UTF-8"?>
		<test-data>test<![CDATA[', unescaped, ']]>test</test-data>'.
	document := XMLDOMParser parse: xml.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size = 1;
		assert: element firstNode isStringNode;
		assert: element firstNode printString = ('test', escaped, 'test').

	document :=
		(XMLDOMParser on: xml)
			preservesCDataNodes: true;
			parseDocument.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size = 3;
		assert: element nodes second isCData;
		assert: element nodes second printString = ('<![CDATA[', unescaped, ']]>');
		assert: element strings asArray = (Array with: 'test' with: unescaped with: 'test').
]

{ #category : #tests }
XMLDOMParserTest >> testChangingNamespaces [
	| document people person |

	document := XMLDOMParser parse: self addressBookNamespacedXML.

	people := document allElementsNamed: 'person' namespaceURI: 'defaultNS'.
	(person := people third) prefix: 'ps'.
	self assert: person == (document findElementNamed: 'person' namespaceURI: 'personNS').
	self assert:
		(people copyWithout: person) =
			((document findElementNamed: 'addressbook') nodesSelect: [:each |
				each isElement and: [each namespaceURI = 'defaultNS']]).
]

{ #category : #tests }
XMLDOMParserTest >> testCollectingParsedNodes [
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
XMLDOMParserTest >> testDeclaringXMLNamespace [
	| xmlNamespace |

	xmlNamespace :=XMLNamespaceScope xmlNamespaceURI.
	self deny:
		((XMLDOMParser parse: self addressBookNamespacedXML) root
			declaresPrefix: 'xml'
			uri: xmlNamespace).

	self assert:
		((XMLDOMParser parse: '<test xmlns:xml="', xmlNamespace, '"/>') root
			declaresPrefix: 'xml'
			uri: xmlNamespace).
]

{ #category : #tests }
XMLDOMParserTest >> testDisabledNamespacesAttributes [
	| document |

	document :=
		XMLDOMParser
			parse: '<root xmlns:prefix="prefixNS" xmlns="defaultNS" name="value"/>'
			usingNamespaces: false.
	self
		assert: document root attributeNames asArray = #('xmlns:prefix' 'xmlns' 'name');
		assert: (document root attributeAt: 'xmlns:prefix') = 'prefixNS';
		assert: (document root attributeAt: 'xmlns') = 'defaultNS';
		assert: (document root attributeAt: 'name') = 'value'.
]

{ #category : #'tests - internal subset' }
XMLDOMParserTest >> testDoctypeDeclaration [
	| doctype |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.
	self
		assert: doctype root = 'root';
		assert: doctype publicID = 'pubid';
		assert: doctype systemID = 'external.dtd';
		assert: doctype nodes notEmpty;
		assert: (doctype nodes allSatisfy: [:each | each isDeclaration]).
]

{ #category : #tests }
XMLDOMParserTest >> testDocument [
	| document root |

	document := XMLDOMParser parse: self addressBookXML.
	document allNodesDo: [:each | self assert: each document == document].

	root := document root.
	root innerXML: self addressBookXML.
	document allNodesDo: [:each | self assert: each document == document].

	document removeNode: root.
	root allNodesDo: [:each | self assert: each document isNil].
]

{ #category : #tests }
XMLDOMParserTest >> testElementNames [
	| document root  persons |

	document := XMLDOMParser parse: self addressBookXML.
	root := document root.

	persons := 	root allNodesSelect: [:each |
			each isElement
				and: [(each isNamedAny: #('notperson' 'person'))
					and: [(each isNamed: 'person')
						and: [(each name = 'person') and: [each localName = 'person']]]]].
	self assert: persons size = 4.

	root allElementsNamed: 'person' do: [:p |
		self assert: (persons includes: p).
		persons remove: p].
	self assert: persons isEmpty.
]

{ #category : #tests }
XMLDOMParserTest >> testElementPrefixes [
	| document  persons |

	document := XMLDOMParser parse: self addressBookNamespacePrefixedXML.
	persons := 	document allElementsSelect: [:each |
		(each isNamedAny: #('notperson' 'ps:person'))
			and: [(each isNamedAny: #('notperson' 'person'))
				and: [(each isNamed: 'person')
					and: [(each isNamed: 'ps:person')
						and: [(each name = 'ps:person') and: [each localName = 'person']]]]]].
	self assert: persons size = 4.
]

{ #category : #tests }
XMLDOMParserTest >> testElementPrefixesNamespacesDisabled [
	| document  persons |

	document :=
		XMLDOMParser
			parse: self addressBookNamespacePrefixedXML
			usingNamespaces: false.
	persons := 	document allElementsSelect: [:each |
		(each isNamedAny: #('notperson' 'ps:person'))
			and: [(each isNamedAny: #('notperson' 'person'))
				and: [(each isNamed: 'person')
					and: [(each isNamed: 'ps:person')
						and: [(each name = 'ps:person') and: [each localName = 'person']]]]]].
	self assert: persons size = 4.
]

{ #category : #tests }
XMLDOMParserTest >> testFindElementNamespaceURI [
	| document people |

	document := XMLDOMParser parse: self addressBookNamespacedXML.

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
XMLDOMParserTest >> testInnerXML [
	| document |

	document := XMLDOMParser parse: self addressBookXML.
	document allElementsNamed: 'person' do: [:person | | contactInfo address1 address2 |
		#('address' 'job-info' 'manager') do: [:each |
			self assert: (person elementAt: each) innerXML isEmpty].
.
		contactInfo := person elementAt: 'contact-info'.
		address1 := (person attributeAt: 'first-name'), '@example.com'.
		address2 := (person attributeAt: 'first-name'), '@users.example.com'.
		self
			assert: (contactInfo innerXML: '<email></email><email2/>') innerXML = '<email /><email2 />';
			assert: contactInfo elements size = 2;
			assert: (contactInfo elements first isNamed: 'email');
			assert: (contactInfo elements second isNamed: 'email2');
			assert: (contactInfo firstElement innerXML: address1, '<!--ignored-->') innerXML = address1;
			assert: (contactInfo elements second innerXML: '<![CDATA[', address2, ']]>') innerXML = address2.
		self assert:
			contactInfo innerXML = 
				('<email>', address1, '</email><email2>', address2, '</email2>')].
]

{ #category : #tests }
XMLDOMParserTest >> testInnerXMLDocument [
	| document |

	document := XMLDOMParser parse: self addressBookXMLWithDTD.
	self
		assert: ((document innerXML: '<new-root/>') root isNamed: 'new-root');
		assert: document innerXML = '<new-root />';
		assert: ((document root innerXML: 'test') contentString = 'test');
		assert: document root innerXML = 'test';
		assert:
			(document innerXML: self addressBookXMLWithDTD) printString =
				(XMLDOMParser parse: self addressBookXMLWithDTD) printString.
	self
		should: [document innerXML: '<root1/><root2/>']
		raise: XMLWellFormednessException.
]

{ #category : #'tests - internal subset' }
XMLDOMParserTest >> testInternalAttributeDeclarations [
	| doctype firstAttribute secondAttribute |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	firstAttribute := doctype nodes second.
	self
		assert: firstAttribute element = 'root';
		assert: firstAttribute attribute = 'name';
		assert: firstAttribute type = 'CDATA';
		assert: firstAttribute defaultPragma = 'IMPLIED';
		assert: firstAttribute defaultValue isEmpty.

	secondAttribute := doctype nodes third.
	self
		assert: secondAttribute element = 'root';
		assert: secondAttribute attribute = 'number';
		assert: secondAttribute type = '(one |two |three )';
		assert: secondAttribute defaultPragma isEmpty;
		assert: secondAttribute defaultValue = 'three'.
]

{ #category : #'tests - internal subset' }
XMLDOMParserTest >> testInternalElementDeclaration [
	| doctype elementDeclaration |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.
	elementDeclaration := doctype nodes first.
	self
		assert: elementDeclaration element = 'root';
		assert: elementDeclaration contentModel = '(#PCDATA|one|two)*'.
]

{ #category : #'tests - internal subset' }
XMLDOMParserTest >> testInternalGeneralEntityDeclarations [
	| doctype firstEntity secondEntity |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	firstEntity := doctype nodes fourth.
	self
		deny: firstEntity isParameter;
		assert: firstEntity name = 'general';
		assert: firstEntity replacement = 'replacement';
		assert: firstEntity publicID isEmpty;
		assert: firstEntity systemID isEmpty;
		assert: firstEntity ndata isEmpty.

	secondEntity := doctype nodes fifth.
	self
		deny: secondEntity isParameter;
		assert: secondEntity name = 'externalGeneral';
		assert: secondEntity replacement isEmpty;
		assert: secondEntity publicID = 'pubid2';
		assert: secondEntity systemID = 'external1.dtd';
		assert: secondEntity ndata isEmpty.
]

{ #category : #'tests - internal subset' }
XMLDOMParserTest >> testInternalNotationDeclarations [
	| doctype notation |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	notation := doctype nodes eighth.
	self
		assert: notation name = 'notation';
		assert: notation publicID isEmpty;
		assert: notation systemID = 'note.doc'.
]

{ #category : #'tests - internal subset' }
XMLDOMParserTest >> testInternalParameterEntityDeclarations [
	| doctype firstEntity secondEntity |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	firstEntity := doctype nodes sixth.
	self
		assert: firstEntity isParameter;
		assert: firstEntity name = 'parameter';
		assert: firstEntity replacement = 'replacement';
		assert: firstEntity publicID isEmpty;
		assert: firstEntity systemID isEmpty.

	secondEntity := doctype nodes seventh.
	self
		assert: secondEntity isParameter;
		assert: secondEntity name = 'externalParameter';
		assert: secondEntity replacement isEmpty;
		assert: secondEntity publicID isEmpty;
		assert: secondEntity systemID = 'external2.dtd'.
]

{ #category : #tests }
XMLDOMParserTest >> testNamespaces [
	| document  |

	document := XMLDOMParser parse: self addressBookNamespacePrefixedXML.
	document allElementsDo: [:each |
		(each == document root or: [each isNamed: 'person'])
			ifTrue: [
				self assert: each hasPrefix.
				each == document root
					ifTrue: [
						self
							assert: each prefix = 'book';
							assert: each namespaceURI = 'bookNS']
					ifFalse: [
						self
							assert: each prefix = 'ps';
							assert: each namespaceURI = 'personNS']]
			ifFalse: [
				self
					assert: each namespaceURI = 'defaultNS';
					deny: each hasPrefix;
					assert: each prefix isEmpty]].
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesDeclaring [
	| document |

	document := XMLDOMParser parse: self addressBookNamespacedXML.
	document allElementsDo: [:each |
		self assert: each hasNamespaces.
		each == document root
			ifTrue: [
				self
					assert: each declaresDefaultNamespace;
					assert: (each declaresPrefix: 'ps' uri: 'personNS')]
			ifFalse: [ 
				self
					deny: each declaresDefaultNamespace;
					deny: (each declaresPrefix: 'ps' uri: 'personNS')].
		self
			deny: (each declaresPrefix: 'undeclared' uri: 'undeclaredNS');
			deny: (each isDeclaredPrefix: 'undeclared');
			deny: (each isDeclaredPrefix: 'undeclared' uri: 'undeclaredNS');
			assert: (each isDeclaredPrefix: 'ps');
			assert: (each isDeclaredPrefix: 'ps' uri: 'personNS')].
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesDeclaringDisabled [
	| document |

	document := XMLDOMParser parse: self addressBookNamespacedXML usingNamespaces: false.
	document allElementsDo: [:each |
		self
			deny: each hasNamespaces;
			deny: each declaresDefaultNamespace;
			deny: (each declaresPrefix: 'ps' uri: 'personNS');
			deny: (each isDeclaredPrefix: 'ps');
			deny: (each isDeclaredPrefix: 'ps' uri: 'personNS')].
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesDisabled [
	| document |

	document :=
		XMLDOMParser
			parse: self addressBookNamespacePrefixedXML
			usingNamespaces: false.
	document allElementsDo: [:each |
		self assert: each namespaceURI isEmpty.
		(each == document root or: [each isNamed: 'person'])
			ifTrue: [
				self
					assert: each hasPrefix;
					assert:
						each prefix =
							((each == document root) ifTrue: ['book'] ifFalse: ['ps'])]
			ifFalse: [
				self
					deny: each hasPrefix;
					assert: each prefix isEmpty]].
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesResolving [
	| document |

	document := XMLDOMParser parse: self addressBookNamespacedXML.
	document allElementsDo: [:each |
		self
			assert: each defaultNamespace = 'defaultNS';
			assert: (each resolvePrefix: '') = 'defaultNS';
			assert: (each resolvePrefix: 'book') = 'bookNS';
			assert: (each resolvePrefix: 'ps') = 'personNS';
			assert:
				each namespaceURI =
					(each hasPrefix
						ifTrue: [each resolvePrefix: each prefix]
						ifFalse: [each defaultNamespace])]
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesResolvingDisabled [
	| document |

	document :=
		XMLDOMParser
			parse: self addressBookNamespacedXML
			usingNamespaces: false.
	document allElementsDo: [:each |
		self
			assert: each defaultNamespace isEmpty;
			assert: (each resolvePrefix: '') isEmpty;
			assert: (each resolvePrefix: 'book') isEmpty;
			assert: (each resolvePrefix: 'ps') isEmpty;
			assert:
				each namespaceURI =
					(each hasPrefix
						ifTrue: [each resolvePrefix: each prefix]
						ifFalse: [each defaultNamespace])]
]

{ #category : #tests }
XMLDOMParserTest >> testNodeDetecting [
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
XMLDOMParserTest >> testOverridingDefaultNamespace [
	| document |

	document := XMLDOMParser parse: '<outer xmlns="default"><inner xmlns=""/></outer>'.
	self
		assert: document root namespaceURI = 'default';
		assert: document root defaultNamespace = 'default';
		assert: document root firstNode namespaceURI isEmpty;
		assert: document root firstNode defaultNamespace isEmpty.
]

{ #category : #tests }
XMLDOMParserTest >> testParseDocumentUntil [
	| i document |

	self
		shouldnt: [
			i := 0.
			document :=
				(XMLDOMParser on: '<root><one>two<#malformed')
					parseDocumentUntil: [(i := i + 1) > 4]]
		raise: XMLWellFormednessException.
	self
		assert: document allNodes size = 4;
		assert: (document findElementNamed: 'one') nodes size = 1;
		assert: (document findElementNamed: 'one') contentString = 'two'.
	self
		should: [
			i := 0.
			(XMLDOMParser on: '<root><one>two<#malformed')
				parseDocumentUntil: [(i := i + 1) > 5]]
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLDOMParserTest >> testParseDocumentWhile [
	| i document |

	self
		shouldnt: [
			i := 0.
			document :=
				(XMLDOMParser on: '<root><one>two<#malformed')
					parseDocumentWhile: [(i := i + 1) <= 4]]
		raise: XMLWellFormednessException.
	self
		assert: document allNodes size = 4;
		assert: (document findElementNamed: 'one') nodes size = 1;
		assert: (document findElementNamed: 'one') contentString = 'two'.
	self
		should: [
			i := 0.
			(XMLDOMParser on: '<root><one>two<#malformed')
				parseDocumentWhile: [(i := i + 1) <= 5]]
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLDOMParserTest >> testParsedElementNames [
	| document |

	document := XMLDOMParser parse: self addressBookNamespacePrefixedXML.
	self assert:
		document elementNames =
			(document elements collect: [:each | each name ]).

	document allElementsDo: [:element |
		self assert:
			element elementNames =
				(element elements collect: [:each | each name])].
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

{ #category : #tests }
XMLDOMParserTest >> testXMLDeclaration [
	| document |

	document := XMLDOMParser parse: '<?xml version="1.0" encoding="UTF-8"?>'.
	self
		assert: document version = 1.0;
		assert: document encoding = 'UTF-8';
		deny: document isStandalone.

	document := XMLDOMParser parse: '<?xml version="1.1" encoding="utf-8" standalone="yes"?>'.
	self
		assert: document version = 1.1;
		assert: document encoding = 'utf-8';
		assert: document isStandalone.
]

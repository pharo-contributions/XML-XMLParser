Class {
	#name : #XMLDOMParserTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-Base'
}

{ #category : #source }
XMLDOMParserTest >> addressBookNamespacePrefixedXML [
	^ XMLParserTest addressBookNamespacePrefixedXML
]

{ #category : #source }
XMLDOMParserTest >> addressBookNamespacedXML [
	^ XMLParserTest addressBookNamespacedXML
]

{ #category : #source }
XMLDOMParserTest >> addressBookXML [
	^ XMLParserTest addressBookXML
]

{ #category : #source }
XMLDOMParserTest >> addressBookXMLWithDTD [
	^ XMLParserTest addressBookXMLWithDTD
]

{ #category : #source }
XMLDOMParserTest >> internalSubsetXMLWithDeclarations [
	^ XMLParserTest internalSubsetXMLWithDeclarations
]

{ #category : #accessing }
XMLDOMParserTest >> nodeFactoryClass [
	^ XMLNodeFactory
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
		assert: people size equals: 4;
		assert:
			(document
				allElementsNamed: 'person'
				namespaceURI: 'undeclaredNS') isEmpty
]

{ #category : #tests }
XMLDOMParserTest >> testAttributeListClass [
	(Array
		with: XMLAttributeList
		with: XMLCachingAttributeList)
		do: [:listClass | | document parser |
			parser := XMLDOMParser on: self addressBookXML.
			parser configuration attributeListClass: listClass.
			document := parser parseDocument.
			self assert: parser configuration attributeListClass == listClass.
			document allElements do: [:each |
				self assert: each attributeNodes class == listClass]]
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
			assert: (each attributeNodeAt: 'ps:first-name' namespaceURI: 'personNS') notNil]
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
			assert: (each attributeNodeAt: 'ps:first-name' namespaceURI: 'personNS') isNil]
]

{ #category : #tests }
XMLDOMParserTest >> testAttributeParent [
	(XMLDOMParser parse: self addressBookXML) allElementsDo: [:element |
		element hasAttributes
			ifTrue: [
				element attributeNodesDo: [:each |
					self
						assert: each hasParent;
						assert: each parent == element;
						assert: each element == element]]]
]

{ #category : #tests }
XMLDOMParserTest >> testAttributes [
	| document firstPerson  |

	document := XMLDOMParser parse: self addressBookXML.
	firstPerson := document findElementNamed: 'person'.
	self
		assert: (firstPerson attributeAt: 'employee-number') equals: 'A0000';
		assert: (firstPerson attributeAt: 'family-name') equals: 'Gates';
		assert: (firstPerson attributeAt: 'first-name') equals: 'Bob';
		assert:
			firstPerson attributeNames asArray equals:
				#('employee-number' 'family-name' 'first-name');
		assert: firstPerson attributeAssociations asArray equals:
			{('employee-number'->'A0000'). ('family-name'->'Gates'). ('first-name'->'Bob').}
]

{ #category : #tests }
XMLDOMParserTest >> testAttributesExcludingDeclarations [
	| document   |

	document := XMLDOMParser parse: self addressBookNamespacedXML.
	self deny: document root hasAttributes
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
		assert: (root attributeAt: 'xmlns') equals: 'defaultNS';
		assert: (root attributeAt: 'xmlns:book') equals: 'bookNS';
		assert: (root attributeAt: 'xmlns:ps') equals: 'personNS'
]

{ #category : #tests }
XMLDOMParserTest >> testCDataSection [
	#('' ']' ']]' ']]]' ']>' ']>]' ']>]>]')
		with: #('' ']' ']]' ']]]' ']&gt;' ']&gt;]' ']&gt;]&gt;]')
		do: [:suffix :escapedSuffix | | document element unescaped escaped xml |
			unescaped :=
				'this is CDATA test content 1 < 2 & 5 > 3', suffix.
			escaped :=
				'this is CDATA test content 1 &lt; 2 &amp; 5 &gt; 3', escapedSuffix.
			xml :=
				'<?xml version="1.0" encoding="UTF-8"?>
				<test-data>test<![CDATA[', unescaped, ']]>test</test-data>'.
			document := XMLDOMParser parse: xml.
			element := document findElementNamed: 'test-data'.
			self
				assert: element nodes size equals: 1;
				assert: element firstNode isStringNode;
				assert: element firstNode printString equals: ('test', escaped, 'test').

			document :=
				(XMLDOMParser on: xml)
					preservesCDataNodes: true;
					parseDocument.
			element := document findElementNamed: 'test-data'.
			self
				assert: element nodes size equals: 3;
				assert: element nodes second isCData;
				assert: element nodes second printString equals:
					('<![CDATA[', unescaped, ']]>');
				assert: element strings asArray equals:
					(Array with: 'test' with: unescaped with: 'test')]
]

{ #category : #tests }
XMLDOMParserTest >> testCDataSectionEntityReplacement [
	| document element unescaped escaped xml |

	unescaped := 'this is CDATA test content 1 < 2 & 5 > 3'.
	escaped := 'this is CDATA test content 1 &lt; 2 &amp; 5 &gt; 3'.
	xml :=
		'<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE test-data [
			<!ENTITY cdata "<![CDATA[this is CDATA test content 1 < 2 &#38; 5 > 3]]>">
		]>
		<test-data>test&cdata;test</test-data>'.
	document := XMLDOMParser parse: xml.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size equals: 1;
		assert: element firstNode isStringNode;
		assert: element firstNode printString equals: ('test', escaped, 'test').

	document :=
		(XMLDOMParser on: xml)
			preservesCDataNodes: true;
			parseDocument.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size equals: 3;
		assert: element nodes second isCData;
		assert: element nodes second printString equals: ('<![CDATA[', unescaped, ']]>');
		assert: element strings asArray equals: (Array with: 'test' with: unescaped with: 'test')
]

{ #category : #tests }
XMLDOMParserTest >> testChangingNamespaces [
	| document people person |

	document := XMLDOMParser parse: self addressBookNamespacedXML.

	people := document allElementsNamed: 'person' namespaceURI: 'defaultNS'.
	(person := people third) prefix: 'ps'.
	self assert: person == (document findElementNamed: 'person' namespaceURI: 'personNS').
	self assert:
		(people copyWithout: person) equals:
			((document findElementNamed: 'addressbook') nodesSelect: [:each |
				each isElement and: [each namespaceURI = 'defaultNS']])
]

{ #category : #tests }
XMLDOMParserTest >> testComment [
	| xml document comments |

	xml := '<!--one--><test><!--two--></test><!--three-->'.
	document := XMLDOMParser parse: xml.
	comments := document allNodesSelect: [:each | each isComment].
	self assert: comments isEmpty.

	document :=
		(XMLDOMParser on: xml)
			preservesCommentNodes: true;
			parseDocument.
	comments := document allNodesSelect: [:each | each isComment].
	self
		assert: (comments allSatisfy: [:each | each isComment]);
		assert: (comments collect: [:each | each string]) asArray equals: #('one' 'two' 'three')
]

{ #category : #tests }
XMLDOMParserTest >> testDeclaringXMLNamespace [
	| xmlNamespace elements |

	xmlNamespace :=XMLNamespaceScope xmlNamespaceURI.
	self deny:
		((XMLDOMParser parse: self addressBookNamespacedXML) root
			declaresPrefix: 'xml'
			uri: xmlNamespace).

	elements :=
		(XMLDOMParser parse:
			'<one><two xmlns:xml="', xmlNamespace, '"/><xml:three/></one>') allElements.
	self
		deny: (elements first declaresPrefix: 'xml' uri: xmlNamespace);
		assert: (elements second declaresPrefix: 'xml' uri: xmlNamespace);
		deny: (elements third declaresPrefix: 'xml' uri: xmlNamespace)
]

{ #category : #tests }
XMLDOMParserTest >> testDoctypeDeclaration [
	| doctype |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetXMLWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.
	self
		assert: doctype root equals: 'root';
		assert: doctype publicID equals: 'pubid';
		assert: doctype systemID equals: 'external.dtd';
		assert: doctype nodes notEmpty;
		assert: (doctype nodes allSatisfy: [:each | each isDeclaration])
]

{ #category : #tests }
XMLDOMParserTest >> testDocument [
	| parser document root |

	parser := XMLDOMParser on: self addressBookXML.
	self assert: parser document isNil.

	document := parser parseDocument.
	self assert: parser document == document.

	parser on: self addressBookXML.
	self assert: parser document isNil.

	document allNodesDo: [:each |
		self assert: each document == document].

	root := document root.
	root innerXML: self addressBookXML.
	document allNodesDo: [:each |
		self assert: each document == document].

	document removeNode: root.
	root allNodesDo: [:each |
		self assert: each document isNil]
]

{ #category : #tests }
XMLDOMParserTest >> testDocumentInternalSubset [
	| document doctypeDeclaration |

	document := XMLDOMParser parse: self internalSubsetXMLWithDeclarations.
	doctypeDeclaration := document doctypeDeclaration.
	doctypeDeclaration allNodesDo: [:each |
		self assert: each document == document].

	document doctypeDeclaration: nil.
	doctypeDeclaration allNodesDo: [:each |
		self assert: each document isNil]
]

{ #category : #tests }
XMLDOMParserTest >> testElementMixedContent [
	| xml mixedContent |

	xml := '<mixed-content> one <two/> <three/> four <five> </five> seven </mixed-content>'.
	mixedContent := (XMLDOMParser parse: xml) root.
	self
		assert: mixedContent nodes size equals: 7;
		assert: (mixedContent nodes first isStringNode: ' one ');
		assert: (mixedContent nodes second isElementNamed: 'two');
		deny: mixedContent nodes second hasChildren;
		assert: (mixedContent nodes third isStringNode: ' ');
		assert: (mixedContent nodes fourth isElementNamed: 'three');
		deny: mixedContent nodes fourth hasChildren;
		assert: (mixedContent nodes fifth isStringNode: ' four ');
		assert: (mixedContent nodes sixth isElementNamed: 'five');
		assert: mixedContent nodes sixth hasChildren;
		assert: mixedContent nodes sixth nodes size equals: 1;
		assert: (mixedContent nodes sixth nodes first isStringNode: ' ');
		assert: (mixedContent nodes seventh isStringNode: ' seven ')
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
	self assert: persons size equals: 4.

	root allElementsNamed: 'person' do: [:p |
		self assert: (persons includes: p).
		persons remove: p].
	self assert: persons isEmpty
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
	self assert: persons size equals: 4
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
	self assert: persons size equals: 4.
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
			self assert: (person elementAt: each) innerXML equals: ''].

		contactInfo := person elementAt: 'contact-info'.
		address1 := (person attributeAt: 'first-name'), '@example.com'.
		address2 := (person attributeAt: 'first-name'), '@users.example.com'.
		self
			assert: (contactInfo innerXML: '<email></email><email2/>') innerXML equals: '<email/><email2/>';
			assert: contactInfo elements size equals: 2;
			assert: (contactInfo elements first isNamed: 'email');
			assert: (contactInfo elements second isNamed: 'email2');
			assert: (contactInfo firstElement innerXML: address1, '<!--ignored-->') innerXML equals: address1;
			assert: (contactInfo elements second innerXML: '<![CDATA[', address2, ']]>') innerXML equals: address2.
		self assert:
			contactInfo innerXML equals: 
				('<email>', address1, '</email><email2>', address2, '</email2>')].
]

{ #category : #tests }
XMLDOMParserTest >> testInnerXMLDocument [
	| document |

	document := XMLDOMParser parse: self addressBookXMLWithDTD.
	self
		assert: ((document innerXML: '<new-root/>') root isNamed: 'new-root');
		assert: document innerXML equals: '<new-root/>';
		assert: (document root innerXML: 'test') contentString equals: 'test';
		assert: document root innerXML equals: 'test'.
	
	document := XMLDOMParser parse: self addressBookXMLWithDTD.
	self assert:
		(document innerXML: document innerXML) printString equals:
			(XMLDOMParser parse: self addressBookXMLWithDTD) printString.
	self
		should: [document innerXML: self addressBookXMLWithDTD]
		raise: XMLWellFormednessException.

	document := XMLDOMParser parse: '<root/>'.
	self
		should: [document innerXML: '<root1/><root2/>']
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLDOMParserTest >> testInnerXMLEntities [
	| document |

	document :=
		(XMLDOMParser on:
			'<!DOCTYPE test [
					<!ENTITY one "one">
					<!ENTITY two "two">
					<!ENTITY three "<!--comment-->">
				]>
			<test name="&one;">&one;</test>')
			preservesCommentNodes: true;
			parseDocument.
	self
		assert: (document root attributeAt: 'name') equals: 'one';
		assert: document root contentString equals: 'one'.

	document innerXML: '<test name="&two;">&three;</test>'.
	self
		assert: (document root attributeAt: 'name') equals: 'two';
		assert: document root hasChildren;
		assert: document root nodes size equals: 1;
		assert: document root firstNode isComment;
		assert: document root firstNode string equals: 'comment'.

	document root innerXML: '&two;'.
	self
		assert: (document root attributeAt: 'name') equals: 'two';
		assert: document root contentString equals: 'two'.

	self
		should: [document innerXML: '<test name="&undeclared;"></test>']
		raise: XMLWellFormednessException.
	self
		should: [document innerXML: '<test name="">&undeclared;</test>']
		raise: XMLWellFormednessException.
	self
		should: [document innerXML: '&three;<test/>']
		raise: XMLWellFormednessException.
	self
		should: [document innerXML: '<test/>&three;']
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLDOMParserTest >> testInternalAttributeDeclarations [
	| doctype firstAttribute secondAttribute |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetXMLWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	firstAttribute := doctype nodes second.
	self
		assert: firstAttribute element equals: 'root';
		assert: firstAttribute attribute equals: 'name';
		assert: firstAttribute type equals: 'CDATA';
		assert: firstAttribute defaultPragma equals: 'IMPLIED';
		assert: firstAttribute defaultValue equals: ''.

	secondAttribute := doctype nodes third.
	self
		assert: secondAttribute element equals: 'root';
		assert: secondAttribute attribute equals: 'number';
		assert: secondAttribute type equals: '(one|two|three)';
		assert: secondAttribute defaultPragma equals: '';
		assert: secondAttribute defaultValue equals: 'three'.
]

{ #category : #tests }
XMLDOMParserTest >> testInternalElementDeclaration [
	| doctype elementDeclaration |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetXMLWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.
	elementDeclaration := doctype nodes first.
	self
		assert: elementDeclaration element equals: 'root';
		assert: elementDeclaration contentModel equals: '(#PCDATA|one|two)*'.
]

{ #category : #tests }
XMLDOMParserTest >> testInternalGeneralEntityDeclarations [
	| doctype firstEntity secondEntity |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetXMLWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	firstEntity := doctype nodes fourth.
	self
		deny: firstEntity isParameter;
		assert: firstEntity name equals: 'general';
		assert: firstEntity replacement equals: 'replacement';
		assert: firstEntity publicID equals: '';
		assert: firstEntity systemID equals: '';
		assert: firstEntity ndata equals: ''.

	secondEntity := doctype nodes fifth.
	self
		deny: secondEntity isParameter;
		assert: secondEntity name equals: 'externalGeneral';
		assert: secondEntity replacement equals: '';
		assert: secondEntity publicID equals: 'pubid2';
		assert: secondEntity systemID equals: 'external1.dtd';
		assert: secondEntity ndata equals: ''.
]

{ #category : #tests }
XMLDOMParserTest >> testInternalNotationDeclarations [
	| doctype notation |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetXMLWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	notation := doctype nodes eighth.
	self
		assert: notation name equals: 'notation';
		assert: notation publicID equals: '';
		assert: notation systemID equals: 'note.doc'.
]

{ #category : #tests }
XMLDOMParserTest >> testInternalParameterEntityDeclarations [
	| doctype firstEntity secondEntity |

	doctype :=
		(XMLDOMParser
			parse: self internalSubsetXMLWithDeclarations
			usingNamespaces: true
			validation: true
			externalEntities: false) doctypeDeclaration.

	firstEntity := doctype nodes sixth.
	self
		assert: firstEntity isParameter;
		assert: firstEntity name equals: 'parameter';
		assert: firstEntity replacement equals: 'replacement';
		assert: firstEntity publicID equals: '';
		assert: firstEntity systemID equals: ''.

	secondEntity := doctype nodes seventh.
	self
		assert: secondEntity isParameter;
		assert: secondEntity name equals: 'externalParameter';
		assert: secondEntity replacement equals: '';
		assert: secondEntity publicID equals: '';
		assert: secondEntity systemID equals: 'external2.dtd'.
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
							assert: each prefix equals: 'book';
							assert: each namespaceURI equals: 'bookNS']
					ifFalse: [
						self
							assert: each prefix equals: 'ps';
							assert: each namespaceURI equals: 'personNS']]
			ifFalse: [
				self
					assert: each namespaceURI equals: 'defaultNS';
					deny: each hasPrefix;
					assert: each prefix equals: '']].
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesCopyOnWrite [
	| xml elements |

	xml := 
		'<one xmlns:prefix1="ns" xmlns="defualt">
			<two xmlns:prefix2="ns2"><three /></two>
			<four><five xmlns:prefix1="ns3" xmlns="defualt2" /></four>
		</one>'.
	elements := (XMLDOMParser parse: xml) allElements.
	self assert:
		(IdentitySet withAll: "avoid newFrom: for GS portability"
			(elements collect: [:each |
				each namespaceScope prefixMappings])) size equals: 3.

	elements := (XMLDOMParser parse: xml usingNamespaces: false) allElements.
	self assert:
		(IdentitySet withAll: "avoid newFrom: for GS portability"
			(elements collect: [:each |
				each namespaceScope prefixMappings])) size equals: elements size.
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
		self assert: each namespaceURI equals: ''.
		(each == document root or: [each isNamed: 'person'])
			ifTrue: [
				self
					assert: each hasPrefix;
					assert:
						each prefix equals:
							((each == document root) ifTrue: ['book'] ifFalse: ['ps'])]
			ifFalse: [
				self
					deny: each hasPrefix;
					assert: each prefix equals: '']].
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesDisabledAttributes [
	| document |

	document :=
		XMLDOMParser
			parse: '<root xmlns:prefix="prefixNS" xmlns="defaultNS" name="value"/>'
			usingNamespaces: false.
	self
		assert: document root attributeNames asArray equals: #('xmlns:prefix' 'xmlns' 'name');
		assert: (document root attributeAt: 'xmlns:prefix') equals: 'prefixNS';
		assert: (document root attributeAt: 'xmlns') equals: 'defaultNS';
		assert: (document root attributeAt: 'name') equals: 'value'.
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesDisabledReuse [
	| parser document oldRootScope newRootScope |

	parser := XMLDOMParser on: self addressBookNamespacedXML.
	document :=
		parser
			usesNamespaces: true;
			parseDocument.
	oldRootScope := document root namespaceScope.
	self assert: oldRootScope hasNamespaces.

	document :=
		parser
			on: self addressBookNamespacedXML;
			usesNamespaces: false;
			parseDocument.
	newRootScope := document root namespaceScope.
	self
		deny: newRootScope = oldRootScope;
		deny: newRootScope hasNamespaces.

	self
		should: [
			parser
				on: '<test xmlns:unused="unusedNS"><used:test/></test>';
				usesNamespaces: true;
				parseDocument]
		raise: XMLNamespaceException.
	self
		shouldnt: [
			document :=
				parser
					on: '<test xmlns:unused="unusedNS"><used:test/></test>';
					usesNamespaces: false;
					parseDocument]
		raise: XMLNamespaceException.
	self deny: document root hasNamespaces.
]

{ #category : #tests }
XMLDOMParserTest >> testNamespacesResolving [
	| document |

	document := XMLDOMParser parse: self addressBookNamespacedXML.
	document allElementsDo: [:each |
		self
			assert: each defaultNamespace equals: 'defaultNS';
			assert: (each resolvePrefix: '') equals: 'defaultNS';
			assert: (each resolvePrefix: 'book') equals: 'bookNS';
			assert: (each resolvePrefix: 'ps') equals: 'personNS';
			assert:
				each namespaceURI equals:
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
			assert: each defaultNamespace equals: '';
			assert: (each resolvePrefix: '') equals: '';
			assert: (each resolvePrefix: 'book') equals: '';
			assert: (each resolvePrefix: 'ps') equals: '';
			assert:
				each namespaceURI equals:
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
			ifNone: ['not found']) equals: 'not found'.
]

{ #category : #tests }
XMLDOMParserTest >> testNodeFactory [
	| parser oldNodeFactory newNodeFactory |

	parser := XMLDOMParser on: self addressBookXML.
	oldNodeFactory := parser nodeFactory.
	self assert: oldNodeFactory class == self nodeFactoryClass.

	newNodeFactory := self nodeFactoryClass new.
	self
		assert: (parser nodeFactory: newNodeFactory) == parser;
		assert: parser nodeFactory == newNodeFactory.
]

{ #category : #tests }
XMLDOMParserTest >> testNodeListClass [
	(Array
		with: XMLNodeList
		with: XMLCachingNodeList)
		do: [:listClass | | document parser |
			parser := XMLDOMParser on: self addressBookXML.
			parser configuration nodeListClass: listClass.
			document := parser parseDocument.
			self
				assert: parser configuration nodeListClass == listClass;
				assert: document nodes class == listClass.
			document allElements do: [:each |
				self assert: each nodes class == listClass]]
]

{ #category : #tests }
XMLDOMParserTest >> testNodeParent [
	(XMLDOMParser parse: self addressBookXML) allNodesDo: [:node |
		node hasChildren
			ifTrue: [
				node nodesDo: [:each |
					self
						assert: each hasParent;
						assert: each parent == node]]]
]

{ #category : #tests }
XMLDOMParserTest >> testNodeStack [
	| parser  |

	parser := XMLDOMParser on: self addressBookXML.
	self assert: parser nodeStack isEmpty.

	parser := XMLDOMParser on: self addressBookXML.
	parser parser parseToken.
	self deny: parser nodeStack isEmpty.

	parser on: self addressBookXML.
	self assert: parser nodeStack isEmpty.
]

{ #category : #tests }
XMLDOMParserTest >> testOptimizeForLargeDocuments [
	| parser |

	parser := XMLDOMParser on: ''.

	parser optimizeForLargeDocuments.
	self
		deny: parser isValidating;
		deny: parser usesNamespaces;
		assert: parser documentReadLimit isNil;
		assert: parser nodeFactory attributeListClass == XMLAttributeList.
]

{ #category : #tests }
XMLDOMParserTest >> testOverridingDefaultNamespace [
	| document |

	document :=
		XMLDOMParser parse:
			'<outer xmlns="default"><inner xmlns=""/></outer>'.
	self
		assert: document root namespaceURI equals: 'default';
		assert: document root defaultNamespace equals: 'default';
		assert: document root firstNode namespaceURI equals: '';
		assert: document root firstNode defaultNamespace equals: ''.
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
		assert: document allNodes size equals: 4;
		assert: (document findElementNamed: 'one') nodes size equals: 1;
		assert: (document findElementNamed: 'one') contentString equals: 'two'.
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
		assert: document allNodes size equals: 4;
		assert: (document findElementNamed: 'one') nodes size equals: 1;
		assert: (document findElementNamed: 'one') contentString equals: 'two'.
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
		document elementNames equals:
			(document elements collect: [:each | each name ]).

	document allElementsDo: [:element |
		self assert:
			element elementNames equals:
				(element elements collect: [:each | each name])].
]

{ #category : #tests }
XMLDOMParserTest >> testPreservesCDataNodes [
	| parser |

	parser := XMLDOMParser on: self addressBookXML.
	self
		deny: parser preservesCDataNodes;
		assert: (parser preservesCDataNodes: true) == parser;
		assert: parser preservesCDataNodes;
		assert: (parser preservesCDataNodes: false) == parser;
		deny: parser preservesCDataNodes.
]

{ #category : #tests }
XMLDOMParserTest >> testPreservesCommentNodes [
	| parser |

	parser := XMLDOMParser on: self addressBookXML.
	self
		deny: parser preservesCommentNodes;
		assert: (parser preservesCommentNodes: true) == parser;
		assert: parser preservesCommentNodes;
		assert: (parser preservesCommentNodes: false) == parser;
		deny: parser preservesCommentNodes.
]

{ #category : #tests }
XMLDOMParserTest >> testPreservesIgnorableWhitespace [
	| parser |

	parser := XMLDOMParser on: self addressBookXML.
	parser isValidating: false.
	"should enable validation"
	self
		deny: parser preservesIgnorableWhitespace;
		assert: (parser preservesIgnorableWhitespace: true) == parser;
		assert: parser preservesIgnorableWhitespace;
		assert: parser isValidating.

	"disabling validation should disable it"
	self
		assert: (parser isValidating: false) == parser;
		deny: parser preservesIgnorableWhitespace;
		deny: parser isValidating
]

{ #category : #tests }
XMLDOMParserTest >> testProcessingInstruction [
	| document |

	document :=
		XMLDOMParser parse:
			'<?xml version="1.1" standalone="yes"?><?firstTarget first>Data?>',
			'<root><?secondTarget second?Data?></root> '.

	self
		assert: document version equals: 1.1;
		assert: document nodes size equals: 2;
		assert: document firstNode isPI;
		assert: document firstNode target equals: 'firstTarget';
		assert: document firstNode data equals: 'first>Data';
		assert: document root firstNode target equals: 'secondTarget';
		assert: document root firstNode data equals: 'second?Data'.
]

{ #category : #tests }
XMLDOMParserTest >> testProcessingInstructionEntityReplacement [
	| document doctypeDeclaration root |

	document :=
		XMLDOMParser parse:
			'<?xml version="1.1" standalone="yes"?>
			<!DOCTYPE root [
				<!ENTITY % first "<?firstTarget first>Data?>">
				%first;
				<!ENTITY second "<?secondTarget second?Data?>">
			]><root>&second;</root> '.

	self
		assert: document version equals: 1.1;
		assert: document hasDoctypeDeclaration;
		assert: document nodes size equals: 1.

	doctypeDeclaration := document doctypeDeclaration.
	self
		assert: doctypeDeclaration nodes size equals: 3;
		assert: doctypeDeclaration nodes second isPI;
		assert: doctypeDeclaration nodes second target equals: 'firstTarget';
		assert: doctypeDeclaration nodes second data equals: 'first>Data'.

	root := document root.
	self
		assert: root nodes size equals: 1;
		assert: root firstNode isPI;
		assert: root firstNode target equals: 'secondTarget';
		assert: root firstNode data equals: 'second?Data'.
]

{ #category : #tests }
XMLDOMParserTest >> testRootElement [
	| document root  |

	document := XMLDOMParser parse: self addressBookXML.
	self assert: document class == XMLDocument.
	root := document root.
	self assert: (root class == XMLElement).

	self assert:
		(root allNodesDetect: [:each |
			each isElement
				and: [each isNamedAny: #('AddressBook' 'addressbook')]]) == root.
	self assert: (root findElementNamed: 'addressbook') == root.
]

{ #category : #tests }
XMLDOMParserTest >> testUnreplacedEntityRererencePrinting [
	| xml |

	xml :=
		'<!DOCTYPE one [<!ENTITY three "three">]>',
		'<one two="&quot;&three;&quot;">',
		'&lt;four five=&#34;&amp;six;&#34;/&gt;',
		'</one>'.
	self assert:
		((XMLDOMParser on: xml)
			isValidating: false;
			replacesContentEntityReferences: false;
			parseDocument) printString equals: xml.
]

{ #category : #tests }
XMLDOMParserTest >> testWhitespacePreservation [
	| xml root notPreserved preserved |

	xml := '
		<!DOCTYPE root [
			<!ELEMENT root (not-preserved)>
			<!ELEMENT not-preserved (preserved+)>
			<!ELEMENT preserved (not-preserved?)>
			<!ATTLIST root xml:space (default|preserve) #IMPLIED>
			<!ATTLIST not-preserved xml:space (default|preserve) #IMPLIED>
			<!ATTLIST preserved xml:space (default|preserve) "preserve">
		]>
		<root xml:space="preserve">
			<not-preserved xml:space="default">
				<preserved>
				</preserved>
			</not-preserved>
		</root>'.
	root := (XMLDOMParser parse: xml) root.
	self
		assert: root nodes size equals: 3;
		assert: root nodes first isStringNode;
		assert: root nodes first isWhitespace;
		assert: (root nodes second isElementNamed: 'not-preserved');
		assert: root nodes third isStringNode;
		assert: root nodes third isWhitespace.

	notPreserved := root nodes second.
	self
		assert: notPreserved nodes size equals: 1;
		assert: (notPreserved nodes first isElementNamed: 'preserved').

	preserved := notPreserved firstNode.
	self
		assert: preserved nodes size equals: 1;
		assert: preserved nodes first isStringNode;
		assert: preserved nodes first isWhitespace.
]

{ #category : #tests }
XMLDOMParserTest >> testXMLDeclaration [
	| document |

	document :=
		XMLDOMParser parse:
			'<?xml version="1.0" encoding="UTF-8"?><test/>'.
	self
		assert: document version equals: 1.0;
		assert: document encoding equals: 'UTF-8';
		deny: document isStandalone.

	document :=
		XMLDOMParser parse:
			'<?xml version="1.1" encoding="utf-8" standalone="yes"?><test/>'.
	self
		assert: document version equals: 1.1;
		assert: document encoding equals: 'utf-8';
		assert: document isStandalone.
]

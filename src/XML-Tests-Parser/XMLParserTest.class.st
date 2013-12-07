Class {
	#name : #XMLParserTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
XMLParserTest >> addressBookXML [
	^'<addressbook>
  <person employee-number="A0000" family-name="Gates" first-name="Bob">
    <contact-info><!--Confidential--></contact-info>
    <address city="Los Angeles" number="1239" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Manager"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7000" family-name="Brown"
    first-name="Robert" middle-initial="L.">
    <contact-info>
      <email address="robb@iro.ibm.com"/>
      <home-phone number="03-3987873"/>
    </contact-info>
    <address city="New York" number="344" state="NY" street="118 St."/>
    <job-info employee-type="Full-Time" is-manager="yes" job-description="Group Leader"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7890" family-name="DePaiva"
    first-name="Kassie" middle-initial="W.">
    <contact-info><!-- Kassie''s agent phone: 03-987654 --></contact-info>
    <address city="Los Angeles" number="1234" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Actor"/>
    <manager employee-number="A0000"/>
    <misc-info>One of the most talented actresses on Daytime. Kassie
      plays the devious and beautiful Blair Cramer on ABC&apos;s
      &quot;One Life To Live.&quot;</misc-info>
  </person>
  <person employee-number="A7987" family-name="Smith" first-name="Joe">
    <contact-info>
      <email address="joes@iro.ibm.com"/>
      <mobile-phone number="888-7657765"/>
      <home-phone number="03-8767898"/>
      <home-phone number="03-8767871"/>
    </contact-info>
    <address city="New York" number="12789" state="NY" street="W. 15th Ave."/>
    <job-info employee-type="Part-Time" is-manager="no" job-description="Hacker"/>
    <manager employee-number="A7000"/>
  </person>
</addressbook>
'
]

{ #category : #source }
XMLParserTest >> addressBookXMLWithDTD [
	^'<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE addressbook SYSTEM "addressbook.dtd">
<?xml-stylesheet type="text/xsl" href="demo.xsl"?>
<addressbook>
  <person employee-number="A0000" family-name="Gates" first-name="Bob">
    <contact-info><!--Confidential--></contact-info>
    <address city="Los Angeles" number="1239" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Manager"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7000" family-name="Brown"
    first-name="Robert" middle-initial="L.">
    <contact-info>
      <email address="robb@iro.ibm.com"/>
      <home-phone number="03-3987873"/>
    </contact-info>
    <address city="New York" number="344" state="NY" street="118 St."/>
    <job-info employee-type="Full-Time" is-manager="yes" job-description="Group Leader"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7890" family-name="DePaiva"
    first-name="Kassie" middle-initial="W.">
    <contact-info><!-- Kassie''s agent phone: 03-987654 --></contact-info>
    <address city="Los Angeles" number="1234" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Actor"/>
    <manager employee-number="A0000"/>
    <misc-info>One of the most talented actresses on Daytime. Kassie
      plays the devious and beautiful Blair Cramer on ABC&apos;s
      &quot;One Life To Live.&quot;</misc-info>
  </person>
  <person employee-number="A7987" family-name="Smith" first-name="Joe">
    <contact-info>
      <email address="joes@iro.ibm.com"/>
      <mobile-phone number="888-7657765"/>
      <home-phone number="03-8767898"/>
      <home-phone number="03-8767871"/>
    </contact-info>
    <address city="New York" number="12789" state="NY" street="W. 15th Ave."/>
    <job-info employee-type="Part-Time" is-manager="no" job-description="Hacker"/>
    <manager employee-number="A7000"/>
  </person>
</addressbook>
'
]

{ #category : #benchmark }
XMLParserTest >> benchmark1 [
	"
	XMLParserTest new benchmark1
	600 timesRepeat => 2131 (Alexandre Bergel 3/29/2010 09:09)
	"
	Smalltalk garbageCollect.
	^ [4000 timesRepeat: [SAXHandler parse: self addressBookXML]] timeToRun
]

{ #category : #benchmark }
XMLParserTest >> benchmark2 [
	"
	XMLParserTest new benchmark2
	"
	Smalltalk garbageCollect.
	^ [4000 timesRepeat: [XMLDOMParser parse: self addressBookXML]] timeToRun
]

{ #category : #benchmark }
XMLParserTest >> benchmark3 [
	"
	XMLParserTest new benchmark3
	"
	Smalltalk garbageCollect.
	^ [4000 timesRepeat: [self testParsing]] timeToRun
]

{ #category : #benchmark }
XMLParserTest >> benchmark4 [
	| doc |
	"
	XMLParserTest new benchmark4
	"
	doc := XMLDOMParser
		parse: self addressBookXML readStream
		usingNamespaces: false.
	^ [500000 timesRepeat: [
		doc root firstElement
			elementAt: 'contact-info';
			elementAt: 'address';
			elementAt: 'job-info';
			elementAt: 'manager']] timeToRun.
]

{ #category : #source }
XMLParserTest >> exampleCDATASectionXML [
	^'<?xml version="1.0" encoding="UTF-8"?>
<test-data><![CDATA[this is CDATA test content 1 < 2 & 5 > 3]]></test-data>'
]

{ #category : #source }
XMLParserTest >> exampleEncodedXML [
	^'<?xml version="1.0" encoding="UTF-8"?>
<test-data>&#8230;</test-data>
'
]

{ #category : #tests }
XMLParserTest >> testAttributeDefaultDeclaration [
	| dtd document |

	dtd := '<!DOCTYPE root [
		<!ATTLIST root one #IMPLIED >
		<!ATTLIST root two #REQUIRED >
		<!ATTLIST root three #FIXED "fixedDefault" >
		<!ATTLIST root three #FIXED "redundant" >
		<!ATTLIST root four "default" >]>'.
	document := XMLDOMParser parse: dtd, '<root two="required" three="nonDefault" />'.
	self
		assert: (document root attributeAt: 'two') = 'required';
		assert: (document root includesAttribute: 'one');
		assert: (document root attributeAt: 'three') = 'fixedDefault';
		assert: (document root attributeAt: 'four') = 'default'.
	self should: [XMLDOMParser parse: dtd, '<root />'] raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeEntityDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ENTITY firstEntity SYSTEM "first.txt" NDATA first>
		<!ENTITY secondEntity SYSTEM "second.txt" NDATA second>
		<!ATTLIST root unparsedEntity ENTITY #IMPLIED>
		<!ATTLIST root unparsedEntities ENTITIES #IMPLIED>]>'.
	XMLDOMParser parse: dtd, '<root unparsedEntity="firstEntity"  unparsedEntities="firstEntity  secondEntity"/> '.
	self
		should: [XMLDOMParser parse: dtd, '<root unparsedEntity="thirdEntity"/>']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root unparsedEntity="secondEntity thirdEntity"/>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeEnumerationDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ATTLIST root number ( one | two | three) #IMPLIED >
		<!NOTATION txtFile PUBLIC "//file.txt//">
		<!NOTATION confFile PUBLIC "//file.conf//">
		<!ATTLIST root note NOTATION (txtFile | confFile ) #IMPLIED>]>'.
	self
		shouldnt: [XMLDOMParser parse: dtd, '<root number="two" note="txtFile"/>']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root number="four"/>']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root note="htmlFile" />']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeIDDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [<!ATTLIST unique id ID #REQUIRED>]>'.
	XMLDOMParser parse: dtd, '<root><unique id=" one "/><unique id="two"/></root> '.
	self
		should: [
			XMLDOMParser parse:
				dtd, '<root><unique id="one"/><unique id=" one "/></root> ']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeIDRefDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ATTLIST unique id ID #REQUIRED>
		<!ATTLIST ref idref IDREF #REQUIRED>
		<!ATTLIST refs idrefs IDREFS #REQUIRED>]>'.
	XMLDOMParser parse:
		dtd, '<root>
		<unique id=" one "/><unique id=" two "/>
		<ref idref="one"/><refs idrefs="  one  two"/>
		</root> '.
	self
		should: [
			XMLDOMParser parse:
				dtd, '<root><unique id="one"/><ref idref="two"/></root> ']
		raise: XMLValidationException.
	self
		should: [
			XMLDOMParser parse:
				dtd, '<root><unique id="one"/><refs idrefs="one two"/></root> ']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeNmtokenDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ATTLIST root name NMTOKEN #IMPLIED>
		<!ATTLIST root names NMTOKENS #IMPLIED>]>'.
	XMLDOMParser parse: dtd, '<root name="one" names="  one  two three"/> '.
	self
		should: [XMLDOMParser parse: dtd, '<root name="1"/> ']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root names="1 2 3" />']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeValueNormalization [
	| separators unnormalized normalized document |

	separators :=
		String
			with: Character space
			with: Character tab
			with: Character lf.
	unnormalized := separators, 'nonspace', separators.
	normalized := '   nonspace   '.
	document :=
		(XMLDOMParser parse:
			'<root name="', unnormalized,'">', unnormalized, '</root>').
	self
		assert: (document root attributeAt: 'name') = normalized;
		assert: (document root contentString) = unnormalized.
]

{ #category : #tests }
XMLParserTest >> testCDATASection [
	| document element output escapedOutput |

	output := 'this is CDATA test content 1 < 2 & 5 > 3'.
	escapedOutput := 'this is CDATA test content 1 &lt; 2 &amp; 5 &gt; 3'.

	document := XMLDOMParser parse: self exampleCDATASectionXML.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size = 1;
		assert: element firstNode isStringNode;
		assert: element firstNode printString = escapedOutput.

	document :=
		(XMLDOMParser on: self exampleCDATASectionXML)
			preservesCDataNodes: true;
			parseDocument.
	element := document findElementNamed: 'test-data'.
	self
		assert: element nodes size = 1;
		assert: element firstNode isCData;
		assert: element firstNode printString = ('<![CDATA[',output,']]>').
]

{ #category : #tests }
XMLParserTest >> testComments [
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

{ #category : #'tests-xmltokenizer' }
XMLParserTest >> testConditionalSection [
	| tokenizer |

	tokenizer :=
		XMLTokenizer
			driver: nil
			on:
			'<![INCLUDE [included',
			'<![ IGNORE [ignored; <![INCLUDE[ignored;]]> ignored.]]>',
			', included]]>, included.'.
	tokenizer tokenContext enterInternalSubset.
	tokenizer nextToken.
	self assert: tokenizer streamReader upToEnd = 'included, included, included.'
]

{ #category : #tests }
XMLParserTest >> testDeclaringNamespaces [
	self
		shouldnt: [SAXHandler parse: '<prefix:root prefix:name="test" xmlns:prefix="NS"/>']
		raise: XMLNamespaceException.
	self
		shouldnt: [SAXHandler parse: '<root xmlns="defaultNS"/>']
		raise: XMLNamespaceException.

	"Cannot change xmlns or xml prefixes"
	self
		should: [SAXHandler parse: '<root xmlns:xmlns="newNS"/>']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<root xmlns:xml="newNS" />']
		raise: XMLNamespaceException.
]

{ #category : #'tests-utf8' }
XMLParserTest >> testDecodingCharacters [
	| xmlDocument element |

	xmlDocument := XMLDOMParser parse: self exampleEncodedXML.
	element := xmlDocument findElementNamed: 'test-data'.

	self assert: element contentString first charCode = 8230.	


]

{ #category : #tests }
XMLParserTest >> testDisabledNamespacesAttributes [
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

{ #category : #tests }
XMLParserTest >> testDoctypeRoot [
	| xml |

	xml := '<!DOCTYPE root><invalidRoot/>'.
	self
		should: [SAXHandler parse: xml]
		raise: XMLValidationException.
	self
		shouldnt: [
			SAXHandler
				parse: xml
				usingNamespaces: false
				validation: false]
		raise: XMLValidationException 
]

{ #category : #tests }
XMLParserTest >> testElementAnyAndEmptyDeclarations [
	self
		shouldnt: [
			SAXHandler parse: 
				'<!DOCTYPE addressbook [<!ELEMENT addressbook ANY>]>',
				self addressBookXML]
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse: 
				'<!DOCTYPE addressbook [<!ELEMENT addressbook EMPTY>]>',
				self addressBookXML]
		raise: XMLValidationException
]

{ #category : #tests }
XMLParserTest >> testElementContentModels [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ELEMENT numbers (one,two?,three)>
		<!ELEMENT colors (red|blue|green)*>
		<!ELEMENT days (mon+,tue*,wed)>]>'.

	XMLDOMParser parse: dtd, '<root><numbers><one/><two/><three/></numbers></root>'.
	XMLDOMParser parse: dtd, '<root><numbers><one/><three/></numbers></root>'.
	self
		should: [
			XMLDOMParser parse:
				dtd, '<root><numbers><one/><two/><two/><three/></root></numbers>']
		raise: XMLValidationException.

	XMLDOMParser parse: dtd, '<root><colors/></root>'.
	XMLDOMParser parse: dtd, '<root><colors><red/><green/><blue/><red/></colors></root>'.
	self
		should: [XMLDOMParser parse: dtd, '<root><colors><orange/></colors></root>']
		raise: XMLValidationException.

	XMLDOMParser parse: dtd, '<root><days><mon/><mon/><tue/><wed/></days></root>'.
	XMLDOMParser parse: dtd, '<root><days><mon/><wed/></days></root>'.
	self
		should: [XMLDOMParser parse: dtd, '<root><days><tue/></wed></root>']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root><days><mon/><tue/><fri/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementMixedContentDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ELEMENT root (#PCDATA | one | two | three)*>
		<!ELEMENT two (#PCDATA)>
		<!ELEMENT three (#PCDATA)*>]>'.
	self
		shouldnt: [
			XMLDOMParser parse:
				dtd, '<root>text<one/><two><![CDATA[text]]></two></root>']
		raise: XMLValidationException.
	self
		shouldnt: [XMLDOMParser parse: dtd, '<root><three>text<!--comment--></three></root>']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root><four/></root>']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root><two><three/></two></root>']
		raise: XMLValidationException.
	self
		should: [
			XMLDOMParser parse: "missing *"
				'<!DOCTYPE root [<!ELEMENT root (#PCDATA|one)>]><root/>']
		raise: XMLValidationException.
	'+*?,' do: [:each |
		self
			should: [
				XMLDOMParser parse:
					'<!DOCTYPE root [<!ELEMENT two (#PCDATA', each asString, ')>]><root/>']
			raise: XMLValidationException].
]

{ #category : #tests }
XMLParserTest >> testEntityReplacement [
	| document |

	document := XMLDOMParser parse: '
		<!DOCTYPE root [
			<!ENTITY % partialDeclaration "name1 &#39;replacement1&#x27;">
			<!ENTITY % name1Declaration "<!ENTITY %partialDeclaration;>">
			%name1Declaration;
			<!ENTITY name2 "replacement2 &name1;" >
			<!ENTITY name3 "replacement3 &name2;" >
			<!ENTITY predefined "&amp;&gt;&lt;&quot;&apos;" >
			<!ENTITY quotes "&#x22;&#39;">
		]>
		<root name="&quotes;">&name1; &name2; &name3; ',
		'&predefined; &amp;&gt;&lt;&quot;&apos; %name1Declaration;</root>'.
	self assert:
		document root contentString =
			('replacement1 ',
			'replacement2 replacement1 ',
			'replacement3 replacement2 replacement1 ',
			'&><"'' &><"'' %name1Declaration;').
	self assert: (document root attributeAt: 'name') = (String with: $" with: $').
]

{ #category : #tests }
XMLParserTest >> testExampleAddressBook [
	| tokenizer |
	"self debug: #testExampleAddressBook"

	tokenizer :=
		XMLTokenizer
			driver: nil
			on: self addressBookXML readStream.

	"We enumerate the first characters of the addressbook example.
	The file being parsed begins with <addressbook"
	self assert: tokenizer streamReader next = $<.
	self assert: tokenizer streamReader next = $a.	
	self assert: tokenizer streamReader next = $d.
	self assert: tokenizer streamReader next = $d.
	self assert: tokenizer streamReader next = $r.

	self
		shouldnt: [tokenizer streamReader next notNil] whileTrue
		raise: Error. 
]

{ #category : #tests }
XMLParserTest >> testExampleAddressBookWithDTD [
	| tokenizer |
	"XMLTokenizer exampleAddressBookWithDTD"

	tokenizer :=
		XMLTokenizer
			driver: nil
			on: self addressBookXMLWithDTD readStream.
	self
		shouldnt: [tokenizer streamReader next notNil] whileTrue
		raise: Error
]

{ #category : #tests }
XMLParserTest >> testFileClientPaths [
	| fileClient cwd |

	fileClient := XMLFileClient defaultImplementation new.
	cwd := fileClient currentWorkingDirectory.
	self
		assert: cwd first == $/;
		deny: cwd last == $/;
		assert: (fileClient combineRelative: 'relative' withBase: 'relative/path') = 'relative/relative';
		assert: (fileClient combineRelative: 'relative/path' withBase: 'relative/path') = 'relative/relative/path';
		assert: (fileClient combineRelative: 'relative' withBase: cwd) = (cwd, '/relative');
		assert: (fileClient combineRelative: '/nonrelative' withBase: cwd) = '/nonrelative';
		assert: (fileClient combineRelative: 'relative' withBase: cwd) = (cwd, '/relative');
		assert: (fileClient combineRelative: '../../relative' withBase: cwd) = (cwd, '/../../relative');
		assert: (fileClient combineRelative: './relative' withBase: cwd) = (cwd, '/relative');
		assert: (fileClient combineRelative: '.relative' withBase: cwd) = (cwd, '/.relative').
]

{ #category : #tests }
XMLParserTest >> testHTTPClientPaths [
	| httpClient domain directoryUrl documentUrl queryUrl |

	httpClient := XMLHTTPClient defaultImplementation new.
	domain := 'http://www.example.com'.
	directoryUrl := domain, '/documents/'.
	documentUrl := directoryUrl, 'document.xml'.
	queryUrl := documentUrl, '?name=value'.
	self
		assert: (httpClient combineRelative: directoryUrl withBase: domain) = directoryUrl;
		assert: (httpClient combineRelative: '/nonrelative' withBase: domain) = (domain, '/nonrelative');
		assert: (httpClient combineRelative: '/nonrelative' withBase: directoryUrl) = (domain, '/nonrelative');
		assert: (httpClient combineRelative: '/nonrelative' withBase: documentUrl) = (domain, '/nonrelative');
		assert: (httpClient combineRelative: 'relative.xml' withBase: directoryUrl) = (directoryUrl, 'relative.xml');
		assert: (httpClient combineRelative: 'relative.xml' withBase: documentUrl) = (directoryUrl, 'relative.xml');
		assert: (httpClient combineRelative: 'relative.xml' withBase: queryUrl) = (directoryUrl, 'relative.xml').
]

{ #category : #tests }
XMLParserTest >> testInnerXML [
	| document contactInfo address1 address2 |

	document := XMLDOMParser parse: self addressBookXML.
	document allElementsNamed: 'person' do: [:person |
		address1 := (person attributeAt: 'first-name'), '@example.com'.
		address2 := (person attributeAt: 'first-name'), '@users.example.com'.
		(contactInfo := person elementAt: 'contact-info')
			innerXML: '<email>', address1, '</email><email2>', address2, '</email2>'.

		self
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
XMLParserTest >> testInvalidElementContentModels [
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root ()>]>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one,)>]>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one|)>]>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one)(two)>]>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one|,two)>]>']
		raise: XMLValidationException.
	'|,?*+' do: [:each |
		self
			should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (', each asString, 'one)>]>']
			raise: XMLValidationException].
]

{ #category : #tests }
XMLParserTest >> testLineEndingsDoNotMatter [
	| source docFromSourceWithCrs docFromSourceWithLfs docFromSourceWithCrlfs |

	source := '<root>{1}one{1}two{1}</root>'.
	docFromSourceWithCrs := XMLDOMParser parse: (source format: (Array with: String cr)).
	docFromSourceWithLfs := XMLDOMParser parse: (source format: (Array with: String lf)).
	docFromSourceWithCrlfs := XMLDOMParser parse: (source format: (Array with: String crlf)).
	self
		assert: (docFromSourceWithCrs root contentString) = (docFromSourceWithLfs root contentString);
		assert: (docFromSourceWithLfs root contentString) = (docFromSourceWithCrlfs root contentString).
]

{ #category : #tests }
XMLParserTest >> testParsing [
	| document root firstPerson persons |
	"self debug: #testParsing"

	document := XMLDOMParser parse: self addressBookXML.
	self assert: (document isKindOf: XMLDocument).
	root := document root.
	self assert: (root class == XMLElement).

	self assert:
		(root allNodesDetect: [:each |
			each isElement
				and: [each isNamedAny: #('AddressBook' 'addressbook')]]) == root.
	self assert: (root findElementNamed: 'addressbook') == root.

	persons := 	root allNodesSelect: [:each |
			each isElement and: [each isNamedAny: #('Person' 'person')]].
	self assert: persons size = 4.
	root allElementsNamed: 'person' do: [:p |
		self assert: (persons includes: p).
		persons remove: p].
	self assert: persons isEmpty.

	firstPerson := root findElementNamed: 'person'.
	self assert:
		(firstPerson allElements collect: [:each | each name]) asArray =
			#('person' 'contact-info' 'address' 'job-info' 'manager').
	self assert:
		(firstPerson nodesCollect: [:each | each name]) asArray =
			#('contact-info' 'address' 'job-info' 'manager').
	self assert: (firstPerson attributeAt: 'employee-number') = 'A0000'.
	self assert: (firstPerson attributeAt: 'family-name') = 'Gates'.
	self assert: (firstPerson attributeAt: 'first-name') = 'Bob'.
	self assert: firstPerson attributeNames asArray =
		#('employee-number' 'family-name' 'first-name').
	self assert: firstPerson attributeAssociations asArray =
		{('employee-number'->'A0000'). ('family-name'->'Gates'). ('first-name'->'Bob').}.
]

{ #category : #tests }
XMLParserTest >> testParsingHTML [
	| document |
	
	document := HTMLParser parse: 'text'.
	self
		assert: document allNodes size = 4;
		assert: (document allElementsCollect: [:each | each name]) asArray = #('html' 'body');
		assert: (document findElementNamed: 'body') contentString = 'text'.

	document := HTMLParser parse:
		'<head><title><b>"title</b></title><script>',
		'1 < 2; 3 > 2; document.write("</script>");</script>
		<style>//"</style><head>'.
	self
		assert: (document findElementNamed: 'title') contentString = '<b>"title</b>';
		assert: (document findElementNamed: 'script') contentString =
			'1 < 2; 3 > 2; document.write("</script>");';
		assert: (document findElementNamed: 'style') contentString = '//"'.

	document := HTMLParser parse: '<head><p>text<title>reopened'.
	self
		assert: (document root elementsCollect: [:each | each name]) asArray = #('head' 'body');
		assert: (document findElementNamed: 'head') elements size = 1;
		assert: ((document findElementNamed: 'head') elementAt: 'title') contentString = 'reopened';
		assert: (document findElementNamed: 'body') elements size = 1;
		assert: ((document findElementNamed: 'body') elementAt: 'p') contentString = 'text'.

	document := HTMLParser parse: '<body>one<img>two</img><body>three'.
	self
		assert: (document allElementsCollect: [:each | each name]) asArray = #('html' 'body' 'img');
		assert: (document findElementNamed: 'body') contentString = 'one twothree';
		deny: (document findElementNamed: 'img') hasChildren.

	self assert:
		((HTMLParser parse: '<html><b></body></html><i>')
			allElementsCollect: [:each | each name]) asArray = #('html' 'body' 'b' 'i').
]

{ #category : #tests }
XMLParserTest >> testParsingNamespaces [
	| document people person |

	document :=
		XMLDOMParser parse:
			'<root xmlns="defaultNS" xmlns:ps="personNS">',
			self addressBookXML,
			'</root>'.

	people := document allElementsNamed: 'person' namespaceURI: 'defaultNS'.
	self assert: people size = 4.
	self assert:
		(document allElementsNamed: 'person' namespaceURI: 'undeclaredNS') isEmpty.

	(person := people third) prefix: 'ps'.
	self assert:
		person == (document findElementNamed: 'person' namespaceURI: 'personNS').
	self assert:
		(people copyWithout: person) =
			((document findElementNamed: 'addressbook') nodesSelect: [:each |
				each isElement and: [each namespaceURI = 'defaultNS']]).
	self assert:
		people second ==
			((document findElementNamed: 'addressbook') nodesDetect: [:each |
				each isElement and: [(each attributeAt: 'family-name') = 'Brown']]).
	self assert:
		(document
			findElementNamed: 'person'
			namespaceURI: 'defaultNS'
			with: [:each | (each attributeAt: 'employee-number') = 'A7987']) == people last.
]

{ #category : #tests }
XMLParserTest >> testProcessingInstructions [
	| document |

	document :=
		XMLDOMParser parse:
			'<?xml version="1.1" standalone="yes"?><?firstTarget firstData?>',
			'<root><?secondTarget secondData?></root> '.

	self
		assert: document version = 1.1;
		assert: document nodes size = 2;
		assert: document firstNode isPI;
		assert: document firstNode target = 'firstTarget';
		assert: document firstNode data = 'firstData';
		assert: document root firstNode target = 'secondTarget';
		assert: document root firstNode data = 'secondData'.
]

{ #category : #tests }
XMLParserTest >> testRecursiveGeneralEntityReplacement [
	self
		shouldnt: [
			SAXHandler parse:
				'<!DOCTYPE root [
					<!ENTITY first "&second;">
					<!ENTITY second "&third;">
					<!ENTITY third "last">]>
				<root>&first;</root>']
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [
					<!ENTITY first "&second;">
					<!ENTITY second "&third;">
					<!ENTITY third "&fourth;">
					<!ENTITY fourth "last">]>
				<root>&first;</root>']
		raise: XMLParserException.
]

{ #category : #tests }
XMLParserTest >> testRecursiveParameterEntityReplacement [
	self
		shouldnt: [
			SAXHandler parse:
				'<!DOCTYPE root [
					<!ENTITY % first "&#37;second;">
					<!ENTITY % second "&#37;third;">
					<!ENTITY % third "<!--last-->">
					%first;]>
				<root/>']
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [
					<!ENTITY % first "&#37;second;">
					<!ENTITY % second "&#37;third;">
					<!ENTITY % third "&#37;fourth;">
					<!ENTITY % fourth "<!--last-->">
					%first;]>
				<root/>']
		raise: XMLParserException.
]

{ #category : #tests }
XMLParserTest >> testSAXEntityHandlers [
	| xml parser |

	xml := '<!DOCTYPE root [
		<!ENTITY first " &second; ">
		<!ENTITY second " replacement ">]>
	<root>&first;</root>'.
	(parser :=SAXHandlerProxy saxHandler: (SAXHandler on: xml)) parseDocument.
	self assert:
		#(startDocument
			startDTD:publicID:systemID:
			generalEntityDeclaration:replacement: generalEntityDeclaration:replacement:
			endDTD
			startElement:prefix:uri:localName:attributes:
			startEntity: startEntity: endEntity: endEntity: characters:
			endElement:prefix:uri:localName:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		((parser sentHandlerMessages select: [:each | #(startEntity: endEntity:) includes: each selector])
			collect: [:each | each arguments first]) asArray = #('first' 'second' 'second' 'first').
]

{ #category : #tests }
XMLParserTest >> testSAXIgnorableWhitespace [
	| xml parser |

	xml := '
	<root>
		<child>
			test
		</child>
	</root>
	'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml)) parseDocument.
	self assert:
		#(startDocument
			startElement:prefix:uri:localName:attributes:
			ignorableWhitespace:
			startElement:prefix:uri:localName:attributes: characters: endElement:prefix:uri:localName:
			ignorableWhitespace:
			endElement:prefix:uri:localName:
			ignorableWhitespace:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		((parser sentHandlerMessages select: [:each | each selector == #ignorableWhitespace:])
			allSatisfy: [:each | each arguments first notEmpty]).
]

{ #category : #tests }
XMLParserTest >> testSAXPrefixMappingHandlers [
	| xml parser |

	xml := '<prefix:root xmlns:prefix="prefixNS" xmlns="defaultNS"></prefix:root>'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml)) parseDocument.
	self assert:
		#(startDocument
			startPrefixMapping:uri: startPrefixMapping:uri:
			startElement:prefix:uri:localName:attributes: endElement:prefix:uri:localName:
			endPrefixMapping: endPrefixMapping:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		((parser sentHandlerMessages select: [:each |
			#(startPrefixMapping:uri: endPrefixMapping:) includes: each selector])
				collect: [:each | each arguments asArray]) asArray =
					#(#('prefix' 'prefixNS') #('' 'defaultNS') #('prefix') #('')).
]

{ #category : #tests }
XMLParserTest >> testSAXPrefixMappingHandlersDisabled [
	| xml parser |

	xml := '<prefix:root xmlns:prefix="prefixNS" xmlns="defaultNS"></prefix:root>'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml))
		usesNamespaces: false;
		parseDocument.
	self assert:
		#(startDocument
			startElement:prefix:uri:localName:attributes: endElement:prefix:uri:localName:
			endDocument) = parser sentHandlerSelectors.
]

{ #category : #tests }
XMLParserTest >> testSAXSkippedEntityHandler [
	| xml parser |

	xml := '<root>&undeclared;</root>'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml))
		isValidating: false;
		parseDocument.
	self assert:
		#(startDocument
			startElement:prefix:uri:localName:attributes:
			skippedEntity:
			endElement:prefix:uri:localName:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		(parser sentHandlerMessages detect: [:each | each selector == #skippedEntity:])
			arguments first = 'undeclared'.
]

{ #category : #tests }
XMLParserTest >> testSelfReferentialEntityReplacement [
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ENTITY first "&first;">]><root>&first;</root>']
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ENTITY % first "%first;">%first;]><root/>']
		raise: XMLParserException.
]

{ #category : #tests }
XMLParserTest >> testStandalone [
	| dtdXml standaloneDecl |

	dtdXml := self addressBookXMLWithDTD.
	self should: [SAXHandler parse: dtdXml] raise: XMLFileIOException.
	self
		shouldnt: [
			SAXHandler
				parse: dtdXml
				usingNamespaces: true
				validation: true
				externalEntities: false]
		raise: XMLFileIOException.

	standaloneDecl := (dtdXml copyUpTo: $>) allButLast, ' standalone="yes" ?>'.
	self
		shouldnt: [SAXHandler parse: standaloneDecl, (dtdXml copyAfter: $>)]
		raise: XMLFileIOException.
]

{ #category : #tests }
XMLParserTest >> testSubsetEndingEntityReplacement [
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [
					<!ENTITY % endOfSubset "]>">
					%endOfSubset;
					<root/>']
		raise: XMLParserException
]

{ #category : #'tests-xmltokenizer' }
XMLParserTest >> testTokenizerAddressBook [
	| tokenizer |
	tokenizer := XMLTokenizer driver: nil on: self addressBookXML readStream.
	[tokenizer streamReader next notNil] whileTrue
]

{ #category : #'tests-xmltokenizer' }
XMLParserTest >> testTokenizerAddressBookWithDTD [
	| tokenizer |
	tokenizer := XMLTokenizer driver: nil on: self addressBookXMLWithDTD readStream.
	[tokenizer streamReader next notNil] whileTrue
]

{ #category : #'tests-xmltokenizer' }
XMLParserTest >> testTokenizerCharacters [
	| tokenizer |
	"This test is actually not that useful. This is not the proper way of using the parser.
	This test is here just for specification purpose"
	"self debug: #testParsingCharacters"

	tokenizer := XMLTokenizer driver: nil on: self addressBookXML readStream.

	self
		assert: tokenizer streamReader next == $<;
		assert: ('address' allSatisfy: [:each | tokenizer streamReader next == each]);
		assert: tokenizer streamReader peek == $b.
	tokenizer streamReader pushBack: 'test'.
	self
		assert: ('test' allSatisfy: [:each | tokenizer streamReader next == each]);
		assert: tokenizer streamReader peek == $b;
		assert: ('book' allSatisfy: [:each | tokenizer streamReader next == each]).
	tokenizer streamReader
		pushBack: 'book';
		pushBack: 'test'.
	self
		assert: ('test' allSatisfy: [:each | tokenizer streamReader next == each]);
		assert: ('book' allSatisfy: [:each | tokenizer streamReader next == each]).
]

{ #category : #tests }
XMLParserTest >> testUndeclaredEntities [
	| document dtd content |

	dtd := '<!DOCTYPE root [<!ENTITY declared "%undeclared;">]>'.
	content := '<root>&undeclared;test&undeclared;</root>'.
	self should: [XMLDOMParser parse: content] raise: XMLValidationException.
	self should: [XMLDOMParser parse: dtd, '<root/>'] raise: XMLValidationException.
	self
		shouldnt: [
			document :=
				XMLDOMParser
					parse: dtd, content
					usingNamespaces: false
					validation: false]
		raise: XMLValidationException.
	self assert: document allNodes second contentString = 'test'.
]

{ #category : #tests }
XMLParserTest >> testUndeclaredNamespaces [
	self
		shouldnt: [SAXHandler parse: '<prefix:root prefix:name="test"/>' usingNamespaces: false]
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<prefix:root/>']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<root prefix:name="test"/>']
		raise: XMLNamespaceException.

	"xml is OK as a prefix, xmlns is not"
	self
		shouldnt: [SAXHandler parse: '<xml:root xml:name="test"/>']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<xmlns:root />']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLParserTest >> testUnparsedEntities [
	| document |

	document := XMLDOMParser parse: '
		<!DOCTYPE root [
			<!NOTATION note PUBLIC "-//ext//note//EN">
			<!ENTITY unparsedEntity SYSTEM "note.txt" NDATA note>
		]>
		<root notation=&unparsedEntity; />'.
	self assert: (document root attributeAt: 'notation') = 'note'.
	self
		should: [XMLDOMParser parse: '<root attr=&undeclaredUnparsedEntity;/>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testWellFormedness [
	| error |

	error := XMLWellFormednessException.
	self
		should: [SAXHandler parse: '<root1>'] raise: error;
		should: [SAXHandler parse: '</root1>'] raise: error;
		should: [SAXHandler parse: '<root1/><root2/>'] raise: error;
		should: [SAXHandler parse: '<root></unopened></root>'] raise: error;
		should: [SAXHandler parse: '<root><unclosed></root>'] raise: error;
		should: [SAXHandler parse: '<root><first><second></first></second></root>'] raise: error.
]

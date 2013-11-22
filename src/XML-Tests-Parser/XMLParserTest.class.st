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
	XMLDOMParser parse: dtd, '<root number="two" note="txtFile"/>'.
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
	| xmlDocument element output |

	xmlDocument :=
		(XMLDOMParser on: self exampleCDATASectionXML readStream)
			preservesCDataNodes: true;
			parseDocument.
	element := xmlDocument findElementNamed: 'test-data'.

	self assert: element contentString = 'this is CDATA test content 1 < 2 & 5 > 3'.
	
	output := element printString.
	self assert: '<test-data><![CDATA[this is CDATA test content 1 < 2 & 5 > 3]]></test-data>' = output
	

]

{ #category : #tests }
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

{ #category : #'tests-utf8' }
XMLParserTest >> testDecodingCharacters [
	| xmlDocument element |

	xmlDocument := XMLDOMParser parse: self exampleEncodedXML.
	element := xmlDocument findElementNamed: 'test-data'.

	self assert: element contentString first charCode = 8230.	


]

{ #category : #tests }
XMLParserTest >> testDoctypeRoot [
	| xml |

	xml := '<!DOCTYPE root><invalidRoot/>'.
	self
		should: [XMLDOMParser parse: xml]
		raise: XMLValidationException.
	XMLDOMParser
		parse: xml
		usingNamespaces: false
		validation: false.
]

{ #category : #tests }
XMLParserTest >> testElementAnyAndEmptyDeclarations [
	XMLDOMParser parse: 
		'<!DOCTYPE addressbook [<!ELEMENT addressbook ANY>]>',
		self addressBookXML.
	self
		should: [
			XMLDOMParser parse: 
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
		<!ELEMENT two (#PCDATA)>]>'.
	XMLDOMParser parse: dtd, '<root>text<one/><two>text</two></root>'.
	self
		should: [XMLDOMParser parse: dtd, '<root><five/></root>']
		raise: XMLValidationException.
	self
		should: [XMLDOMParser parse: dtd, '<root><two><three/></two></root>']
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
			<!ENTITY % partialDeclaration "name1 &#39;replacement1&#39;">
			<!ENTITY % name1Declaration "<!ENTITY %partialDeclaration;>">
			%name1Declaration;
			<!ENTITY name2 "replacement2 &name1;" >
			<!ENTITY name3 "replacement3 &name2;" >
			<!ENTITY predefined "&amp;&gt;&lt;&quot;&apos;" >
			<!ENTITY quotes "&#34;&#39;">
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
XMLParserTest >> testLineEndingsDoNotMatter [
	| source docWithCrs docWithCrlfs |

	(source := String new writeStream)
		nextPutAll: '<foo>';
		cr;
		nextPutAll: 'bar';
		cr;
		nextPutAll: 'baz';
		cr;
		nextPutAll: '</foo>'.

	docWithCrs := XMLDOMParser parse: source contents.
	docWithCrlfs :=
		XMLDOMParser parse:
			(source contents
				copyReplaceAll: String cr
				with: String crlf).
	self assert: (docWithCrs root contentString) = (docWithCrlfs root contentString)
]

{ #category : #tests }
XMLParserTest >> testParsing [
	| xmlDocument root firstPerson numberOfPersons |
	"self debug: #testParsing"

	xmlDocument := XMLDOMParser parse: self addressBookXML.
	self assert: (xmlDocument isKindOf: XMLDocument).
	root := xmlDocument root.
	self assert: (root class == XMLElement).

	self assert: (root findElementNamed: 'person') notNil.
	self assert: (root findElementNamed: 'addressbook') notNil.

	self assert: (root findElementNamed: 'addressbook') == root.

	numberOfPersons := 0.
	root allElementsNamed: 'person' do: [:p | numberOfPersons := numberOfPersons + 1].
	self assert: numberOfPersons = 4.

	firstPerson := root findElementNamed: 'person'.
	self assert: (firstPerson attributeAt: 'employee-number') = 'A0000'.
	self assert: (firstPerson attributeAt: 'family-name') = 'Gates'.
	self assert: (firstPerson attributeAt: 'first-name') = 'Bob'.
	self assert: firstPerson attributeNames asArray =
		#('employee-number' 'family-name' 'first-name').
	self assert: firstPerson attributeAssociations asArray =
		{('employee-number'->'A0000'). ('family-name'->'Gates'). ('first-name'->'Bob').}.

]

{ #category : #tests }
XMLParserTest >> testParsingCharacters [
	| tokenizer |
	"This test is actually not that useful. This is not the proper way of using the parser.
	This test is here just for specification purpose"
	"self debug: #testParsingCharacters"

	tokenizer := XMLTokenizer driver: nil on: self addressBookXML readStream.

	self assert: tokenizer streamReader next = $<.
	self assert: tokenizer streamReader next = $a.
	self assert: tokenizer streamReader next = $d.
	self assert: tokenizer streamReader next = $d.
	self assert: tokenizer streamReader next = $r.
]

{ #category : #tests }
XMLParserTest >> testStandalone [
	| dtdXml standaloneDecl |

	dtdXml := self addressBookXMLWithDTD.
	SAXHandler
		parse: dtdXml
		usingNamespaces: true
		validation: true
		externalEntities: false.
	self should: [SAXHandler parse: dtdXml] raise: XMLFileIOException.

	standaloneDecl := (dtdXml copyUpTo: $>) allButLast, ' standalone="yes" ?>'.
	SAXHandler parse: standaloneDecl, (dtdXml copyAfter: $>).
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

{ #category : #tests }
XMLParserTest >> testUndeclaredEntities [
	| document dtd content |

	dtd := '<!DOCTYPE root [%undeclared;]>'.
	content := '<root>&undeclared;test&undeclared;</root>'.
	document :=
		XMLDOMParser
			parse: dtd, content
			usingNamespaces: false
			validation: false.
	self assert: document allNodes second contentString = 'test'.
	self should: [XMLDOMParser parse: content] raise: XMLValidationException.
	self should: [XMLDOMParser parse: dtd, '<root/>'] raise: XMLValidationException.
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

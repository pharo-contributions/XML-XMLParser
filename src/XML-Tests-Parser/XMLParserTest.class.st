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

{ #category : #private }
XMLParserTest >> recursiveEntityDeclarationsNamed: aName depth: aLimit isParameter: aBoolean [
	| entityDeclarations |

	entityDeclarations := String new writeStream.
	1 to: aLimit do: [:i |
		entityDeclarations
			cr;
			nextPutAll: '<!ENTITY '.
		aBoolean
			ifTrue: [entityDeclarations nextPutAll: '% '].

		entityDeclarations
			nextPutAll: aName, i printString;
			nextPutAll: ' "'.
			(i = aLimit)
				ifTrue: [entityDeclarations nextPutAll: '<!--last-->']
				ifFalse: [
					aBoolean
						ifTrue: [entityDeclarations nextPutAll: '&#37;']
						ifFalse: [entityDeclarations nextPut: $&].
					entityDeclarations
						nextPutAll: aName, (i + 1) printString;
						nextPut: $;].
		entityDeclarations nextPutAll: '">'].

	^ entityDeclarations contents.
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
		<!ATTLIST root
			unparsedEntity ENTITY #IMPLIED
			unparsedEntities ENTITIES #IMPLIED>]>'.
	self
		shouldnt: [
			SAXHandler parse:
				dtd, '<root unparsedEntity="firstEntity"  unparsedEntities="firstEntity  secondEntity"/> ']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root unparsedEntity="thirdEntity"/>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root unparsedEntity="secondEntity thirdEntity"/>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeEnumerationDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!NOTATION txtFile PUBLIC "//file.txt//">
		<!NOTATION confFile PUBLIC "//file.conf//">
		<!ATTLIST root
			number ( one | two | three) #IMPLIED
			note NOTATION (txtFile | confFile ) #IMPLIED>]>'.
	self
		shouldnt: [SAXHandler parse: dtd, '<root number="two" note="txtFile"/>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root number="four"/>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root note="htmlFile" />']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeIDDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ATTLIST unique id ID #REQUIRED>
		<!ATTLIST unique2 id ID #REQUIRED>]>'.
	self
		shouldnt: [
			SAXHandler parse:
				dtd, '<root><unique id=" one "/><unique id="two"/><unique2 id="three"/></root> ']
		raise:XMLValidationException.
	self
		should: [
			SAXHandler parse:
				dtd, '<root><unique id="one"/><unique id=" one "/></root> ']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [
					<!ATTLIST unique
						id ID #REQUIRED
						id2 ID #REQUIRED>]>
					<root/>']
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
		<!ATTLIST root
			name NMTOKEN #IMPLIED
			names NMTOKENS #IMPLIED>]>'.
	self
		shouldnt: [SAXHandler parse: dtd, '<root name="one" names="  one  two three"/> ']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root name="1"/> ']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root names="1 2 3" />']
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
	tokenizer tokenContext enterExternalSubset.
	tokenizer nextToken.
	self assert: tokenizer streamReader upToEnd = 'included, included, included.'.

	self
		should: [SAXHandler parse: '<!DOCTYPE root [ <![IGNORE[<!--ignored-->]]> ]><root/>']
		raise: XMLParserException.
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
	| xml document  |

	xml := '<?xml version="1.0" encoding="UTF-8"?>
			<test-data>&#{1};</test-data>'.

	document := XMLDOMParser parse: (xml format: (Array with: '8230')).
	self assert: document root contentString first charCode = 8230.

	self
		should: [XMLDOMParser parse: (xml format: (Array with: 'xFFFFFFF'))]
		raise: XMLParserException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: '0'))]
		raise: XMLParserException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: '-1'))]
		raise: XMLParserException.
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
			<!ENTITY quotes "&#x27;quoted &#x22;value&#34;&#39;">
		]>
		<root name="&quotes;">&name1; &name2; &name3; ',
		'%name1Declaration;</root>'.
	self assert:
		document root contentString =
			('replacement1 ',
			'replacement2 replacement1 ',
			'replacement3 replacement2 replacement1 ',
			'%name1Declaration;').
	self assert:
		(document root attributeAt: 'name') =
			(('quoted "value"' copyWithFirst: $') copyWith: $').
]

{ #category : #tests }
XMLParserTest >> testFileClientPaths [
	| fileClient cwd cwdParent |

	fileClient := XMLFileClient defaultImplementation new.
	cwd := fileClient currentWorkingDirectory.
	cwdParent := cwd copyUpToLast: $/.
	self
		assert: cwd first == $/;
		deny: cwd last == $/;
		assert: (fileClient combineRelative: 'relative' withBase: 'relative/path') = 'relative/relative';
		assert: (fileClient combineRelative: 'relative/path' withBase: 'relative/path') = 'relative/relative/path';
		assert: (fileClient combineRelative: 'relative' withBase: cwd) = (cwdParent, '/relative');
		assert: (fileClient combineRelative: '/nonrelative' withBase: cwd) = '/nonrelative';
		assert: (fileClient combineRelative: '../../relative' withBase: cwd) = (cwdParent, '/../../relative');
		assert: (fileClient combineRelative: './relative' withBase: cwd) = (cwdParent, '/relative');
		assert: (fileClient combineRelative: '.relative' withBase: cwd) = (cwdParent, '/.relative').
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
XMLParserTest >> testPredefinedEntityReplacement [
	| document references replacements |

	references := String new writeStream.
	replacements := String new writeStream.
	XMLTokenizer predefinedEntities keysAndValuesDo: [:name :char |
		references
			nextPut: $&;
			nextPutAll: name;
			nextPut: $;.
		replacements nextPut: char].

	document :=
		XMLDOMParser parse:
			('<!DOCTYPE root [
				<!ENTITY nonRecursive "&amp;notAReference;">]>
			<root name=''{1}''>
				<one>{1}</one>
				<two>&nonRecursive;</two>
			</root>' format: (Array with: references contents)).
	self
		assert: (document root attributeAt: 'name') = replacements contents;
		assert: (document findElementNamed: 'one') contentString = replacements contents;
		assert: (document findElementNamed: 'two') contentString = '&notAReference;'.
]

{ #category : #tests }
XMLParserTest >> testPreservesUndeclaredEntityReferences [
	| xml parser document |

	xml := '<!DOCTYPE root [
		<!ENTITY unreferenced "%undeclaredOne;">
		%undeclaredOne;]>
		<root name="&undeclaredTwo;">&undeclaredThree;</root>'.
	(parser := XMLDOMParser on: xml)
		isValidating: false;
		preservesUndeclaredEntityReferences: true.
	document := parser parseDocument.

	self
		assert: document doctypeDeclaration nodes size = 1;
		assert: document doctypeDeclaration firstNode replacement = '%undeclaredOne;';
		assert: (document root attributeAt: 'name') = '&undeclaredTwo;';
		assert: (document root contentString) = '&undeclaredThree;'.
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
	| limit entityDeclarations |

	limit := XMLTokenizer new maxEntityReplacementDepth.
	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit
			isParameter: false.
	self
		shouldnt: [
			SAXHandler parse:
				'<!DOCTYPE root [', entityDeclarations, ']>
				<root>&entity1;</root>']
		raise: XMLEntityDepthException.

	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit + 1
			isParameter: false.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [', entityDeclarations, ']>
				<root>&entity1;</root>']
		raise: XMLEntityDepthException.
]

{ #category : #tests }
XMLParserTest >> testRecursiveParameterEntityReplacement [
	| limit entityDeclarations |

	limit := XMLTokenizer new maxEntityReplacementDepth.
	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit
			isParameter: true.
	self
		shouldnt: [
			SAXHandler parse:
				'<!DOCTYPE root [',
					entityDeclarations, '
					%entity1;]>
				<root/>']
		raise: XMLEntityDepthException.

	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit + 1
			isParameter: true.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [',
					entityDeclarations,'
					%entity1;]>
				<root/>']
		raise: XMLEntityDepthException.
]

{ #category : #tests }
XMLParserTest >> testRenamingParsedNodes [
	| document element attribute |

	document := XMLDOMParser parse: '<root xmlns:prefix="ns" name="value"/>'.

	element := document root.
	element name: 'prefix:root'.
	self assert: (document elementAt: 'prefix:root') == element.

	attribute := element attributeNodeAt: 'name'.
	attribute name: 'prefix:name'.
	self
		assert: (element attributeNodeAt: 'prefix:name') == attribute;
		assert: (element attributeAt: 'prefix:name') = 'value'.

	self
		should: [attribute name: 'undeclared:name']
		raise: XMLNamespaceException.
	self
		should: [element name: 'undeclared:root']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLParserTest >> testSelfReferentialEntityReplacement [
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ENTITY first "&first;">]><root>&first;</root>']
		raise: XMLEntityDepthException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ENTITY % first "&#37;first;">%first;]><root/>']
		raise: XMLEntityDepthException.
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

{ #category : #'tests-xmltokenizer' }
XMLParserTest >> testTokenizerMaxPushBack [
	| tokenizer |

	tokenizer :=
		XMLTokenizer
			driver: nil
			on: self addressBookXML readStream.
	self
		shouldnt: [
			tokenizer streamReader maxNestedStreams
				timesRepeat: [tokenizer streamReader pushBack: 'test']]
		raise: XMLParserException.
	self
		should: [tokenizer streamReader pushBack: 'test']
		raise: XMLParserException.
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

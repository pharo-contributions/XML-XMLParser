Class {
	#name : #XMLParserTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
XMLParserTest class >> addressBookXML [
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
XMLParserTest class >> addressBookXMLWithDTD [
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

{ #category : #source }
XMLParserTest >> addressBookXML [
	^ self class addressBookXML
]

{ #category : #source }
XMLParserTest >> addressBookXMLWithDTD [
	^ self class addressBookXMLWithDTD
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
	^ [4000 timesRepeat: [XMLDOMParser parse: self addressBookXMLWithDTD]] timeToRun
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
XMLParserTest >> elementDeclarationsNamed: aNameCollection [
	| stream |

	stream := String new writeStream.
	aNameCollection do: [:each |
		stream
			nextPutAll: '<!ELEMENT ';
			nextPutAll: each;
			nextPutAll: ' EMPTY>';
			cr].
	^ stream contents.
]

{ #category : #tests }
XMLParserTest >> testAttributeDefaultDeclaration [
	| dtd document |

	dtd := '
		<!DOCTYPE root [
		<!ELEMENT root EMPTY>
		<!ATTLIST root one CDATA #IMPLIED
						two CDATA #REQUIRED
						three CDATA #FIXED "fixedDefault"
						three CDATA #FIXED "redundant"
						four CDATA "default" >]>'.
	document := XMLDOMParser parse: dtd, '<root two=''required'' />'.
	self
		assert: (document root attributeAt: 'two') = 'required';
		deny: (document root includesAttribute: 'one');
		assert: (document root attributeAt: 'three') = 'fixedDefault';
		assert: (document root attributeAt: 'four') = 'default'.
	self
		should: [SAXHandler parse: dtd, '<root />'] raise: XMLValidationException;
		should: [SAXHandler parse: dtd, '<root three="nonDefault"/>'] raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testAttributeEntityDeclaration [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!NOTATION first SYSTEM "first.txt">
		<!NOTATION second SYSTEM "second.txt">
		<!ENTITY firstEntity SYSTEM "first.txt" NDATA first>
		<!ENTITY secondEntity SYSTEM "second.txt" NDATA second>
		<!ELEMENT root EMPTY>
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
		<!ELEMENT root EMPTY>
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
		<!ELEMENT root (unique|unique2)+>
		<!ELEMENT unique EMPTY>
		<!ELEMENT unique2 EMPTY>
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
		<!ELEMENT root (unique|ref|refs)+>
		<!ELEMENT unique EMPTY>
		<!ELEMENT ref EMPTY>
		<!ELEMENT refs EMPTY>
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
		<!ELEMENT root ANY>
		<!ATTLIST root name NMTOKEN #IMPLIED>
		<!ATTLIST root names NMTOKENS #IMPLIED>]>'.
	self
		shouldnt: [SAXHandler parse: dtd, '<root name=" one " names="  one  two three "/> ']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root name="#" names="one two"/>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root name="one" names="# #" />']
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
XMLParserTest >> testAttributeValueWithAngleBrackets [
	self
		should: [SAXHandler parse: '<test name="<value/>"/>']
		raise: XMLWellFormednessException.
	self
		shouldnt: [SAXHandler parse: '<test name="&lt;value/>"/>']
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLParserTest >> testComments [
	self
		shouldnt: [SAXHandler parse: '<test><!-- <comment/> --></test>']
		raise: XMLWellFormednessException.
	self
		should: [SAXHandler parse: '<test><!-- <comment/> -- --></test>']
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLParserTest >> testDeclaringNamespaces [
	self
		shouldnt: [SAXHandler parse: '<prefix:root prefix:name="test" xmlns:prefix="NS"/>']
		raise: XMLNamespaceException.
	self
		shouldnt: [SAXHandler parse: '<root xmlns="defaultNS"/>']
		raise: XMLNamespaceException.
	self
		shouldnt: [SAXHandler parse: '<root xmlns=""/>' usingNamespaces: true]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLParserTest >> testDeclaringNamespacesBadPrefixes [
	self
		should: [SAXHandler parse: '<root xmlns:invalid:prefix="invalidNS"/>']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<root xmlns::invalidprefix="invalidNS"/>']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<root xmlns:invalidprefix:="invalidNS"/>']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<:invalidname />']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<invalidname: />']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<root :invalidname="test" />']
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<root invalidname:="test" />']
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLParserTest >> testDeclaringNamespacesBadURIs [
	self
		should: [SAXHandler parse: '<root xmlns:empty=""/>' usingNamespaces: true]
		raise: XMLNamespaceException.

	"Cannot change xmlns or xml prefixes"
	self
		should: [SAXHandler parse: '<root xmlns:xmlns="newNS"/>' usingNamespaces: true]
		raise: XMLNamespaceException.
	self
		should: [SAXHandler parse: '<root xmlns:xml="newNS" />' usingNamespaces: true]
		raise: XMLNamespaceException.

	"Redundant xml prefix mapping is ok, but xmlns is not"
	self
		shouldnt: [
			SAXHandler
				parse: '<root xmlns:xml="', XMLNamespaceScope xmlNamespaceURI, '"/>'
				usingNamespaces: true]
		raise: XMLNamespaceException.
	self
		should: [
			SAXHandler
				parse: '<root xmlns:xmlns="', XMLNamespaceScope xmlnsNamespaceURI, '"/>'
				usingNamespaces: true]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLParserTest >> testDefaultDocumentURI [
	| cwd documentURI |

	documentURI := (SAXHandler on: '' documentURI: 'test/test.xml') documentURI.
	self assert: documentURI = 'test/test.xml'.

	cwd := XMLFileHandle currentWorkingDirectory.
	documentURI := (SAXHandler on: '') documentURI.
	self
		assert: documentURI size > (cwd size + 1);
		assert: (documentURI copyUpToLast: $/) = cwd
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
XMLParserTest >> testElementAnyDeclarations [
	self
		shouldnt: [
			SAXHandler parse: 
				'<!DOCTYPE one [
					<!ELEMENT one ANY>
					<!ELEMENT two ANY>]>
				<one>one<two><![CDATA[two]]><two/></two>three</one>']
		raise: XMLValidationException.
	self
		shouldnt: [
			SAXHandler parse: 
				'<!DOCTYPE root [
					<!ELEMENT root ANY>
					<!ELEMENT two ANY>]>
				<root><two></two></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsBranching [
	| dtd |

	dtd := '<!DOCTYPE root [',
		(self elementDeclarationsNamed: #('one' 'two' 'three' 'four' 'five')),
		'<!ELEMENT root ((one|two),(three|four|five))>]>'.

	self
		shouldnt: [
			SAXHandler
				parse: dtd, '<root><one/><three/></root>';
				parse: dtd, '<root><one/><four/></root>';
				parse: dtd, '<root><one/><five/></root>';
				parse: dtd, '<root><two/><three/></root>';
				parse: dtd, '<root><two/><four/></root>';
				parse: dtd, '<root><two/><five/></root>']
		raise: XMLValidationException.

	self
		should: [SAXHandler parse: dtd, '<root><one/><two/><three/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><three/><four/><five/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><four/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsManyBranches [
	| dtd names |

	names := (1 to: 50) collect: [:each | 'element', each printString].
	dtd := String streamContents: [:stream |
		stream
			nextPutAll: '<!DOCTYPE root [';
			nextPutAll: (self elementDeclarationsNamed: names);
			nextPutAll: '<!ELEMENT root ('.
		names
			do: [:each | stream nextPutAll: each]
			separatedBy: [stream nextPut: $|].
		stream nextPutAll: ')>]>'].

	names do: [:each |
		self
			shouldnt: [SAXHandler parse: dtd, '<root><', each, '/></root>']
			raise: XMLValidationException].
	self
		should: [
			SAXHandler parse:
				dtd, '<root><element', (names size + 1) printString, '/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsOptional [
	| dtd |

	dtd := '<!DOCTYPE root [',
		(self elementDeclarationsNamed: #('one' 'two' 'three' 'four' 'five')),
		'<!ELEMENT root (one?,two,three?,(four?, five)?)>]>'.

	self
		shouldnt: [
			SAXHandler
				parse: dtd, '<root><one/><two/><three/><four/><five/></root>';
				parse: dtd, '<root><two/><three/></root>';
				parse: dtd, '<root><one/><two/><three/><five/></root>';
				parse: dtd, '<root><two/></root>';
				parse: dtd, '<root><one/><two/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><three/><four/><five/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><two/><three/><four/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><two/><three/><five/><four/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsOptionalBranching [
	| dtd |

	dtd := '<!DOCTYPE root [',
		(self elementDeclarationsNamed: #('one' 'two' 'three' 'four' 'five' 'six')),
		'<!ELEMENT root (((one,two)|(three,four)),five?)>]>'.

	self
		shouldnt: [
			SAXHandler
				parse: dtd, '<root><one/><two/><five/></root>';
				parse: dtd, '<root><three/><four/><five/></root>';
				parse: dtd, '<root><one/><two/></root>';
				parse: dtd, '<root><three/><four/></root>']
		raise: XMLValidationException.

	self
		should: [SAXHandler parse: dtd, '<root><three/><five/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><five/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><five/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsOptionalEmpty [
	| dtd |

	dtd := '<!DOCTYPE root [',
		(self elementDeclarationsNamed: #('one' 'two' 'three')),
		'<!ELEMENT root (one?,two)?>]>'.

	self
		shouldnt: [
			SAXHandler
				parse: dtd, '<root><one/><two/></root>';
				parse: dtd, '<root><two/></root>';
				parse: dtd, '<root></root>']
		raise: XMLValidationException.

	self
		should: [SAXHandler parse: dtd, '<root><one/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><three/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><one/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsPlus [
	| dtd |

	dtd := '<!DOCTYPE root [',
		(self elementDeclarationsNamed: #('one' 'two' 'three' 'four' 'five')),
		'<!ELEMENT root ((one?,two)+,three,four+,five)>]>'.

	self
		shouldnt: [
			SAXHandler
				parse: dtd, '<root><one/><two/><three/><four/><five/></root>';
				parse: dtd, '<root><two/><one/><two/><two/><three/><four/><five/></root>';
				parse: dtd, '<root><two/><three/><four/><four/><five/></root>';
				parse: dtd, '<root><two/><three/><four/><five/></root>']
		raise: XMLValidationException.

	self
		should: [SAXHandler parse: dtd, '<root><three/><four/><five/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><two/><four/><four/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><one/><two/><three/><five/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsStar [
	| dtd |

	dtd := '<!DOCTYPE root [',
		(self elementDeclarationsNamed: #('one' 'two' 'three' 'four' 'five')),
		'<!ELEMENT root ((one?,two)*,(three)*,four,five*)>]>'.

	self
		shouldnt: [
			SAXHandler
				parse: dtd, '<root><one/><two/><three/><four/><five/></root>';
				parse: dtd, '<root><two/><one/><two/><three/><four/><five/></root>';
				parse: dtd, '<root><three/><three/><four/><five/></root>';
				parse: dtd, '<root><four/><five/><five/></root>';
				parse: dtd, '<root><four/></root>']
		raise: XMLValidationException.

	self
		should: [SAXHandler parse: dtd, '<root><three/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementContentModelsStarEmpty [
	| dtd |

	dtd := '<!DOCTYPE root [',
		(self elementDeclarationsNamed: #('one' 'two' 'three')),
		'<!ELEMENT root (one*,two)*>]>'.

	self
		shouldnt: [
			SAXHandler
				parse: dtd, '<root><one/><one/><two/><two/></root>';
				parse: dtd, '<root><two/><one/><two/></root>';
				parse: dtd, '<root><two/><two/></root>';
				parse: dtd, '<root></root>']
		raise: XMLValidationException.

	self
		should: [SAXHandler parse: dtd, '<root><one/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><three/></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementEmptyDeclarations [
	self
		shouldnt: [
			SAXHandler parse: 
				'<!DOCTYPE root [<!ELEMENT root EMPTY>]>',
				'<root> <!--empty--> <?pi data?> </root>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse: 
				'<!DOCTYPE root [
					<!ELEMENT root EMPTY>
					<!ELEMENT non-empty ANY>]><root><non-empty/></root>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse: 
				'<!DOCTYPE root [<!ELEMENT root EMPTY>]><root>non-empty</root>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse: 
				'<!DOCTYPE root [<!ELEMENT root EMPTY>]><root>&#32;</root>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse: 
				'<!DOCTYPE root [<!ELEMENT root EMPTY>]><root><![CDATA[non-empty]]></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testElementMixedContentDeclaration [
	| dtd |

	dtd := '
		<!DOCTYPE root [
			<!ELEMENT root (#PCDATA | one | two | three)*>
			<!ELEMENT one EMPTY>
			<!ELEMENT two (#PCDATA)>
			<!ELEMENT three (#PCDATA)*>
			<!ELEMENT four EMPTY>]>'.
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
		raise: XMLWellFormednessException.
	'+*?,' do: [:each |
		self
			should: [
				XMLDOMParser parse:
					'<!DOCTYPE root [<!ELEMENT two (#PCDATA', each asString, ')>]><root/>']
			raise: XMLWellFormednessException].
]

{ #category : #tests }
XMLParserTest >> testElementWellFormedness [
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

{ #category : #tests }
XMLParserTest >> testEntityEmptyReplacements [
	| xml document |

	xml := '
	<?xml version="1.0"?>
	<!DOCTYPE entities [
		<!ENTITY % inner "">
		%inner;
		<!ENTITY % outer ''%inner;''>
		%outer;
		<!ENTITY inner  "%outer;"> 
		<!ENTITY outer ''&inner;''>]>
	<entities one="&outer;" two="&inner;" three=''&outer;'' four=''&inner;''>&outer;&inner;</entities>'.

	self
		shouldnt: [document := XMLDOMParser parse: xml]
		raise: XMLWellFormednessException.
	self
		assert: (document root attributeAt: 'one') isEmpty;
		assert: (document root attributeAt: 'two') isEmpty;
		assert: (document root attributeAt: 'three') isEmpty;
		assert: (document root attributeAt: 'four') isEmpty;
		assert: document root contentString isEmpty.
]

{ #category : #tests }
XMLParserTest >> testEntityLiteralContextNesting [
	| xml inner outer document |

	xml := '
	<?xml version="1.0"?>
	<!DOCTYPE entities [
		<!ENTITY % inner " '' inner &#34; ">
		<!ENTITY % outer '' "%inner;&#39; ''>
		<!ENTITY inner  "%outer;"> 
		<!ENTITY outer '' &#39; " &inner; &#39; " ''>]>
	<entities one="&outer;" two="&inner;" three=''&outer;'' four=''&inner;''>&outer;&inner;</entities>'.
	inner := ' " '' inner " '' '.
	outer := ' '' " ', inner, ' '' " '.

	self
		shouldnt: [document := XMLDOMParser parse: xml]
		raise: XMLWellFormednessException.
	self
		assert: (document root attributeAt: 'one') = outer;
		assert: (document root attributeAt: 'two') = inner;
		assert: (document root attributeAt: 'three') = outer;
		assert: (document root attributeAt: 'four') = inner;
		assert: (document root contentString) = (outer, inner).
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
XMLParserTest >> testEntityURIInheritance [
	| xml parser driver |

	xml := '<!DOCTYPE root [%first;]><root xml:base="/new/xml">&second;</root>'.
	parser :=
		(SAXHandler
			on: xml
			documentURI: 'test.xml') parser.
	(driver := parser driver)
		doctypeDefinition parameterEntities
			at: 'first'
			put:
				(DTDExternalParameterEntity
					name: 'first'
					replacement: '<!ENTITY second "<!--comment-->">'
					uri: 'test.ent').

	self assert: driver currentURI = 'test.xml'.

	3 timesRepeat: [parser parseToken].
	self assert: driver currentURI = 'test.ent'.

	2 timesRepeat: [parser parseToken].
	self assert: driver currentURI = 'test.xml'.

	2 timesRepeat: [parser parseToken].
	self assert: driver currentURI = '/new/xml'.

	3 timesRepeat: [parser parseToken].
	self
		assert: driver currentURI = 'test.xml';
		assert: parser atEnd.
]

{ #category : #tests }
XMLParserTest >> testIncompleteCDataTokens [
	#('<test><![' '<test><![CDATA[' '<test><![CDATA[ test'
		'<test><![CDATA[ test ]' '<test><![CDATA[ test ]]')
		do: [:each | 
			self
				should: [SAXHandler parse: each]
				raise: XMLWellFormednessException]
]

{ #category : #tests }
XMLParserTest >> testIncompleteCommentTokens [
	#('<!--' '<!-- comment' '<!-- comment -' '<!-- comment --')
		do: [:each | 
			self
				should: [SAXHandler parse: each]
				raise: XMLWellFormednessException]
]

{ #category : #tests }
XMLParserTest >> testIncompleteDoctypeTokens [
	#('<!DOCTYPE' '<!DOCTYPE >'
		'<!DOCTYPE test' '<!DOCTYPE test PUBLIC' '<!DOCTYPE test PUBLIC "pubid'
		'<!DOCTYPE test PUBLIC "pubid" "sysid' '<!DOCTYPE test PUBLIC "pubid" "sysid"'
		'<!DOCTYPE test SYSTEM' '<!DOCTYPE test SYSTEM "sysid' '<!DOCTYPE test SYSTEM "sysid"'
		'<!DOCTYPE test [' '<!DOCTYPE test []')
		do: [:each | 
			self
				should: [SAXHandler parse: each]
				raise: XMLWellFormednessException]
]

{ #category : #tests }
XMLParserTest >> testIncompleteEndTagTokens [
	#('<test></' '<test></test')
		do: [:each | 
			self
				should: [SAXHandler parse: each]
				raise: XMLWellFormednessException]
]

{ #category : #tests }
XMLParserTest >> testIncompletePITokens [
	#('<?name' '<?name value' '<?name value?' '<?name value>')
		do: [:each | 
			self
				should: [SAXHandler parse: each]
				raise: XMLWellFormednessException]
]

{ #category : #tests }
XMLParserTest >> testIncompleteStartTagTokens [
	#('<' '<test' '<test name'
		'<test name=' '<test name="value' '<test name="value"'
		'<test name="value" /')
		do: [:each | 
			self
				should: [SAXHandler parse: each]
				raise: XMLWellFormednessException]
]

{ #category : #tests }
XMLParserTest >> testIncompleteXMLDeclarationTokens [
	#('<?xml' '<?xml ?' '<?xml ?>'
		'<?xml version' '<?xml version=' '<?xml version="1.0'
		'<?xml version="1.0" encoding' '<?xml version="1.0" encoding="UTF-8'
		'<?xml version="1.0" encoding="UTF-8" standalone'
		'<?xml version="1.0" encoding="UTF-8" standalone="yes'
		'<?xml version="1.0" encoding="UTF-8" standalone="yes"'
		'<?xml version="1.0" encoding="UTF-8" standalone="yes"?')
		do: [:each | 
			self
				should: [SAXHandler parse: each]
				raise: XMLWellFormednessException]
]

{ #category : #tests }
XMLParserTest >> testInvalidElementContentModels [
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root ()>]>']
		raise: XMLWellFormednessException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one,)>]>']
		raise: XMLWellFormednessException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one|)>]>']
		raise: XMLWellFormednessException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one)(two)>]>']
		raise: XMLWellFormednessException.
	self
		should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (one|,two)>]>']
		raise: XMLWellFormednessException.
	'|,?*+' do: [:each |
		self
			should: [SAXHandler parse: '<!DOCTYPE root [<!ELEMENT root (', each asString, 'one)>]>']
			raise: XMLWellFormednessException].
]

{ #category : #tests }
XMLParserTest >> testIsInContent [
	| xml handler parser |

	xml := '<?xml version="1.0"?>
			<!--comment-->
			<?target data?>
			<!DOCTYPE root [<!ELEMENT root EMPTY>]>
			<!--comment-->
			<?target data?>
			<root/>'.
	handler := SAXHandler on: xml.
	parser := handler parser.
	9 timesRepeat: [
		parser parseToken.
		self deny: handler isInContent].
	parser parseToken.
	self assert: handler isInContent.
]

{ #category : #tests }
XMLParserTest >> testLineEndingsDoNotMatter [
	| source docFromSourceWithCRs docFromSourceWithLFs docFromSourceWithCRLFs |

	source := '<root>{1}one{1}two{1}</root>'.
	docFromSourceWithCRs := XMLDOMParser parse: (source format: (Array with: String cr)).
	docFromSourceWithLFs := XMLDOMParser parse: (source format: (Array with: String lf)).
	docFromSourceWithCRLFs := XMLDOMParser parse: (source format: (Array with: String crlf)).
	self
		assert: (docFromSourceWithCRs root contentString) = (docFromSourceWithLFs root contentString);
		assert: (docFromSourceWithLFs root contentString) = (docFromSourceWithCRLFs root contentString).
]

{ #category : #tests }
XMLParserTest >> testNamespacePrefixAliasing [
	| declarations |

	declarations := '<test xmlns:alias1="ns" xmlns:alias2="ns" '.
	self
		shouldnt: [
			SAXHandler
				parse: declarations, ' alias1:name="value" />'
				usingNamespaces: true]
		raise: XMLNamespaceException.
	self
		should: [
			SAXHandler
				parse: declarations, ' alias1:name="value" alias2:name="value"/>'
				usingNamespaces: true]
		raise: XMLNamespaceException.
	self
		shouldnt: [
			SAXHandler
				parse: declarations, ' alias1:name="value" alias2:name2="value"/>'
				usingNamespaces: true]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLParserTest >> testNamespacePrefixInheritance [
	self
		shouldnt: [
			SAXHandler
				parse:
					'<one xmlns:prefix1="ns">
						<prefix1:two xmlns:prefix2="ns2">
							<prefix2:three><prefix1:four /></prefix2:three>
						</prefix1:two>
					</one>'
				usingNamespaces: true]
		raise: XMLNamespaceException.
	self
		should: [
			SAXHandler
				parse:
					'<one xmlns:prefix1="ns">
						<prefix1:two xmlns:prefix2="ns2" />
						<prefix2:three />
					</one>'
				usingNamespaces: true]
		raise: XMLNamespaceException.
	self
		should: [
			SAXHandler
				parse:
					'<one xmlns:prefix1="ns">
						<prefix1:two xmlns:prefix2="ns2">
							<prefix2:three xmlns:prefix3="ns3" />
						</prefix1:two>
						<prefix3:four />
					</one>'
				usingNamespaces: true]
		raise: XMLNamespaceException.
	self
		shouldnt: [
			SAXHandler
				parse:
					'<one xmlns:prefix1="ns">
						<prefix1:two xmlns:prefix2="ns2">
							<prefix2:three xmlns:prefix3="ns3" />
						</prefix1:two>
						<prefix2:four />
						<prefix3:five />
					</one>'
				usingNamespaces: false]
		raise: XMLNamespaceException.
]

{ #category : #tests }
XMLParserTest >> testParserLittleDocument [

	| doc |
	doc := XMLDOMParser parse: 
'<?xml version="1.0" encoding="UTF-8"?>
<!--an example-->
<example:user xmlns:example="urn://example">
    <username>jsmith</username>
    <real-name>John Smith</real-name>
    <age>25</age>
    <id>101</id>
</example:user>' readStream.
]

{ #category : #tests }
XMLParserTest >> testPredefinedEntityReplacement [
	| document references replacements |

	references := String new writeStream.
	replacements := String new writeStream.
	XMLWellFormedParserTokenizer predefinedEntities keysAndValuesDo: [:name :char |
		references
			nextPut: $&;
			nextPutAll: name;
			nextPut: $;.
		replacements nextPut: char].

	document :=
		XMLDOMParser parse:
			('<!DOCTYPE root [
				<!ENTITY nonRecursive "&amp;nonRecursive;">]>
			<root name=''{1}''>
				<one>{1}</one>
				<two>&nonRecursive;</two>
			</root>' format: (Array with: references contents)).
	self
		assert: (document root attributeAt: 'name') = replacements contents;
		assert: (document findElementNamed: 'one') contentString = replacements contents;
		assert: (document findElementNamed: 'two') contentString = '&nonRecursive;'.
]

{ #category : #tests }
XMLParserTest >> testPrefixedAttributeDeclarations [
	| dtd |

	dtd := '<!DOCTYPE root [
		<!ELEMENT root EMPTY>
		<!ATTLIST root
			prefix:name CDATA #IMPLIED
			unprefixed CDATA #IMPLIED>]>'.
	self
		shouldnt: [
			SAXHandler parse:
				dtd, '<root xmlns:prefix="ns" prefix:name="value" unprefixed="value"/>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root name="value" unprefixed="value" />']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse:
				dtd, '<root xmlns:prefix="ns" prefix:name="value" prefix:unprefixed="value"/>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testPrefixedElementDeclarations [
	| dtd |

	dtd := '<!DOCTYPE prefix:root [
		<!ELEMENT prefix:root ANY>
		<!ELEMENT unprefixed EMPTY>]>'.
	self
		shouldnt: [SAXHandler parse: dtd, '<prefix:root xmlns:prefix="ns"><unprefixed/></prefix:root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root><unprefixed/></root>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<prefix:root xmlns:prefix="ns"><prefix:unprefixed/></prefix:root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testProcessingInstructions [
	| document |

	document :=
		XMLDOMParser parse:
			'<?xml version="1.1" standalone="yes"?><?firstTarget first>Data?>',
			'<root><?secondTarget second?Data?></root> '.

	self
		assert: document version = 1.1;
		assert: document nodes size = 2;
		assert: document firstNode isPI;
		assert: document firstNode target = 'firstTarget';
		assert: document firstNode data = 'first>Data';
		assert: document root firstNode target = 'secondTarget';
		assert: document root firstNode data = 'second?Data'.
]

{ #category : #tests }
XMLParserTest >> testRequiredDTDDeclarations [
	self
		shouldnt: [
			(SAXHandler on: '<!DOCTYPE root [<!ELEMENT root EMPTY>]><root/>')
				requiresDocumentConstraints: true;
				parseDocument]
		raise: XMLValidationException.
	self
		should: [
			(SAXHandler on: '<root/>')
				requiresDocumentConstraints: true;
				parseDocument]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testReusingParser [
	| parser oldConfiguraiton |

	parser := SAXHandler on: self addressBookXML.
	oldConfiguraiton := parser configuration.
	parser parseDocument.
	parser on: self addressBookXMLWithDTD.
	self assert: parser configuration == oldConfiguraiton.
]

{ #category : #tests }
XMLParserTest >> testSelfReferentialEntityReplacement [
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ENTITY first "&first;">]><root>&first;</root>']
		raise: XMLWellFormednessException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ENTITY % first "&#37;first;">%first;]><root/>']
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLParserTest >> testStandalone [
	| dtdXML standaloneDeclXML |

	dtdXML := self addressBookXMLWithDTD.
	self
		shouldnt: [
			SAXHandler
				parse: dtdXML
				usingNamespaces: true
				validation: true
				externalEntities: false]
		raise: XMLFileException.

	standaloneDeclXML :=
		(dtdXML copyUpTo: $>) allButLast, ' standalone="yes" ?>', (dtdXML copyAfter: $>).
	self
		shouldnt: [
			SAXHandler
				parse: standaloneDeclXML
				usingNamespaces: true
				validation: false
				externalEntities: true]
		raise: XMLFileException.
	self
		shouldnt: [
			SAXHandler
				parse: standaloneDeclXML
				usingNamespaces: true
				validation: true
				externalEntities: false]
		raise: XMLFileException.
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
		raise: XMLWellFormednessException
]

{ #category : #tests }
XMLParserTest >> testUndeclaredAttributes [
	self
		shouldnt: [
			SAXHandler
				parse: '<!DOCTYPE root [<!ENTITY ignored "ignored">]><root name="value"/>'
				usingNamespaces:true
				validation: true]
		raise: XMLValidationException.
	self
		shouldnt: [
			SAXHandler parse:
				'<!DOCTYPE root [
					<!ELEMENT root ANY>
					<!ATTLIST root name CDATA #IMPLIED>]><root name="value"></root>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ELEMENT root ANY>]><root name="value"></root>']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testUndeclaredElements [
	self
		shouldnt: [
			SAXHandler
				parse: '<!DOCTYPE root [<!ENTITY ignored "">]><root/>'
				usingNamespaces:true
				validation: true]
		raise:XMLValidationException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ELEMENT root ANY>]><root><undeclared/></root>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE root [<!ATTLIST root name CDATA #IMPLIED>]><root/>']
		raise: XMLValidationException.
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
XMLParserTest >> testUndeclaredEntitiesPreserved [
	| xml parser document |

	xml := '<!DOCTYPE root [
		<!ENTITY unreferenced "%undeclaredOne;">
		%undeclaredOne;]>
		<root name="&#34;&undeclaredTwo;&#34;">&lt;&undeclaredThree;&gt;</root>'.
	(parser := XMLDOMParser on: xml)
		isValidating: false;
		preservesUndeclaredEntityReferences: true.
	document := parser parseDocument.

	self
		assert: document doctypeDeclaration nodes size = 1;
		assert: document doctypeDeclaration firstNode replacement = '%undeclaredOne;';
		assert: (document root attributeAt: 'name') = '"&undeclaredTwo;"';
		assert: (document root contentString) = '<&undeclaredThree;>'.
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
	| dtd |

	dtd := '
		<!DOCTYPE root [
			<!NOTATION note PUBLIC "-//ext//note//EN">
			<!ENTITY unparsedEntity SYSTEM "note.txt" NDATA note>
			<!ELEMENT root EMPTY>
			<!ATTLIST root notation ENTITY #REQUIRED>
		]>'.
	self
		shouldnt: [SAXHandler parse: dtd, '<root notation="unparsedEntity" />']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<root notation="undeclaredUnparsedEntity" />']
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testUnparsedEntitiesUndeclaredNotations [
	| xml |

	xml := '
		<!DOCTYPE root [
			<!ENTITY unparsedEntity SYSTEM "note.txt" NDATA note>
		]><root/>'.
	self
		should: [SAXHandler parse: xml]
		raise: XMLValidationException.
	self
		shouldnt: [
			SAXHandler
				parse: xml
				usingNamespaces: true
				validation: false]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testUnreplacedContentEntities [
	| xml document |

	xml := '
		<!DOCTYPE one [<!ENTITY declared "replacement">]>
		<one two="&quot;&declared;&quot;">&#60;&declared;&#62;</one>'.
	document :=
		(XMLDOMParser on: xml)
			replacesContentEntityReferences: false;
			parseDocument.
	self
		assert: (document root attributeAt: 'two') = '&quot;&declared;&quot;';
		assert: document root contentString = '&#60;&declared;&#62;'.
]

{ #category : #tests }
XMLParserTest >> testUnreplacedContentEntitiesParameterEntities [
	| beforeSubset subset afterSubset xml document |

	beforeSubset := '<?xml version="1.1"?> <!DOCTYPE entity ['.
	subset :=
		'<!ENTITY % first "<!ENTITY second &#34;replacement&#34;>">
		%first;'.
	afterSubset := ']><entity>&second;</entity>'.
	xml := beforeSubset, subset, afterSubset.
	self assert: (XMLDOMParser parse: xml) root contentString = 'replacement'.
	
	document :=
		(XMLDOMParser on: xml)
			replacesContentEntityReferences: false;
			parseDocument.
	self assert: document root contentString = '&second;'.
	self
		should: [
			(SAXHandler on: (beforeSubset, '%first;]>'))
				replacesContentEntityReferences: false;
				parseDocument]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testUnreplacedContentEntitiesUndeclared [
	| xml document |

	xml := '<one two="&quot;&undeclared;&quot;">&#60;&undeclared;&#62;</one>'.
	self
		should: [
			(SAXHandler on: xml)
				replacesContentEntityReferences: false;
				parseDocument]
		raise: XMLValidationException.
	self
		shouldnt: [
			document :=
				(XMLDOMParser on: xml)
					isValidating: false;
					replacesContentEntityReferences: false;
					parseDocument]
		raise: XMLValidationException.
	self
		assert: (document root attributeAt: 'two') = '&quot;&undeclared;&quot;';
		assert: document root contentString = '&#60;&undeclared;&#62;'.
]

{ #category : #tests }
XMLParserTest >> testValidationAndConstraintsToggle [
	self assert:
		((SAXHandler on: '')
			isValidating: false;
			requiresDocumentConstraints: true;
			isValidating).
	self deny:
		((SAXHandler on: '')
			requiresDocumentConstraints: true;
			isValidating: false;
			requiresDocumentConstraints).
]

{ #category : #tests }
XMLParserTest >> testValidationAndEntityReferenceToggle [
	self deny:
		((SAXHandler on: '')
			isValidating: true;
			preservesUndeclaredEntityReferences: true;
			isValidating).
	self deny:
		((SAXHandler on: '')
			preservesUndeclaredEntityReferences: true;
			isValidating: true;
			preservesUndeclaredEntityReferences).
]

{ #category : #tests }
XMLParserTest >> testWhitespacePreservation [
	| xml root notPreserved preserved |

	xml := '
		<root xml:space="preserve">
			<not-preserved xml:space="default">
				<preserved xml:space="preserve">
				</preserved>
			</not-preserved>
		</root>'.
	root := (XMLDOMParser parse: xml) root.
	self
		assert: root nodes size = 3;
		assert: root stringNodes size = 2.
	root stringNodesDo: [:each | self assert: each isWhitespace].

	notPreserved := root nodes second.
	self assert: notPreserved nodes size = 1.

	preserved := notPreserved firstElement.
	self
		assert: preserved firstNode isStringNode;
		assert: preserved firstNode isWhitespace.
]

{ #category : #tests }
XMLParserTest >> testWhitespacePreservationValidation [
	| dtd |

	dtd := '
		<!DOCTYPE whitespace [
			<!ELEMENT whitespace EMPTY>
			<!ATTLIST whitespace xml:space (default|preserve) ''preserve''>]>'.
	self
		shouldnt: [SAXHandler parse: dtd, '<whitespace></whitespace>']
		raise: XMLValidationException.
	self
		shouldnt: [SAXHandler parse: dtd, '<whitespace xml:space="default"> </whitespace>']
		raise: XMLValidationException.
	self
		shouldnt: [
			SAXHandler parse:
				(dtd copyReplaceAll: '(default|preserve)' with: '(preserve|default)')]
		raise: XMLValidationException.
	self
		shouldnt: [SAXHandler parse: (dtd copyReplaceAll: '(default|preserve)' with: '(preserve)')]
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse:
				(dtd copyReplaceAll: '(default|preserve)' with: '(default|preserve|other)')]
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: (dtd copyReplaceAll: '(default|preserve)' with: 'CDATA')]
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<whitespace> </whitespace>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<whitespace><![CDATA[ ]]></whitespace>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: dtd, '<whitespace xml:space="default"><![CDATA[ ]]></whitespace>']
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: (dtd copyReplaceAll: '(default|preserve)' with: '(not|valid)')]
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: (dtd copyReplaceAll: '(default|preserve)' with: 'CDATA')]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testXMLIDAttributeValidation [
	| xml xmlWithDuplicateID |

	xml := '<a xml:id="one"><b xml:id="two"/></a>'.
	xmlWithDuplicateID := '<a xml:id="one"><b xml:id="one"/></a>'.
	self
		shouldnt: [SAXHandler parse: xml]
		raise: XMLValidationException.
	self
		should: [SAXHandler parse: xmlWithDuplicateID]
		raise: XMLValidationException.
	self
		shouldnt: [
			(SAXHandler on: xmlWithDuplicateID)
				isValidating: false;
				parseDocument]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testXMLIDAttributeValidationDTD [
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE one [
					<!ELEMENT one ANY>
					<!ATTLIST one xml:id CDATA #IMPLIED>]>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE one [
					<!ELEMENT one ANY>
					<!ATTLIST one xml:id ID #IMPLIED>]>
				<one xml:id="invalid:id"/>']
		raise: XMLValidationException.
	self
		should: [
			SAXHandler parse:
				'<!DOCTYPE one [
					<!ELEMENT one ANY>
					<!ELEMENT two ANY>
					<!ATTLIST one xml:id ID #IMPLIED>
					<!ATTLIST two xml:id ID #IMPLIED>]>
				<one xml:id="valid"><two xml:id="valid"/></one>']
		raise: XMLValidationException.
	self
		shouldnt: [
			SAXHandler parse:
				'<!DOCTYPE one [
					<!ELEMENT one ANY>
					<!ELEMENT two ANY>
					<!ATTLIST one xml:id ID #IMPLIED>
					<!ATTLIST two xml:id ID #IMPLIED>]>
				<one xml:id="valid1"><two xml:id="valid2"/></one>']
		raise: XMLValidationException.
	self
		shouldnt: [
			SAXHandler
				parse:
					'<!DOCTYPE one [
						<!ELEMENT one ANY>
						<!ELEMENT two ANY>
						<!ATTLIST one xml:id CDATA #IMPLIED>
						<!ATTLIST two xml:id ID #IMPLIED>]>
					<one xml:id="invalid:id"><two xml:id="invalid:id"/></one>'
				usingNamespaces: true
				validation: false]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLParserTest >> testXMLPrefixedAttributes [
	| xml document |

	xml := '<a xml="one" xmll="two" xml:="three" xmlnss="four"></a>'.
	document := XMLDOMParser parse: xml usingNamespaces: true.

	self
		assert: (document root attributeAt: 'xml') = 'one';
		assert: (document root attributeAt: 'xmll') = 'two';
		assert: (document root attributeAt: 'xml:') = 'three';
		assert: (document root attributeAt: 'xmlnss') = 'four'.
]

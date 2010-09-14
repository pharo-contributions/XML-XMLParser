Class {
	#name : #XMLParserTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Test'
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
	=> 2131 (Alexandre Bergel 3/29/2010 09:09)
	"
	Smalltalk garbageCollect.
	^ [600 timesRepeat: [SAXHandler parse: self addressBookXML]] timeToRun
]

{ #category : #benchmark }
XMLParserTest >> benchmark2 [
	"
	XMLParserTest new benchmark2
	"
	Smalltalk garbageCollect.
	^ [600 timesRepeat: [XMLDOMParser parse: self addressBookXML]] timeToRun
]

{ #category : #benchmark }
XMLParserTest >> benchmark3 [
	"
	XMLParserTest new benchmark3
	"
	Smalltalk garbageCollect.
	^ [300 timesRepeat: [self testParsing]] timeToRun
]

{ #category : #benchmark }
XMLParserTest >> benchmark4 [
	| doc |
	"
	XMLParserTest new benchmark4
	"
	doc := XMLDOMParser
		parseDocumentFrom: self addressBookXML readStream
		useNamespaces: false.
	^ [100000 timesRepeat: [
		doc root topElement
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

{ #category : #'tests-utf8' }
XMLParserTest >> testCDATASection [
	| xmlDocument element output |

	xmlDocument :=
		(XMLDOMParser on: self exampleCDATASectionXML readStream)
			preservesCDataSections: true;
			parseDocument.
	element := xmlDocument firstTagNamed: #'test-data'.

	self assert: element contentString = 'this is CDATA test content 1 < 2 & 5 > 3'.
	
	output := element printString.
	self assert: '<test-data><![CDATA[this is CDATA test content 1 < 2 & 5 > 3]]></test-data>' = output
	

]

{ #category : #'tests-utf8' }
XMLParserTest >> testDecodingCharacters [
	| xmlDocument element |

	xmlDocument := XMLDOMParser parseDocumentFrom: self exampleEncodedXML readStream.
	element := xmlDocument firstTagNamed: #'test-data'.

	self assert: element contentString first charCode = 8230.	


]

{ #category : #tests }
XMLParserTest >> testExampleAddressBook [
	| tokenizer |
	"self debug: #testExampleAddressBook"

	tokenizer := XMLTokenizer on: self addressBookXML readStream.

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

	tokenizer := XMLTokenizer on: self addressBookXMLWithDTD readStream.
	self
		shouldnt: [tokenizer streamReader next notNil] whileTrue
		raise: Error
]

{ #category : #tests }
XMLParserTest >> testLineEndingsDoNotMatter [
   |text cr crlf|
   text :=
 '<foo>
 bar
 baz
 </foo>'.
	cr := XMLDOMParser parseDocumentFrom: text readStream.
	crlf := XMLDOMParser parseDocumentFrom:
		(text copyReplaceAll: String cr with: String crlf) readStream.
	self assert: (cr root contentString) = (crlf root contentString).

]

{ #category : #tests }
XMLParserTest >> testParsing [
	| xmlDocument root firstPerson numberOfPersons |
	"self debug: #testParsing"

	xmlDocument := XMLDOMParser parseDocumentFrom: self addressBookXML readStream.
	self assert: (xmlDocument isKindOf: XMLDocument).
	root := xmlDocument root.
	self assert: (root class == XMLElement).

	self assert: (root firstTagNamed: 'person') notNil.
	self assert: (root firstTagNamed: 'addressbook') notNil.

	self assert: (root firstTagNamed: 'addressbook') == root.

	numberOfPersons := 0.
	root tagsNamed: 'person' do: [:p | numberOfPersons := numberOfPersons + 1].
	self assert: numberOfPersons = 4.

	firstPerson := root firstTagNamed: 'person'.
	self assert: (firstPerson attributeAt: 'employee-number') = 'A0000'.
	self assert: (firstPerson attributeAt: 'family-name') = 'Gates'.
	self assert: (firstPerson attributeAt: 'first-name') = 'Bob'.
	self assert: firstPerson attributeNames asArray =
		#('employee-number' 'family-name' 'first-name').
	self assert: firstPerson attributeAssociations asArray =
		{('employee-number'->'A0000'). ('family-name'->'Gates'). ('first-name'->'Bob').}.

	self assert: (firstPerson @ 'employee-number') = (firstPerson attributeAt: 'employee-number').
	self assert: (firstPerson @ 'employee-number') = (firstPerson @ 'employee-number').
]

{ #category : #tests }
XMLParserTest >> testParsingCharacters [
	| parser |
	"This test is actually not that useful. This is not the proper way of using the parser. This test is here just for specification purpose"
	"self debug: #testParsingCharacters"

	parser := SAXDriver on: self addressBookXML readStream.

	self assert: parser streamReader next = $<.
	self assert: parser streamReader next = $a.
	self assert: parser streamReader next = $d.
	self assert: parser streamReader next = $d.
	self assert: parser streamReader next = $r.
]

{ #category : #'tests-xmltokenizer' }
XMLParserTest >> testTokenizerAddressBook [
	| tokenizer |
	tokenizer := XMLTokenizer on: self addressBookXML readStream.
	[tokenizer streamReader next notNil] whileTrue
]

{ #category : #'tests-xmltokenizer' }
XMLParserTest >> testTokenizerAddressBookWithDTD [
	| tokenizer |
	tokenizer := XMLTokenizer on: self addressBookXMLWithDTD readStream.
	[tokenizer streamReader next notNil] whileTrue
]

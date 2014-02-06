Class {
	#name : #HTMLParserTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #benchmarking }
HTMLParserTest >> benchmark1 [
	"
	HTMLParserTest new benchmark1
	"
	Smalltalk garbageCollect.
	^ [4000 timesRepeat: [HTMLHandler parse: XMLParserTest addressBookXML]] timeToRun
]

{ #category : #benchmarking }
HTMLParserTest >> benchmark2 [
	"
	HTMLParserTest new benchmark2
	"
	Smalltalk garbageCollect.
	^ [4000 timesRepeat: [HTMLParser parse: XMLParserTest addressBookXML]] timeToRun
]

{ #category : #tests }
HTMLParserTest >> testDecodingCharacters [
	self assert:
		(HTMLParser parse: '&#60; &#x3C; &#0; &#-1; &#invalid; &#invalid &#')
			contentString = '< < &#0; &#-1; &#invalid; &#invalid &#'.
]

{ #category : #tests }
HTMLParserTest >> testHTMLEntities [
	| entity string |

	entity := 'nbsp'.
	string := ((HTMLParser parse: '<p>&', entity, ';</p>') findElementNamed: 'p') contentString.
	self
		assert: string size = 1;
		assert: string first == (HTMLParserTokenizer predefinedEntities at: entity).
		
	self assert:
		((HTMLParser parse: '<body>&undeclared; &undeclared &;')
			findElementNamed: 'body') contentString = '&undeclared; &undeclared &;'.
]

{ #category : #tests }
HTMLParserTest >> testParsingAttributes [
	| document element |

	document := HTMLParser parse: '<test one="quoted" two=''subQuoted'' three=unquoted four'.
	element := document findElementNamed: 'test'.
	self
		assert: (element attributeAt: 'one') = 'quoted';
		assert: (element attributeAt: 'two') = 'subQuoted';
		assert: (element attributeAt: 'three') = 'unquoted';
		assert: (element attributeAt: 'four') isEmpty.
]

{ #category : #tests }
HTMLParserTest >> testParsingForms [
	| document |

	document := HTMLParser parse: '<form><input><form><input>'.

	self assert:
		(document allElements asArray collect: [:each | each name]) =
			#('html' 'body' 'form' 'input' 'form' 'input').

	document allElementsNamed: 'form' do: [:each |
		self
			assert: each elements size = 1;
			assert: (each firstElement isNamed: 'input')].
	document allElementsNamed: 'input' do: [:each |
		self deny: each hasChildren].
]

{ #category : #tests }
HTMLParserTest >> testParsingInvalidPCData [
	| document |

	#('< one & two >' '& three < four >') do: [:each |
		document := HTMLParser parse: each.
		self
			assert: document allNodes size = 4;
			assert: (document findElementNamed: 'body') contentString = each].
]

{ #category : #tests }
HTMLParserTest >> testParsingNonHTMLSections [
	| document |

	document := HTMLParser parse:
		'<head><Title><b>"title</b></TITLE><SCRIPT>',
		'1 < 2; 3 > 2; document.write("</Script>");</Script>
		<Style>//"</STYLE><HEAD>'.
	self
		assert: (document findElementNamed: 'title') contentString = '<b>"title</b>';
		assert: (document findElementNamed: 'script') contentString =
			'1 < 2; 3 > 2; document.write("</Script>");';
		assert: (document findElementNamed: 'style') contentString = '//"'.
]

{ #category : #tests }
HTMLParserTest >> testParsingTables [
	| document tables trs tds |

	document := HTMLParser parse: '<table><tr><td>one<td>two<tr><td>three<table><tr><td>four'.
	self assert:
		(document allElements asArray collect: [:each | each name]) =
			#('html' 'body' 'table' 'tr' 'td' 'td' 'tr' 'td' 'table' 'tr' 'td').

	tables := document allElementsNamed: 'table'.
	self
		assert: tables first elements size = 2;
		assert: tables second elements size = 1.
	tables do: [:each | self assert: (each elements allSatisfy: [:element | element isNamed: 'tr'])].

	trs := document allElementsNamed: 'tr'.
	self
		assert: trs first elements size = 2;
		assert: trs second elements size = 1;
		assert: trs third elements size = 1.
	trs do: [:each | self assert: (each elements allSatisfy: [:element | element isNamed: 'td'])].

	tds := document allElementsNamed: 'td'.
	self
		assert: tds first contentString = 'one';
		assert: tds second contentString = 'two';
		assert: tds third contentString = 'three four';
		assert: (tds third nodes second isNamed: 'table').
]

{ #category : #tests }
HTMLParserTest >> testParsingText [
	| document |
	
	document := HTMLParser parse: 'text'.
	self
		assert: document allNodes size = 4;
		assert: (document allElementsCollect: [:each | each name]) asArray = #('html' 'body');
		assert: (document findElementNamed: 'body') contentString = 'text'.
]

{ #category : #tests }
HTMLParserTest >> testParsingVoidElements [
	| document |

	document := HTMLParser parse: '<body>one<img>two</img><body>three'.
	self
		assert: (document allElementsCollect: [:each | each name]) asArray = #('html' 'body' 'img');
		assert: (document findElementNamed: 'body') contentString = 'one twothree';
		deny: (document findElementNamed: 'img') hasChildren.
]

{ #category : #tests }
HTMLParserTest >> testParsingXML [
	self
		shouldnt: [
			HTMLHandler
				parse: XMLParserTest addressBookXML;
				parse: XMLParserTest addressBookXMLWithDTD;
				parse: XMLDOMParserTest addressBookNamespacedXML;
				parse: XMLDOMParserTest addressBookNamespacePrefixedXML]
		raise: XMLParserException
]

{ #category : #tests }
HTMLParserTest >> testReopeningHTML [
	| document |

	document := HTMLParser parse: '<html><B></body></html><I>'.
	self
		assert: (document allElementsCollect: [:each | each name]) asArray = #('html' 'body' 'b' 'i');
		assert: document root nodes size = 1;
		assert: (document root firstElement elementsCollect: [:each | each name]) asArray = #('b' 'i').

	document := HTMLParser parse: '<html><B>bold</body></html>normal'.
	self
		assert: (document allElementsCollect: [:each | each name]) asArray = #('html' 'body' 'b');
		assert: (document findElementNamed: 'body') contentString = 'bold normal'.
]

{ #category : #tests }
HTMLParserTest >> testReopeningHeadSection [
	| document |

	document := HTMLParser parse: '<head><p>text<Title>reopened'.
	self
		assert: (document root elementsCollect: [:each | each name]) asArray = #('head' 'body');
		assert: (document findElementNamed: 'head') elements size = 1;
		assert: ((document findElementNamed: 'head') elementAt: 'title') contentString = 'reopened';
		assert: (document findElementNamed: 'body') elements size = 1;
		assert: ((document findElementNamed: 'body') elementAt: 'p') contentString = 'text'.
]

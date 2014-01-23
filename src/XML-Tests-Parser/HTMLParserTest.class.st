Class {
	#name : #HTMLParserTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #tests }
HTMLParserTest >> testAcceptingInvalidPCData [
	| document |

	#('< one & two >' '& three < four >') do: [:each |
		document := HTMLParser parse: each.
		self
			assert: document allNodes size = 4;
			assert: (document findElementNamed: 'body') contentString = each].
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
		((HTMLParser parse: '<body>&undeclared;</body>') findElementNamed: 'body')
			contentString isEmpty.
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

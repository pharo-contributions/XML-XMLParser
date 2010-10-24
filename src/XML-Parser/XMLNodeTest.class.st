Class {
	#name : #XMLNodeTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests'
}

{ #category : #private }
XMLNodeTest class >> reorderTests: aSelectorCollection [
	"
	self reorderTests:

		((self selectors select: [:each | each asString beginsWith: 'test'])
			sortBy: [:a : b | (a asString compare: b asString) < 3]) asArray
	"

	| oldSource newSource methodCategory |

	aSelectorCollection doWithIndex: [:oldSelector :i |
		oldSource := (self sourceCodeAt: oldSelector) asString readStream.
		newSource := (String new: oldSource size) writeStream.
		methodCategory := self whichCategoryIncludesSelector: oldSelector.

		oldSource skip: 'test' size.
		[oldSource peek isDigit]
			whileTrue: [oldSource next].

		newSource
			nextPutAll: 'test';
			nextPutAll: (i printPaddedWith: $0 to: 3);
			nextPutAll: oldSource upToEnd.

		self
			removeSelector: oldSelector;
			compile: newSource contents classified: methodCategory].
]

{ #category : #assertions }
XMLNodeTest >> assertDocument: aDocument hasDoctype: aDoctype version: aVersion encoding: anEncoding [
	self
		assert: aDocument doctypeDeclaration = aDoctype;
		assert: aDocument version = aVersion;
		assert: aDocument encoding = anEncoding
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement hasAttribute: anAttributeName equalTo: anAttributeValue [
	self
		assert: (anElement includesAttribute: anAttributeName);
		assert: (anElement attributeAt: anAttributeName) = anAttributeValue;
		assert: (anElement @ anAttributeName) = anAttributeValue;
		assert: (anElement attributeNodeAt: anAttributeName) notNil;
		assert: (anElement attributeNodeAt: anAttributeName) value = anAttributeValue
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement hasAttributes: aDictionary [
	self assert:
		((aDictionary isMemberOf: Dictionary)
			ifTrue: [(Dictionary newFrom: anElement attributes) = aDictionary]
			ifFalse: [anElement attributes = aDictionary])
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement hasContentString: aContentString withStrings: aStringArray [
	| combinedStrings |

	self assert: anElement contentString = aContentString.
	combinedStrings := anElement stringNodes collect: [:each | each string].
	self assert: combinedStrings asArray = aStringArray asArray.
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement hasName: aName attributes: aDictionary contentString: aString [
	self
		assert: (anElement isNamed: aName);
		assertElement: anElement hasAttributes: aDictionary;
		assert: anElement contentString = aString
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement hasName: aName localName: aLocalName [
	self
		assert: anElement name = aName;
		assert: anElement localName = aLocalName;
		assert: (anElement isNamed: aName);
		assert: (anElement isNamed: aLocalName)
]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode hasPrefix: aPrefix uri: aUri [
	self
		assert: aNode prefix = aPrefix;
		assert: aNode namespaceURI = aUri
]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode hasType: aType [
	self assertNode: aNode hasTypes: (Array with: aType)
]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode hasTypes: aTypeArray [
	self deny:
		((#(isAttribute isCData isComment isContentNode isDocument isElement isPI isStringNode)
			copyWithoutAll: aTypeArray) anySatisfy: [:each | aNode perform: each]).
	self assert: (aTypeArray allSatisfy: [:each | aNode perform: each]).
]

{ #category : #assertions }
XMLNodeTest >> assertPI: aNode hasTarget: aTarget data: aData [
	self
		assert: aNode target = aTarget;
		assert: aNode data = aData;
		assert: aNode printString = ('<?', aTarget, ' ', aData, '?>')
]

{ #category : #assertions }
XMLNodeTest >> assertStringNode: aStringNode equals: aString withPrintString: aPrintString [
	self
		assert: aStringNode string = aString;
		assert: aStringNode contentString = aString;
		assert: aStringNode printString = aPrintString
]

{ #category : #accessing }
XMLNodeTest >> createNodes: aNumber with: aBlock [
	^ ((1 to: aNumber)
		collect: [:i | aBlock valueWithPossibleArgument: i])
			asOrderedCollection
]

{ #category : #accessing }
XMLNodeTest >> escapedString [
	^ 'test&lt;&gt;&amp;&quot;'
]

{ #category : #accessing }
XMLNodeTest >> intersperse: aNodeCollection with: aPaddingCollection [
	| mixedCollection nodeStream paddingStream |

	mixedCollection := XMLOrderedList new.
	nodeStream := aNodeCollection readStream.
	paddingStream := aPaddingCollection readStream.
	[nodeStream atEnd and: [paddingStream atEnd]]
		whileFalse: [
			nodeStream atEnd
				ifFalse: [mixedCollection add: nodeStream next].
			paddingStream atEnd
				ifFalse: [mixedCollection add: paddingStream next]].
	^ mixedCollection.
]

{ #category : #accessing }
XMLNodeTest >> intersperseWithNodes: aNodeCollection [
	^ self
		intersperse: aNodeCollection
		with: (self newNodes: aNodeCollection size)
]

{ #category : #accessing }
XMLNodeTest >> markupString [
	^ 'test<>&"'
]

{ #category : #accessing }
XMLNodeTest >> newElements: aNumber [
	^ self
		createNodes: aNumber
		with: [:i | XMLElement named: 'test', i asString]
]

{ #category : #accessing }
XMLNodeTest >> newElementsNamed: aNameArray [
	| names qualifiedName element |

	names := aNameArray asOrderedCollection.
	^ XMLOrderedList newFrom:
		(self
			createNodes: aNameArray size
			with: [
				((qualifiedName := names removeFirst) includes: $:)
					ifTrue: [
						qualifiedName splitQualifiedNameInto: [:prefix :localPart |
							element := XMLElement
								name: qualifiedName
								namespaceURI: 'http://', prefix]]
					ifFalse: [element := XMLElement named: qualifiedName].
				element]).
]

{ #category : #accessing }
XMLNodeTest >> newNodes: aNumber [
	^ self createNodes: aNumber with: [XMLMockNode new]
]

{ #category : #accessing }
XMLNodeTest >> newStrings: aNumber [
	^ self
		createNodes: aNumber
		with: [:i | XMLString string: 'test', i asString]
]

{ #category : #assertions }
XMLNodeTest >> should: aBlock addNode: aNode to: aParent [
	self should: aBlock addNodes: (Array with: aNode) to: aParent
]

{ #category : #assertions }
XMLNodeTest >> should: aBlock addNodes: aNodeCollection to: aParent [
	| added |

	self deny: (aNodeCollection anySatisfy: [:each | aParent includesNode: each]).
	(added := aBlock value) isCollection
		ifFalse: [added := Array with: added].
	self
		assert: added asArray = aNodeCollection asArray;
		assert: (added allSatisfy: [:each |
			(aParent includesNode: each) and: [each parent = aParent]])
]

{ #category : #assertions }
XMLNodeTest >> should: aBlock enumerate: aCollection [
	| enumerated |

	enumerated := OrderedCollection new.
	aBlock value: [:each | enumerated add: each].
	self assert: enumerated = aCollection asOrderedCollection.
]

{ #category : #assertions }
XMLNodeTest >> should: aBlock removeNode: aNode from: aParent [
	self should: aBlock removeNodes: (Array with: aNode) from: aParent
]

{ #category : #assertions }
XMLNodeTest >> should: aBlock removeNodes: aNodeCollection from: aParent [
	| removed |

	self assert: (aNodeCollection allSatisfy: [:each | aParent includesNode: each]).
	(removed := aBlock value) isCollection
		ifFalse: [removed := Array with: removed].

	self
		assert: removed asArray = aNodeCollection asArray;
		deny: (removed anySatisfy: [:each | aParent includesNode: each])
]

{ #category : #tests }
XMLNodeTest >> test001node [
	| node parent |

	node := XMLMockNode new.
	self
		deny: node hasChildren;
		assert:
			(#(isAttribute isCData isComment isContentNode isDocument
				isElement isPI isStringNode hasParent)
					noneSatisfy: [:each | node perform: each]);
		assert:
			(#(nextNode previousNode parent)
				allSatisfy: [:each | (node perform: each) isNil]);
		assert: node asString = (node class asString, '(', node identityHash asString, ') ');
		assert: node contentString isEmpty.

	parent := XMLMockNode new.
	node parent: parent.
	self
		assert: node hasParent;
		assert: node parent = parent.
]

{ #category : #tests }
XMLNodeTest >> test002processingInstruction [
	| pi t d |

	pi := XMLPI new.
	t := 'target'.
	d := 'data'.
	self
		assert: pi isPI;
		assertPI: pi hasTarget: '' data: '';
		assertPI: (pi target: t) hasTarget: t data: '';
		assertPI: (pi data: d) hasTarget: t data: d;
		assertPI: (XMLPI target: t data: d) hasTarget: t data: d.
]

{ #category : #tests }
XMLNodeTest >> test003stringNode [
	| node raw escaped |

	node := XMLString new.
	raw := self markupString.
	escaped := self escapedString.
	self
		assert: node isStringNode & node isContentNode;
		assertStringNode: node equals: '' withPrintString: '';
		assertStringNode: (node string: raw) equals: raw withPrintString: escaped;
		assertStringNode: (node addContent: raw) equals: raw, raw withPrintString: escaped, escaped.
	self
		assertStringNode: (node addContent: (XMLString string: raw))
		equals: raw, raw, raw
		withPrintString: escaped, escaped, escaped.

	self assertStringNode: (XMLString string: raw) equals: raw withPrintString: escaped.
	self
		assertStringNode: (XMLString string: (XMLString string: raw))
		equals: raw
		withPrintString: escaped.

	self assertStringNode: raw asXMLString equals: raw withPrintString: escaped.
]

{ #category : #tests }
XMLNodeTest >> test004cdataNode [
	| node raw |

	node := XMLCData new.
	raw := self markupString.
	self
		assert: node isCData & node isStringNode & node isContentNode;
		assertStringNode: node equals: '' withPrintString: '<![CDATA[]]>';
		assertStringNode: (node string: raw) equals: raw withPrintString: '<![CDATA[', raw, ']]>' 
]

{ #category : #tests }
XMLNodeTest >> test005emptyNodeWithElements [
	| node |

	node := XMLMockNodeWithElements new.
	self
		deny: node hasChildren;
		deny: node hasElements;
		assert: node nodes isEmpty;
		assert: node elements isEmpty;
		assert: node firstNode isNil;
		assert: node firstElement isNil;
		assert: node lastNode isNil;
		assert: node lastElement isNil.
]

{ #category : #tests }
XMLNodeTest >> test006namespaces [
	| node |

	node := XMLElement new.
	self
		assertNode: node hasPrefix: '' uri: '';
		assertNode: (node name: 'foo:name' namespaceURI: 'http://foo') hasPrefix: 'foo' uri: 'http://foo'.

	node declarePrefix: 'bar' uri: 'http://bar'.
	self assertNode: (node prefix: 'bar') hasPrefix: 'bar' uri: 'http://bar'.

	self should: [node prefix: 'badprefix'] raise: XMLNamespaceException.
]

{ #category : #tests }
XMLNodeTest >> test007addingNodes [
	| node children |

	node := XMLMockNodeWithElements new.
	children := self newNodes: 6.
	self
		should: [node addNode: children second] addNode: children second to: node;
		should: [node addNodeFirst: children first] addNode: children first to: node.
	self
		should: [node addNodes: (children copyFrom: 3 to: 4)]
		addNodes: (children copyFrom: 3 to: 4)
		to: node.
	self
		should: [node addNode: children sixth after: children fourth]
		addNode: children sixth
		to: node.
	self
		should: [node addNode: children fifth before: children sixth]
		addNode: children fifth
		to: node.

	self
		assert: node nodes asOrderedCollection = children;
		assert: node firstNode = children first;
		should: [node addNode: (XMLMockNode new parent: XMLMockNode new)] raise: Error;
		should: [node addNode: children first] raise: Error.
]

{ #category : #tests }
XMLNodeTest >> test008removingNodes [
	| node children |

	node := XMLMockNodeWithElements new.
	children := self newNodes: 5.
	node addNodes: children.
	self
		should: [node removeNode: children first]
		removeNode: children first
		from: node.
	self
		should: [node removeNodes: (children copyFrom: 2 to: 3)]
		removeNodes: (children copyFrom: 2 to: 3)
		from: node.
	self
		assert: node removeNodes = node;
		deny: node hasChildren.
]

{ #category : #tests }
XMLNodeTest >> test009accessingBeforeAfterNodes [
	| node children |

	node := XMLMockNodeWithElements new.
	children := self newNodes: 3.
	node addNodes: children.
	children do: [:each | | next previous |
		next := children after: each ifAbsent: [nil].
		previous := children before: each ifAbsent: [nil].
		
		self
			assert: each nextNode = next;
			assert: each previousNode = previous;
			assert: (node nodeAfter: each) = next;
			assert: (node nodeBefore: each) = previous].
]

{ #category : #tests }
XMLNodeTest >> test010emptyElement [
	| element |

	element := XMLElement new.
	self
		assert: element isElement & element isContentNode;
		deny: element hasAttributes;
		deny: element hasContentNodes;
		assert: element contentNodes isEmpty;
		assert: element stringNodes isEmpty.
]

{ #category : #tests }
XMLNodeTest >> test011elementNaming [
	| element |

	element := XMLElement new.
	self
		assertElement: element hasName: '' localName: '';
		assertElement: (element name: 'foo') hasName: 'foo' localName: 'foo';
		assertNode: element hasPrefix: '' uri: ''.

	element name: 'bar:foo' namespaceURI: 'http://bar'.
	self
		assertElement: element hasName: 'bar:foo' localName: 'foo';
		assertNode: element hasPrefix: 'bar' uri: 'http://bar'.
]

{ #category : #tests }
XMLNodeTest >> test012elementContentString [
	| element str |

	str := self markupString.
	(element := XMLElement new) contentString: str.
	self
		assert: element hasChildren;
		assert: element hasContentNodes;
		assert: element hasStringNodes;
		assert: element contentString = str.

	"Intersperse between text"
	element addNode: XMLMockNode new.
	self
		assertElement: (element addContent: str)
		hasContentString: str, ' ', str
		withStrings: (Array with: str with: str).

	"addContent: should combine neighboring string nodes"
	self
		assertElement: (element addContent: (XMLString string: str))
		hasContentString: str, ' ', str, str
		withStrings: (Array with: str with: str, str).

	element addElement: ((XMLElement named: 'foo') addContent: 'test').
	self assert: (element contentStringAt: 'foo') = 'test'.
]

{ #category : #tests }
XMLNodeTest >> test013elementAttributes [
	| element attrs |

	element := XMLElement new.
	self
		assert: (element attributeAt: 'foo') isEmpty;
		assert: (element attributeAt: 'foo' ifAbsent: ['absent']) = 'absent';
		deny: (element includesAttribute: 'foo').

	self
		assert: (element attributeAt: 'foo' put: 'test') = 'test';
		assert: element hasAttributes;
		assertElement: element hasAttribute: 'foo' equalTo: 'test';
		assert: (element attributeAt: 'bar' ifAbsentPut: ['test2']) = 'test2';
		assertElement: element hasAttribute: 'bar' equalTo: 'test2';
		assert: element attributeNames asArray =  #('foo' 'bar').

	self
		assert: element attributeAssociations asArray =
			(Array with: 'foo'->'test' with: 'bar'->'test2').
	self
		assertElement: element
		hasAttributes:
			(XMLOrderPreservingDictionary
				with: 'foo'->'test'
				with: 'bar'->'test2').

	self
		assert: (element removeAttribute: 'foo') = 'test';
		assert: (element removeAttribute: 'bar') = 'test2';
		deny: element hasAttributes.
]

{ #category : #tests }
XMLNodeTest >> test014elementConstructors [
	| noAttributes attributes str element |

	noAttributes := XMLOrderPreservingDictionary new.
	self
		assertElement: (XMLElement named: 'foo')
		hasName: 'foo'
		attributes: noAttributes
		contentString: ''.

	attributes := XMLOrderPreservingDictionary with: 'foo'->'test1' with: 'bar'->'test2'.
	self
		assertElement: (XMLElement name: 'foo' attributes: attributes)
		hasName: 'foo'
		attributes: attributes
		contentString: ''.

	str := self markupString.
	self
		assertElement: (XMLElement named: 'foo')
		hasName: 'foo'
		attributes: noAttributes
		contentString: ''.
	self
		assertElement: (XMLElement name: 'foo' attributes: attributes)
		hasName: 'foo'
		attributes: attributes
		contentString: ''.

	element := XMLElement
		name: 'prefix:foo'
		namespaceURI: 'http://foo'
		attributes: attributes.
	self
		assertElement: element hasName: 'prefix:foo' attributes: attributes contentString: '';
		assertNode: element hasPrefix: 'prefix' uri: 'http://foo'.
]

{ #category : #tests }
XMLNodeTest >> test015elementCDATANodes [
	| element str |

	str := self markupString.
	(element := XMLElement new) addNode: (XMLCData string: str).
	self
		assert: element hasChildren;
		assert: element hasStringNodes;
		assert: element contentString = str;
		assert: (element firstNode isKindOf: XMLCData) 
]

{ #category : #tests }
XMLNodeTest >> test016addingElements [
	| node elements children |

	node := XMLMockNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'bar' 'baz').
	node addNodes: (self intersperseWithNodes: elements).
	self
		assert: node hasElements;
		assert: node firstElement = elements first;
		assert: node elements = elements;
		assert: (elements allSatisfy: [:each | node includesElement: each name]).
]

{ #category : #tests }
XMLNodeTest >> test017accessingBeforeAfterElements [
	| node elements |

	node := XMLMockNodeWithElements new.
	elements := self newElements: 3.
	node addNodes: (self intersperseWithNodes: elements).
	elements do: [:each | | next previous |
		next := elements after: each ifAbsent: [nil].
		previous := elements before: each ifAbsent: [nil].
		
		self
			assert: each nextElement = next;
			assert: each previousElement = previous;
			assert: (node elementAfter: each) = next;
			assert: (node elementBefore: each) = previous].
]

{ #category : #tests }
XMLNodeTest >> test018elementPrinting [
	| element attributes |

	element := (XMLElement named: 'element').
	attributes := XMLOrderPreservingDictionary with: 'b'->'two' with: 'a'->'one'.
	self
		assert: element printString = '<element />';
		assert: (element contentString: 'test') printString = '<element>test</element>';
		assert: (element setAttributes: attributes) printString = '<element b="two" a="one">test</element>'
]

{ #category : #tests }
XMLNodeTest >> test019nodeAndElementEnumeration [
	| node nodes elements |

	node := XMLMockNodeWithElements new.
	self
		should: [:block | node nodesDo: block] enumerate: #();
		should: [:block | node elementsDo: block] enumerate: #().

	elements := self newElements: 3.
	nodes := self intersperseWithNodes: elements.
	node addNodes: nodes.
	self
		should: [:block | node nodesDo: block] enumerate: nodes;
		should: [:block | node elementsDo: block] enumerate: elements.
]

{ #category : #tests }
XMLNodeTest >> test020contentNodeEnumeration [
	| node nodes elements stringNodes contentNodes |

	node := XMLElement new.
	elements := self newElements: 3.
	stringNodes := self newStrings: 3.
	contentNodes := self intersperse: elements with: stringNodes.
	node addNodes: (self intersperseWithNodes: contentNodes).

	self
		assert: node contentNodes = contentNodes;
		should: [:block | node contentNodesDo: block] enumerate: contentNodes;
		should: [:block | node stringNodesDo: block] enumerate: stringNodes.
]

{ #category : #tests }
XMLNodeTest >> test021elementAccessing [
	| node nodes elements |

	node := XMLMockNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'bar' 'prefix:foo' 'baz').
	node addNodes: (self intersperseWithNodes: elements).
	self
		assert: (node elementAt: 'absent') isNil;
		assert: (node elementAt: 'absent' ifAbsent: ['absent']) = 'absent';
		assert: (node elementsAt: 'absent') isEmpty;
		assert: (node elementAtAny: #('absent')) isNil;
		assert: (node elementAtAny: #('absent') ifAbsent: ['absent']) = 'absent';
		assert: (node elementAt: 'foo') = elements first;
		assert: (node elementAt: 'bar') = elements second;
		assert: (node elementsAt: 'foo') = ((elements first: 3) copyWithout: elements second);
		assert: (node elementAt: 'prefix:foo') = elements third;
		assert: (node elementsAt: 'prefix:foo') = (XMLOrderedList with: elements third);
		assert: (node elementAtAny: #('bar' 'prefix:foo')) = elements second;
		assert: (node elementAtAny: #('absent' 'baz')) = elements last.
]

{ #category : #tests }
XMLNodeTest >> test022firstTagSearching [
	| node elements |

	node := XMLMockNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'bar' 'prefix:foo' 'prefix:bar' 'bar' 'baz').
	node addNodes: (elements first: 2).
	node nodes first addNodes: (elements copyFrom: 3 to: 4).
	node nodes second addNodes: (elements copyFrom: 5 to: 6).
	self
		assert: (node firstTagNamed: 'absent') isNil;
		assert: (node firstTagNamed: 'foo' with: [false]) isNil;
		assert: (node firstTagNamedAny: #('absent')) isNil;
		assert: (node firstTagNamedAny: #('foo') with: [false]) isNil.

	self
		assert: (node firstTagNamed: 'foo') = elements first;
		assert: (node firstTagNamed: 'prefix:bar') = elements fourth;
		assert: (node firstTagNamedAny: #('prefix:foo' 'prefix:bar' 'absent')) = elements third;
		assert: (node firstTagNamedAny: #('absent:bar' 'baz')) = elements last;
		assert: (elements first firstTagNamed: 'foo') = elements first;
		assert: (elements second firstTagNamedAny: #('foo' 'bar')) = elements second.
	self assert: (node
		firstTagNamed: 'bar'
		with: [:each | each = elements fifth]) = elements fifth.
	self assert: (node
		firstTagNamedAny: #('bar' 'baz')
		with: [:each | each = elements last]) = elements last.
	self assert: (elements first
		firstTagNamed: 'foo'
		with: [:each | each = elements third]) = elements third.
	self assert: (elements second
		firstTagNamedAny: #('bar')
		with: [:each | each = elements fifth]) = elements fifth.
]

{ #category : #tests }
XMLNodeTest >> test023tagsNamedSearching [
	| node elements |

	node := XMLMockNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'bar' 'prefix:foo' 'bar' 'prefix:bar' 'baz').
	node addNodes: (elements first: 2).
	node nodes first addNodes: (elements copyFrom: 3 to: 4).
	node nodes second addNodes: (elements copyFrom: 5 to: 6).
	self
		should: [:block | node tagsNamed: 'absent' do: block] enumerate: #();
		should: [:block | node tagsNamedAny: #('absent') do: block] enumerate: #();
		should: [:block | node elementsAt: 'absent' do: block] enumerate: #().

	self
		should: [:block | node tagsNamed: 'foo' do: block]
		enumerate: (Array with: elements first with: elements third).
	self
		should: [:block | node tagsNamed: 'prefix:foo' do: block]
		enumerate: (Array with: elements third).
	self
		should: [:block | node firstElement elementsAt: 'foo' do: block]
		enumerate: (Array with: elements third).
	self
		should: [:block | node tagsNamedAny: #('foo' 'prefix:bar') do: block]
		enumerate: (Array with: elements first with: elements third with: elements fifth)
]

{ #category : #tests }
XMLNodeTest >> test024elementRemoving [
	| node nodes elements |

	node := XMLMockNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'prefix:bar' 'bar' 'baz').
	node addNodes: (self intersperseWithNodes: elements).
	self
		assert: (node removeNode: elements first) = elements first;
		assert: node elements = elements allButFirst;
		assert: (node elementAt: 'foo') isNil;
		assert: (node elementsAt: 'foo') isEmpty;
		assert: (node removeNode: elements second) = elements second;
		assert: node elements = (elements last: 2);
		assert: (node elementAt: 'bar') = elements third;
		assert: (node elementsAt: 'bar') = (XMLOrderedList with: elements third);
		assert: (node removeNode: elements third) = elements third;
		assert: node elements = (elements last: 1);
		assert: (node elementAt: 'bar') isNil;
		assert: (node elementsAt: 'bar') isEmpty;
		assert: node firstElement = elements last;
		assert: (node removeNode: elements last) = elements last;
		deny: node hasElements;
		assert: node firstElement isNil.
]

{ #category : #tests }
XMLNodeTest >> test025elementRenaming [
	| node nodes elements |

	node := XMLMockNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'prefix:bar' 'bar' 'baz').
	node addNodes: (self intersperseWithNodes: elements).

	elements first name: 'notfoo'.
	self
		deny: (node includesElement: 'foo');
		assert: (node elementAt: 'foo') isNil;
		assert: (node elementsAt: 'foo') isEmpty;
		assert: (node elementAt: 'notfoo') = elements first.

	elements third name: 'prefix:bar' namespaceURI: 'http://bar'.
	self assert: (node elementsAt: 'prefix:bar') = (elements copyFrom: 2 to: 3).

	elements fourth name: 'bar'.
	self assert: (node elementsAt: 'bar') = elements allButFirst.

	elements fourth name: 'foo'.
	self assert: (node elementAt: 'foo') = elements last.
]

{ #category : #tests }
XMLNodeTest >> test026documentTest [
	| doc root doctype |

	doc := XMLDocument new.
	root := XMLElement new.
	doctype := XMLDoctypeDeclaration root: 'root' publicID: 'public' systemID: 'system'.
	self
		assert: doc isDocument;
		assert: doc root isNil;
		assert: (doc addElement: root) root = root;
		assertDocument: doc hasDoctype: nil version: nil encoding: 'UTF-8'.

	self
		assertDocument: (doc doctypeDeclaration: doctype)
		hasDoctype: doctype
		version: nil
		encoding: 'UTF-8'.
	self
		assertDocument: (doc version: 1.0)
		hasDoctype: doctype
		version: 1.0
		encoding: 'UTF-8'.
	self
		assertDocument: (doc encoding: 'ISO Latin-1')
		hasDoctype: doctype
		version: 1.0
		encoding: 'ISO Latin-1'.
]

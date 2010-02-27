Class {
	#name : #XMLNodeTest,
	#superclass : #TestCase,
	#classInstVars : [
		'testOrdering'
	],
	#category : #'XML-Parser-Test'
}

{ #category : #assertions }
XMLNodeTest >> assertDocument: aDocument dtd: aDtd version: aVersion encoding: anEncoding required: aRequired [
	self
		assert: aDocument dtd = aDtd;
		assert: aDocument version = aVersion;
		assert: aDocument encoding = anEncoding;
		assert: aDocument requiredMarkup = aRequired
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement attribute: aSymbol is: aValue [
	aValue
		ifEmpty: [self assert: (anElement attributeAt: aSymbol) isNil]
		ifNotEmpty: [self assert: (anElement attributeAt: aSymbol) = aValue].
	self
		assert: (anElement at: aSymbol) = aValue;
		assert: (anElement @ aSymbol) = aValue
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement contentString: aContentString contents: aContentArray [
	| contentStrings |

	self
		assert: anElement contentString = aContentString;
		assert: anElement characterData = aContentString.
	
	contentStrings := (anElement contents collect: [:each | each string]).
	self assert: contentStrings asArray = aContentArray.
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement name: aName attributes: aDictionary contentString: aString [
	self
		assert: (anElement isNamed: aName);
		assert: anElement attributes = aDictionary;
		assert: anElement contentString = aString
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement name: aName localName: aLocalName [
	self
		assert: anElement name == aName asSymbol;
		assert: anElement tag == aName asSymbol;
		assert: anElement qualifiedName == aName asSymbol;
		assert: anElement localName == aLocalName asSymbol;
		assert: (anElement isNamed: aName);
		assert: (anElement isNamed: aLocalName)
]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode namespace: aNamespace uri: aUri [
	self
		assert: aNode namespace = aNamespace;
		assert: aNode namespaceURI = aUri
]

{ #category : #assertions }
XMLNodeTest >> assertPI: aNode target: aTarget data: aData [
	self
		assert: aNode target = aTarget;
		assert: aNode data = aData;
		assert: aNode asString = ('<?', aTarget, ' ', aData, ' ?>')
]

{ #category : #assertions }
XMLNodeTest >> assertString: aNode is: aString printed: aPrintString [
	self
		assert: aNode string = aString;
		assert: aNode characterData = aString;
		assert: aNode asString = aPrintString
]

{ #category : #accessing }
XMLNodeTest >> createNodes: aNumber with: aBlock [
	^ ((1 to: aNumber) collect: [:i | aBlock value]) asOrderedCollection
]

{ #category : #accessing }
XMLNodeTest >> interspersedWithNodes: anElementCollection [
	| mixedNodes |

	mixedNodes := OrderedCollection new.
	anElementCollection
		do: [:each | mixedNodes add: each]
		separatedBy: [mixedNodes add: XMLNode new].
	^ mixedNodes.
]

{ #category : #accessing }
XMLNodeTest >> newElements: aNumber [
	^ self newElementsNamed: ((1 to: aNumber) collect: [:i | 'test', i asString])
]

{ #category : #accessing }
XMLNodeTest >> newElementsNamed: aNameArray [
	| names fullName localName |

	names := aNameArray asOrderedCollection.
	^ self
		createNodes: aNameArray size
		with: [
			fullName := names removeFirst asString.
			(localName := fullName copyAfter: $:)
				ifNotEmpty: [
					XMLElement
						named: localName
						namespace: (fullName copyUpTo: $:)
						uri: nil
						attributes: Dictionary new]
				ifEmpty: [XMLElement named: fullName]].
]

{ #category : #accessing }
XMLNodeTest >> newNodes: aNumber [
	^ self createNodes: aNumber with: [XMLNode new]
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
XMLNodeTest >> test010Node [
	| node parent tests accessors |

	node := XMLNode new.
	parent := XMLNode new.
	tests := (XMLNode methodsInCategory: #testing) copyWithout: #isEmpty.
	accessors := #(nextNode previousNode parent).
	self
		assert: node isEmpty;
		deny: (tests anySatisfy: [:each | node perform: each]);
		deny: (accessors anySatisfy: [:each | (node perform: each) notNil]).

	node parent: parent.
	self
		assert: node hasParent;
		assert: node parent = parent.

	self should: [node addContent: ''] raise: SAXParseException.
]

{ #category : #tests }
XMLNodeTest >> test020PI [
	| pi t d |

	pi := XMLPI new.
	t := 'target'.
	d := 'data'.
	self
		assert: pi isPI & pi isProcessingInstruction;
		assertPI: pi target: '' data: '';
		assertPI: (pi target: t) target: t data: '';
		assertPI: (pi data: d) target: t data: d;
		assertPI: (XMLPI target: t data: d) target: t data: d.
]

{ #category : #tests }
XMLNodeTest >> test030StringNode [
	| string raw escaped |

	string := XMLStringNode new.
	raw := 'test&<>"'.
	escaped := 'test&amp;&lt;&gt;&quot;'.
	self
		assert: (string isText & string isTagOrText);
		assertString: string is: '' printed: '';
		assertString: (string string: raw) is: raw printed: escaped;
		assertString: (XMLStringNode string: string) is: raw printed: escaped;
		assertString: (string addContent: raw) is: raw, raw printed: escaped, escaped.
	self
		assertString: (string addContent: (XMLStringNode string: raw))
		is: raw, raw, raw
		printed: escaped, escaped, escaped.
]

{ #category : #tests }
XMLNodeTest >> test040emptyNodeWithElements [
	| node |

	node := XMLNodeWithElements new.
	self
		assert: node isEmpty;
		deny: node hasElements;
		assert: node nodes isEmpty;
		assert: node elements isEmpty;
		assert: node topNode isNil;
		assert: node topElement isNil.
]

{ #category : #tests }
XMLNodeTest >> test041namespaces [
	| node ns nsUri |

	node := XMLNodeWithElements new.
	ns := 'foo'.
	nsUri := 'http://www.example.com/foo'.
	self
		assertNode: node namespace: nil uri: nil;
		assertNode: (node namespace: ns uri: nsUri) namespace: ns uri: nsUri.
]

{ #category : #tests }
XMLNodeTest >> test042addingNodes [
	| node children |

	node := XMLNodeWithElements new.
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
		should: [node addNode: (self newNode parent: self newNode)] raise: Error;
		should: [node addNode: children first] raise: Error.

	self
		assert: node nodes = children;
		assert: node topNode = children first.
]

{ #category : #tests }
XMLNodeTest >> test043removingNodes [
	| node children |

	node := XMLNodeWithElements new.
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
		should: [node removeNodes]
		removeNodes: (children last: 2)
		from: node.
	self assert: node isEmpty.
]

{ #category : #tests }
XMLNodeTest >> test044accessingBeforeAfterNodes [
	| node children |

	node := XMLNodeWithElements new.
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
XMLNodeTest >> test050emptyElement [
	| element |

	element := XMLElement new.
	self
		assert: element isTag & element isTagOrText;
		deny: element hasAttributes;
		deny: element hasContents;
		assert: element elementsAndContents isEmpty;
		assert: element contents isEmpty.
]

{ #category : #tests }
XMLNodeTest >> test051elementNaming [
	| element |

	element := XMLElement new.
	self
		assertElement: element name: '' localName: '';
		assertElement: (element name: 'foo') name: #foo localName: #foo;
		assertNode: element namespace: nil uri: nil.

	element namespace: 'bar' uri: 'http://bar'.
	self
		assertElement: element name: #bar:foo localName: #foo;
		assertNode: element namespace: 'bar' uri: 'http://bar'.

	element name: 'baz' namespace: 'foo' uri: 'http://foo'.
	self
		assertElement: element name: #foo:baz localName: #baz;
		assertNode: element namespace: 'foo' uri: 'http://foo'.
]

{ #category : #tests }
XMLNodeTest >> test052elementContentString [
	| element str |

	str := 'test<>&"'.
	(element := XMLElement new) contentString: str.
	self
		deny: element isEmpty;
		assert: element hasContents;
		assert: element contentString = str.

	"Intersperse between text"
	element addNode: XMLNode new.
	self
		assertElement: (element addContent: str)
		contentString: str
		contents: (Array with: str with: str).

	"addContent: should combine neighboring string nodes"
	self
		assertElement: (element addContent: (XMLStringNode string: str))
		contentString: str
		contents: (Array with: str with: str, str).
]

{ #category : #tests }
XMLNodeTest >> test053elementAttributes [
	| element attrs |

	element := XMLElement new.
	self
		assert: (element attributeAt: #absent ifAbsent: ['absent']) = 'absent';
		assertElement: element attribute: #absent is: ''.
	self
		assert: (element attributeAt: 'foo' put: 'bar') = 'bar';
		assert: element hasAttributes;
		assertElement: element attribute: #foo is: 'bar';
		assert: (element at: 'bar' put: 'foo') = 'foo';
		assertElement: element attribute: 'bar' is: 'foo'.
	self assert:
		element allAttributes asSortedCollection =
			#('bar' 'foo') asSortedCollection.
	self
		assert: (element removeAttribute: #foo) = 'bar';
		deny: (element includesAttribute: #foo).
]

{ #category : #tests }
XMLNodeTest >> test054elementConstructors [
	| noAttributes attributes element |

	noAttributes := Dictionary new.
	attributes := Dictionary with: #attr1->'value1' with: 'attr2'->'value2'.

	self
		assertElement: (XMLElement named: #foo)
		name: #foo
		attributes: noAttributes
		contentString: ''.
	self
		assertElement: (XMLElement named: #foo attributes: attributes)
		name: #foo
		attributes: attributes
		contentString: ''.
	self
		assertElement: (XMLElement named: #foo contentString: 'test<>&"')
		name: #foo
		attributes: noAttributes
		contentString: 'test<>&"'.
	self
		assertElement: (XMLElement named: #foo attributes: attributes contentString: 'test<>&"')
		name: #foo
		attributes: attributes
		contentString: 'test<>&"'.

	element := XMLElement named: #foo namespace: 'prefix' uri: 'http://foo' attributes: attributes.
	self
		assertElement: element name: #prefix:foo attributes: attributes contentString: '';
		assertNode: element namespace: 'prefix' uri: 'http://foo'.
]

{ #category : #tests }
XMLNodeTest >> test060addingElements [
	| node elements children |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #(foo bar baz).
	node addNodes: (self interspersedWithNodes: elements).
	self
		assert: node hasElements;
		assert: node topElement = elements first;
		assert: node elements = elements;
		assert: (elements allSatisfy: [:each | node includesElement: each name]).
]

{ #category : #tests }
XMLNodeTest >> test061accessingBeforeAfterElements [
	| node elements |

	node := XMLNodeWithElements new.
	elements := self newElements: 3.
	node addNodes: (self interspersedWithNodes: elements).
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
XMLNodeTest >> test062elementPrinting [
	| element attributes |

	element := (XMLElement named: #foo).
	(attributes := Dictionary new)
		at: #a put: 'b';
		at: #b put: 'c'.
	self
		assert: element asString = '<foo></foo>';
		assert: (element contentString: 'test') asString = '<foo>test</foo>';
		assert: (element setAttributes: attributes) asString = '<foo a="b" b="c">test</foo>'
]

{ #category : #tests }
XMLNodeTest >> test070nodeAndElementEnumeration [
	| node nodes elements |

	node := XMLNodeWithElements new.
	self
		should: [:block | node nodesDo: block] enumerate: #();
		should: [:block | node elementsDo: block] enumerate: #().

	elements := self newElements: 3.
	nodes := self interspersedWithNodes: elements.
	node addNodes: nodes.
	self
		should: [:block | node nodesDo: block] enumerate: nodes;
		should: [:block | node elementsDo: block] enumerate: elements.
]

{ #category : #tests }
XMLNodeTest >> test071elementsAndContentsEnumeration [
	| node nodes elements contents elementsAndContents |

	node := XMLElement new.
	elements := self newElements: 3.
	contents := Array with: (XMLStringNode string: 'test') with: (XMLStringNode string: 'test2').
	(elementsAndContents := elements copy)
		addFirst: contents first;
		add: contents second after: elements second.
	node addNodes: (self interspersedWithNodes: elementsAndContents).

	self
		assert: node elementsAndContents = elementsAndContents;
		should: [:block | node elementsAndContentsDo: block] enumerate: elementsAndContents;
		should: [:block | node contentsDo: block] enumerate: contents.
]

{ #category : #tests }
XMLNodeTest >> test080elementAccessing [
	| node nodes elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #(foo bar prefix:foo baz).
	node addNodes: (self interspersedWithNodes: elements).
	self
		assert: (node elementAt: #absent) isNil;
		assert: (node elementAt: #absent ifAbsent: ['absent']) = 'absent';
		assert: (node elementsAt: #absent) isEmpty;
		assert: (node elementsAt: #absent ifAbsent: ['absent']) = 'absent';
		assert: (node elementAtAny: #(absent)) isNil;
		assert: (node elementAtAny: #(absent) ifAbsent: ['absent']) = 'absent';
		assert: (node elementAt: 'foo') = elements first;
		assert: (node elementAt: #bar) = elements second;
		assert: (node elementsAt: #foo) = ((elements first: 3) copyWithout: elements second);
		assert: (node elementAt: 'prefix:foo') = elements third;
		assert: (node elementsAt: 'prefix:foo') = (OrderedCollection with: elements third);
		assert: (node elementAtAny: #(bar prefix:foo)) = elements second;
		assert: (node elementAtAny: #(absent baz)) = elements last.
]

{ #category : #tests }
XMLNodeTest >> test081firstTagSearching [
	| node elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #(foo bar prefix:foo prefix:bar bar baz).
	node addNodes: (elements first: 2).
	node nodes first addNodes: (elements copyFrom: 3 to: 4).
	node nodes second addNodes: (elements copyFrom: 5 to: 6).

	self
		assert: (node firstTagNamed: #absent) isNil;
		assert: (node firstTagNamed: #foo with: [false]) isNil;
		assert: (node firstTagNamedAny: #(absent)) isNil;
		assert: (node firstTagNamedAny: #(foo) with: [false]) isNil;
		assert: (node firstTagNamed: 'foo') = elements first;
		assert: (node firstTagNamed: #prefix:bar) = elements fourth;
		assert: (node firstTagNamed: #bar with: [:each | each = elements fifth]) = elements fifth;
		assert: (node firstTagNamedAny: #(prefix:foo prefix:bar absent)) = elements third;
		assert: (node firstTagNamedAny: #(bar baz) with: [:each | each = elements last]) = elements last;
		assert: (elements first firstTagNamed: #foo) = elements first;
		assert: (elements first firstTagNamed: 'prefix:foo') = elements third;
		assert: (elements first firstTagNamed: #foo with: [:each | each = elements first]) = elements first;
		assert: (elements first firstTagNamed: #foo with: [:each | each = elements third]) = elements third;
		assert: (elements second firstTagNamedAny: #('bar' baz)) = elements second;
		assert: (elements second firstTagNamedAny: #(bar) with: [:each | each = elements fifth]) = elements fifth.
]

{ #category : #tests }
XMLNodeTest >> test082tagsNamedSearching [
	| node elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #(foo bar prefix:foo bar prefix:bar baz).
	node addNodes: (elements first: 2).
	node nodes first addNodes: (elements copyFrom: 3 to: 4).
	node nodes second addNodes: (elements copyFrom: 5 to: 6).

	self
		should: [:block |node tagsNamed: #absent do: block] enumerate: #();
		should: [:block |node tagsNamed: #absent childrenDo: block] enumerate: #();
		should: [:block |node tagsNamed: #absent childrenDoAndRecurse: block] enumerate: #();
		should: [:block |node tagsNamed: #absent contentsDo: block] enumerate: #();
		should: [:block |node tagsNamed: #foo contentsDo: block] enumerate: #().
	self
		should: [:block |node tagsNamed: #foo do: block]
		enumerate: (Array with: elements first with: elements third).
	self
		should: [:block |node tagsNamed: #prefix:foo do: block]
		enumerate: (Array with: elements third).
	self
		should: [:block | node topElement tagsNamed: #foo childrenDo: block]
		enumerate: (Array with: elements third).
	self
		should: [:block |node tagsNamed: #bar childrenDoAndRecurse: block]
		enumerate: (Array with: elements fourth with: elements second with: elements fifth).

	elements first
		addContent: 'testing 1';
		addNode: XMLNode new;
		addContent: 'testing 2'.
	elements third addContent: 'testing'.
	self
		should: [:block | node tagsNamed: #foo contentsDo: block]
		enumerate: elements first contents, elements third contents.
]

{ #category : #tests }
XMLNodeTest >> test083elementRemoving [
	| node nodes elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #(foo prefix:bar bar baz).
	node addNodes: (self interspersedWithNodes: elements).
	self
		assert: (node removeNode: elements first) = elements first;
		assert: node elements = elements allButFirst;
		assert: (node elementAt: #foo) isNil;
		assert: (node elementsAt: #foo) isEmpty;
		assert: (node removeNode: elements second) = elements second;
		assert: node elements = (elements last: 2);
		assert: (node elementAt: #bar) = elements third;
		assert: (node elementsAt: #bar) = (OrderedCollection with: elements third);
		assert: (node removeNode: elements third) = elements third;
		assert: node elements = (elements last: 1);
		assert: (node elementAt: #bar) isNil;
		assert: (node elementsAt: #bar) isEmpty;
		assert: node topElement = elements last.
]

{ #category : #tests }
XMLNodeTest >> test084elementRenaming [
	| node nodes elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #(foo prefix:bar bar baz).
	node addNodes: (self interspersedWithNodes: elements).

	elements first name: #notfoo.
	self
		deny: (node includesElement: #foo);
		assert: (node elementAt: #foo) isNil;
		assert: (node elementsAt: #foo) isEmpty;
		assert: (node elementAt: #notfoo) = elements first.

	elements third namespace: 'prefix' uri: ''.
	self assert: (node elementsAt: #prefix:bar) = (elements copyFrom: 2 to: 3).

	elements fourth name: #bar.
	self assert: (node elementsAt: #bar) = elements allButFirst.

	elements fourth name: #foo.
	self assert: (node elementAt: #foo) = elements last.
]

{ #category : #tests }
XMLNodeTest >> test090documentTest [
	| doc root |

	doc := XMLDocument new.
	root := XMLElement new.
	self
		assert: doc isDocument;
		assert: doc root isNil;
		assert: (doc addElement: root; root) = root;
		assertDocument: doc dtd: nil version: nil encoding: 'UTF-8' required: nil.

	self
		assertDocument: (doc dtd: '<!DOCTYPE root>')
		dtd: '<!DOCTYPE root>'
		version: nil
		encoding: 'UTF-8'
		required: nil.
	self
		assertDocument: (doc version: '1.0')
		dtd: '<!DOCTYPE root>'
		version: '1.0'
		encoding: 'UTF-8'
		required: nil.
	self
		assertDocument: (doc encoding: 'ISO Latin-1')
		dtd: '<!DOCTYPE root>'
		version: '1.0'
		encoding: 'ISO Latin-1'
		required: nil.
	self
		assertDocument: (doc requiredMarkup: 'root')
		dtd: '<!DOCTYPE root>'
		version: '1.0'
		encoding: 'ISO Latin-1'
		required: 'root'.
]

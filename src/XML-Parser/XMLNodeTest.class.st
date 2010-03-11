Class {
	#name : #XMLNodeTest,
	#superclass : #TestCase,
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
XMLNodeTest >> assertElement: anElement attribute: aString is: aValue [
	self
		assert: (anElement includesAttribute: aString);
		assert: (anElement attributeAt: aString) = aValue;
		assert: (anElement at: aString) = aValue;
		assert: (anElement @ aString) = aValue
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement attributes: aDictionary [
	self assert: anElement attributes = aDictionary
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
		assertElement: anElement attributes: aDictionary;
		assert: anElement contentString = aString
]

{ #category : #assertions }
XMLNodeTest >> assertElement: anElement name: aName localName: aLocalName [
	self
		assert: anElement name = aName;
		assert: anElement tag = aName;
		assert: anElement qualifiedName = aName;
		assert: anElement localName = aLocalName;
		assert: (anElement isNamed: aName);
		assert: (anElement isNamed: aLocalName)
]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode namespace: aNamespace uri: aUri [
	self
		assert: aNode prefix = aNamespace;
		assert: aNode namespaceURI = aUri
]

{ #category : #assertions }
XMLNodeTest >> assertPI: aNode target: aTarget data: aData [
	self
		assert: aNode target = aTarget;
		assert: aNode data = aData;
		assert: aNode printString = ('<?', aTarget, ' ', aData, ' ?>')
]

{ #category : #assertions }
XMLNodeTest >> assertString: aNode is: aString printed: aPrintString [
	self
		assert: aNode string = aString;
		assert: aNode characterData = aString;
		assert: aNode printString = aPrintString
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
XMLNodeTest >> intersperse: aCollection with: aPaddingCollection [
	| mixedCollection nodeStream paddingStream |

	mixedCollection := aCollection species new.
	nodeStream := aCollection readStream.
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
XMLNodeTest >> interspersedWithNodes: aNodeCollection [
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
	^ self
		createNodes: aNameArray size
		with: [
			((qualifiedName := names removeFirst) includes: $:)
				ifTrue: [
					qualifiedName splitQualifiedNameInto: [:prefix :localPart |
						element := XMLElement
							named: qualifiedName
							namespaceURI: 'http://', prefix]]
				ifFalse: [element := XMLElement named: qualifiedName].
				element].
]

{ #category : #accessing }
XMLNodeTest >> newNodes: aNumber [
	^ self createNodes: aNumber with: [XMLNode new]
]

{ #category : #accessing }
XMLNodeTest >> newStrings: aNumber [
	^ self
		createNodes: aNumber
		with: [:i | XMLStringNode string: 'test', i asString]
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
XMLNodeTest >> test010node [
	| node parent testingMessages accessors |

	node := XMLNode new.
	testingMessages := (XMLNode methodsInCategory: 'testing') copyWithout: 'isEmpty'.
	accessors := #(nextNode previousNode parent).
	self
		assert: node isEmpty;
		deny: (testingMessages anySatisfy: [:each | node perform: each]);
		deny: (accessors anySatisfy: [:each | (node perform: each) notNil]).

	parent := XMLNode new.
	node parent: parent.
	self
		assert: node hasParent;
		assert: node parent = parent.
]

{ #category : #tests }
XMLNodeTest >> test020processingInstruction [
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
XMLNodeTest >> test030stringNode [
	| node raw escaped |

	node := XMLStringNode new.
	raw := self markupString.
	escaped := self escapedString.
	self
		assert: node isText & node isTagOrText;
		assertString: node is: '' printed: '';
		assertString: (node string: raw) is: raw printed: escaped;
		assertString: (node addContent: raw) is: raw, raw printed: escaped, escaped.
	self
		assertString: (node addContent: (XMLStringNode string: raw))
		is: raw, raw, raw
		printed: escaped, escaped, escaped.

	self assertString: (XMLStringNode string: raw) is: raw printed: escaped.
	self
		assertString: (XMLStringNode string: (XMLStringNode string: raw))
		is: raw
		printed: escaped.
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
	| node ns uri |

	node := XMLElement new.
	ns := 'foo'.
	uri := 'http://foo'.
	self
		assertNode: node namespace: nil uri: nil;
		assertNode: (node prefix: ns uri: uri) namespace: ns uri: uri.
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
		should: [node addNode: (XMLNode new parent: XMLNode new)] raise: Error;
		should: [node addNode: children first] raise: Error;
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
		assert: node removeNodes = node;
		assert: node isEmpty.
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
		assert: element isTag & element isTagOrText & element isElement;
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
		assertElement: (element name: 'foo') name: 'foo' localName: 'foo';
		assertNode: element namespace: nil uri: nil.

	element prefix: 'bar' uri: 'http://bar'.
	self
		assertElement: element name: 'bar:foo' localName: 'foo';
		assertNode: element namespace: 'bar' uri: 'http://bar'.

	element localName: 'baz'; prefix: 'foo' uri: 'http://foo'.
	self
		assertElement: element name: 'foo:baz' localName: 'baz';
		assertNode: element namespace: 'foo' uri: 'http://foo'.
]

{ #category : #tests }
XMLNodeTest >> test052elementContentString [
	| element str |

	str := self markupString.
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

	element addElement: ((XMLElement named: 'foo') addContent: 'test').
	self assert: (element contentStringAt: 'foo') = 'test'.
]

{ #category : #tests }
XMLNodeTest >> test053elementAttributes [
	| element attrs |

	element := XMLElement new.
	self
		assert: (element at: 'foo') isEmpty;
		assert: (element attributeAt: 'foo') isNil;
		assert: (element at: 'foo' ifAbsent: ['absent']) = 'absent';
		assert: (element attributeAt: 'foo' ifAbsent: ['absent']) = 'absent';
		deny: (element includesAttribute: 'foo').

	self
		assert: (element attributeAt: 'foo' put: 'test') = 'test';
		assert: element hasAttributes;
		assertElement: element attribute: 'foo' is: 'test';
		assert: (element attributeAt: 'bar' put: 'test2') = 'test2';
		assertElement: element attribute: 'bar' is: 'test2';
		assert: (element at: 'baz' put: 'test3') = 'test3';
		assertElement: element attribute: 'baz' is: 'test3';
		assert: element attributeNames asArray =  #('foo' 'bar' 'baz').

	self
		assert: element attributeAssociations asArray =
			(Array with: 'foo'->'test' with: 'bar'->'test2' with: 'baz'->'test3').
	self
		assertElement: element
		attributes:
			(XMLOrderPreservingDictionary
				with: 'foo'->'test'
				with: 'bar'->'test2'
				with: 'baz'->'test3').

	self
		assert: (element removeAttribute: 'foo') = 'test';
		assert: (element removeAttribute: 'bar') = 'test2';
		assert: (element removeAttribute: 'baz') = 'test3';
		deny: element hasAttributes.
]

{ #category : #tests }
XMLNodeTest >> test054elementConstructors [
	| noAttributes attributes str element |

	noAttributes := Dictionary new.
	self
		assertElement: (XMLElement named: 'foo')
		name: 'foo'
		attributes: noAttributes
		contentString: ''.

	attributes := Dictionary with: 'foo'->'test1' with: 'bar'->'test2'.
	self
		assertElement: (XMLElement named: 'foo' attributes: attributes)
		name: 'foo'
		attributes: attributes
		contentString: ''.

	str := self markupString.
	self
		assertElement: (XMLElement named: 'foo')
		name: 'foo'
		attributes: noAttributes
		contentString: ''.
	self
		assertElement: (XMLElement named: 'foo' attributes: attributes)
		name: 'foo'
		attributes: attributes
		contentString: ''.

	element := XMLElement
		named: 'prefix:foo'
		namespaceURI: 'http://foo'
		attributes: attributes.
	self
		assertElement: element name: 'prefix:foo' attributes: attributes contentString: '';
		assertNode: element namespace: 'prefix' uri: 'http://foo'.
]

{ #category : #tests }
XMLNodeTest >> test060addingElements [
	| node elements children |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'bar' 'baz').
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

	element := (XMLElement named: 'foo').
	attributes := XMLOrderPreservingDictionary with: 'b'->'two' with: 'a'->'one'.
	self
		assert: element asString = '<foo></foo>';
		assert: (element contentString: 'test') printString = '<foo>test</foo>';
		assert: (element setAttributes: attributes) printString = '<foo b="two" a="one">test</foo>'
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
	contents := self newStrings: 3.
	elementsAndContents := self intersperse: elements with: contents.
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
	elements := self newElementsNamed: #('foo' 'bar' 'prefix:foo' 'baz').
	node addNodes: (self interspersedWithNodes: elements).
	self
		assert: (node elementAt: 'absent') isNil;
		assert: (node elementAt: 'absent' ifAbsent: ['absent']) = 'absent';
		assert: (node elementsAt: 'absent') isEmpty;
		assert: (node elementsAt: 'absent' ifAbsent: ['absent']) = 'absent';
		assert: (node elementAtAny: #('absent')) isNil;
		assert: (node elementAtAny: #('absent') ifAbsent: ['absent']) = 'absent';
		assert: (node elementAt: 'foo') = elements first;
		assert: (node elementAt: 'bar') = elements second;
		assert: (node elementsAt: 'foo') = ((elements first: 3) copyWithout: elements second);
		assert: (node elementAt: 'prefix:foo') = elements third;
		assert: (node elementsAt: 'prefix:foo') = (OrderedCollection with: elements third);
		assert: (node elementAtAny: #('bar' 'prefix:foo')) = elements second;
		assert: (node elementAtAny: #('absent' 'baz')) = elements last.
]

{ #category : #tests }
XMLNodeTest >> test081firstTagSearching [
	| node elements |

	node := XMLNodeWithElements new.
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
XMLNodeTest >> test082tagsNamedSearching [
	| node elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'bar' 'prefix:foo' 'bar' 'prefix:bar' 'baz').
	node addNodes: (elements first: 2).
	node nodes first addNodes: (elements copyFrom: 3 to: 4).
	node nodes second addNodes: (elements copyFrom: 5 to: 6).
	self
		should: [:block | node tagsNamed: 'absent' do: block] enumerate: #();
		should: [:block | node elementsAt: 'absent' do: block] enumerate: #();
		should: [:block | node tagsNamed: 'absent' childrenDoAndRecurse: block] enumerate: #();
		should: [:block | node tagsNamed: 'absent' contentsDo: block] enumerate: #();
		should: [:block | node tagsNamed: 'foo' contentsDo: block] enumerate: #().

	self
		should: [:block | node tagsNamed: 'foo' do: block]
		enumerate: (Array with: elements first with: elements third).
	self
		should: [:block | node tagsNamed: 'prefix:foo' do: block]
		enumerate: (Array with: elements third).
	self
		should: [:block | node topElement elementsAt: 'foo' do: block]
		enumerate: (Array with: elements third).
	self
		should: [:block | node tagsNamed: 'bar' childrenDoAndRecurse: block]
		enumerate: (Array with: elements fourth with: elements second with: elements fifth).

	elements first
		addContent: 'testing 1';
		addNode: XMLNode new; "Intersperse between string nodes"
		addContent: 'testing 2'.
	elements third addContent: 'testing'.
	self
		should: [:block | node tagsNamed: 'foo' contentsDo: block]
		enumerate: elements first contents, elements third contents.
]

{ #category : #tests }
XMLNodeTest >> test083elementRemoving [
	| node nodes elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'prefix:bar' 'bar' 'baz').
	node addNodes: (self interspersedWithNodes: elements).
	self
		assert: (node removeNode: elements first) = elements first;
		assert: node elements = elements allButFirst;
		assert: (node elementAt: 'foo') isNil;
		assert: (node elementsAt: 'foo') isEmpty;
		assert: (node removeNode: elements second) = elements second;
		assert: node elements = (elements last: 2);
		assert: (node elementAt: 'bar') = elements third;
		assert: (node elementsAt: 'bar') = (OrderedCollection with: elements third);
		assert: (node removeNode: elements third) = elements third;
		assert: node elements = (elements last: 1);
		assert: (node elementAt: 'bar') isNil;
		assert: (node elementsAt: 'bar') isEmpty;
		assert: node topElement = elements last;
		assert: (node removeNode: elements last) = elements last;
		deny: node hasElements;
		assert: node topElement isNil.
]

{ #category : #tests }
XMLNodeTest >> test084elementRenaming [
	| node nodes elements |

	node := XMLNodeWithElements new.
	elements := self newElementsNamed: #('foo' 'prefix:bar' 'bar' 'baz').
	node addNodes: (self interspersedWithNodes: elements).

	elements first name: 'notfoo'.
	self
		deny: (node includesElement: 'foo');
		assert: (node elementAt: 'foo') isNil;
		assert: (node elementsAt: 'foo') isEmpty;
		assert: (node elementAt: 'notfoo') = elements first.

	elements third prefix: 'prefix' uri: ''.
	self assert: (node elementsAt: 'prefix:bar') = (elements copyFrom: 2 to: 3).

	elements fourth name: 'bar'.
	self assert: (node elementsAt: 'bar') = elements allButFirst.

	elements fourth name: 'foo'.
	self assert: (node elementAt: 'foo') = elements last.
]

{ #category : #tests }
XMLNodeTest >> test090documentTest [
	| doc root |

	doc := XMLDocument new.
	root := XMLElement new.
	self
		assert: doc isDocument;
		assert: doc root isNil;
		assert: (doc addElement: root) root = root;
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

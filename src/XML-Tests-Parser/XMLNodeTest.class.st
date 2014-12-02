"
This is a base class for node tests.
"
Class {
	#name : #XMLNodeTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLNodeTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #assertions }
XMLNodeTest >> assertList: aList collects: aSecondList [
	self
		assert: aList = aSecondList;
		assert: aList class == self collectListClass.
]

{ #category : #assertions }
XMLNodeTest >> assertList: aList selects: aSecondList [
	self
		assert: aList = aSecondList;
		assert: aList class == self selectNodeListClass.
]

{ #category : #accessing }
XMLNodeTest >> collectListClass [
	^ XMLOrderedList
]

{ #category : #accessing }
XMLNodeTest >> escapedString [
	^ '&lt;test name="&amp;name;"&gt;''&amp;value;''&lt;/test&gt;'
]

{ #category : #accessing }
XMLNodeTest >> markupString [
	^ '<test name="&name;">''&value;''</test>'
]

{ #category : #'instance creation' }
XMLNodeTest >> newElementWithAttributes [
	| element |

	element :=
		XMLElement
			name: 'test'
			namespaces: (Array with: '' -> 'defaultNS' with: 'prefix' -> 'testNS').
	element attributeNodes
		add: (XMLAttribute name: 'one' value: 'two');
		add: (XMLAttribute name: 'three' value: 'four');
		add: (XMLAttribute name: 'prefix:three' value: 'five');
		add: (XMLAttribute name: 'prefix:six' value: 'seven').
	^ element.
]

{ #category : #accessing }
XMLNodeTest >> nodeClass [
	^ XMLNode
]

{ #category : #accessing }
XMLNodeTest >> selectNodeListClass [
	^ XMLNodeList
]

{ #category : #assertions }
XMLNodeTest >> should: aBlock enumerate: aCollection [
	| enumerated |

	enumerated := OrderedCollection new.
	aBlock value: [:each | enumerated add: each].
	self assert: enumerated = aCollection asOrderedCollection.
]

{ #category : #tests }
XMLNodeTest >> testAddContent [
	self should: [self nodeClass new addContent: 'test'] raise: Error
]

{ #category : #tests }
XMLNodeTest >> testAncestorElements [
	self assert: self nodeClass new ancestorElements isEmpty
]

{ #category : #tests }
XMLNodeTest >> testAncestorElementsDo [
	| node |

	node := self nodeClass new.
	self should: [:block |  node ancestorElementsDo: block] enumerate: #().
]

{ #category : #tests }
XMLNodeTest >> testAncestorNodes [
	self assert: self nodeClass new ancestorNodes isEmpty
]

{ #category : #tests }
XMLNodeTest >> testAncestorNodesDo [
	| node |

	node := self nodeClass new.
	self should: [:block |  node ancestorNodesDo: block] enumerate: #().
]

{ #category : #tests }
XMLNodeTest >> testCanHaveChildren [
	self deny: self nodeClass new canHaveChildren
]

{ #category : #tests }
XMLNodeTest >> testConfiguration [
	self assert: self nodeClass new configuration isNil
]

{ #category : #tests }
XMLNodeTest >> testContentString [
	self assert: self nodeClass new contentString isEmpty
]

{ #category : #tests }
XMLNodeTest >> testCopy [
	| node copy |

	(node := self nodeClass new)
		parent: self nodeClass new.
	copy := node copy.
	self
		deny: copy == node;
		deny: copy hasParent. 
]

{ #category : #tests }
XMLNodeTest >> testDocument [
	self assert: self nodeClass new document isNil
]

{ #category : #tests }
XMLNodeTest >> testHasChildren [
	self deny: self nodeClass new hasChildren
]

{ #category : #tests }
XMLNodeTest >> testHasParent [
	| node |

	node := self nodeClass new.
	self deny: node hasParent.

	node parent: self nodeClass new.
	self assert: node hasParent.
]

{ #category : #tests }
XMLNodeTest >> testIsCData [
	self deny: self nodeClass new isCData
]

{ #category : #tests }
XMLNodeTest >> testIsComment [
	self deny: self nodeClass new isComment
]

{ #category : #tests }
XMLNodeTest >> testIsContentNode [
	self deny: self nodeClass new isContentNode
]

{ #category : #tests }
XMLNodeTest >> testIsDeclaration [
	self deny: self nodeClass new isDeclaration
]

{ #category : #tests }
XMLNodeTest >> testIsDocument [
	self deny: self nodeClass new isDocument
]

{ #category : #tests }
XMLNodeTest >> testIsElement [
	self deny: self nodeClass new isElement
]

{ #category : #tests }
XMLNodeTest >> testIsElementNamed [
	self deny: (self nodeClass new isElementNamed: '')
]

{ #category : #tests }
XMLNodeTest >> testIsElementNamedAny [
	self deny: (self nodeClass new isElementNamedAny: #())
]

{ #category : #tests }
XMLNodeTest >> testIsPI [
	self deny: self nodeClass new isPI
]

{ #category : #tests }
XMLNodeTest >> testIsStringNode [
	self
		deny: self nodeClass new isStringNode;
		deny: (self nodeClass new isStringNode: '').
]

{ #category : #tests }
XMLNodeTest >> testNextNode [
	self assert: self nodeClass new nextNode isNil
]

{ #category : #tests }
XMLNodeTest >> testParent [
	| node parent |

	node := self nodeClass new.
	self assert: node parent isNil.

	parent := self nodeClass new.
	node parent: parent.
	self assert: node parent == parent.
]

{ #category : #tests }
XMLNodeTest >> testPreviousNode [
	self assert: self nodeClass new previousNode isNil
]

{ #category : #tests }
XMLNodeTest >> testRawContentString [
	self assert: self nodeClass new rawContentString isEmpty
]

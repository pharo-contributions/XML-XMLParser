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
		assert: aList class == self selectListClass.
]

{ #category : #accessing }
XMLNodeTest >> attributeAssociations [
	^ Array
		with: 'one' -> '1'
		with: 'two' -> '2'
		with: 'prefix:two' -> '3'
		with: 'prefix:four' -> '4'
]

{ #category : #accessing }
XMLNodeTest >> attributes [
	^ OrderPreservingStringDictionary newFrom: self attributeAssociations
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

{ #category : #accessing }
XMLNodeTest >> namespaceAssociations [
	^ Array
		with: '' -> 'defaultNS'
		with: 'prefix' -> 'prefixNS'
		with: 'prefixTwo' -> 'prefixTwoNS'
]

{ #category : #accessing }
XMLNodeTest >> namespaces [
	^ OrderPreservingStringDictionary newFrom: self namespaceAssociations
]

{ #category : #'instance creation' }
XMLNodeTest >> newElementWithAttributes [
	| element |

	element :=
		XMLElement
			name: 'test'
			namespaces: self namespaceAssociations.
	self attributeAssociations do: [:each |
		element attributeNodes addLast:
			(XMLAttribute
				name: each key
				value: each value)].
	^ element.
]

{ #category : #accessing }
XMLNodeTest >> nodeClass [
	^ XMLNode
]

{ #category : #accessing }
XMLNodeTest >> selectListClass [
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
XMLNodeTest >> testCanonicallyEquals [
	self assert: (self nodeClass new canonicallyEquals: self nodeClass new)
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
XMLNodeTest >> testIsAttribute [
	self deny: self nodeClass new isAttribute
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
XMLNodeTest >> testIsInLanguage [
	self deny: (self nodeClass new isInLanguage: 'test')
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

{ #category : #tests }
XMLNodeTest >> testSortKey [
	self assert: self nodeClass new sortKey = self nodeClass name asString
]

{ #category : #tests }
XMLNodeTest >> testValidate [
	self
		shouldnt: [self nodeClass new validate]
		raise: XMLValidationException
]

{ #category : #accessing }
XMLNodeTest >> unprefixedAttributeAssociations [
	^ self attributeAssociations collect: [:each |
		each key xmlLocalNameAfterPrefix -> each value]
]

{ #category : #accessing }
XMLNodeTest >> unprefixedAttributes [
	^ OrderPreservingStringDictionary newFrom: self unprefixedAttributeAssociations
]

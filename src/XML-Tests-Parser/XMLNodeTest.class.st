"
This is a base class for node tests.
"
Class {
	#name : #XMLNodeTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #'as yet unclassified' }
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

{ #category : #tests }
XMLNodeTest >> assertNode: aNode hasName: aQualifiedName namespaceURI: aUri [
	| prefix localName |

	prefix := aQualifiedName copyUpTo: $:.
	prefix = aQualifiedName
		ifTrue: [
			prefix := ''.
			localName := aQualifiedName]
		ifFalse: [localName := aQualifiedName copyAfter: $:].
	self
		assert: aNode name = aQualifiedName;
		assert: aNode prefix = prefix;
		assert: aNode localName = localName;
		assert: (aNode isNamed: aQualifiedName);
		assert: (aNode isNamed: localName);
		assert: aNode namespaceURI = aUri;
		assert:
			aNode expandedName =
				(aUri
					ifEmpty: [localName]
					ifNotEmpty: ['{', aUri, '}', localName]);
		assert: (prefix ifEmpty: [aNode hasPrefix not] ifNotEmpty: [aNode hasPrefix])


]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode hasPrefix: aPrefix uri: aUri [
	self
		assert: aNode prefix = aPrefix;
		assert: aNode namespaceURI = aUri
]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode hasType: aType [
	self assertNode: aNode hasTypes: (aType ifNotNil: [Array with: aType] ifNil: [#()])
]

{ #category : #assertions }
XMLNodeTest >> assertNode: aNode hasTypes: aTypeArray [
	self deny:
		((#(isCData isComment isContentNode isDocument isElement isPI isStringNode)
			copyWithoutAll: aTypeArray) anySatisfy: [:each | aNode perform: each]).
	self assert: (aTypeArray allSatisfy: [:each | aNode perform: each]).
]

{ #category : #accessing }
XMLNodeTest >> collectListClass [
	^ XMLOrderedList
]

{ #category : #accessing }
XMLNodeTest >> createNodes: aNumber with: aBlock [
	^ ((1 to: aNumber)
		collect: [:i | aBlock valueWithPossibleArgument: i])
			asOrderedCollection
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
		with: (self newStrings: aNodeCollection size)
]

{ #category : #accessing }
XMLNodeTest >> markupString [
	^ '<test name="&name;">''&value;''</test>'
]

{ #category : #accessing }
XMLNodeTest >> newNodes: aNumber [
	^ self createNodes: aNumber with: [self nodeClass new]
]

{ #category : #accessing }
XMLNodeTest >> newStrings: aNumber [
	^ self
		createNodes: aNumber
		with: [:i | XMLString string: 'test', i printString]
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
XMLNodeTest >> testContentString [
	self assert: self nodeClass new contentString isEmpty
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

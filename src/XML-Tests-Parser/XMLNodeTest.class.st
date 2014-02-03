"
This is a base class for node tests.
"
Class {
	#name : #XMLNodeTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-DOM'
}

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
XMLNodeTest >> newNodes: aNumber [
	^ self createNodes: aNumber with: [XMLMockNode new]
]

{ #category : #accessing }
XMLNodeTest >> newStrings: aNumber [
	^ self
		createNodes: aNumber
		with: [:i | XMLString string: 'test', i printString]
]

{ #category : #assertions }
XMLNodeTest >> should: aBlock enumerate: aCollection [
	| enumerated |

	enumerated := OrderedCollection new.
	aBlock value: [:each | enumerated add: each].
	self assert: enumerated = aCollection asOrderedCollection.
]

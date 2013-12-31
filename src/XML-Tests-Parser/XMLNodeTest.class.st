"
This is a base class for node tests.
"
Class {
	#name : #XMLNodeTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #utility }
XMLNodeTest class >> reorderTests [
	self reorderTestsIn: self
]

{ #category : #utility }
XMLNodeTest class >> reorderTests: aSelectorCollection in: aClass [
	"
	This utility method reorders test* messages the receiver (a TestCase subclass) implements.

	Given a collection of selectors in a desired order where each begins with a 'test' or 'test' + integer
	prefix, it will rename each such that they have a new 'test' + integer prefix where the integer
	corresponds to their position in the supplied collection.
	
	If the test messages in the receiver are already in the order you like but are not numbered properly,
	use the form of this message that takes no arguments to renumber them properly.
	"

	| oldSource newSource methodCategory digitsNeeded |

	(aSelectorCollection allSatisfy: [:each | each asString beginsWith: 'test'])
		ifFalse: [self error: 'Will not reorder non-test selector'].
	digitsNeeded := aSelectorCollection size printString size.
	aSelectorCollection doWithIndex: [:oldSelector :i |
		oldSource := (aClass sourceCodeAt: oldSelector) asString readStream.
		newSource := (String new: oldSource size) writeStream.
		methodCategory := aClass whichCategoryIncludesSelector: oldSelector.

		oldSource skip: 'test' size.
		[oldSource peek isDigit]
			whileTrue: [oldSource next].

		newSource
			nextPutAll: 'test';
			nextPutAll: (i printPaddedWith: $0 to: digitsNeeded);
			nextPutAll: oldSource upToEnd.

		aClass
			removeSelector: oldSelector;
			compile: newSource contents classified: methodCategory].
]

{ #category : #utility }
XMLNodeTest class >> reorderTestsIn: aClass [
	self
		reorderTests:
			((self selectors select: [:each | each asString beginsWith: 'test'])
				sortBy: [:a : b | (a asString compare: b asString) < 3]) asArray
		in: aClass
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

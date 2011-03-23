"
This class represents a node that can contain child nodes. You probably will only use its API through one its subclasses, specifically the document, element and doctype declaration node classes.

This class provides message to access, add and remove child nodes under the ""accessing"" category. The nodes themselves are stored in some type of XMLObservableList, the exact type of which varies depending on the subclass and can be accessed directly using #nodes. You can modify the #nodes list directly if you like, but adding nodes to it or removing nodes from it will have the effect of adding them to removing them from the parent node. If this is not what you want, then make sure you copy the return value of #nodes before manipulating it.

The ""enumerating"" category provides two different modes of enumeration: the #nodes* enumerating messages enumerate child nodes of the receiver only, while the #allNode* forms recursively enumerate all descendent nodes, including the receiver itself, using depth-first traversal.

The inner XML of a node with children can be accessed as a string using #innerXML and set using #innerXML:.
"
Class {
	#name : #XMLNodeWithChildren,
	#superclass : #XMLNode,
	#instVars : [
		'nodes'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNodeWithChildren >> addNode: aNode [
	^ self nodes addLast: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNode: aNode after: aPriorNode [
	^ self nodes add: aNode after: aPriorNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNode: aNode before: aSubsequentNode [
	^ self nodes add: aNode before: aSubsequentNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNodeFirst: aNode [
	^ self nodes addFirst: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNodes: aNodeCollection [
	^ self nodes addAll: aNodeCollection
]

{ #category : #notifications }
XMLNodeWithChildren >> addedNode: aNode [
	aNode
		addObserver: self;
		parent: self
]

{ #category : #accessing }
XMLNodeWithChildren >> allNodes [
	^ self allNodesCollect: [:each | each]
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesCollect: aBlock [
	| collectedNodes |

	collectedNodes := self nodes copyEmpty.
	self allNodesDo: [:each | collectedNodes add: (aBlock value: each)].
	^ collectedNodes.
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesDetect: aBlock [
	^ self allNodesDetect: aBlock ifNone: [nil]
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesDetect: aBlock ifNone: anExceptionBlock [
	self allNodesDo: [:each | (aBlock value: each) ifTrue: [^ each]].
	^ anExceptionBlock value.
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesDo: aBlock [
	super allNodesDo: aBlock.

	self hasChildren
		ifTrue: [self nodesDo: [:each | each allNodesDo: aBlock]]
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesSelect: aBlock [
	| selectedNodes |

	selectedNodes := self nodes copyEmpty.
	self allNodesDo: [:each |
		(aBlock value: each)
			ifTrue: [selectedNodes add: each]].
	^ selectedNodes.
]

{ #category : #accessing }
XMLNodeWithChildren >> firstNode [
	^ self nodes ifNotEmpty: [ self nodes first ] ifEmpty: [ nil ]
]

{ #category : #testing }
XMLNodeWithChildren >> hasChildren [
	"Direct variable access avoids possibly unnecessary lazy initialization of the node list"

	^ nodes notNil and: [nodes notEmpty]
]

{ #category : #testing }
XMLNodeWithChildren >> includesNode: aNode [
	^ self nodes includes: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> innerXML [
	| writer |

	writer := XMLWriter new.
	self writeInnerXMLWith: writer.
	^ writer contents.
]

{ #category : #parsing }
XMLNodeWithChildren >> innerXML: aStringOrStream [
	self removeNodes.

	(self innerXMLParserOn: aStringOrStream) parseDocument.
]

{ #category : #private }
XMLNodeWithChildren >> innerXMLParserOn: aStringOrStream [
	^ XMLDOMParser on: aStringOrStream withRootNode: self
]

{ #category : #accessing }
XMLNodeWithChildren >> lastNode [
	^ self nodes ifNotEmpty: [ self nodes last ] ifEmpty: [ nil ]
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeAfter: aNode [
	^ self nodes after: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeBefore: aNode [
	^ self nodes before: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> nodes [
	^ nodes ifNil: [
		(nodes := self nodesClass new)
			addObserver: self;
			yourself]
]

{ #category : #private }
XMLNodeWithChildren >> nodesClass [
	self subclassResponsibility
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesCollect: aBlock [
	^ self nodes collect: aBlock
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesDetect: aBlock [
	^ self nodesDetect: aBlock ifNone: [nil]
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesDetect: aBlock ifNone: anExceptionBlock [
	^ self nodes detect: aBlock ifNone: anExceptionBlock
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesDo: aBlock [
	self nodes do: aBlock
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesSelect: aBlock [
	^ self nodes select: aBlock
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNode: aNode [
	^ self nodes remove: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNodes [
	self nodes removeAll
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNodes: aNodeCollection [
	^ self nodes removeAll: aNodeCollection
]

{ #category : #notifications }
XMLNodeWithChildren >> removedNode: aNode [
	aNode
		removeObserver: self;
		parent: nil.
]

{ #category : #accessing }
XMLNodeWithChildren >> replaceNode: aNode with: aReplacementNode [
	^ self nodes
		at: (self nodes indexOf: aNode)
		put: aReplacementNode
]

{ #category : #accessing }
XMLNodeWithChildren >> topNode [
	self deprecated: 'use #firstNode instead'.

	^ self firstNode.
]

{ #category : #printing }
XMLNodeWithChildren >> writeInnerXMLWith: aWriter [
	self nodesDo: [:each | each writeXMLOn: aWriter]
]

{ #category : #printing }
XMLNodeWithChildren >> writeXMLOn: aWriter [
	self writeInnerXMLWith: aWriter
]

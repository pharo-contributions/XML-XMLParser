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
	#category : #'XML-Parser-DOM'
}

{ #category : #adding }
XMLNodeWithChildren >> addNode: aNode [
	^ self nodes addLast: aNode
]

{ #category : #adding }
XMLNodeWithChildren >> addNode: aNode after: aPriorNode [
	^ self nodes add: aNode after: aPriorNode
]

{ #category : #adding }
XMLNodeWithChildren >> addNode: aNode before: aSubsequentNode [
	^ self nodes add: aNode before: aSubsequentNode
]

{ #category : #adding }
XMLNodeWithChildren >> addNodeFirst: aNode [
	^ self nodes addFirst: aNode
]

{ #category : #adding }
XMLNodeWithChildren >> addNodes: aNodeCollection [
	^ self nodes addAll: aNodeCollection
]

{ #category : #notifications }
XMLNodeWithChildren >> addedNode: aNode [
	aNode parent: self
]

{ #category : #notifications }
XMLNodeWithChildren >> addingNode: aNode [
	aNode hasParent
		ifTrue: [self errorAddingNodeWithParent]
]

{ #category : #accessing }
XMLNodeWithChildren >> allNodes [
	| allNodes |

	allNodes := self newNodeListForSelect.
	self allNodesDo: [:each | allNodes addLast: each].
	^ allNodes.
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesCollect: aBlock [
	| collectedObjects |

	collectedObjects := self newListForCollect.
	self allNodesDo: [:each | collectedObjects addLast: (aBlock value: each)].
	^ collectedObjects.
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesDetect: aBlock [
	^ self allNodesDetect: aBlock ifNone: [nil]
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesDetect: aBlock ifNone: anExceptionBlock [
	self allNodesDo: [:each |
		(aBlock value: each)
			ifTrue: [^ each]].
	^ anExceptionBlock value.
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesDo: aBlock [
	aBlock value: self.
	self hasChildren
		ifTrue: [self nodesDo: [:each | each allNodesDo: aBlock]]
]

{ #category : #enumerating }
XMLNodeWithChildren >> allNodesSelect: aBlock [
	| selectedNodes |

	selectedNodes := self newNodeListForSelect.
	self allNodesDo: [:each |
		(aBlock value: each)
			ifTrue: [selectedNodes addLast: each]].
	^ selectedNodes.
]

{ #category : #accessing }
XMLNodeWithChildren >> descendentNodes [
	| descendentNodes |

	descendentNodes := self newNodeListForSelect.
	self descendentNodesDo: [:each | descendentNodes addLast: each].
	^ descendentNodes.
]

{ #category : #enumerating }
XMLNodeWithChildren >> descendentNodesCollect: aBlock [
	| collectedObjects |

	collectedObjects := self newListForCollect.
	self descendentNodesDo: [:each | collectedObjects addLast: (aBlock value: each)].
	^ collectedObjects.
]

{ #category : #enumerating }
XMLNodeWithChildren >> descendentNodesDetect: aBlock [
	^ self descendentNodesDetect: aBlock ifNone: [nil]
]

{ #category : #enumerating }
XMLNodeWithChildren >> descendentNodesDetect: aBlock ifNone: anExceptionBlock [
	self descendentNodesDo: [:each |
		(aBlock value: each)
			ifTrue: [^ each]].
	^ anExceptionBlock value.
]

{ #category : #enumerating }
XMLNodeWithChildren >> descendentNodesDo: aBlock [
	self hasChildren
		ifTrue: [self nodesDo: [:each | each allNodesDo: aBlock]]
]

{ #category : #enumerating }
XMLNodeWithChildren >> descendentNodesSelect: aBlock [
	| selectedNodes |

	selectedNodes := self newNodeListForSelect.
	self descendentNodesDo: [:each |
		(aBlock value: each)
			ifTrue: [selectedNodes addLast: each]].
	^ selectedNodes.
]

{ #category : #private }
XMLNodeWithChildren >> errorAddingNodeWithParent [
	XMLDOMException signal: 'Cannot add child node that already has a parent'
]

{ #category : #accessing }
XMLNodeWithChildren >> firstNode [
	"returns nil when empty"
	^ self nodes first
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
	self hasChildren
		ifFalse: [^ ''].
	self
		withNewXMLWriterOn: (String new: self nodes size * 10) writeStream
		do: [ :writer |
			self writeInnerXMLOn: writer.
			^ writer contents].
]

{ #category : #accessing }
XMLNodeWithChildren >> lastNode [
	"returns nil when empty"
	^ self nodes last
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeAfter: aNode [
	^ self nodes after: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeBefore: aNode [
	^ self nodes before: aNode
]

{ #category : #private }
XMLNodeWithChildren >> nodeListClass [
	^ XMLNodeList
]

{ #category : #accessing }
XMLNodeWithChildren >> nodes [
	^ nodes ifNil: [nodes := self nodeListClass observer: self]
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesCollect: aBlock [
	^ self nodes collect: aBlock
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesDetect: aBlock [
	^ self nodes detect: aBlock
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

{ #category : #private }
XMLNodeWithChildren >> parserHandlerClass [
	^ XMLDOMParser
]

{ #category : #copying }
XMLNodeWithChildren >> postCopy [
	super postCopy.

	nodes
		ifNotNil: [nodes := nodes deepCopyWithObserver: self].
]

{ #category : #removing }
XMLNodeWithChildren >> removeNode: aNode [
	^ self nodes remove: aNode
]

{ #category : #removing }
XMLNodeWithChildren >> removeNodes [
	self nodes removeAll
]

{ #category : #removing }
XMLNodeWithChildren >> removeNodes: aNodeCollection [
	^ self nodes removeAll: aNodeCollection
]

{ #category : #notifications }
XMLNodeWithChildren >> removedNode: aNode [
	aNode parent: nil
]

{ #category : #accessing }
XMLNodeWithChildren >> replaceNode: aNode with: aReplacementNode [
	^ self nodes
		at: (self nodes indexOf: aNode)
		put: aReplacementNode
]

{ #category : #printing }
XMLNodeWithChildren >> writeInnerXMLOn: aWriter [
	self nodesDo: [:each | each writeXMLOn: aWriter]
]

{ #category : #printing }
XMLNodeWithChildren >> writeXMLOn: aWriter [
	self writeInnerXMLOn: aWriter
]

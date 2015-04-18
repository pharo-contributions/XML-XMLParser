"
This class represents a node that can contain child nodes. You probably will only use its API through one its subclasses, specifically the document, element and doctype declaration node classes.

This class provides message to access, add and remove child nodes under the ""accessing"" category. The nodes themselves are stored in some type of XMLObservableList, the exact type of which varies depending on the subclass and can be accessed directly using #nodes. You can modify the #nodes list directly if you like, but adding nodes to it or removing nodes from it will have the effect of adding them to removing them from the parent node. If this is not what you want, then make sure you copy the return value of #nodes before manipulating it.

The ""enumerating"" category provides three different modes of enumeration: the #nodes* enumerating messages enumerate child nodes of the receiver only, while the #allNode* forms recursively enumerate all descendent nodes, including the receiver itself, using depth-first traversal, while the #descendentNode* forms  enumerate only descendent nodes and not the receiver.
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

{ #category : #notifying }
XMLNodeWithChildren >> addedNode: aNode [
	aNode parent: self
]

{ #category : #notifying }
XMLNodeWithChildren >> addingNode: aNode [
	aNode hasParent
		ifTrue: [self errorAddingNodeWithParent]
]

{ #category : #accessing }
XMLNodeWithChildren >> allNodes [
	| allNodes |

	allNodes := self newListForSelect.
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

	selectedNodes := self newListForSelect.
	self allNodesDo: [:each |
		(aBlock value: each)
			ifTrue: [selectedNodes addLast: each]].
	^ selectedNodes.
]

{ #category : #testing }
XMLNodeWithChildren >> canHaveChildren [
	^ true
]

{ #category : #accessing }
XMLNodeWithChildren >> descendentNodes [
	| descendentNodes |

	descendentNodes := self newListForSelect.
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

	selectedNodes := self newListForSelect.
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

	^ nodes notNil and: [nodes size > 0]
]

{ #category : #testing }
XMLNodeWithChildren >> includesNode: aNode [
	^ self nodes includes: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> innerXML [
	"returns descendent nodes as XML string"
	self hasChildren
		ifTrue: [
			^ self
				withNewXMLWriterOn: (String new: self nodes size * 10) writeStream
				do: [:writer |
					self writeInnerXMLOn: writer.
					writer contents]]
		ifFalse: [^ '']
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
XMLNodeWithChildren >> nodeAt: anIndex [
	"returns nil if absent"
	^ self nodes at: anIndex
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeAt: anIndex ifAbsent: aBlock [
	^ self nodes at: anIndex ifAbsent: aBlock
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeAt: anIndex put: aNode [
	^ self nodes at: anIndex put: aNode
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
	"returns the internal node list; safe to modify, but adding/removing will
	have the affect of adding/removing from the receiver"
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
XMLNodeWithChildren >> removeNode: aNode ifAbsent: aBlock [
	^ self nodes remove: aNode ifAbsent: aBlock
]

{ #category : #removing }
XMLNodeWithChildren >> removeNodes [
	self nodes removeAll
]

{ #category : #removing }
XMLNodeWithChildren >> removeNodes: aNodeCollection [
	^ self nodes removeAll: aNodeCollection
]

{ #category : #notifying }
XMLNodeWithChildren >> removedNode: aNode [
	aNode parent: nil
]

{ #category : #accessing }
XMLNodeWithChildren >> replaceNode: aNode with: aReplacementNode [
	"replace node in the receiver with another node.
	if the second node is also in the receiver, their
	positions are just swapped"
	| firstIndex secondIndex |

	firstIndex := self nodes indexOf: aNode.
	(secondIndex := self nodes indexOf: aReplacementNode) > 0
		ifTrue: [self nodes swap: firstIndex with: secondIndex]
		ifFalse: [self nodes at: firstIndex put: aReplacementNode].
	^ aReplacementNode.
]

{ #category : #printing }
XMLNodeWithChildren >> writeInnerXMLOn: aWriter [
	self nodesDo: [:each | each writeXMLOn: aWriter]
]

{ #category : #printing }
XMLNodeWithChildren >> writeXMLOn: aWriter [
	self writeInnerXMLOn: aWriter
]

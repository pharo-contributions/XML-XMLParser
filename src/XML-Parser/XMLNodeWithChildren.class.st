"
This class represents a node that can contain child nodes. It provides message that allow you to add, remove, access, and enumerate child nodes. The nodes themselves are stored in some type of XMLObservableList, the exact type of which varies depending on the subclass, and can be accessed directly by sending #nodes.
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
XMLNodeWithChildren >> firstNode [
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
XMLNodeWithChildren >> lastNode [
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
XMLNodeWithChildren >> nodesDo: aBlock [
	self nodes do: aBlock
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
		at: [self nodes indexOf: aNode]
		put: aReplacementNode
]

{ #category : #accessing }
XMLNodeWithChildren >> topNode [
	self deprecated: 'use #firstNode instead'.

	^ self firstNode.
]

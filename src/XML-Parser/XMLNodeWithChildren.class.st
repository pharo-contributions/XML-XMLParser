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
	^ self with: [self nodes add: aNode] add: aNode.
]

{ #category : #accessing }
XMLNodeWithChildren >> addNode: aNode after: afterNode [
	^ self with: [self nodes add: aNode after: afterNode] add: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNode: aNode before: beforeNode [
	^ self with: [self nodes add: aNode before: beforeNode] add: aNode.
]

{ #category : #accessing }
XMLNodeWithChildren >> addNodeFirst: aNode [
	^ self isEmpty
		ifTrue: [self addNode: aNode]
		ifFalse: [self addNode: aNode before: self topNode]
]

{ #category : #accessing }
XMLNodeWithChildren >> addNodes: aNodeCollection [
	aNodeCollection do: [:each | self addNode: each].
	^ aNodeCollection.
]

{ #category : #private }
XMLNodeWithChildren >> changedChildNode: aNode [
]

{ #category : #testing }
XMLNodeWithChildren >> includesNode: aNode [
	^ self nodes includes: aNode
]

{ #category : #testing }
XMLNodeWithChildren >> isEmpty [
	^ self nodes isEmpty
]

{ #category : #accessing }
XMLNodeWithChildren >> lastNode [
	^ self nodes at: self nodes size ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeAfter: aNode [
	^ self nodes after: aNode ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithChildren >> nodeBefore: aNode [
	^ self nodes before: aNode ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithChildren >> nodes [
	^ nodes ifNil: [nodes := OrderedCollection new]
]

{ #category : #enumerating }
XMLNodeWithChildren >> nodesDo: aBlock [
	self nodes do: aBlock
]

{ #category : #printing }
XMLNodeWithChildren >> printXMLOn: writer [
	self nodesDo: [:each | each printXMLOn: writer].
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNode: aNode [
	^ self with: [self nodes remove: aNode] remove: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNodes [
	^ self removeNodes: self nodes copy
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNodes: aNodeCollection [
	aNodeCollection do: [:each | self removeNode: each].
	^ aNodeCollection.
]

{ #category : #accessing }
XMLNodeWithChildren >> topNode [
	^ self nodes at: 1 ifAbsent: [nil]
]

{ #category : #private }
XMLNodeWithChildren >> with: aBlock add: aNode [
	"This is an execute-around method that takes a block purporting to add aNode
	to #nodes. It evaluates the block, establishes a parent-child relationship.
	
	Methods adding anything to #nodes should be implemented around this
	message."

	aNode hasParent
		ifTrue: [self error: 'attempt to add node with parent'. ^ nil].

	self with: aBlock onError: [^ nil].
	aNode parent: self.
	^ aNode.
]

{ #category : #private }
XMLNodeWithChildren >> with: aBlock onError: errorBlock [
	^ aBlock
		on: Error
		do: [:error | error signal. errorBlock valueWithPossibleArgument: error]
]

{ #category : #private }
XMLNodeWithChildren >> with: aBlock remove: aNode [
	"This is an execute-around method that takes a block purporting to remove
	aNode from #nodes, evaluates it, breaks the parent-child relationship.
	
	Methods that remove anything from #nodes should be implemented around this
	message."

	self with: aBlock onError: [^ nil].
	aNode parent: nil.
	^ aNode.
]

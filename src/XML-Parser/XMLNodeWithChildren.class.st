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
XMLNodeWithChildren >> addNode: aNode after: afterNode [
	^ self nodes add: aNode after: afterNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNode: aNode before: beforeNode [
	^ self nodes add: aNode before: beforeNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNodeFirst: aNode [
	^ self nodes addFirst: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> addNodes: aNodeCollection [
	aNodeCollection do: [:each | self addNode: each].
	^ aNodeCollection.
]

{ #category : #private }
XMLNodeWithChildren >> addedNode: aNode toList: aCollection [

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
	^ nodes ifNil: [nodes := XMLNodeList parent: self]
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
	^ self nodes remove: aNode
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNodes [
	self nodes removeAll
]

{ #category : #accessing }
XMLNodeWithChildren >> removeNodes: aNodeCollection [
	aNodeCollection do: [:each | self removeNode: each].
	^ aNodeCollection.
]

{ #category : #private }
XMLNodeWithChildren >> removedNode: aNode fromList: aCollection [

]

{ #category : #private }
XMLNodeWithChildren >> renamedChildNode: aNode [
]

{ #category : #accessing }
XMLNodeWithChildren >> topNode [
	^ self nodes at: 1 ifAbsent: [nil]
]

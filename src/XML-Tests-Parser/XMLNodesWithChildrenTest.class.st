Class {
	#name : #XMLNodesWithChildrenTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-Nodes'
}

{ #category : #assertions }
XMLNodesWithChildrenTest >> assertNode: aNode hasChildren: aNodeCollection [
	self assert: aNode nodes asArray = aNodeCollection asArray
]

{ #category : #assertions }
XMLNodesWithChildrenTest >> assertNodeHasNoChildren: aNode [
	self
		deny: aNode hasChildren;
		assert: aNode nodes isEmpty;
		assert: aNode firstNode isNil;
		assert: aNode lastNode isNil
]

{ #category : #assertions }
XMLNodesWithChildrenTest >> should: aBlock addNode: aNode to: aParent [
	self should: aBlock addNodes: (Array with: aNode) to: aParent
]

{ #category : #assertions }
XMLNodesWithChildrenTest >> should: aBlock addNodes: aNodeCollection to: aParent [
	| nodesAdded |

	self deny: (aNodeCollection anySatisfy: [:each | aParent includesNode: each]).
	(nodesAdded := aBlock value) isCollection
		ifFalse: [nodesAdded := Array with: nodesAdded].
	self
		assert: nodesAdded asArray = aNodeCollection asArray;
		assert:
			(nodesAdded allSatisfy: [:each |
				(aParent includesNode: each) and: [each parent == aParent]])
]

{ #category : #assertions }
XMLNodesWithChildrenTest >> should: aBlock removeNode: aNode from: aParent [
	self should: aBlock removeNodes: (Array with: aNode) from: aParent
]

{ #category : #assertions }
XMLNodesWithChildrenTest >> should: aBlock removeNodes: aNodeCollection from: aParent [
	| nodesRemoved |

	self assert: (aNodeCollection allSatisfy: [:each | aParent includesNode: each]).
	(nodesRemoved := aBlock value) isCollection
		ifFalse: [nodesRemoved := Array with: nodesRemoved].

	self
		assert: nodesRemoved asArray = aNodeCollection asArray;
		deny: (nodesRemoved anySatisfy: [:each | aParent includesNode: each])
]

{ #category : #tests }
XMLNodesWithChildrenTest >> test1emptyNodeWithChildren [
	self assertNodeHasNoChildren: XMLMockNodeWithChildren new
]

{ #category : #tests }
XMLNodesWithChildrenTest >> test2addingNodes [
	| node children |

	node := XMLMockNodeWithChildren new.
	children := self newNodes: 6.
	self
		should: [node addNode: children second] addNode: children second to: node;
		should: [node addNodeFirst: children first] addNode: children first to: node.
	self
		should: [node addNodes: (children copyFrom: 3 to: 4)]
		addNodes: (children copyFrom: 3 to: 4)
		to: node.
	self
		should: [node addNode: children sixth after: children fourth]
		addNode: children sixth
		to: node.
	self
		should: [node addNode: children fifth before: children sixth]
		addNode: children fifth
		to: node.
	self assertNode: node hasChildren: children.

	self
		should: [node addNode: (XMLMockNode new parent: XMLMockNode new)] raise: Error;
		should: [node addNode: children first] raise: Error.
]

{ #category : #tests }
XMLNodesWithChildrenTest >> test3removingNodes [
	| node children |

	node := XMLMockNodeWithElements new.
	children := self newNodes: 5.
	node addNodes: children.
	self
		should: [node removeNode: children first]
		removeNode: children first
		from: node.
	self
		should: [node removeNodes: (children copyFrom: 2 to: 3)]
		removeNodes: (children copyFrom: 2 to: 3)
		from: node.
	self assert: node removeNodes == node.

	self assertNodeHasNoChildren: node.
]

{ #category : #tests }
XMLNodesWithChildrenTest >> test4accessingAdjacentNodes [
	| node children |

	node := XMLMockNodeWithElements new.
	children := self newNodes: 5.
	node addNodes: children.
	children do: [:each | | next previous |
		next := children after: each ifAbsent: [nil].
		previous := children before: each ifAbsent: [nil].
		
		self
			assert: each nextNode == next;
			assert: each previousNode == previous;
			assert: (node nodeAfter: each) == next;
			assert: (node nodeBefore: each) == previous].

	self
		assert: (node nodeAfter: XMLNode new) isNil;
		assert: (node nodeBefore: XMLNode new) isNil.
]

{ #category : #tests }
XMLNodesWithChildrenTest >> test5accessingFirstAndLastNodes [
	| node children |

	node := XMLMockNodeWithElements new.
	self
		assert: node firstNode isNil;
		assert: node lastNode isNil.

	children := self newNodes: 3.
	node addNode: children first.
	self
		assert: node firstNode == children first;
		assert: node lastNode == children first.

	node addNodes: children allButFirst.
	self
		assert: node firstNode == children first;
		assert: node lastNode == children last.

	node removeNode: children first.
	self
		assert: node firstNode == children second;
		assert: node lastNode == children last.
]

{ #category : #tests }
XMLNodesWithChildrenTest >> test6replacingNodes [
	| node children newChildren |

	node := XMLMockNodeWithChildren new.
	children := self newNodes: 3.
	newChildren := self newNodes: 3.
	node addNodes: children.
	self
		should: [node replaceNode: children first with: newChildren first]
		addNode: newChildren first
		to: node.
	self
		should: [node replaceNode: children second with: newChildren second]
		addNode: newChildren second
		to: node.
	self
		should: [node replaceNode: children third with: newChildren third]
		addNode: newChildren third
		to: node.

	self assert: node nodes asOrderedCollection = newChildren asOrderedCollection.
]

{ #category : #tests }
XMLNodesWithChildrenTest >> test7childNodeEnumeration [
	| node nodes |

	node := XMLMockNodeWithElements new.
	self should: [:block | node nodesDo: block] enumerate: #().

	nodes := self newNodes: 5.
	node addNodes: nodes.
	self should: [:block | node nodesDo: block] enumerate: nodes.
]

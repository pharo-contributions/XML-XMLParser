"
Abstract, do not run.
"
Class {
	#name : #XMLNodeWithChildrenTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLNodeWithChildrenTest class >> isAbstract [
	^ true
]

{ #category : #assertions }
XMLNodeWithChildrenTest >> assertNode: aNode hasChildren: aNodeCollection [
	self assert: aNode nodes asArray = aNodeCollection asArray
]

{ #category : #assertions }
XMLNodeWithChildrenTest >> assertNodeHasNoChildren: aNode [
	self
		deny: aNode hasChildren;
		assert: aNode nodes isEmpty;
		assert: aNode firstNode isNil;
		assert: aNode lastNode isNil
]

{ #category : #accessing }
XMLNodeWithChildrenTest >> newNodeWithNodes [
	^ self nodeClass new
		addNode: (XMLComment string: 'one');
		addNode: (XMLPI target: 'two' data: 'three');
		addNode: (XMLComment string: 'four');
		addNode: (XMLPI target: 'five' data: 'six');
		yourself
]

{ #category : #accessing }
XMLNodeWithChildrenTest >> nodeClass [
	^ XMLNodeWithChildren
]

{ #category : #assertions }
XMLNodeWithChildrenTest >> should: aBlock addNode: aNode to: aParent [
	self should: aBlock addNodes: (Array with: aNode) to: aParent
]

{ #category : #assertions }
XMLNodeWithChildrenTest >> should: aBlock addNodes: aNodeCollection to: aParent [
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
XMLNodeWithChildrenTest >> should: aBlock removeNode: aNode from: aParent [
	self should: aBlock removeNodes: (Array with: aNode) from: aParent
]

{ #category : #assertions }
XMLNodeWithChildrenTest >> should: aBlock removeNodes: aNodeCollection from: aParent [
	| nodesRemoved |

	self assert: (aNodeCollection allSatisfy: [:each | aParent includesNode: each]).
	(nodesRemoved := aBlock value) isCollection
		ifFalse: [nodesRemoved := Array with: nodesRemoved].

	self
		assert: nodesRemoved asArray = aNodeCollection asArray;
		deny: (nodesRemoved anySatisfy: [:each | aParent includesNode: each])
]

{ #category : #tests }
XMLNodeWithChildrenTest >> test1emptyNodeWithChildren [
	self assertNodeHasNoChildren: self nodeClass new
]

{ #category : #tests }
XMLNodeWithChildrenTest >> test2addingNodes [
	| node children |

	node := self nodeClass new.
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
		should: [node addNode: (self nodeClass new parent: self nodeClass new)] raise: Error;
		should: [node addNode: children first] raise: Error.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> test3removingNodes [
	| node children |

	node := self nodeClass new.
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
XMLNodeWithChildrenTest >> test4accessingAdjacentNodes [
	| node children |
	node := self nodeClass new.
	children := self newNodes: 5.
	node addNodes: children.
	children
		do: [ :each | 
			| next previous |
			next := children after: each ifAbsent: [ nil ].
			previous := children before: each ifAbsent: [ nil ].
			self
				assert: each nextNode == next;
				assert: each previousNode == previous;
				assert: (node nodeAfter: each) == next;
				assert: (node nodeBefore: each) == previous ].
	self
		assert: (node nodeAfter: XMLNode new) isNil;
		assert: (node nodeBefore: XMLNode new) isNil
]

{ #category : #tests }
XMLNodeWithChildrenTest >> test5accessingFirstAndLastNodes [
	| node children |

	node := self nodeClass new.
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
XMLNodeWithChildrenTest >> test6replacingNodes [
	| node children newChildren |

	node := self nodeClass new.
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
XMLNodeWithChildrenTest >> test7childNodeEnumeration [
	| node nodes |

	node := self nodeClass new..
	self should: [:block | node nodesDo: block] enumerate: #().

	nodes := self newNodes: 5.
	node addNodes: nodes.
	self should: [:block | node nodesDo: block] enumerate: nodes.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodes [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		assert: allNodes size = 5;
		assert: allNodes first == nodeWithNodes;
		assert: allNodes second isComment;
		assert: allNodes second string = 'one';
		assert: allNodes third isPI;
		assert: allNodes third target = 'two';
		assert: allNodes third data = 'three';
		assert: allNodes fourth isComment;
		assert: allNodes fourth string = 'four';
		assert: allNodes fifth isPI;
		assert: allNodes fifth target = 'five';
		assert: allNodes fifth data = 'six'.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesCollect [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		assertList: (nodeWithNodes allNodesCollect: [:each | each identityHash])
		collects: (allNodes collect: [:each | each identityHash]).

	allNodes do: [:node |
		(node respondsTo: #allNodesCollect:)
			ifTrue: [
				self
					assertList: (node allNodesCollect: [:each | each identityHash])
					collects: (node allNodes collect: [:each | each identityHash])]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesDetect [
	| nodeWithNodes allNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	detectedNode := nodeWithNodes allNodesDetect: [:each | each isPI].
	self
		assert: detectedNode notNil;
		assert: detectedNode isPI;
		assert: detectedNode == (allNodes detect: [:each | each isPI]);
		assert: (nodeWithNodes allNodesDetect: [:each | each isDeclaration]) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesDetectIfNone [
	| nodeWithNodes allNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	detectedNode :=
		nodeWithNodes
			allNodesDetect: [:each | each isPI]
			ifNone: [#absent].
	self
		deny: detectedNode = #absent;
		assert: detectedNode isPI;
		assert: detectedNode == (allNodes detect: [:each | each isPI] ifNone: [#absent]);
		assert:
			(nodeWithNodes
				allNodesDetect: [:each | each isDeclaration]
				ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesDo [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		should: [:block | nodeWithNodes allNodesDo: block]
		enumerate: allNodes.

	allNodes do: [:node |
		node isElement
			ifTrue: [
				self
					should: [:block | node allNodesDo: block]
					enumerate: node allNodes]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesSelect [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		assertList: (nodeWithNodes allNodesSelect: [:each | each isComment])
		selects: (allNodes select: [:each | each isComment]).

	allNodes do: [:node |
		(node respondsTo: #allNodesSelect:)
			ifTrue: [
				self
					assertList: (node allNodesSelect: [:each | each isComment])
					selects: (node allNodes select: [:each | each isComment])]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodes [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		assertList: descendentNodes
		selects: nodeWithNodes allNodes allButFirst.

	descendentNodes do: [:node |
		node isElement
			ifTrue: [
				self
					assertList: node descendentNodes
					selects: node allNodes allButFirst]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesCollect [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		assertList: (nodeWithNodes descendentNodesCollect: [:each | each identityHash])
		collects: (descendentNodes collect: [:each | each identityHash]).

	descendentNodes do: [:node |
		(node respondsTo: #descendentNodesCollect:)
			ifTrue: [
				self
					assertList: (node descendentNodesCollect: [:each | each identityHash])
					collects: (node descendentNodes collect: [:each | each identityHash])]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesDetect [
	| nodeWithNodes descendentNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	detectedNode := nodeWithNodes descendentNodesDetect: [:each | each isPI].
	self
		assert: detectedNode notNil;
		assert: detectedNode isPI;
		assert: detectedNode == (descendentNodes detect: [:each | each isPI]);
		assert: (nodeWithNodes descendentNodesDetect: [:each | each isDeclaration]) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesDetectIfNone [
	| nodeWithNodes descendentNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	detectedNode :=
		nodeWithNodes
			descendentNodesDetect: [:each | each isPI]
			ifNone: [#absent].
	self
		deny: detectedNode = #absent;
		assert: detectedNode isPI;
		assert: detectedNode == (descendentNodes detect: [:each | each isPI] ifNone: [#absent]);
		assert:
			(nodeWithNodes
				descendentNodesDetect: [:each | each isDeclaration]
				ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesDo [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		should: [:block | nodeWithNodes descendentNodesDo: block]
		enumerate: descendentNodes.

	descendentNodes do: [:node |
		node isElement
			ifTrue: [
				self
					should: [:block | node descendentNodesDo: block]
					enumerate: node descendentNodes]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesSelect [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		assertList: (nodeWithNodes descendentNodesSelect: [:each | each isComment])
		selects: (descendentNodes select: [:each | each isComment]).

	descendentNodes do: [:node |
		(node respondsTo: #descendentNodesSelect:)
			ifTrue: [
				self
					assertList: (node descendentNodesSelect: [:each | each isComment])
					selects: (node descendentNodes select: [:each | each isComment])]].
]

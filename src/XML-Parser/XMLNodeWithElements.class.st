"
This class represents a node with child nodes. You will likely use its API through either XMLDocument or XMLElement.

To retrieve child elements by name, you can send any of the #element- messages under ""accessing."" To search a node and its descendants using depth-first traversal, you can send any of the #firstTag: or #tagsNamed: messages under ""searching.""
"
Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNode,
	#instVars : [
		'nodes',
		'elements',
		'elementsByName',
		'uri',
		'namespace'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: anElement [
	self addNode: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> addNode: aNode [
	^ self with: [self nodes add: aNode] add: aNode.
]

{ #category : #accessing }
XMLNodeWithElements >> addNode: aNode after: afterNode [
	^ self with: [self nodes add: aNode after: afterNode] add: aNode
]

{ #category : #accessing }
XMLNodeWithElements >> addNode: aNode before: beforeNode [
	^ self with: [self nodes add: aNode before: beforeNode] add: aNode.
]

{ #category : #accessing }
XMLNodeWithElements >> addNodeFirst: aNode [
	^ self isEmpty
		ifTrue: [self addNode: aNode]
		ifFalse: [self addNode: aNode before: self topNode]
]

{ #category : #accessing }
XMLNodeWithElements >> addNodes: aNodeCollection [
	aNodeCollection do: [:each | self addNode: each].
	^ aNodeCollection.
]

{ #category : #private }
XMLNodeWithElements >> changedChildElement: anElement [
	self rebuildElementCache
]

{ #category : #accessing }
XMLNodeWithElements >> elementAfter: anElement [
	^ self elements after: anElement ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aSymbol [
	^ self elementAt: aSymbol ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aSymbol ifAbsent: aBlock [
	^ (self elementsAt: aSymbol ifAbsent: [^ aBlock value]) first
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aSymbolArray [
	^ self elementAtAny: aSymbolArray ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aSymbolArray ifAbsent: aBlock [
	| answer |

	aSymbolArray do: [:each | (answer := self elementAt: each) ifNotNil: [^ answer]].
	^ aBlock value.
]

{ #category : #accessing }
XMLNodeWithElements >> elementBefore: anElement [
	^ self elements before: anElement ifAbsent: [nil]
]

{ #category : #private }
XMLNodeWithElements >> elementCacheAdd: anElement [
	self elements add: anElement.

	self elementCacheAt: anElement localName add: anElement.
	anElement hasPrefix
		ifTrue: [self elementCacheAt: anElement tag add: anElement].
]

{ #category : #private }
XMLNodeWithElements >> elementCacheAt: aSymbol add: anElement [
	(self elementsByName
		at: aSymbol asSymbol
		ifAbsentPut: [self newElements]) add: anElement
]

{ #category : #private }
XMLNodeWithElements >> elementCacheAt: aSymbol remove: anElement [
	self
		remove: anElement
		from: (self elementsAt: aSymbol ifAbsent: [^ self]).

	(self elementsAt: aSymbol)
		ifEmpty: [self elementsByName removeKey: aSymbol].
]

{ #category : #private }
XMLNodeWithElements >> elementCacheRemove: anElement [
	self remove: anElement from: self elements.

	self elementCacheAt: anElement localName remove: anElement.
	anElement hasPrefix
		ifTrue: [self elementCacheAt: anElement tag remove: anElement].
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: aSymbol [
	self deprecated: 'use #elementAt: with an unqualified name instead'.

	^ self elementAt: aSymbol.
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: aSymbol ifAbsent: aBlock [
	self deprecated: 'use #elementAt:ifAbsent: with an unqualified name instead'.

	^ self elementAt: aSymbol ifAbsent: aBlock.
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	^ elements ifNil: [elements := self newElements]
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aSymbol [
	^ self elementsAt: aSymbol ifAbsent: [self newElements]
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aSymbol ifAbsent: aBlock [
	^ self elementsByName at: aSymbol asSymbol ifAbsent: aBlock.
]

{ #category : #private }
XMLNodeWithElements >> elementsByName [ 
	^ elementsByName ifNil: [elementsByName := IdentityDictionary new].
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self elements do: aBlock
]

{ #category : #comparing }
XMLNodeWithElements >> equalTo: aNodeWithElements [
	^ (aNodeWithElements respondsTo: #asString)
		and: [self asString = aNodeWithElements asString]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aSymbol [ 
	"Return the first encountered node with the specified tag. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamed: aSymbol]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aSymbol with: aBlock [
	"Return the first encountered node with the specified tag that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamed: aSymbol) and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aSymbolArray [
	"Return the first encountered node with any of the specified tag names. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamedAny: aSymbolArray]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aSymbolArray with: aBlock [
	"Return the first encountered node with any of the specified tag names that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamedAny: aSymbolArray) and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	^ self elements notEmpty
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aSymbol [
	^ self elementsByName includesKey: aSymbol asSymbol
]

{ #category : #testing }
XMLNodeWithElements >> includesNode: aNode [
	^ self nodes includes: aNode
]

{ #category : #testing }
XMLNodeWithElements >> isEmpty [
	^ self nodes isEmpty
]

{ #category : #namespace }
XMLNodeWithElements >> namespace [
	^ namespace
]

{ #category : #namespace }
XMLNodeWithElements >> namespace: aPrefix uri: aUri [
	namespace := aPrefix.
	uri := aUri.
]

{ #category : #namespace }
XMLNodeWithElements >> namespaceURI [
	^ uri
]

{ #category : #private }
XMLNodeWithElements >> newElements [
	^ OrderedCollection new
]

{ #category : #accessing }
XMLNodeWithElements >> nodeAfter: aNode [
	^ self nodes after: aNode ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> nodeBefore: aNode [
	^ self nodes before: aNode ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> nodes [
	^ nodes ifNil: [nodes := OrderedCollection new]
]

{ #category : #enumerating }
XMLNodeWithElements >> nodesDo: aBlock [
	self nodes do: aBlock
]

{ #category : #printing }
XMLNodeWithElements >> printXMLOn: writer [
	self nodesDo: [:each | each printXMLOn: writer].
]

{ #category : #private }
XMLNodeWithElements >> rebuildElementCache [
	"This method rebuilds the #elements and #elementsByName caches using #nodes. It is
	sent by #with:add: when an element node is added to #nodes anywhere but to its end
	and also changedChildElement: when the name or namespace informatin of a child
	element is changed.
	
	See #with:add: and #with:remove:"

	self elements removeAll.
	self elementsByName removeAll.

	self nodesDo: [:each | each isTag ifTrue: [self elementCacheAdd: each]].
]

{ #category : #searching }
XMLNodeWithElements >> recurse: aBlock [
	"Descend down the tree visiting each element with aBlock."

	self elementsDo: [:each | each recurse: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> recurseUntilTrue: aBlock [
	"Descend down the tree visiting each element with aBlock until one such evaluation
	of aBlock with an element is true, then return that element. Otherwise, return nil."

	| result |

	self elementsDo: [:each | (result := each recurseUntilTrue: aBlock) ifNotNil: [^ result]].
	^ nil.
]

{ #category : #private }
XMLNodeWithElements >> remove: aNode from: aCollection [
	^ aCollection remove: aNode ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> removeNode: aNode [
	^ self with: [self remove: aNode from: self nodes] remove: aNode
]

{ #category : #accessing }
XMLNodeWithElements >> removeNodes [
	^ self removeNodes: self nodes copy
]

{ #category : #accessing }
XMLNodeWithElements >> removeNodes: aNodeCollection [
	aNodeCollection do: [:each | self removeNode: each].
	^ aNodeCollection.
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aSymbol childrenDo: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match"

	self elementsDo: [:each | each ifNamed: aSymbol do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aSymbol childrenDoAndRecurse: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match and recurse"

	self elementsDo: [:each | each tagsNamed: aSymbol do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aSymbol contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver.
	The receiver has no tag, so pass the message on"

	self recurse: [:each | each ifNamed: aSymbol do: [each contentsDo: aBlock]]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aSymbol do: aOneArgumentBlock [
	"Search for nodes with tag aSymbol. When encountered evaluate aOneArgumentBlock"

	self recurse: [:each | each ifNamed: aSymbol do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock [
	self deprecated: 'use #tagsNamed:do: instead'.

	self tagsNamed: aSymbol do: aOneArgumentBlock.
]

{ #category : #accessing }
XMLNodeWithElements >> topElement [
	^ self elements at: 1 ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> topNode [
	^ self nodes at: 1 ifAbsent: [nil]
]

{ #category : #private }
XMLNodeWithElements >> with: aBlock add: aNode [
	"This is an execute-around method that takes a block purporting to add aNode
	to #nodes. It evaluates the block, establishes a parent-child relationship,
	and if the node is an XMLElement, adds it to the element cache or rebuilds
	the cache if needed.
	
	Methods adding anything to #nodes should be implemented around this
	message."

	aNode hasParent
		ifTrue: [self error: 'attempt to add node with parent'. ^ nil].

	self with: aBlock onError: [^ nil].
	aNode parent: self.
	aNode isTag ifTrue: [
		(self nodes last = aNode)
			ifTrue: [self elementCacheAdd: aNode]
			ifFalse: [self rebuildElementCache]].
	^ aNode.
]

{ #category : #private }
XMLNodeWithElements >> with: aBlock onError: errorBlock [
	^ aBlock
		on: Error
		do: [:error | error signal. errorBlock valueWithPossibleArgument: error]
]

{ #category : #private }
XMLNodeWithElements >> with: aBlock remove: aNode [
	"This is an execute-around method that takes a block purporting to remove
	aNode from #nodes, evaluates it, breaks the parent-child relationship,
	and removes aNode from the element cache if it happens to be an XMLElement.
	
	Methods that remove anything from #nodes should be implemented around this
	message."

	self with: aBlock onError: [^ nil].
	aNode parent: nil.
	aNode isTag ifTrue: [self elementCacheRemove: aNode].
	^ aNode.
]

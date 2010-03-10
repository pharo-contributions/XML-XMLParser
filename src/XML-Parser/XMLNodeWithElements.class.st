"
This class represents a node with child nodes. You will likely use its API through either XMLDocument or XMLElement. To retrieve child elements by name, you can send any of the #element- messages in ""accessing."" The #firstTag- messages search the receiver and its descendants using depth-first traversal for specific elements, and the #tagsNamed- messages perform some sort of iteration over descendent elements also using depth-first traversal.
"
Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNodeWithChildren,
	#instVars : [
		'elements',
		'elementsByName'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: anElement [
	self addNode: anElement
]

{ #category : #private }
XMLNodeWithElements >> addedNode: aNode toList: aCollection [
	aNode isTag ifTrue: [
		(self nodes last = aNode)
			ifTrue: [self elementCacheAdd: aNode]
			ifFalse: [self rebuildElementCache]].
]

{ #category : #accessing }
XMLNodeWithElements >> elementAfter: anElement [
	^ self elements after: anElement ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aString [
	^ self elementAt: aString ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aString ifAbsent: aBlock [
	^ (self elementsAt: aString ifAbsent: [^ aBlock value]) first
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aStringArray [
	^ self elementAtAny: aStringArray ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aStringArray ifAbsent: aBlock [
	| answer |

	aStringArray do: [:each | (answer := self elementAt: each) ifNotNil: [^ answer]].
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
		ifTrue: [self elementCacheAt: anElement qualifiedName add: anElement].
]

{ #category : #private }
XMLNodeWithElements >> elementCacheAt: aString add: anElement [
	(self elementsByName
		at: aString
		ifAbsentPut: [self newElements]) add: anElement
]

{ #category : #private }
XMLNodeWithElements >> elementCacheAt: aString remove: anElement [
	(self elementsByName at: aString) remove: anElement.

	(self elementsAt: aString)
		ifEmpty: [self elementsByName removeKey: aString].
]

{ #category : #private }
XMLNodeWithElements >> elementCacheRemove: anElement [
	self elements remove: anElement.

	self elementCacheAt: anElement localName remove: anElement.
	anElement hasPrefix
		ifTrue: [self elementCacheAt: anElement qualifiedName remove: anElement].
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: aString [
	self deprecated: 'use #elementAt: with an unqualified name instead'.

	^ self elementAt: aString.
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: aString ifAbsent: aBlock [
	self deprecated: 'use #elementAt:ifAbsent: with an unqualified name instead'.

	^ self elementAt: aString ifAbsent: aBlock.
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	^ elements ifNil: [elements := self newElements]
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aString [
	^ self elementsAt: aString ifAbsent: [self newElements]
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAt: aString do: aBlock [
	(self elementsAt: aString) do: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aString ifAbsent: aBlock [
	^ self elementsByName at: aString ifAbsent: aBlock.
]

{ #category : #private }
XMLNodeWithElements >> elementsByName [ 
	^ elementsByName ifNil: [elementsByName := Dictionary new].
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self elements do: aBlock
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aString [ 
	"Return the first encountered node with the specified tag. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamed: aString]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aString with: aBlock [
	"Return the first encountered node with the specified tag that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamed: aString) and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aStringArray [
	"Return the first encountered node with any of the specified tag names. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamedAny: aStringArray]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aStringArray with: aBlock [
	"Return the first encountered node with any of the specified tag names that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamedAny: aStringArray) and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	^ self elements notEmpty
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aString [
	^ (self elementAt: aString) notNil
]

{ #category : #accessing }
XMLNodeWithElements >> lastElement [
	^ self elements at: self elements size ifAbsent: [nil]
]

{ #category : #private }
XMLNodeWithElements >> newElements [
	^ OrderedCollection new
]

{ #category : #private }
XMLNodeWithElements >> rebuildElementCache [
	"This method rebuilds the #elements and #elementsByName caches using #nodes. It is
	sent by #with:add: when an element node is added to #nodes anywhere except at the
	end and also by changedChildElement: when the name or namespace information of a
	child element is changed.
	
	See #with:add: and #with:remove:"

	self elements removeAll.
	self elementsByName removeAll.

	self nodesDo: [:each | each isTag ifTrue: [self elementCacheAdd: each]].
]

{ #category : #searching }
XMLNodeWithElements >> recurse: aBlock [
	"Descend depth-first visiting each element with aBlock."

	self elementsDo: [:each | each recurse: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> recurseUntilTrue: aBlock [
	"Descend depth-first visiting each element with aBlock until one such evaluation
	of aBlock with an element is true, then return that element. If no evaluation is
	true, then return nil."

	| result |

	self elementsDo: [:each | (result := each recurseUntilTrue: aBlock) ifNotNil: [^ result]].
	^ nil.
]

{ #category : #private }
XMLNodeWithElements >> removedNode: aNode fromList: aCollection [
	aNode isTag ifTrue: [self elementCacheRemove: aNode].
]

{ #category : #private }
XMLNodeWithElements >> renamedChildNode: aNode [
	aNode isTag ifTrue: [self rebuildElementCache]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString childrenDo: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match"

	self deprecated: 'use #elementsAt:do: instead'.

	self elementsAt: aString do: aOneArgumentBlock.
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString childrenDoAndRecurse: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match and recurse"

	self elementsDo: [:each | each tagsNamed: aString do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver.
	The receiver has no tag, so pass the message on"

	self tagsNamed: aString do: [:each | each contentsDo: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString do: aOneArgumentBlock [
	"Search for nodes with tag aString. When encountered evaluate aOneArgumentBlock"

	self recurse: [:each | each ifNamed: aString do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString ifReceiverDoAndRecurse: aOneArgumentBlock [
	self deprecated: 'use #tagsNamed:do: instead'.

	self tagsNamed: aString do: aOneArgumentBlock.
]

{ #category : #accessing }
XMLNodeWithElements >> topElement [
	^ self elements at: 1 ifAbsent: [nil]
]

{ #category : #private }
XMLNodeWithElements >> with: aBlock add: aNode [
	"This is an execute-around method that takes a block purporting to add aNode
	to #nodes. It evaluates the block, establishes a parent-child relationship,
	and if the node is an XMLElement, adds it to the element cache or rebuilds
	the cache if needed.
	
	Methods adding anything to #nodes should be implemented around this
	message."

	(super with: aBlock add: aNode) ifNil: [^ nil].

	aNode isTag ifTrue: [
		(self nodes last = aNode)
			ifTrue: [self elementCacheAdd: aNode]
			ifFalse: [self rebuildElementCache]].
	^ aNode.
]

{ #category : #private }
XMLNodeWithElements >> with: aBlock remove: aNode [
	"This is an execute-around method that takes a block purporting to remove
	aNode from #nodes, evaluates it, breaks the parent-child relationship,
	and removes aNode from the element cache if it happens to be an XMLElement.
	
	Methods that remove anything from #nodes should be implemented around this
	message."

	(super with: aBlock remove: aNode) ifNil: [^ nil].

	aNode isTag ifTrue: [self elementCacheRemove: aNode].
	^ aNode.
]

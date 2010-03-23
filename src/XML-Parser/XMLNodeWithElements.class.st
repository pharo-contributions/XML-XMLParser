"
This class represents a node with elements. You will likely use its API through either XMLDocument or XMLElement. To retrieve child elements by name, you can send any of the #element- messages in ""accessing."" The #firstTag- messages search the receiver and its descendants using depth-first traversal for specific elements, and the #tagsNamed- messages iterate over descendent elements also using depth-first traversal.
"
Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNodeWithChildren,
	#instVars : [
		'elementCache'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: anElement [
	self addNode: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementAfter: anElement [
	^ self elements after: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aString [
	^ self elementCache firstElementNamed: aString
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aString ifAbsent: aBlock [
	^ (self elementCache firstElementNamed:  aString) ifNil: aBlock
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
	^ self elements before: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementCache [
	^ elementCache ifNil: [elementCache := XMLElementCache new]
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
	^ self elementCache elements
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aString [
	^ self elementCache elementsNamed: aString
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAt: aString do: aBlock [
	(self elementsAt: aString) do: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aString ifAbsent: aBlock [
	^ (self elementCache elementsNamed: aString) ifEmpty: aBlock.
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self elements do: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> firstElement [
	^ self elements first
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
	^ self elements last
]

{ #category : #announcements }
XMLNodeWithElements >> nodeAdded: aNode [
	super nodeAdded: aNode.

	aNode isTag
		ifTrue: [self elementCache cacheElement: aNode].
]

{ #category : #announcements }
XMLNodeWithElements >> nodeRemoved: aNode [
	super nodeRemoved: aNode.

	aNode isTag
		ifTrue: [self elementCache uncacheElement: aNode].
]

{ #category : #announcements }
XMLNodeWithElements >> nodeRenamed: aNode from: anOldName to: aNewName [
	aNode isTag
		ifTrue: [self elementCache rebuildCacheFrom: self nodes].
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
	^ self firstElement
]

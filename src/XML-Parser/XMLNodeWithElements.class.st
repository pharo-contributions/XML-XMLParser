"
This class represents a node with elements. You will likely use its API through XMLDocument or XMLElement objects.

To retrieve child elements by name, you can send any of the #element- messages under ""accessing."" The #firstTag- messages search the receiver and its descendants using depth-first traversal for specific elements, and the #tagsNamed- messages iterate over descendent elements also using depth-first traversal.
"
Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNodeWithChildren,
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: anElement [
	self addNode: anElement
]

{ #category : #notifications }
XMLNodeWithElements >> addedElement: anElement [
	anElement document: self document
]

{ #category : #accessing }
XMLNodeWithElements >> contentNodes [
	^ self nodes select: [:each | each isContentNode]
]

{ #category : #enumerating }
XMLNodeWithElements >> contentNodesDo: aBlock [
	self nodes do: [:each | each isContentNode ifTrue: [aBlock value: each]]
]

{ #category : #accessing }
XMLNodeWithElements >> contentStringAt: aString [
	^ (self elementAt: aString ifAbsent: [^ '']) contentString
]

{ #category : #accessing }
XMLNodeWithElements >> document [
	self subclassResponsibility
]

{ #category : #accessing }
XMLNodeWithElements >> elementAfter: anElement [
	^ self elements after: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aString [
	^ self nodes elementNamed: aString
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aString ifAbsent: aBlock [
	^ self nodes elementNamed: aString ifAbsent: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName namespaceURI: aUri [
	^ self nodes elementNamed: aName namespaceURI: aUri
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName namespaceURI: aUri ifAbsent: aBlock [
	^ self nodes elementNamed: aName namespaceURI: aUri ifAbsent: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aStringArray [
	^ self elementAtAny: aStringArray ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aStringArray ifAbsent: aBlock [
	| answer |

	aStringArray do: [:each |
		(answer := self elementAt: each)
			ifNotNil: [^ answer]].
	^ aBlock value.
]

{ #category : #accessing }
XMLNodeWithElements >> elementBefore: anElement [
	^ self elements before: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	^ self nodes elements
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aString [
	^ self nodes elementsNamed: aString
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAt: aString do: aBlock [
	(self nodes elementsNamed: aString) do: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aName namespaceURI: aUri [
	^ self nodes elementsNamed: aName namespaceURI: aUri
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self nodes elementsDo: aBlock
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
		(each isNamed: aString)
			and: [aBlock valueWithPossibleArgument: each]]
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
		(each isNamedAny: aStringArray)
			and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #testing }
XMLNodeWithElements >> hasContent [
	^ self nodes anySatisfy: [:each | each isContentNode]
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	"Faster version for #recurse*: methods to avoid initializing the node list in leaf elements"
	^ nodes notNil and: [nodes hasElements]
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aString [
	^ self nodes includesElementNamed: aString
]

{ #category : #parsing }
XMLNodeWithElements >> innerXML: aString [
	| parsedDocument newNodes |

	parsedDocument := XMLDOMParser
		parseDocumentFrom: aString
		useNamespaces: self usesNamespaces.
	newNodes := parsedDocument nodes copy.
	parsedDocument removeNodes.
	self
		removeNodes;
		addNodes: newNodes.
]

{ #category : #testing }
XMLNodeWithElements >> isContentNode [
	^ true
]

{ #category : #accessing }
XMLNodeWithElements >> lastElement [
	^ self elements last
]

{ #category : #private }
XMLNodeWithElements >> namespaceScope [
	^ XMLNamespaceScope new
]

{ #category : #private }
XMLNodeWithElements >> nodesClass [
	^ XMLNodeList
]

{ #category : #printing }
XMLNodeWithElements >> printContentOn: aStream [
	self contentNodesDo: [:each | each printContentOn: aStream]
]

{ #category : #printing }
XMLNodeWithElements >> printXMLOn: writer [
	self nodesDo: [:each | each printXMLOn: writer].
]

{ #category : #searching }
XMLNodeWithElements >> recurse: aBlock [
	"Descend depth-first visiting each element with aBlock."

	self hasElements
		ifTrue: [self elementsDo: [:each | each recurse: aBlock]]
]

{ #category : #searching }
XMLNodeWithElements >> recurseUntilTrue: aBlock [
	"Descend depth-first visiting each element with aBlock until one such evaluation
	of aBlock with an element is true, then return that element. If no evaluation is
	true, then return nil."
	| result |

	self hasElements
		ifTrue: [
			self elementsDo: [:each |
				(result := each recurseUntilTrue: aBlock)
					ifNotNil: [^ result]]].
	^ nil.
]

{ #category : #notifications }
XMLNodeWithElements >> removedElement: anElement [
	anElement document: nil
]

{ #category : #notifications }
XMLNodeWithElements >> renamedElement: anElement from: anOldName to: aNewName [
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

	self deprecated: 'use "node elementsDo: [:each | each tagsNamed: aName do: [...]]" instead'.

	self elementsDo: [:each | each tagsNamed: aString do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver.
	The receiver has no tag, so pass the message on"

	self deprecated: 'use "node tagsNamed: aName do: [:each | each stringNodes...]" instead'.

	self tagsNamed: aString do: [:each | each stringNodesDo: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString do: aOneArgumentBlock [
	"Search for nodes with tag aString. When encountered evaluate aOneArgumentBlock"

	self recurse: [:each |
		(each isNamed: aString)
			ifTrue: [aOneArgumentBlock valueWithPossibleArgument: each]]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamedAny: aStringCollection do: aOneArgumentBlock [
	"Search for nodes with tag aString. When encountered evaluate aOneArgumentBlock"

	self recurse: [:each |
		(each isNamedAny: aStringCollection)
			ifTrue: [aOneArgumentBlock valueWithPossibleArgument: each]]
]

{ #category : #accessing }
XMLNodeWithElements >> topElement [
	self deprecated: 'use #firstElement instead'.

	^ self firstElement.
]

{ #category : #testing }
XMLNodeWithElements >> usesNamespaces [
	^ true
]

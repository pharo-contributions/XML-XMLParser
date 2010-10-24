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
XMLNodeWithElements >> contentStringAt: aName [
	^ (self elementAt: aName ifAbsent: [^ '']) contentString
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
XMLNodeWithElements >> elementAt: aName [
	^ self nodes elementNamed: aName
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName ifAbsent: aBlock [
	^ self nodes elementNamed: aName ifAbsent: aBlock
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
XMLNodeWithElements >> elementAtAny: aNameArray [
	^ self elementAtAny: aNameArray ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aNameArray ifAbsent: aBlock [
	| answer |

	aNameArray do: [:each |
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
XMLNodeWithElements >> elementsAt: aName [
	^ self nodes elementsNamed: aName
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAt: aName do: aBlock [
	(self nodes elementsNamed: aName) do: aBlock
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
XMLNodeWithElements >> firstTagNamed: aName [ 
	"Return the first encountered node with the specified tag. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamed: aName]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aName with: aBlock [
	"Return the first encountered node with the specified tag that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamed: aName)
			and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aNameArray [
	"Return the first encountered node with any of the specified tag names. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamedAny: aNameArray]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aNameArray with: aBlock [
	"Return the first encountered node with any of the specified tag names that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamedAny: aNameArray)
			and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #testing }
XMLNodeWithElements >> hasContentNodes [
	^ self nodes anySatisfy: [:each | each isContentNode]
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	"Faster version for #recurse*: methods to avoid initializing the node list in leaf elements"
	^ nodes notNil and: [nodes hasElements]
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aName [
	^ self nodes includesElementNamed: aName
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
XMLNodeWithElements >> tagsNamed: aName childrenDo: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match"

	self deprecated: 'use #elementsAt:do: instead'.

	self elementsAt: aName do: aOneArgumentBlock.
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aName childrenDoAndRecurse: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match and recurse"

	self deprecated: 'use "node elementsDo: [:each | each tagsNamed: aName do: [...]]" instead'.

	self elementsDo: [:each | each tagsNamed: aName do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aName contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver.
	The receiver has no tag, so pass the message on"

	self deprecated: 'use "node tagsNamed: aName do: [:each | each stringNodes...]" instead'.

	self tagsNamed: aName do: [:each | each stringNodesDo: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aName do: aOneArgumentBlock [
	"Search for nodes with tag aName. When encountered evaluate aOneArgumentBlock"

	self recurse: [:each |
		(each isNamed: aName)
			ifTrue: [aOneArgumentBlock valueWithPossibleArgument: each]]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamedAny: aNameCollection do: aOneArgumentBlock [
	"Search for nodes with tag aName. When encountered evaluate aOneArgumentBlock"

	self recurse: [:each |
		(each isNamedAny: aNameCollection)
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

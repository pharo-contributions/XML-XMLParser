"
This class represents a node with elements. You will likely use its API through its subclasses instead.

Instances provide ""accessing"" messages to retrieve child elements by their name and namespace information. The #elementAt: forms return the first matching element, while the #elementsAt: forms return all matching child elements.

As with node enumeration in the superclass, there are two different modes of enumeration: the #elements* enumerating messages that enumerate child elements only, and the #allElements* forms that enumerate all descendent elements, including the receiver if it is an element (but not if it is a document), using depth-first traversal.

The #findElementNamed:* forms can be used to search using depth-first traversal for a specific element. Searching will start with the receiver if it is an element.

All element name matching is done using both the qualified and local name of elements, so 'prefix:element-name' will only match 'prefix:element-name' while 'element-name' will match 'element-name', 'prefix:element-name' or 'different-prefix:element-name' and so on.
"
Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNodeWithChildren,
	#instVars : [
		'configuration'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: anElement [
	self addNode: anElement
]

{ #category : #notifications }
XMLNodeWithElements >> addedElement: anElement [
	anElement
		configuration: self configuration;
		document: self document
]

{ #category : #accessing }
XMLNodeWithElements >> allElements [
	^ self allElementsCollect: [:each | each]
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsCollect: aBlock [
	| collectedElements |

	collectedElements := self elements copyEmpty.
	self allElementsDo: [:each | collectedElements add: (aBlock value: each)].
	^ collectedElements.
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsDetect: aBlock [
	"Descend depth-first visiting each element with aBlock until one such evaluation
	of aBlock with an element is true, then return that element. If no evaluation is
	true, then return nil."

	^ self allElementsDetect: aBlock ifNone: [nil]
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsDetect: aBlock ifNone: anExceptionBlock [
	"Descend depth-first visiting each element with aBlock until one such evaluation
	of aBlock with an element is true, then return that element. If no evaluation is
	true, then return nil."

	self allElementsDo: [:each | (aBlock value: each) ifTrue: [^ each]].
	^ anExceptionBlock value.
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsDo: aBlock [
	"Descend depth-first visiting each element with aBlock."

	self hasElements
		ifTrue: [self elementsDo: [:each | each allElementsDo: aBlock]]
]

{ #category : #accessing }
XMLNodeWithElements >> allElementsNamed: aName [
	^ self allElementsSelect: [:each | each isNamed: aName]
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsNamed: aName do: aBlock [
	self allElementsDo: [:each |
		(each isNamed: aName)
			ifTrue: [aBlock value: each]]
]

{ #category : #accessing }
XMLNodeWithElements >> allElementsNamed: aName namespaceURI: aUri [
	^ (self allElementsNamed: aName) select: [:each | each namespaceURI = aUri]
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsSelect: aBlock [
	| selectedElements |

	selectedElements := self elements copyEmpty.
	self allElementsDo: [:each |
		(aBlock value: each)
			ifTrue: [selectedElements add: each]].
	^ selectedElements.
]

{ #category : #accessing }
XMLNodeWithElements >> configuration [
	^ configuration ifNil: [
		self configuration: XMLDOMConfiguration new.
		configuration]
]

{ #category : #accessing }
XMLNodeWithElements >> configuration: aConfiguration [
	configuration := aConfiguration.

	self hasElements
		ifTrue: [self elementsDo: [:each | each configuration: aConfiguration]]
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
XMLNodeWithElements >> document: aDocument [ 
	self subclassResponsibility
]

{ #category : #accessing }
XMLNodeWithElements >> elementAfter: anElement [
	^ self elements after: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName [
	^ self nodes elementAt: aName
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName ifAbsent: aBlock [
	^ self nodes elementAt: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName namespaceURI: aUri [
	^ self nodes elementAt: aName namespaceURI: aUri
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName namespaceURI: aUri ifAbsent: aBlock [
	^ self nodes elementAt: aName namespaceURI: aUri ifAbsent: aBlock
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
XMLNodeWithElements >> elementsAndContents [
	self deprecated: 'use #contentNodes instead'.

	^ self contentNodes.
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAndContentsDo: aBlock [
	self deprecated: 'use contentNodesDo: instead'.

	self contentNodesDo: aBlock.
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aName [
	^ self nodes elementsAt: aName
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAt: aName do: aBlock [
	(self nodes elementsAt: aName) do: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aName namespaceURI: aUri [
	^ self nodes elementsAt: aName namespaceURI: aUri
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsCollect: aBlock [
	^ self nodes elementsCollect: aBlock
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDetect: aBlock [
	^ self nodes elementsDetect: aBlock
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDetect: aBlock ifNone: anExceptionBlock [
	^ self nodes elementsDetect: aBlock ifNone: anExceptionBlock
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self nodes elementsDo: aBlock
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsSelect: aBlock [
	^ self nodes elementsSelect: aBlock
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName [
	^ self allElementsDetect: [:each | each isNamed: aName]
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName namespaceURI: aUri [
	^ self allElementsDetect: [:each | (each isNamed: aName) and: [each namespaceURI = aUri]]
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName namespaceURI: aUri with: aBlock [
	^ self allElementsDetect: [:each |
			(each isNamed: aName)
				and: [each namespaceURI = aUri
					and: [aBlock value: each]]]
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName with: aBlock [
	^ self allElementsDetect: [:each | (each isNamed: aName) and: [aBlock value: each]]
]

{ #category : #accessing }
XMLNodeWithElements >> firstElement [
	^ self elements first
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aName [
	self deprecated: 'use #findElementNamed: instead'.

	^ self findElementNamed: aName.
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aName with: aBlock [
	self deprecated: 'use #findElementNamed:with: instead'.

	^ self findElementNamed: aName with: aBlock.
]

{ #category : #testing }
XMLNodeWithElements >> hasContentNodes [
	^ self nodes anySatisfy: [:each | each isContentNode]
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	"Faster version used when traversing to avoid initializing the node list
	in leaf elements"
	^ nodes notNil and: [nodes hasElements]
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aName [
	^ self nodes includesElementAt: aName
]

{ #category : #private }
XMLNodeWithElements >> innerXMLParserOn: aStringOrStream [
	^ (self configuration parserClass on: aStringOrStream withRootNode: self)
		configuration: self configuration.
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

{ #category : #notifications }
XMLNodeWithElements >> removedElement: anElement [
	anElement document: nil
]

{ #category : #notifications }
XMLNodeWithElements >> renamedElement: anElement from: anOldName to: aNewName [
]

{ #category : #enumerating }
XMLNodeWithElements >> tagsNamed: aName childrenDo: aOneArgumentBlock [
	self deprecated: 'use #elementsAt:do: instead'.

	self elementsAt: aName do: aOneArgumentBlock.
]

{ #category : #enumerating }
XMLNodeWithElements >> tagsNamed: aName childrenDoAndRecurse: aOneArgumentBlock [
	self deprecated: 'use "node elementsDo: [:each | each allElementsNamed: aName do: [...]]" instead'.

	self elementsDo: [:each | each allElementsNamed: aName do: aOneArgumentBlock].
]

{ #category : #enumerating }
XMLNodeWithElements >> tagsNamed: aName contentsDo: aBlock [
	self deprecated: 'use "node allElementsNamed: aName do: [:each | each stringNodes...]" instead'.

	self allElementsNamed: aName do: [:each | each stringNodesDo: aBlock].
]

{ #category : #enumerating }
XMLNodeWithElements >> tagsNamed: aName do: aBlock [
	self deprecated: 'use #allElementsNamed:do: instead'.

	self allElementsNamed: aName do: aBlock.
]

{ #category : #accessing }
XMLNodeWithElements >> topElement [
	self deprecated: 'use #firstElement instead'.

	^ self firstElement.
]

{ #category : #testing }
XMLNodeWithElements >> usesNamespaces [
	"Uses direct access and isNil test for performance"
	^ configuration isNil or: [configuration usesNamespaces]
]

{ #category : #accessing }
XMLNodeWithElements >> usesNamespaces: aBoolean [
	self configuration usesNamespaces: aBoolean
]

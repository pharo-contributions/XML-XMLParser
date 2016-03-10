"
This is an abstract class for nodes with elements.

Instances provide ""accessing"" messages to retrieve child elements by their name and namespace information. The #elementAt: forms return the first matching element, while the #elementsAt: forms return all matching child elements.

There are three different modes of enumeration: the #elements* enumerating messages enumerate child elements, the #allElements* forms enumerate the receiver (if it's an element) and all descendant elements, and the #descendantElement* forms enumerate descendant elements only.

The #findElementNamed:* forms search the receicer (if it's an element) and descendants for a specific element.

Element name matching is done the qualified and local name, so 'prefix:element-name' will only match 'prefix:element-name' while 'element-name' will match 'element-name', 'prefix:element-name' or 'different-prefix:element-name' and so on.

The inner XML can be accessed as a string using #innerXML and set (reparsed) using #innerXML:.
"
Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNodeWithChildren,
	#instVars : [
		'configuration'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #adding }
XMLNodeWithElements >> addContent: aStringOrStringNode [
	"Adds a string or string node. If the last child node is already a string node,
	the characters being added are concatenated to it."

	(self hasChildren and: [self lastNode acceptsContent])
		ifTrue: [self lastNode addContent: aStringOrStringNode]
		ifFalse: [self addNode:
			(aStringOrStringNode isString
				ifTrue: [self nodeFactory newString: aStringOrStringNode]
				ifFalse: [aStringOrStringNode])]
]

{ #category : #deprecated }
XMLNodeWithElements >> addElement: anElement [
	self deprecated: 'Use #addNode: or #addElementNamed: instead'.

	self addNode: anElement.
]

{ #category : #adding }
XMLNodeWithElements >> addElementNamed: aName [
	^ self addNode: (self nodeFactory newElementNamed: aName)
]

{ #category : #adding }
XMLNodeWithElements >> addElementNamed: aName namespaceURI: aURI [
	^ self addNode:
		(self nodeFactory
			newElementNamed: aName
			namespaceURI: aURI)
]

{ #category : #notifying }
XMLNodeWithElements >> addedElement: anElement [
	self addedNode: anElement.
	anElement configuration: self configuration.
]

{ #category : #accessing }
XMLNodeWithElements >> allElements [
	| allElements |

	allElements := self newListForSelect.
	self allElementsDo: [:each | allElements addLast: each].
	^ allElements.
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsCollect: aBlock [
	| collectedObjects |

	collectedObjects := self newListForCollect.
	self allElementsDo: [:each | collectedObjects addLast: (aBlock value: each)].
	^ collectedObjects.
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

	self allElementsDo: [:each |
		(aBlock value: each)
			ifTrue: [^ each]].
	^ anExceptionBlock value.
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsDo: aBlock [
	"Descend depth-first visiting each element with aBlock."

	self hasChildren
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
XMLNodeWithElements >> allElementsNamed: aName namespaceURI: aURI [
	^ self allElementsSelect: [:each |
		(each isNamed: aName)
			and: [each namespaceURI = aURI]]
]

{ #category : #enumerating }
XMLNodeWithElements >> allElementsSelect: aBlock [
	| selectedElements |

	selectedElements := self newListForSelect.
	self allElementsDo: [:each |
		(aBlock value: each)
			ifTrue: [selectedElements addLast: each]].
	^ selectedElements.
]

{ #category : #accessing }
XMLNodeWithElements >> configuration [
	^ configuration ifNil: [
		self configuration: self configurationClass new.
		configuration]
]

{ #category : #accessing }
XMLNodeWithElements >> configuration: aConfiguration [
	configuration := aConfiguration.

	self hasChildren
		ifTrue: [self elementsDo: [:each | each configuration: aConfiguration]]
]

{ #category : #private }
XMLNodeWithElements >> configurationClass [
	^ XMLDOMConfiguration
]

{ #category : #accessing }
XMLNodeWithElements >> contentNodes [
	^ self nodes contentNodes
]

{ #category : #enumerating }
XMLNodeWithElements >> contentNodesDo: aBlock [
	self nodes contentNodesDo: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> contentString: aString [
	self
		removeNodes;
		addContent: aString
]

{ #category : #accessing }
XMLNodeWithElements >> contentStringAt: aName [
	"returns the content string of the element named aName or empty if absent"
	^ self nodes contentStringAt: aName
]

{ #category : #accessing }
XMLNodeWithElements >> descendantElements [
	| descendentElements |

	descendentElements := self newListForSelect.
	self descendantElementsDo: [:each | descendentElements addLast: each].
	^ descendentElements.
]

{ #category : #enumerating }
XMLNodeWithElements >> descendantElementsCollect: aBlock [
	| collectedObjects |

	collectedObjects := self newListForCollect.
	self descendantElementsDo: [:each |
		collectedObjects addLast: (aBlock value: each)].
	^ collectedObjects.
]

{ #category : #enumerating }
XMLNodeWithElements >> descendantElementsDetect: aBlock [
	^ self
		descendantElementsDetect: aBlock
		ifNone: [nil]
]

{ #category : #enumerating }
XMLNodeWithElements >> descendantElementsDetect: aBlock ifNone: anExceptionBlock [
	self descendantElementsDo: [:each |
		(aBlock value: each)
			ifTrue: [^ each]].
	^ anExceptionBlock value.
]

{ #category : #enumerating }
XMLNodeWithElements >> descendantElementsDo: aBlock [
	self hasChildren
		ifTrue: [self elementsDo: [:each | each allElementsDo: aBlock]]
]

{ #category : #accessing }
XMLNodeWithElements >> descendantElementsNamed: aName [
	^ self descendantElementsSelect: [:each | each isNamed: aName]
]

{ #category : #enumerating }
XMLNodeWithElements >> descendantElementsNamed: aName do: aBlock [
	self descendantElementsDo: [:each |
		(each isNamed: aName)
			ifTrue: [aBlock value: each]]
]

{ #category : #accessing }
XMLNodeWithElements >> descendantElementsNamed: aName namespaceURI: aURI [
	^ self descendantElementsSelect: [:each |
		(each isNamed: aName)
			and: [each namespaceURI = aURI]]
]

{ #category : #enumerating }
XMLNodeWithElements >> descendantElementsSelect: aBlock [
	| selectedElements |

	selectedElements := self newListForSelect.
	self descendantElementsDo: [:each |
		(aBlock value: each)
			ifTrue: [selectedElements addLast: each]].
	^ selectedElements.
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElements [
	"less common alternate spelling"
	^ self descendantElements
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsCollect: aBlock [
	"less common alternate spelling"
	^ self descendantElementsCollect: aBlock
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsDetect: aBlock [
	"less common alternate spelling"
	^ self descendantElementsDetect: aBlock
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsDetect: aBlock ifNone: anExceptionBlock [
	"less common alternate spelling"
	^ self
		descendantElementsDetect: aBlock
		ifNone: anExceptionBlock
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsDo: aBlock [
	"less common alternate spelling"
	^ self descendantElementsDo: aBlock
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsNamed: aName [
	"less common alternate spelling"
	^ self descendantElementsNamed: aName
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsNamed: aName do: aBlock [
	"less common alternate spelling"
	^ self
		descendantElementsNamed: aName
		do: aBlock
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsNamed: aName namespaceURI: aURI [
	"less common alternate spelling"
	^ self
		descendantElementsNamed: aName
		namespaceURI: aURI
]

{ #category : #deprecated }
XMLNodeWithElements >> descendentElementsSelect: aBlock [
	"less common alternate spelling"
	^ self descendantElementsSelect: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementAfter: anElement [
	"returns nil if anElement is last"
	^ self nodes elementAfter: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName [
	"returns nil if absent"
	^ self nodes elementAt: aName
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName ifAbsent: aBlock [
	^ self nodes elementAt: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName namespaceURI: aURI [
	"returns nil if absent"
	^ self nodes elementAt: aName namespaceURI: aURI
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aName namespaceURI: aURI ifAbsent: aBlock [
	^ self nodes elementAt: aName namespaceURI: aURI ifAbsent: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementBefore: anElement [
	"returns nil if anElement is first"
	^ self nodes elementBefore: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementNames [
	^ self nodes elementNames
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	^ self nodes elements
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aName [
	^ self nodes elementsAt: aName
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAt: aName do: aBlock [
	self nodes elementsAt: aName do: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aName namespaceURI: aURI [
	^ self nodes elementsAt: aName namespaceURI: aURI
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

{ #category : #private }
XMLNodeWithElements >> escapesContentEntitiesWhenWriting [
	"avoid initializing config; defualt to true"
	^ configuration isNil
		or: [configuration replacesContentEntityReferences]
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName [
	^ self allElementsDetect: [:each | each isNamed: aName]
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName namespaceURI: aURI [
	^ self allElementsDetect: [:each |
		(each isNamed: aName)
			and: [each namespaceURI = aURI]]
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName namespaceURI: aURI with: aBlock [
	^ self allElementsDetect: [:each |
		(each isNamed: aName)
			and: [each namespaceURI = aURI
				and: [aBlock value: each]]]
]

{ #category : #searching }
XMLNodeWithElements >> findElementNamed: aName with: aBlock [
	^ self allElementsDetect: [:each |
		(each isNamed: aName)
			and: [aBlock value: each]]
]

{ #category : #searching }
XMLNodeWithElements >> findElementWithID: anID [
	"implements getElementByID()"

	| document doctypeDefinition elementsAndIDAttributes |
	
	((document := self document) notNil
		and: [(doctypeDefinition := document doctypeDefinition) notNil
			and: [doctypeDefinition hasElementIDValidator]])
		ifFalse: [^ nil].
	elementsAndIDAttributes :=
		doctypeDefinition elementIDValidator elementsAndIDAttributes.

	self allElementsDo: [:each |
		each hasAttributes
			ifTrue: [
				elementsAndIDAttributes
					at: each name
					ifPresent: [:idAttribute |
						(each attributeAt: idAttribute) = anID
							ifTrue: [^ each]]]].
	^ nil.
]

{ #category : #accessing }
XMLNodeWithElements >> firstElement [
	"returns nil if no elements"
	^ self nodes firstElement
]

{ #category : #testing }
XMLNodeWithElements >> hasContentNodes [
	^ self nodes hasContentNodes
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	"Faster version used when traversing to avoid initializing the node list
	in leaf elements"
	^ nodes notNil and: [nodes hasElements]
]

{ #category : #testing }
XMLNodeWithElements >> hasStringNodes [
	^ self nodes hasStringNodes
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aName [
	^ self nodes includesElement: aName
]

{ #category : #parsing }
XMLNodeWithElements >> innerXML: aStringOrStream [
	self innerXMLParsedWith: (self parserHandlerClass on: aStringOrStream)
]

{ #category : #private }
XMLNodeWithElements >> innerXMLContext [
	^ XMLContentContext new
]

{ #category : #parsing }
XMLNodeWithElements >> innerXMLParsedWith: aParser [
	| removedNodes |

	removedNodes := self nodes asArray.
	self removeNodes.
	[aParser
		pushInnerXMLRootNode: self;
		parseDocument]
		on: Error
		do: [:error |
			self
				removeNodes;
				addNodes: removedNodes.
			error pass].
]

{ #category : #testing }
XMLNodeWithElements >> isContentNode [
	^ true
]

{ #category : #accessing }
XMLNodeWithElements >> lastElement [
	"returns nil if no elements"
	^ self nodes lastElement
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newCData: aString [
	^ self nodeFactory newCData: aString
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newComment: aString [
	^ self nodeFactory newComment: aString
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newDocument [
	^ self nodeFactory newDocument
		configuration: self configuration
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newElement [
	^ self nodeFactory newElement
		configuration: self configuration
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newElementNamed: aName [
	^ (self nodeFactory newElementNamed: aName)
		configuration: self configuration
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newElementNamed: aName namespaceURI: aURI [
	^ (self nodeFactory
		newElementNamed: aName
		namespaceURI: aURI)
		configuration: self configuration
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newPI [
	^ self nodeFactory newPI
]

{ #category : #'instance creation' }
XMLNodeWithElements >> newString: aString [
	^ self nodeFactory newString: aString
]

{ #category : #accessing }
XMLNodeWithElements >> nodeFactory [
	^ self configuration nodeFactory
]

{ #category : #accessing }
XMLNodeWithElements >> nodeFactory: aNodeFactory [
	self configuration nodeFactory: aNodeFactory
]

{ #category : #private }
XMLNodeWithElements >> nodeListClass [
	^ self configuration nodeFactory nodeListClass
]

{ #category : #private }
XMLNodeWithElements >> parserHandlerClass [
	^ self configuration parserHandlerClass
]

{ #category : #copying }
XMLNodeWithElements >> postCopyConfiguration [
	configuration
		ifNotNil: [self configuration: configuration copy]
]

{ #category : #printing }
XMLNodeWithElements >> printRawContentOn: aStream [
	self contentNodesDo: [:each | each printRawContentOn: aStream]
]

{ #category : #notifying }
XMLNodeWithElements >> removedElement: anElement [
	self removedNode: anElement
]

{ #category : #notifying }
XMLNodeWithElements >> renamedElement: anElement from: anOldName to: aNewName [
	self nodes
		renamedElement: anElement
		from: anOldName
		to: aNewName
]

{ #category : #accessing }
XMLNodeWithElements >> stringNodes [
	^ self nodes stringNodes
]

{ #category : #enumerating }
XMLNodeWithElements >> stringNodesDo: aBlock [
	self nodes stringNodesDo: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> strings [
	^ self nodes strings
]

{ #category : #enumerating }
XMLNodeWithElements >> stringsDo: aBlock [
	self nodes stringsDo: aBlock
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

{ #category : #validating }
XMLNodeWithElements >> validateWith: aValidator [
	self hasChildren
		ifTrue: [self nodesDo: [:each | each validateWith: aValidator]]
]

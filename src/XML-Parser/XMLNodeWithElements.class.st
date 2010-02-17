Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNode,
	#instVars : [
		'nodes',
		'elements',
		'elementsDictionary',
		'uri',
		'namespace'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #comparing }
XMLNodeWithElements >> = anObject [

	^ #(namespace namespaceURI nodes)
		allSatisfy: [:selector |
			(anObject respondsTo: selector)
				and: [(self perform: selector) = (anObject perform: selector)]]
]

{ #category : #private }
XMLNodeWithElements >> addChildNode: aNode [

	self nodes add: (aNode parent: self)
]

{ #category : #accessing }
XMLNodeWithElements >> addElement: anElement [

	anElement isTag ifFalse: [^ self addNode: anElement].

	self
		elementsAt: anElement localName
		add: anElement.
	anElement hasPrefix ifTrue: [
		self
			elementsAt: anElement tag
			add: anElement].
	self elements add: anElement.

	^ self addChildNode: anElement.
]

{ #category : #accessing }
XMLNodeWithElements >> addNode: aNode [
	^ aNode isTag
		ifTrue: [self addElement: aNode]
		ifFalse: [self addChildNode: aNode]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aSymbol [
	^self elementAt: aSymbol ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: aSymbol ifAbsent: aBlock [
	^ (self
		elementsAt: aSymbol
		ifAbsent: [^ aBlock value]) first
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: aSymbol [
	^self elementUnqualifiedAt: aSymbol ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: aSymbol ifAbsent: aBlock [
	^ self elementAt: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	^ elements ifNil: [elements := self newElementCollection]
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aSymbol [

	^ self
		elementsAt: aSymbol
		ifAbsent: [self newElementCollection]
]

{ #category : #private }
XMLNodeWithElements >> elementsAt: aSymbol add: anElement [

	^ (self elementsDictionary
		at: aSymbol asSymbol
		ifAbsentPut: [self newElementCollection]) add: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aSymbol ifAbsent: aBlock [

	^ self elementsDictionary
		at: aSymbol asSymbol
		ifAbsent: aBlock.
]

{ #category : #private }
XMLNodeWithElements >> elementsAt: aSymbol remove: anElement [

	(self elementsDictionary
		at: aSymbol
		ifAbsent: [^ nil])
			remove: anElement
			ifAbsent: [^ nil].
	(self elementsDictionary at: aSymbol)
		ifEmpty: [self elementsDictionary removeKey: aSymbol].

	^ anElement.
]

{ #category : #private }
XMLNodeWithElements >> elementsDictionary [ 

	^ elementsDictionary ifNil: [elementsDictionary := IdentityDictionary new].
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self elements do: aBlock
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aSymbol [ 
	"Return the first encountered node with the specified tag. Pass the message on"

	| answer |

	self elementsDo: [:each | (answer := each firstTagNamed: aSymbol) ifNotNil: [^answer]].
	^nil
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aSymbol with: aBlock [
	"Return the first encountered node with the specified tag that
	allows the block to evaluate to true. Pass the message on"

	| answer |

	self elementsDo: [:each |
		(answer := each firstTagNamed: aSymbol with: aBlock) ifNotNil: [^answer]].
	^nil
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	^self elements notEmpty
]

{ #category : #testing }
XMLNodeWithElements >> hash [

	^ #(namespace namespaceURI nodes)
		inject: 0
		into: [:total :selector | total bitXor: (self perform: selector) hash]
]

{ #category : #testing }
XMLNodeWithElements >> includes: aNode [

	^ self nodes includes: aNode
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aSymbol [

	^ self elementsDictionary includesKey: aSymbol asSymbol
]

{ #category : #testing }
XMLNodeWithElements >> isEmpty [

	^ self nodes isEmpty
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace [
	^ namespace
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace: ns uri: u [
	namespace := ns.
	uri := u
]

{ #category : #'name space' }
XMLNodeWithElements >> namespaceURI [
	^ uri
]

{ #category : #factory }
XMLNodeWithElements >> newElementCollection [

	^ OrderedCollection new
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

{ #category : #accessing }
XMLNodeWithElements >> removeAll [

	self nodes copy do: [:each | self removeNode: each]
]

{ #category : #private }
XMLNodeWithElements >> removeChildNode: aNode [

	self nodes
		remove: (aNode parent: nil)
		ifAbsent: nil
]

{ #category : #accessing }
XMLNodeWithElements >> removeElement: anElement [

	anElement isTag ifFalse: [^ self removeNode: anElement].

	self
		elementsAt: anElement localName
		remove: anElement.
	anElement hasPrefix ifTrue: [
		self
			elementsAt: anElement tag
			remove: anElement].
	self elements remove: anElement.

	^ self removeChildNode: anElement.
]

{ #category : #accessing }
XMLNodeWithElements >> removeNode: aNode [

	^ aNode isTag
		ifTrue: [self removeElement: aNode]
		ifFalse: [self removeChildNode: aNode]
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

	self elementsDo: [:each | each tagsNamed: aSymbol contentsDo: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aSymbol do: aOneArgumentBlock [
	"Search for nodes with tag aSymbol. When encountered evaluate aOneArgumentBlock"

	self elementsDo: [:each | each tagsNamed: aSymbol do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock [
	"Recurse all children"

	self tagsNamed: aSymbol do: aOneArgumentBlock
]

{ #category : #accessing }
XMLNodeWithElements >> topElement [
	^self elements first
]

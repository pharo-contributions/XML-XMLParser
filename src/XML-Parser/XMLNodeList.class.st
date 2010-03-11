Class {
	#name : #XMLNodeList,
	#superclass : #OrderedCollection,
	#instVars : [
		'parent'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLNodeList class >> parent: aNodeWithChildren [
	^ self new parent: aNodeWithChildren
]

{ #category : #adding }
XMLNodeList >> add: newNode after: oldNode [
	^ self with: [super add: newNode after: oldNode] add: newNode
]

{ #category : #adding }
XMLNodeList >> add: newNode afterIndex: oldNode [
	^ self with: [super add: newNode afterIndex: oldNode] add: newNode
]

{ #category : #adding }
XMLNodeList >> add: newNode before: oldNode [
	^ self with: [super add: newNode before: oldNode] add: newNode
]

{ #category : #adding }
XMLNodeList >> add: newNode beforeIndex: oldNode [
	^ self with: [super add: newNode beforeIndex: oldNode] add: newNode
]

{ #category : #adding }
XMLNodeList >> addFirst: aNode [
	^ self with: [super addFirst: aNode] add: aNode
]

{ #category : #adding }
XMLNodeList >> addLast: aNode [
	^ self with: [super addLast: aNode] add: aNode
]

{ #category : #adding }
XMLNodeList >> at: anIndex ifAbsentPut: aValue [
	^ self
		at: anIndex
		ifAbsent: [self at: anIndex put: aValue]
]

{ #category : #adding }
XMLNodeList >> at: anIndex put: aNode [
	(self at: anIndex ifAbsent: [nil])
		ifNotNil: [self with: [super at: anIndex put: nil] remove: (self at: anIndex)].
	^ self with: [super at: anIndex put: aNode] add: aNode.
]

{ #category : #copying }
XMLNodeList >> copy [
	^ self species withAll: self
]

{ #category : #copying }
XMLNodeList >> copyEmpty [
	^ self species new: self size
]

{ #category : #errors }
XMLNodeList >> errorNodeWithParent [
	self error: 'cannot add node that is already the child of another node'. ^ nil.
]

{ #category : #accessing }
XMLNodeList >> parent [
	^ parent
]

{ #category : #accessing }
XMLNodeList >> parent: aNodeWithChildren [
	parent := aNodeWithChildren
]

{ #category : #printing }
XMLNodeList >> printOn: aStream [
	self printXMLOn: (XMLWriter on: aStream)
]

{ #category : #printing }
XMLNodeList >> printXMLOn: writer [
	self do: [:each | each printXMLOn: writer].
]

{ #category : #removing }
XMLNodeList >> remove: aNode ifAbsent: aBlock [
	^ self with: [super remove: aNode ifAbsent: [^ aBlock value]] remove: aNode
]

{ #category : #removing }
XMLNodeList >> removeAll [
	self ifEmpty: [^ self].
	self copy do: [:each | self with: [self removeFirst] remove: each]
]

{ #category : #removing }
XMLNodeList >> removeAt: anIndex [
	^ self with: [super removeAt: anIndex] remove: (self at: anIndex)
]

{ #category : #removing }
XMLNodeList >> removeFirst [
	^ self removeAt: 1
]

{ #category : #removing }
XMLNodeList >> removeLast [
	^ self removeAt: self size
]

{ #category : #copying }
XMLNodeList >> species [
	^ OrderedCollection
]

{ #category : #private }
XMLNodeList >> with: aBlock add: aNode [

	aNode hasParent ifTrue: [^ self errorNodeWithParent].

	self with: aBlock onError: [^ nil].
	self parent ifNotNil: [
		aNode parent: self parent.
		self parent addedNode: aNode toList: self].
	^ aNode.
]

{ #category : #private }
XMLNodeList >> with: aBlock onError: errorBlock [
	^ aBlock
		on: Error
		do: [:error | error signal. errorBlock valueWithPossibleArgument: error]
]

{ #category : #private }
XMLNodeList >> with: aBlock remove: aNode [

	self with: aBlock onError: [^ nil].
	aNode parent: nil.
	self parent ifNotNil: [self parent removedNode: aNode fromList: self].
	^ aNode.
]

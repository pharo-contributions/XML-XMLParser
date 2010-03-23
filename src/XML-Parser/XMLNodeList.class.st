Class {
	#name : #XMLNodeList,
	#superclass : #XMLOrderedList,
	#instVars : [
		'parent'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLNodeList class >> parent: aParentNode [
	^ self new parent: aParentNode
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
	(self at: anIndex)
		ifNotNil: [self with: [super at: anIndex put: nil] remove: (self at: anIndex)].
	^ self with: [super at: anIndex put: aNode] add: aNode.
]

{ #category : #errors }
XMLNodeList >> errorNodeWithParent [
	^ self domError: 'Cannot add node that is already the child of another node'
]

{ #category : #accessing }
XMLNodeList >> parent [
	^ parent
]

{ #category : #accessing }
XMLNodeList >> parent: aParent [
	parent := aParent
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

{ #category : #private }
XMLNodeList >> with: aBlock add: aNode [
	aNode hasParent ifTrue: [^ self errorNodeWithParent].
	self
		with: [aBlock value]
		onError: [^ nil].
	self parent ifNotNil: [self parent nodeAdded: aNode].

	^ aNode.
]

{ #category : #private }
XMLNodeList >> with: aBlock onError: errorBlock [
	^ aBlock
		on: Error
		do: [:error |
			errorBlock valueWithPossibleArgument: error.
			error signal]
]

{ #category : #private }
XMLNodeList >> with: aBlock remove: aNode [

	self
		with: [
			aBlock value.
			self parent ifNotNil: [self parent nodeRemoved: aNode]]
		onError: [^ nil].
	^ aNode.
]

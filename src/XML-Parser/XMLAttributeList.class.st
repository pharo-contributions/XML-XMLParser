Class {
	#name : #XMLAttributeList,
	#superclass : #XMLNodeList,
	#instVars : [
		'nodesByName'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #adding }
XMLAttributeList >> addName: aName value: aValue [
	^ self addLast: (XMLAttribute name: aName value: aValue)
]

{ #category : #private }
XMLAttributeList >> errorNonAttributeNode [
	^ self domError: 'Cannot contain non-attribute nodes'.
]

{ #category : #testing }
XMLAttributeList >> includesName: aString [
	^ self nodesByName includesKey: aString
]

{ #category : #accessing }
XMLAttributeList >> names [
	^ self collect: [:each | each name]
]

{ #category : #enumerating }
XMLAttributeList >> namesAndValuesDo: aBlock [
	self do: [:each | aBlock value: each name value: each value]
]

{ #category : #enumerating }
XMLAttributeList >> namesDo: aBlock [
	self do: [:each | aBlock value: each name]
]

{ #category : #accessing }
XMLAttributeList >> nodeNamed: aString [
	^ self nodeNamed: aString ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> nodeNamed: aString ifAbsent: aBlock [
	^ self nodesByName at: aString ifAbsent: aBlock
]

{ #category : #private }
XMLAttributeList >> nodeRenamed: aNode from: anOldName to: aNewName [
	self nodesByName
		removeKey: anOldName;
		at: aNewName put: aNode
]

{ #category : #accessing }
XMLAttributeList >> nodesByName [
	^ nodesByName ifNil: [nodesByName := Dictionary new: 10]
]

{ #category : #accessing }
XMLAttributeList >> removeNodeNamed: aString [
	^ self removeNodeNamed: aString ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> removeNodeNamed: aString ifAbsent: aBlock [
	^ (self remove: (self nodeNamed: aString ifAbsent: [^ aBlock value])) value
]

{ #category : #accessing }
XMLAttributeList >> valueAt: aName [
	^ self valueAt: aName ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> valueAt: aName ifAbsent: aBlock [
	^ (self nodesByName
		at: aName
		ifAbsent: [^ aBlock value]) value
]

{ #category : #accessing }
XMLAttributeList >> valueAt: aName ifAbsentPut: aValue [
	^ self
		valueAt: aName
		ifAbsent: [self valueAt: aName put: aValue]
]

{ #category : #accessing }
XMLAttributeList >> valueAt: aName put: aValue [
	(self includesName: aName)
		ifTrue: [(self nodeNamed: aName) value: aValue]
		ifFalse: [self addName: aName value: aValue].
	^ aValue.
]

{ #category : #private }
XMLAttributeList >> with: aBlock add: aNode [
	aNode isAttribute ifFalse: [^ self errorNonAttributeNode].

	(super with: aBlock add: aNode) ifNil: [^ nil].

	self nodesByName
		at: aNode name
		ifPresent: [self removeNodeNamed: aNode name].
	self nodesByName at: aNode name put: aNode.
	^ aNode.
]

{ #category : #private }
XMLAttributeList >> with: aBlock remove: aNode [
	(super with: aBlock remove: aNode) ifNil: [^ nil].
	self nodesByName removeKey: aNode name.
	^ aNode.
]

Class {
	#name : #XMLAttributeList,
	#superclass : #XMLNodeList,
	#instVars : [
		'attributesByName'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #adding }
XMLAttributeList >> addName: aName value: aValue [
	^ self addLast:
		(XMLAttribute
			name: aName
			value: aValue
			scope: self scope)
]

{ #category : #accessing }
XMLAttributeList >> attributesByName [
	^ attributesByName ifNil: [attributesByName := Dictionary new: 10]
]

{ #category : #private }
XMLAttributeList >> errorNonAttributeNode [
	^ self domError: 'cannot contain non-attribute nodes'.
]

{ #category : #testing }
XMLAttributeList >> includesName: aString [
	^ self attributesByName includesKey: aString
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
	^ self nodeNamed: aString ifAbsent: [nil]
]

{ #category : #accessing }
XMLAttributeList >> nodeNamed: aString ifAbsent: aBlock [
	^ self attributesByName at: aString ifAbsent: aBlock
]

{ #category : #accessing }
XMLAttributeList >> removeNodeNamed: aString [
	^ self removeNodeNamed: aString ifAbsent: [nil]
]

{ #category : #accessing }
XMLAttributeList >> removeNodeNamed: aString ifAbsent: aBlock [
	^ (self remove: (self nodeNamed: aString ifAbsent: [^ aBlock value])) value
]

{ #category : #private }
XMLAttributeList >> renamedNode: aNode [
	self attributesByName
		removeKey: (self attributesByName keyAtValue: aNode);
		at: aNode name put: aNode
]

{ #category : #accessing }
XMLAttributeList >> scope [
	^ self parent ifNotNil: [self parent scope]
]

{ #category : #accessing }
XMLAttributeList >> valueAt: aName [
	^ self valueAt: aName ifAbsent: [nil]
]

{ #category : #accessing }
XMLAttributeList >> valueAt: aName ifAbsent: aBlock [
	^ (self attributesByName
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
	aNode isAttribute
		ifFalse: [^ self errorNonAttributeNode].

	(super with: aBlock add: aNode) ifNil: [^ nil].

	self attributesByName
		at: aNode name
		ifPresent: [self removeNodeNamed: aNode name].
	self attributesByName at: aNode name put: aNode.
	^ aNode.
]

{ #category : #private }
XMLAttributeList >> with: aBlock remove: aNode [
	(super with: aBlock remove: aNode) ifNil: [^ nil].
	self attributesByName removeKey: aNode name.
	^ aNode.
]

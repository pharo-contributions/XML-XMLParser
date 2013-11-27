"
This class represents an ordered list of child nodes for some kind of node with elements, probably either an XML document or element object. Non-modifying accessing messages like #first and #last will never raise exceptions and return nil instead.
"
Class {
	#name : #XMLNodeList,
	#superclass : #XMLObservableList,
	#category : #'XML-Parser-Nodes'
}

{ #category : #private }
XMLNodeList >> afterAdding: aNode [
	aNode addObserver: self.
	aNode isElement
		ifTrue: [self notifyOf: #addedElement: with: aNode].
	self notifyOf: #addedNode: with: aNode.
]

{ #category : #private }
XMLNodeList >> afterRemoving: aNode [
	aNode removeObserver: self.
	aNode isElement
		ifTrue: [self notifyOf: #removedElement: with: aNode].
	self notifyOf: #removedNode: with: aNode.
]

{ #category : #private }
XMLNodeList >> beforeAdding: aNode [
	aNode hasParent
		ifTrue: [XMLDOMException signal: 'Cannot add child node that already has a parent']
]

{ #category : #accessing }
XMLNodeList >> elementAt: aName [
	^ self elementAt: aName ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLNodeList >> elementAt: aName ifAbsent: aBlock [
	^ self
		detect: [:each | each isElement and: [each isNamed: aName]]
		ifNone: aBlock
]

{ #category : #accessing }
XMLNodeList >> elementAt: aName namespaceURI: aUri [
	^ self elementAt: aName namespaceURI: aUri ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLNodeList >> elementAt: aName namespaceURI: aUri ifAbsent: aBlock [
	^ (self elementsAt: aName)
		detect: [:each | each namespaceURI = aUri]
		ifNone: aBlock
]

{ #category : #accessing }
XMLNodeList >> elements [
	^ self select: [:each | each isElement]
]

{ #category : #accessing }
XMLNodeList >> elementsAt: aName [
	^ self elementsSelect: [:each | each isNamed: aName]
]

{ #category : #accessing }
XMLNodeList >> elementsAt: aName namespaceURI: aUri [
	^ (self elementsAt: aName) select: [:each | each namespaceURI = aUri]
]

{ #category : #enumerating }
XMLNodeList >> elementsCollect: aBlock [
	^ self elements collect: aBlock
]

{ #category : #enumerating }
XMLNodeList >> elementsDetect: aBlock [
	^ self elementsDetect: aBlock ifNone: [self defaultValue]
]

{ #category : #enumerating }
XMLNodeList >> elementsDetect: aBlock ifNone: anExceptionBlock [
	^ self
		detect: [:each | each isElement and: [aBlock value: each]]
		ifNone: anExceptionBlock
]

{ #category : #enumerating }
XMLNodeList >> elementsDo: aBlock [
	self do: [:each | each isElement ifTrue: [aBlock value: each]]
]

{ #category : #enumerating }
XMLNodeList >> elementsSelect: aBlock [
	^ self select: [:each | each isElement and: [aBlock value: each]]
]

{ #category : #testing }
XMLNodeList >> hasElements [
	^ self anySatisfy: [:each | each isElement]
]

{ #category : #testing }
XMLNodeList >> includesElementAt: aName [
	^ (self elementAt: aName) notNil
]

{ #category : #private }
XMLNodeList >> renamedElement: anElement from: anOldName to: aNewName [
]

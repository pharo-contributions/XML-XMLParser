"
This class represents an ordered list of child nodes for some kind of node with elements, probably either an XML document or element object. Non-modifying accessing messages like #first and #last will never raise exceptions and return nil instead.
"
Class {
	#name : #XMLNodeList,
	#superclass : #XMLObservableList,
	#category : #'XML-Parser-DOM'
}

{ #category : #private }
XMLNodeList >> afterAdding: aNode [
	observer ifNotNil: [
		aNode isElement
			ifTrue: [observer addedElement: aNode]
			ifFalse: [observer addedNode: aNode]]
]

{ #category : #private }
XMLNodeList >> afterRemoving: aNode [
	observer ifNotNil: [
		aNode isElement
			ifTrue: [observer removedElement: aNode]
			ifFalse: [observer removedNode: aNode]]
]

{ #category : #private }
XMLNodeList >> beforeAdding: aNode [
	observer ifNotNil: [observer addingNode: aNode]
]

{ #category : #accessing }
XMLNodeList >> contentNodes [
	^ self select: [:each | each isContentNode]
]

{ #category : #enumerating }
XMLNodeList >> contentNodesDo: aBlock [
	self do: [:each | each isContentNode ifTrue: [aBlock value: each]]
]

{ #category : #accessing }
XMLNodeList >> contentStringAt: aName [
	^ (self elementAt: aName ifAbsent: [^ '']) contentString
]

{ #category : #accessing }
XMLNodeList >> elementAfter: anElement [
	| last |

	self elementsDo: [:each |
		last = anElement
			ifTrue: [^ each].
		last := each].
	^ self defaultValue.
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
	^ self
		elementAt: aName
		namespaceURI: aUri
		ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLNodeList >> elementAt: aName namespaceURI: aUri ifAbsent: aBlock [
	^ (self elementsAt: aName)
		detect: [:each | each namespaceURI = aUri]
		ifNone: aBlock
]

{ #category : #accessing }
XMLNodeList >> elementBefore: anElement [
	| last |

	last := self defaultValue.
	self elementsDo: [:each |
		each = anElement
			ifTrue: [^ last].
		last := each].
	^ self defaultValue.
]

{ #category : #accessing }
XMLNodeList >> elementNames [
	^ self elementsCollect: [:each | each name]
]

{ #category : #accessing }
XMLNodeList >> elements [
	^ self select: [:each | each isElement]
]

{ #category : #accessing }
XMLNodeList >> elementsAt: aName [
	^ self elementsSelect: [:each | each isNamed: aName]
]

{ #category : #enumerating }
XMLNodeList >> elementsAt: aName do: aBlock [
	(self elementsAt: aName) do: aBlock
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

{ #category : #accessing }
XMLNodeList >> firstElement [
	^ self
		detect: [:each | each isElement]
		ifNone: [self defaultValue]
]

{ #category : #testing }
XMLNodeList >> hasContentNodes [
	^ self anySatisfy: [:each | each isContentNode]
]

{ #category : #testing }
XMLNodeList >> hasElements [
	^ self anySatisfy: [:each | each isElement]
]

{ #category : #testing }
XMLNodeList >> hasStringNodes [
	^ self anySatisfy: [:each | each isStringNode]
]

{ #category : #testing }
XMLNodeList >> includesElement: aName [
	self elementAt: aName ifAbsent: [^ false].
	^ true.
]

{ #category : #accessing }
XMLNodeList >> lastElement [
	self reverseDo: [:each |
		each isElement
			ifTrue: [^ each]].
	^ self defaultValue.
]

{ #category : #notifications }
XMLNodeList >> renamedElement: anElement from: anOldName to: aNewName [
]

{ #category : #sorting }
XMLNodeList >> sort [
	self sort: [:a :b | a sortKey <= b sortKey]
]

{ #category : #sorting }
XMLNodeList >> sorted [
	^ self sorted: [:a :b | a sortKey <= b sortKey]
]

{ #category : #enumerating }
XMLNodeList >> stringNodes [
	^ self select: [:each | each isStringNode]
]

{ #category : #enumerating }
XMLNodeList >> stringNodesDo: aBlock [
	self do: [:each | each isStringNode ifTrue: [aBlock value: each]]
]

{ #category : #enumerating }
XMLNodeList >> strings [
	^ self
		select: [:each | each isStringNode]
		thenCollect: [:each | each string]
]

{ #category : #enumerating }
XMLNodeList >> stringsDo: aBlock [
	self stringNodesDo: [:each | aBlock value: each string]
]

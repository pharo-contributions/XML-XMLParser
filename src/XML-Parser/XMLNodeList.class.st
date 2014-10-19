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
	observer ifNil: [^ self].

	aNode isElement
		ifTrue: [observer addedElement: aNode]
		ifFalse: [observer addedNode: aNode].
]

{ #category : #private }
XMLNodeList >> afterRemoving: aNode [
	observer ifNil: [^ self].

	aNode isElement
		ifTrue: [observer removedElement: aNode]
		ifFalse: [observer removedNode: aNode].
]

{ #category : #private }
XMLNodeList >> beforeAdding: aNode [
	aNode hasParent
		ifTrue: [XMLDOMException signal: 'Cannot add child node that already has a parent']
]

{ #category : #accessing }
XMLNodeList >> elementAfter: anElement [
	| last |

	self elementsDo: [:each |
		last == anElement
			ifTrue: [^ each].
		last := each].
	^ nil.
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
XMLNodeList >> elementBefore: anElement [
	| last |
	
	self elementsDo: [:each |
		each == anElement
			ifTrue: [^ last].
		last := each].
	^ nil.
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

{ #category : #accessing }
XMLNodeList >> firstElement [
	^ self
		detect: [:each | each isElement]
		ifNone: [nil]
]

{ #category : #testing }
XMLNodeList >> hasElements [
	^ self anySatisfy: [:each | each isElement]
]

{ #category : #testing }
XMLNodeList >> includesElementAt: aName [
	^ (self elementAt: aName) notNil
]

{ #category : #accessing }
XMLNodeList >> lastElement [
	self reverseDo: [:each |
		each isElement
			ifTrue: [^ each]].
	^ nil.
]

{ #category : #notifications }
XMLNodeList >> renamedElement: anElement from: anOldName to: aNewName [
]

{ #category : #sorting }
XMLNodeList >> sort [
	self sort: [:a :b |
		(a isElement & b isElement) not
			or: [a name <= b name]]
]

{ #category : #sorting }
XMLNodeList >> sorted [
	^ self sorted: [:a :b |
		(a isElement & b isElement) not
			or: [a name <= b name]]
]

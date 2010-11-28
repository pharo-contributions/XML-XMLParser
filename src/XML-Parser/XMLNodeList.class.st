"
This class represents an ordered list of child nodes for some kind of node with elements, probably either an XML document or element object. It treats element nodes specially, keeping both an ordered list of child elements and a dictionary that allows for faster retrieval of element(s) by qualified name or local name only.

Uniquely named elements are stored directly in the dictionary, while multiple elements sharing a common local or qualified name are stored together as an ordered list in the dictionary.
"
Class {
	#name : #XMLNodeList,
	#superclass : #XMLObservableList,
	#instVars : [
		'elements',
		'elementsByName'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #private }
XMLNodeList >> afterAdding: aNode [
	aNode addObserver: self.
	aNode isElement
		ifTrue: [
			((self last == aNode) or: [(self findElementAfter: aNode) isNil])
				ifTrue: [self elementAddedAtEnd: aNode]
				ifFalse: [self elementInsertedBeforeEnd: aNode].
			self notifyOf: #addedElement: with: aNode].
	self notifyOf: #addedNode: with: aNode.
]

{ #category : #private }
XMLNodeList >> afterRemoving: aNode [
	aNode removeObserver: self.
	aNode isElement
		ifTrue: [
			self elements remove: aNode.
			self elementsByNameAt: aNode name removeElement: aNode.
			aNode hasPrefix
				ifTrue: [self elementsByNameAt: aNode localName removeElement: aNode].
			self notifyOf: #removedElement: with: aNode].
	self notifyOf: #removedNode: with: aNode.
]

{ #category : #private }
XMLNodeList >> beforeAdding: aNode [
	aNode hasParent
		ifTrue: [XMLDOMException signal: 'Cannot add child node that already has a parent']
]

{ #category : #private }
XMLNodeList >> elementAddedAtEnd: anElement [
	self elements add: anElement.
	self
		elementsByNameAt: anElement name
		addElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				elementsByNameAt: anElement localName
				addElement: anElement]
]

{ #category : #accessing }
XMLNodeList >> elementAt: aName [
	^ self elementAt: aName ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLNodeList >> elementAt: aName ifAbsent: aBlock [
	| elementsWithName |

	elementsWithName := self elementsByName at: aName ifAbsent: [^ aBlock value].

	^ elementsWithName isCollection
		ifTrue: [elementsWithName first]
		ifFalse: [elementsWithName]
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

{ #category : #private }
XMLNodeList >> elementInsertedBeforeEnd: anElement [
	| elementAfter |

	elementAfter := self findElementAfter: anElement.
	self elements add: anElement before: elementAfter.

	self elementsByNameAt: anElement name insertElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				elementsByNameAt: anElement localName
				insertElement: anElement]
]

{ #category : #accessing }
XMLNodeList >> elements [
	^ elements ifNil: [elements := self species new]
]

{ #category : #accessing }
XMLNodeList >> elementsAt: aName [
	| elementsWithName |

	elementsWithName :=
		self elementsByName
			at: aName
			ifAbsent: [^ self species new].

	^ elementsWithName isCollection
		ifTrue: [elementsWithName]
		ifFalse: [
			self elementsByName
				at: aName
				put: (self species with: elementsWithName)]
]

{ #category : #accessing }
XMLNodeList >> elementsAt: aName namespaceURI: aUri [
	^ (self elementsAt: aName) select: [:each | each namespaceURI = aUri]
]

{ #category : #private }
XMLNodeList >> elementsByName [
	^ elementsByName ifNil: [elementsByName := Dictionary new].
]

{ #category : #private }
XMLNodeList >> elementsByNameAt: aName addElement: anElement [
	| elementsWithName |

	elementsWithName := 
		self elementsByName
			at: aName
			ifAbsent: [
				self elementsByName at: aName put: anElement.
				^ self].

	elementsWithName isCollection
		ifTrue: [elementsWithName add: anElement]
		ifFalse: [
			self elementsByName
				at: aName
				put: (self species with: elementsWithName with: anElement)]
]

{ #category : #private }
XMLNodeList >> elementsByNameAt: aName insertElement: anElement [
	| elementsWithName elementAfter |

	(elementAfter := self findElementAfter: anElement withName: aName)
		ifNil: [^ self elementsByNameAt: aName addElement: anElement].

	(elementsWithName := self elementsByName at: aName)
		isCollection
			ifTrue: [elementsWithName add: anElement before: elementAfter]
			ifFalse: [
				self elementsByName
					at: aName
					put: (self species with: anElement with: elementAfter)]
]

{ #category : #private }
XMLNodeList >> elementsByNameAt: aName removeElement: anElement [
	| elementsWithName |

	(elementsWithName := self elementsByName at: aName)
		isCollection
			ifTrue: [
				elementsWithName remove: anElement.
				elementsWithName ifEmpty: [self elementsByName removeKey: aName]]
			ifFalse: [self elementsByName removeKey: aName]
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
	^ self elements detect: aBlock ifNone: anExceptionBlock
]

{ #category : #enumerating }
XMLNodeList >> elementsDo: aBlock [
	self elements do: aBlock
]

{ #category : #enumerating }
XMLNodeList >> elementsSelect: aBlock [
	^ self elements select: aBlock
]

{ #category : #private }
XMLNodeList >> findElementAfter: anElement [
	| previousElement |

	previousElement := nil.
	self do: [:each |
		each isElement
			ifTrue: [
				previousElement == anElement
					ifTrue: [^ each].
				previousElement := each]].
	^ nil.
]

{ #category : #private }
XMLNodeList >> findElementAfter: anElement withName: aName [
	| previousElementWithName |

	previousElementWithName := nil.
	self do: [:each |
		(each isElement and: [each isNamed: aName])
			ifTrue: [
				(previousElementWithName == anElement)
					ifTrue: [^ each].
				previousElementWithName := each]].
	^ nil.
]

{ #category : #testing }
XMLNodeList >> hasElements [
	^ elements notNil and: [elements notEmpty]
]

{ #category : #testing }
XMLNodeList >> includesElementNamed: aName [
	^ self elementsByName includesKey: aName
]

{ #category : #notifications }
XMLNodeList >> renamedElement: anElement from: anOldName to: aNewName [
	self elementsByNameAt: anOldName removeElement: anElement.
	anOldName splitQualifiedNameInto: [:oldPrefix :oldLocalName |
		oldPrefix ifNotEmpty: [
			self
				elementsByNameAt: oldLocalName
				removeElement: anElement]].

	self elementsByNameAt: anElement name insertElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				elementsByNameAt: anElement localName
				insertElement: anElement].
]

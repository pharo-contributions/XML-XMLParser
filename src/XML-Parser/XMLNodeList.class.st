"
This class represents an ordered list of child nodes for some kind of node with elements, probably either an XML document or element object. It treats element nodes specially, keeping both an ordered list of child elements and a dictionary that allows for faster retrieval of element(s) by qualified name or local name only.
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
XMLNodeList >> added: aNode [
	aNode addObserver: self.
	aNode isElement
		ifTrue: [
			self last == aNode
				ifTrue: [self elementAddedAtEnd: aNode]
				ifFalse: [self elementInsertedBeforeEnd: aNode].
			self notifyOf: #addedElement: with: aNode].
	self notifyOf: #addedNode: with: aNode.
]

{ #category : #private }
XMLNodeList >> adding: aNode [
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

{ #category : #private }
XMLNodeList >> elementInsertedBeforeEnd: anElement [
	| elementBefore |

	(elementBefore := self findElementBefore: anElement)
		ifNil: [self elements add: anElement]
		ifNotNil: [self elements add: anElement after: elementBefore].

	self elementsByNameAt: anElement name insertElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				elementsByNameAt: anElement localName
				insertElement: anElement]
]

{ #category : #accessing }
XMLNodeList >> elementNamed: aName [
	^ self elementNamed: aName ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLNodeList >> elementNamed: aName ifAbsent: aBlock [
	| elementsWithName |

	elementsWithName := self elementsByName at: aName ifAbsent: [^ aBlock value].

	^ elementsWithName isCollection
		ifTrue: [elementsWithName first]
		ifFalse: [elementsWithName]
]

{ #category : #accessing }
XMLNodeList >> elementNamed: aName namespaceURI: aUri [
	^ self elementNamed: aName namespaceURI: aUri ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLNodeList >> elementNamed: aName namespaceURI: aUri ifAbsent: aBlock [
	^ (self elementsNamed: aName)
		detect: [:each | each namespaceURI = aUri]
		ifNone: aBlock
]

{ #category : #accessing }
XMLNodeList >> elements [
	^ elements ifNil: [elements := self species new]
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
	| elementsWithName elementBefore |

	(elementBefore := self findElementBefore: anElement withName: aName)
		ifNil: [^ self elementsByNameAt: aName addElement: anElement].

	(elementsWithName := self elementsByName at: aName)
		isCollection
			ifTrue: [elementsWithName add: anElement after: elementBefore]
			ifFalse: [
				self elementsByName
					at: aName
					put: (self species with: elementBefore with: anElement)]
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
XMLNodeList >> elementsDo: aBlock [
	self elements do: aBlock
]

{ #category : #accessing }
XMLNodeList >> elementsNamed: aName [
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
XMLNodeList >> elementsNamed: aName namespaceURI: aUri [
	^ (self elementsNamed: aName) select: [:each | each namespaceURI = aUri]
]

{ #category : #private }
XMLNodeList >> findElementBefore: anElement [
	| elementBefore |

	elementBefore := nil.
	self do: [:each |
		each isElement
			ifTrue: [
				(each = anElement)
					ifTrue: [^ elementBefore].
				elementBefore := each]].
	^ elementBefore.
]

{ #category : #private }
XMLNodeList >> findElementBefore: anElement withName: aName [
	| lastNamedElement |

	lastNamedElement := nil.
	self do: [:each |
		(each isElement and: [each isNamed: aName])
			ifTrue: [
				(each = anElement)
					ifTrue: [^ lastNamedElement].
				lastNamedElement := each]].
	^ lastNamedElement.
]

{ #category : #testing }
XMLNodeList >> hasElements [
	^ elements notNil and: [elements notEmpty]
]

{ #category : #testing }
XMLNodeList >> includesElementNamed: aName [
	^ self elementsByName includesKey: aName
]

{ #category : #private }
XMLNodeList >> removed: aNode [
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

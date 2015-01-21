"
This is a node list that caches child elements by name, keeping both an ordered list of elements and a dictionary that allows for faster retrieval of elements by qualified or local name.

You can inject it into the DOM parser like this:
parser := XMLDOMParser on: xmlSource.
parser nodeListClass: XMLCachingNodeList.
"
Class {
	#name : #XMLCachingNodeList,
	#superclass : #XMLNodeList,
	#instVars : [
		'cachedElements',
		'cachedElementsByName'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #private }
XMLCachingNodeList >> afterAdding: aNode at: anIndex [
	aNode isElement
		ifTrue: [
			(anIndex = self size
				or: [(self findElementAfter: aNode) isNil])
				ifTrue: [self elementAddedAtEnd: aNode]
				ifFalse: [self elementInsertedBeforeEnd: aNode]].
	super
		afterAdding: aNode
		at: anIndex.
]

{ #category : #private }
XMLCachingNodeList >> afterAddingLast: aNode [
	aNode isElement
		ifTrue: [self elementAddedAtEnd: aNode].
	super afterAddingLast: aNode.
]

{ #category : #private }
XMLCachingNodeList >> afterRemoving: aNode [
	aNode isElement
		ifTrue: [
			self cachedElements remove: aNode.
			self
				cachedElementsByNameAt: aNode name
				removeElement: aNode.
			aNode hasPrefix
				ifTrue: [
					self
						cachedElementsByNameAt: aNode localName
						removeElement: aNode]].
	super afterRemoving: aNode.
]

{ #category : #private }
XMLCachingNodeList >> cachedElements [
	^ cachedElements ifNil: [cachedElements := OrderedCollection new]
]

{ #category : #private }
XMLCachingNodeList >> cachedElementsByName [
	^ cachedElementsByName ifNil: [cachedElementsByName := Dictionary new]
]

{ #category : #private }
XMLCachingNodeList >> cachedElementsByNameAt: aName addElement: anElement [
	| elementsWithName |

	elementsWithName :=
		self cachedElementsByName
			at: aName
			ifAbsent: [
				self cachedElementsByName at: aName put: anElement.
				^ self].
	 elementsWithName isCollection
		ifTrue: [elementsWithName add: anElement]
		ifFalse: [
			self cachedElementsByName
				at: aName
				put: (OrderedCollection with: elementsWithName with: anElement)].
]

{ #category : #private }
XMLCachingNodeList >> cachedElementsByNameAt: aName insertElement: anElement [
	| elementsWithName elementAfter |

	(elementAfter := self findElementAfter: anElement withName: aName)
		ifNil: [^ self cachedElementsByNameAt: aName addElement: anElement].

	(elementsWithName := self cachedElementsByName at: aName) isCollection
		ifTrue: [elementsWithName add: anElement before: elementAfter]
		ifFalse: [
			self cachedElementsByName
				at: aName
				put: (OrderedCollection with: anElement with: elementAfter)].
]

{ #category : #private }
XMLCachingNodeList >> cachedElementsByNameAt: aName removeElement: anElement [
	| elementsWithName |

	(elementsWithName := self cachedElementsByName at: aName) isCollection
		ifTrue: [
			elementsWithName remove: anElement.
			elementsWithName
				ifEmpty: [self cachedElementsByName removeKey: aName]]
		ifFalse: [self cachedElementsByName removeKey: aName]
]

{ #category : #private }
XMLCachingNodeList >> copyClass [
	"use superclass for copies for performance"
	^ XMLNodeList
]

{ #category : #private }
XMLCachingNodeList >> elementAddedAtEnd: anElement [
	self cachedElements addLast: anElement.
	self
		cachedElementsByNameAt: anElement name
		addElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				cachedElementsByNameAt: anElement localName
				addElement: anElement]
]

{ #category : #accessing }
XMLCachingNodeList >> elementAt: aName ifAbsent: aBlock [
	| elementsWithName |

	(elementsWithName :=
		self cachedElementsByName
			at: aName
			ifAbsent: [^ aBlock value]) isCollection
		ifTrue: [^ elementsWithName first]
		ifFalse: [^ elementsWithName]
]

{ #category : #private }
XMLCachingNodeList >> elementInsertedBeforeEnd: anElement [
	self cachedElements
		add: anElement
		before: (self findElementAfter: anElement).
	self
		cachedElementsByNameAt: anElement name
		insertElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				cachedElementsByNameAt: anElement localName
				insertElement: anElement].
]

{ #category : #accessing }
XMLCachingNodeList >> elements [
	^ self copyEmpty
		addAll: self cachedElements;
		yourself
]

{ #category : #accessing }
XMLCachingNodeList >> elementsAt: aName [
	| elementsWithName copiedElements |

	copiedElements := self copyEmpty.
	(elementsWithName :=
		self cachedElementsByName
			at: aName
			ifAbsent: [^ copiedElements]) isCollection
		ifTrue: [copiedElements addAll: elementsWithName]
		ifFalse: [copiedElements addLast: elementsWithName].
	^ copiedElements.
]

{ #category : #enumerating }
XMLCachingNodeList >> elementsDetect: aBlock ifNone: anExceptionBlock [
	^ self cachedElements
		detect: aBlock
		ifNone: anExceptionBlock
]

{ #category : #enumerating }
XMLCachingNodeList >> elementsDo: aBlock [
	self cachedElements do: aBlock
]

{ #category : #enumerating }
XMLCachingNodeList >> elementsSelect: aBlock [
	| selectedElements |

	selectedElements := self copyEmpty.
	self cachedElements do: [:each |
		(aBlock value: each)
			ifTrue: [selectedElements addLast: each]].
	^ selectedElements.
]

{ #category : #private }
XMLCachingNodeList >> findElementAfter: anElement [
	| previousElement |

	previousElement := nil.
	self do: [:each |
		each isElement
			ifTrue: [
				previousElement = anElement
					ifTrue: [^ each].
				previousElement := each]].
	^ nil.
]

{ #category : #private }
XMLCachingNodeList >> findElementAfter: anElement withName: aName [
	| previousElementWithName |

	previousElementWithName := nil.
	self do: [:each |
		(each isElement and: [each isNamed: aName])
			ifTrue: [
				(previousElementWithName = anElement)
					ifTrue: [^ each].
				previousElementWithName := each]].
	^ nil.
]

{ #category : #accessing }
XMLCachingNodeList >> firstElement [
	^ self cachedElements
		at: 1
		ifAbsent: [self defaultValue]
]

{ #category : #testing }
XMLCachingNodeList >> hasElements [
	^ cachedElements notNil and: [cachedElements notEmpty]
]

{ #category : #testing }
XMLCachingNodeList >> includesElement: aName [
	^ self cachedElementsByName includesKey: aName
]

{ #category : #accessing }
XMLCachingNodeList >> lastElement [
	^ self cachedElements
		at: self cachedElements size
		ifAbsent: [self defaultValue]
]

{ #category : #notifications }
XMLCachingNodeList >> renamedElement: anElement from: anOldName to: aNewName [
	| oldPrefix |

	self
		cachedElementsByNameAt: anOldName
		removeElement: anElement.
	(oldPrefix := anOldName prefixBeforeLocalName)
		ifNotEmpty: [
			self
				cachedElementsByNameAt: (anOldName localNameAfterPrefix: oldPrefix)
				removeElement: anElement].
	self
		cachedElementsByNameAt: anElement name
		insertElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				cachedElementsByNameAt: anElement localName
				insertElement: anElement].
]

{ #category : #sorting }
XMLCachingNodeList >> sort: aSortBlock [
	super sort: aSortBlock.
	self cachedElements sort: aSortBlock.
	self cachedElementsByName valuesDo: [:each |
		each isCollection
			ifTrue: [each sort: aSortBlock]].
]

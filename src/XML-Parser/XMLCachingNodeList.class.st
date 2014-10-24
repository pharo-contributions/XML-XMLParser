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
		'elements',
		'elementsByName'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #private }
XMLCachingNodeList >> afterAdding: aNode [
	aNode isElement
		ifTrue: [
			((self last == aNode) or: [(self findElementAfter: aNode) isNil])
				ifTrue: [self elementAddedAtEnd: aNode]
				ifFalse: [self elementInsertedBeforeEnd: aNode]].
	super afterAdding: aNode.
			
]

{ #category : #private }
XMLCachingNodeList >> afterRemoving: aNode [
	aNode isElement
		ifTrue: [
			self elements remove: aNode.
			self elementsByNameAt: aNode name removeElement: aNode.
			aNode hasPrefix
				ifTrue: [self elementsByNameAt: aNode localName removeElement: aNode]].
	super afterRemoving: aNode.
]

{ #category : #private }
XMLCachingNodeList >> elementAddedAtEnd: anElement [
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
XMLCachingNodeList >> elementAt: aName ifAbsent: aBlock [
	| elementsWithName |

	elementsWithName := self elementsByName at: aName ifAbsent: [^ aBlock value].

	^ elementsWithName isCollection
		ifTrue: [elementsWithName first]
		ifFalse: [elementsWithName]
]

{ #category : #private }
XMLCachingNodeList >> elementInsertedBeforeEnd: anElement [
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
XMLCachingNodeList >> elements [
	^ elements ifNil: [elements := self species new]
]

{ #category : #accessing }
XMLCachingNodeList >> elementsAt: aName [
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

{ #category : #private }
XMLCachingNodeList >> elementsByName [
	^ elementsByName ifNil: [elementsByName := Dictionary new].
]

{ #category : #private }
XMLCachingNodeList >> elementsByNameAt: aName addElement: anElement [
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
XMLCachingNodeList >> elementsByNameAt: aName insertElement: anElement [
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
XMLCachingNodeList >> elementsByNameAt: aName removeElement: anElement [
	| elementsWithName |

	(elementsWithName := self elementsByName at: aName)
		isCollection
			ifTrue: [
				elementsWithName remove: anElement.
				elementsWithName ifEmpty: [self elementsByName removeKey: aName]]
			ifFalse: [self elementsByName removeKey: aName]
]

{ #category : #enumerating }
XMLCachingNodeList >> elementsDetect: aBlock ifNone: anExceptionBlock [
	^ self elements detect: aBlock ifNone: anExceptionBlock
]

{ #category : #enumerating }
XMLCachingNodeList >> elementsDo: aBlock [
	self elements do: aBlock
]

{ #category : #enumerating }
XMLCachingNodeList >> elementsSelect: aBlock [
	^ self elements select: aBlock
]

{ #category : #private }
XMLCachingNodeList >> findElementAfter: anElement [
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
XMLCachingNodeList >> findElementAfter: anElement withName: aName [
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

{ #category : #accessing }
XMLCachingNodeList >> firstElement [
	^ self elements first
]

{ #category : #testing }
XMLCachingNodeList >> hasElements [
	^ elements notNil and: [elements notEmpty]
]

{ #category : #testing }
XMLCachingNodeList >> includesElementAt: aName [
	^ self elementsByName includesKey: aName
]

{ #category : #accessing }
XMLCachingNodeList >> lastElement [
	^ self elements last
]

{ #category : #notifications }
XMLCachingNodeList >> renamedElement: anElement from: anOldName to: aNewName [
	| oldPrefix |

	self elementsByNameAt: anOldName removeElement: anElement.
	(oldPrefix := anOldName qualifiedNamePrefix)
		ifNotEmpty: [
			self
				elementsByNameAt: (anOldName qualifiedNameLocalPartFromPrefix: oldPrefix)
				removeElement: anElement].

	self elementsByNameAt: anElement name insertElement: anElement.
	anElement hasPrefix
		ifTrue: [
			self
				elementsByNameAt: anElement localName
				insertElement: anElement].
]

{ #category : #sorting }
XMLCachingNodeList >> sort: aSortBlock [
	super sort: aSortBlock.
	self elements sort: aSortBlock.
	self elementsByName valuesDo: [:each |
		each isCollection
			ifTrue: [each sort: aSortBlock]].
]

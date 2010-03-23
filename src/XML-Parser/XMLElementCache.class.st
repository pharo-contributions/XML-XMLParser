Class {
	#name : #XMLElementCache,
	#superclass : #Object,
	#instVars : [
		'elements',
		'elementsByName'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLElementCache >> cacheElement: anElement [
	self elements add: anElement.
	self
		cacheElement: anElement
		underName: anElement localName.
	anElement hasPrefix
		ifTrue: [
			self
				cacheElement: anElement
				underName: anElement qualifiedName]
]

{ #category : #accessing }
XMLElementCache >> cacheElement: anElement underName: aName [
	(self elementsByName
		at: aName
		ifAbsentPut: [self newElementList]) add: anElement
]

{ #category : #accessing }
XMLElementCache >> elements [
	^ elements ifNil: [elements := self newElementList]
]

{ #category : #accessing }
XMLElementCache >> elementsByName [ 
	^ elementsByName ifNil: [elementsByName := Dictionary new].
]

{ #category : #accessing }
XMLElementCache >> elementsNamed: aName [
	^ self elementsByName at: aName ifAbsent: [self newElementList]
]

{ #category : #accessing }
XMLElementCache >> firstElementNamed: aName [
	^ (self elementsByName at: aName ifAbsent: [^ nil]) first
]

{ #category : #private }
XMLElementCache >> newElementList [
	^ XMLElementList new
]

{ #category : #accessing }
XMLElementCache >> rebuildCacheFrom: aList [
	self elements removeAll.
	self elementsByName removeAll.

	aList do: [:each | each isTag ifTrue: [self cacheElement: each]].
]

{ #category : #accessing }
XMLElementCache >> uncacheElement: anElement [
	self elements remove: anElement.

	self
		uncacheElement: anElement
		underName: anElement localName.
	anElement hasPrefix
		ifTrue: [
			self
				uncacheElement: anElement
				underName: anElement qualifiedName].
]

{ #category : #accessing }
XMLElementCache >> uncacheElement: anElement underName: aName [
	(self elementsByName at: aName) remove: anElement.

	(self elementsByName at: aName)
		ifEmpty: [self elementsByName removeKey: aName].
]

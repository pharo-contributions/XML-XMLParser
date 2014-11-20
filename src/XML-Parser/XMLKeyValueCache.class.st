"
A simple key-value cache that empties when full.

"
Class {
	#name : #XMLKeyValueCache,
	#superclass : #Object,
	#instVars : [
		'collection',
		'maxSize'
	],
	#category : #'XML-Parser-Util'
}

{ #category : #'instance creation' }
XMLKeyValueCache class >> collection: aCollection maxSize: anInteger [
	^ self basicNew initialize
		setCollection: aCollection
		maxSize: anInteger
]

{ #category : #private }
XMLKeyValueCache class >> defaultMaxSize [
	^ 16
]

{ #category : #'instance creation' }
XMLKeyValueCache class >> maxSize: anInteger [
	^ self
		collection: (Dictionary new: anInteger)
		maxSize: anInteger
]

{ #category : #'instance creation' }
XMLKeyValueCache class >> new [
	^ self maxSize: self defaultMaxSize
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey [
	^ self collection at: aKey
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey ifAbsent: aBlock [
	^ self collection at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey ifAbsentPut: aBlock [
	^ self collection
		at: aKey
		ifAbsent: [
			self collection size >= self maxSize
				ifTrue: [self clear].

			self collection
				at: aKey
				put: aBlock value]
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey put: aValue [
	(self collection includesKey: aKey)
		ifFalse: [
			self collection size >= self maxSize
				ifTrue: [self clear]].
	^ self collection at: aKey put: aValue.
]

{ #category : #clearing }
XMLKeyValueCache >> clear [
	self collection removeAll
]

{ #category : #accessing }
XMLKeyValueCache >> collection [
	^ collection
]

{ #category : #testing }
XMLKeyValueCache >> includesKey: aKey [
	^ self collection includesKey: aKey
]

{ #category : #testing }
XMLKeyValueCache >> isEmpty [
	^ self collection isEmpty
]

{ #category : #accessing }
XMLKeyValueCache >> maxSize [
	^ maxSize
]

{ #category : #accessing }
XMLKeyValueCache >> maxSize: anInteger [
	anInteger < maxSize
		ifTrue: [self clear].

	maxSize := anInteger.
]

{ #category : #copying }
XMLKeyValueCache >> postCopy [
	collection := collection copy
]

{ #category : #initialization }
XMLKeyValueCache >> setCollection: aCollection maxSize: anInteger [
	collection := aCollection.
	maxSize := anInteger.
]

{ #category : #accessing }
XMLKeyValueCache >> size [
	^ self collection size
]

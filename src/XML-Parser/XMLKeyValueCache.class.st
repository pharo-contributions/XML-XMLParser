"
A simple key-value cache that automatically empties when it reaches a maximum size.
"
Class {
	#name : #XMLKeyValueCache,
	#superclass : #Object,
	#instVars : [
		'collection',
		'maxSize'
	],
	#category : #'XML-Parser-Utils'
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
		collection: Dictionary new
		maxSize: anInteger
]

{ #category : #'instance creation' }
XMLKeyValueCache class >> new [
	^ self maxSize: self defaultMaxSize
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey [
	^ self
		at: aKey
		ifAbsent: [nil]
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey ifAbsent: aBlock [
	^ self collection
		at: aKey
		ifAbsent: aBlock
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

	^ self collection
		at: aKey
		put: aValue.
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

{ #category : #testing }
XMLKeyValueCache >> notEmpty [
	^ self isEmpty not
]

{ #category : #copying }
XMLKeyValueCache >> postCopy [
	super postCopy.

	collection := collection copy
]

{ #category : #printing }
XMLKeyValueCache >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self size;
		nextPut: $/;
		print: self maxSize;
		nextPut: $).
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

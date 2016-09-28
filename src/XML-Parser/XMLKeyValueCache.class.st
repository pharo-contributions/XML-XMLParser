"
A simple key-value cache that automatically empties when it reaches a maximum size. Uses a recursive mutex to ensure thread-safety.
"
Class {
	#name : #XMLKeyValueCache,
	#superclass : #Object,
	#instVars : [
		'collection',
		'maxSize',
		'mutex'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #'instance creation' }
XMLKeyValueCache class >> collection: aKeyValueCollection [
	^ self
		collection: aKeyValueCollection
		maxSize: self defaultMaxSize
]

{ #category : #'instance creation' }
XMLKeyValueCache class >> collection: aKeyValueCollection maxSize: anInteger [
	^ self basicNew initialize
		setCollection: aKeyValueCollection
		maxSize: anInteger
]

{ #category : #private }
XMLKeyValueCache class >> collectionClass [
	^ Dictionary
]

{ #category : #private }
XMLKeyValueCache class >> defaultMaxSize [
	^ 32
]

{ #category : #'instance creation' }
XMLKeyValueCache class >> maxSize: anInteger [
	^ self
		collection: self collectionClass new
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
	^ self critical: [
		collection
			at: aKey
			ifAbsent: aBlock]
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey ifAbsentPut: aBlock [
	^ self
		at: aKey
		ifAbsent: [
			self
				at: aKey
				put: aBlock value]
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey ifPresent: aBlock [
	^ self critical: [
		"Gemstone's at:ifAbsentPut: does not use cull:"
		aBlock cull:
			(collection
				at: aKey
				ifAbsent: [^ nil])]
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey ifPresent: aPresentBlock put: aValueBlock [
	"Looks up the value of aKey and if present, evaluates aPresentBlock
	optionally with it, and if aPresentBlock returns true, replaces the old
	value with the result of evaluating aValueBlock."

	^ self
		at: aKey
		ifPresent: [:value |
			(aPresentBlock cull: value)
				ifTrue: [	
					self
						at: aKey
						put: aValueBlock value]
				ifFalse: [value]]
]

{ #category : #accessing }
XMLKeyValueCache >> at: aKey put: aValue [
	^ self critical: [
		(collection includesKey: aKey)
			ifFalse: [
				collection size >= maxSize
					ifTrue: [collection removeAll]].
		collection
			at: aKey
			put: aValue]
]

{ #category : #accessing }
XMLKeyValueCache >> capacity [
	^ maxSize
]

{ #category : #clearing }
XMLKeyValueCache >> clear [
	self removeAll
]

{ #category : #accessing }
XMLKeyValueCache >> collection [
	^ collection
]

{ #category : #copying }
XMLKeyValueCache >> copy [
	^ self critical: [self shallowCopy postCopy]
]

{ #category : #'mutual exclusion' }
XMLKeyValueCache >> critical: aBlock [
	"Can be used to lock the cache during one or more operations in aBlock"

	^ mutex critical: aBlock
]

{ #category : #testing }
XMLKeyValueCache >> includesKey: aKey [
	^ self critical: [collection includesKey: aKey]
]

{ #category : #testing }
XMLKeyValueCache >> isEmpty [
	^ self size = 0
]

{ #category : #accessing }
XMLKeyValueCache >> keys [
	^ self critical: [collection keys]
]

{ #category : #enumerating }
XMLKeyValueCache >> keysAndValuesDo: aTwoArgumentBlock [
	self critical: [collection keysAndValuesDo: aTwoArgumentBlock]
]

{ #category : #enumerating }
XMLKeyValueCache >> keysDo: aBlock [
	self critical: [collection keysDo: aBlock]
]

{ #category : #accessing }
XMLKeyValueCache >> loadFactor [
	^ self size / maxSize
]

{ #category : #accessing }
XMLKeyValueCache >> maxSize [
	^ maxSize
]

{ #category : #accessing }
XMLKeyValueCache >> maxSize: anInteger [
	self critical: [| oldMaxSize |
		oldMaxSize := maxSize.
		(maxSize := anInteger) < oldMaxSize
			ifTrue: [collection removeAll]]
]

{ #category : #private }
XMLKeyValueCache >> mutex [
	^ mutex
]

{ #category : #testing }
XMLKeyValueCache >> notEmpty [
	^ self size > 0
]

{ #category : #copying }
XMLKeyValueCache >> postCopy [
	super postCopy.

	collection := collection copy.
	mutex := XMLReentrantMutexFactory new.
]

{ #category : #printing }
XMLKeyValueCache >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: self loadFactor asFraction asString.
]

{ #category : #removing }
XMLKeyValueCache >> removeAll [
	self critical: [collection removeAll]
]

{ #category : #removing }
XMLKeyValueCache >> removeKey: aKey [
	"this attempts to remove a key, but to support concurrent removal, it
	does not raise errors if it was already removed"
	^ self critical: [
		collection
			removeKey: aKey
			ifAbsent: [nil]]
]

{ #category : #removing }
XMLKeyValueCache >> removeKey: aKey ifAbsent: aBlock [
	^ self critical: [
		collection
			removeKey: aKey
			ifAbsent: aBlock]
]

{ #category : #removing }
XMLKeyValueCache >> removeKey: aKey ifPresent: aBlock [
	"Looks up the value of aKey and if present, evaluates aPresentBlock
	optionally with it, and if aPresentBlock returns true, removes the
	key from the cache and returns its old value."
	^ self
		at: aKey
		ifPresent: [:value |
			(aBlock cull: value)
				ifTrue: [self removeKey: aKey]
				ifFalse: [value]]
]

{ #category : #initialization }
XMLKeyValueCache >> setCollection: aKeyValueCollection maxSize: anInteger [
	collection := aKeyValueCollection.
	maxSize := anInteger.
	mutex := XMLReentrantMutexFactory new.
]

{ #category : #accessing }
XMLKeyValueCache >> size [
	^ collection size
]

{ #category : #accessing }
XMLKeyValueCache >> values [
	^ self critical: [collection values]
]

{ #category : #enumerating }
XMLKeyValueCache >> valuesDo: aBlock [
	self critical: [collection valuesDo: aBlock]
]

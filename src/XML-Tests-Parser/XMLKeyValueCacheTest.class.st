Class {
	#name : #XMLKeyValueCacheTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Utils'
}

{ #category : #accessing }
XMLKeyValueCacheTest >> associations [
	| associations |

	associations := Array new: self maxSize.
	1 to: associations size do: [:i |
		associations
			at: i
			put: ('key', i asString) -> ('value', i asString)].
	^ associations.
]

{ #category : #accessing }
XMLKeyValueCacheTest >> cacheClass [
	^ XMLKeyValueCache
]

{ #category : #accessing }
XMLKeyValueCacheTest >> keys [
	^ self associations collect: [:each | each key]
]

{ #category : #enumerating }
XMLKeyValueCacheTest >> keysAndValuesDo: aBlock [
	self associations do: [:each |
		aBlock
			value: each key
			value: each value]
]

{ #category : #accessing }
XMLKeyValueCacheTest >> maxSize [
	^ 20
]

{ #category : #'instance creation' }
XMLKeyValueCacheTest >> newCache [
	^ self cacheClass new
]

{ #category : #'instance creation' }
XMLKeyValueCacheTest >> newCacheWithEntries [
	| cache |

	cache := self cacheClass maxSize: self maxSize.
	self keysAndValuesDo: [:key :value |
		cache
			at: key
			put: value].
	^ cache.
]

{ #category : #asserting }
XMLKeyValueCacheTest >> should: aBlock inAnyOrderEnumerate: aCollection [
	| enumerated |

	enumerated := OrderedCollection new.
	aBlock value: [:each | enumerated addLast: each].
	self
		assert: enumerated size = aCollection size;
		assert: enumerated asSet = aCollection asSet.
]

{ #category : #asserting }
XMLKeyValueCacheTest >> should: aBlock inAnyOrderEnumerateKeysAndValues: anAssociationCollection [
	| enumerated |

	enumerated := OrderedCollection new.
	aBlock value: [:first :second |
		enumerated addLast: first -> second].
	self
		assert: enumerated size = anAssociationCollection size;
		assert: enumerated asSet = anAssociationCollection asSet.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testAt [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value |
		self assert: (cache at: key) = value].
	self assert: (cache at: 'absentKey') isNil.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testAtIfAbsent [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value |
		self assert:
			(cache
				at: key
				ifAbsent: [self fail]) = value].
	self assert:
		(cache
			at: 'absentKey'
			ifAbsent: ['absentValue']) = 'absentValue'.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testAtIfAbsentPut [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value |
		self assert:
			(cache
				at: key
				ifAbsentPut: [self fail]) = value.
		self
			assert: (cache at: key) = value;
			assert: cache size = self maxSize].
	self assert:
		(cache
			at: 'newKey'
			ifAbsentPut: ['newValue']) = 'newValue'.
	self
		assert: (cache at: 'newKey') = 'newValue';
		assert: cache size = 1.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testAtPut [
	| cache i |

	cache := self cacheClass maxSize: self maxSize.
	i := 0.
	self keysAndValuesDo: [:key :value |
		self assert:
			(cache
				at: key
				put: value) = value.
		self assert: (cache at: key) = value.

		i := i + 1.
		self assert: cache size = i].
	self assert:
		(cache
			at: 'newKey'
			put: 'newValue') = 'newValue'.
	self
		assert: (cache at: 'newKey') = 'newValue';
		assert: cache size = 1.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testClear [
	| cache |

	cache := self newCacheWithEntries.
	self deny: cache isEmpty.

	cache clear.
	self assert: cache isEmpty.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testCopy [
	| cache copy |

	cache := self newCacheWithEntries.
	copy := cache copy.
	self
		deny: cache == copy;
		assert: cache collection = copy collection;
		deny: cache collection == copy collection.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testDefaultMaxSize [
	self assert: self newCache maxSize = self cacheClass defaultMaxSize
]

{ #category : #tests }
XMLKeyValueCacheTest >> testEquals [
	self
		assert: self newCache = self newCache;
		assert: self newCacheWithEntries = self newCacheWithEntries;
		deny: self newCacheWithEntries = self newCache;
		deny: self newCache = self newCacheWithEntries
]

{ #category : #tests }
XMLKeyValueCacheTest >> testHash [
	"We can only safely test that equal objects have the same hash; testing
	that different objects have different hashes would be unreliable
	because #hash is non-cryptographic and has collisions."
	self
		assert: self newCache hash = self newCache hash;
		assert: self newCacheWithEntries hash = self newCacheWithEntries hash;
		assert:
			self newCache hash =
				(self newCacheWithEntries
					removeAll;
					hash)
]

{ #category : #tests }
XMLKeyValueCacheTest >> testIncludesKey [
	| cache |

	cache := self newCacheWithEntries.
	self keys do: [:key |
		self assert: (cache includesKey: key)].
	self deny: (cache includesKey: 'absentKey').
]

{ #category : #tests }
XMLKeyValueCacheTest >> testIsEmpty [
	self
		assert: self newCache isEmpty;
		deny: self newCacheWithEntries isEmpty
]

{ #category : #tests }
XMLKeyValueCacheTest >> testKeys [
	self
		assert: self newCache keys isEmpty;
		assert: self newCacheWithEntries keys asSet = self keys asSet
]

{ #category : #tests }
XMLKeyValueCacheTest >> testKeysAndValuesDo [
	self
		should: [:block | self newCache keysAndValuesDo: block]
		inAnyOrderEnumerateKeysAndValues: #().

	self
		should: [:block | self newCacheWithEntries keysAndValuesDo: block]
		inAnyOrderEnumerateKeysAndValues: self associations.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testKeysDo [
	self
		should: [:block | self newCache keysDo: block]
		inAnyOrderEnumerate: #().

	self
		should: [:block | self newCacheWithEntries keysDo: block]
		inAnyOrderEnumerate: self keys.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testMaxSize [
	| cache |

	cache := self newCacheWithEntries.
	self assert: cache size = self maxSize.

	cache maxSize: self maxSize + 1.
	self assert: cache size = self maxSize.

	cache maxSize: 0.
	self assert: cache size = 0.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testNotEmpty [
	self
		deny: self newCache notEmpty;
		assert: self newCacheWithEntries notEmpty
]

{ #category : #tests }
XMLKeyValueCacheTest >> testRemoveAll [
	| cache |

	cache := self newCacheWithEntries.
	self deny: cache isEmpty.

	cache removeAll.
	self assert: cache isEmpty.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testRemoveKey [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value |
		self
			assert: (cache removeKey: key) = value;
			deny: (cache includesKey: key).
		self
			should: [cache removeKey: key]
			raise: Error].
	self assert: cache isEmpty.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testRemoveKeyIfAbsent [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value |
		self assert:
			(cache
				removeKey: key
				ifAbsent: [self fail]) = value.
		self deny: (cache includesKey: key).
		self assert:
			(cache
				removeKey: key
				ifAbsent: ['absentValue']) = 'absentValue'].
	self assert: cache isEmpty.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testSize [
	self
		assert: self newCache size = 0;
		assert: self newCacheWithEntries size = self maxSize
]

{ #category : #tests }
XMLKeyValueCacheTest >> testValues [
	self
		assert: self newCache values isEmpty;
		assert: self newCacheWithEntries values asSet = self values asSet
]

{ #category : #tests }
XMLKeyValueCacheTest >> testValuesDo [
	self
		should: [:block | self newCache valuesDo: block]
		inAnyOrderEnumerate: #().

	self
		should: [:block | self newCacheWithEntries valuesDo: block]
		inAnyOrderEnumerate: self values.
]

{ #category : #accessing }
XMLKeyValueCacheTest >> values [
	^ self associations collect: [:each | each value]
]

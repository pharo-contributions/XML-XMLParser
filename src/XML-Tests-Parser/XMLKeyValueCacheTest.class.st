Class {
	#name : #XMLKeyValueCacheTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Util'
}

{ #category : #accessing }
XMLKeyValueCacheTest >> cacheClass [
	^ XMLKeyValueCache
]

{ #category : #accessing }
XMLKeyValueCacheTest >> keysAndValuesDo: aBlock [
	1 to: self maxSize do: [:i |
		aBlock
			value: ('key', i asString)
			value: ('value', i asString)]
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

{ #category : #tests }
XMLKeyValueCacheTest >> testAtIfAbsent [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value |
		self assert: (cache at: key ifAbsent: ['absent']) = value].
	self assert: (cache at: 'newkey' ifAbsent: ['absent']) = 'absent'.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testAtIfAbsentPut [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value |
		cache at: key ifAbsentPut: ['newkey'].
		self
			assert: (cache at: key) = value;
			assert: cache size = self maxSize].
	self
		assert: (cache at: 'newkey' ifAbsentPut: ['newvalue']) = 'newvalue';
		assert: (cache at: 'newkey') = 'newvalue';
		assert: cache size = 1.
]

{ #category : #tests }
XMLKeyValueCacheTest >> testAtPut [
	| cache i |

	cache := self cacheClass maxSize: self maxSize.
	i := 0.
	self keysAndValuesDo: [:key :value |
		self
			assert: (cache at: key put: value) = value;
			assert: (cache at: key) = value.
		i := i + 1.
		self assert: cache size = i].
	self
		assert: (cache at: 'newkey' put: 'newvalue') = 'newvalue';
		assert: (cache at: 'newkey') = 'newvalue';
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
XMLKeyValueCacheTest >> testDefaultMaxSize [
	self assert: self newCache maxSize = self cacheClass defaultMaxSize
]

{ #category : #tests }
XMLKeyValueCacheTest >> testIncludesKey [
	| cache |

	cache := self newCacheWithEntries.
	self keysAndValuesDo: [:key :value | self assert: (cache includesKey: key)].
	self deny: (cache includesKey: 'newkey').
]

{ #category : #tests }
XMLKeyValueCacheTest >> testIsEmpty [
	self
		assert: self newCache isEmpty;
		deny: self newCacheWithEntries isEmpty
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
XMLKeyValueCacheTest >> testSize [
	self
		assert: self newCache size = 0;
		assert: self newCacheWithEntries size = self maxSize
]

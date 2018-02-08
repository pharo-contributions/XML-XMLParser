Class {
	#name : #XMLDecodingReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> binaryInputCollection [
	^ self binaryFrom: 'test'
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> binaryInputCollectionWithBOM [
	^ self streamConverterClass byteOrderMarkBytes, self binaryInputCollection
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> binaryInvalidInputCollections [
	^ #()
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> binaryInvalidInputCollectionsWithBOM [
	^ self binaryInvalidInputCollections collect: [:each |
		self streamConverterClass byteOrderMarkBytes, each]
]

{ #category : #testing }
XMLDecodingReadStreamAdapterTest >> decodesBinaryInput [
	^ true
]

{ #category : #testing }
XMLDecodingReadStreamAdapterTest >> detectsBOMs [
	^ false
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> inputCollection [
	^ self detectsBOMs
		ifTrue: [
			self decodesBinaryInput
				ifTrue: [self binaryInputCollectionWithBOM]
				ifFalse: [self stringInputCollectionWithBOM]]
		ifFalse: [
			self decodesBinaryInput
				ifTrue: [self binaryInputCollection]
				ifFalse: [self stringInputCollection]]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> invalidInputCollections [
	^ self detectsBOMs
		ifTrue: [
			self decodesBinaryInput
				ifTrue: [self binaryInvalidInputCollectionsWithBOM]
				ifFalse: [self stringInvalidInputCollectionsWithBOM]]
		ifFalse: [
			self decodesBinaryInput
				ifTrue: [self binaryInvalidInputCollections]
				ifFalse: [self stringInvalidInputCollections]]
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapterTest >> newStreamAdapterOn: aStream [
	| adapter |

	adapter := super newStreamAdapterOn: aStream.
	self detectsBOMs
		ifTrue: [adapter detectEncoding]
		ifFalse: [adapter streamConverter: self streamConverterClass new].
	^ adapter.
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> streamAdapterClass [
	^ XMLDecodingReadStreamAdapter
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> streamCollection [
	^ self detectsBOMs
		ifTrue: [
			self decodesBinaryInput
				ifTrue: [self binaryInputCollectionWithBOM]
				ifFalse: [self stringInputCollectionWithBOM]]
		ifFalse: [
			self decodesBinaryInput
				ifTrue: [self inputCollection]
				ifFalse: [self stringInputCollection]]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> streamConverterClass [
	^ XMLNullStreamConverter
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> stringInputCollectionWithBOM [
	^ self stringFrom: self binaryInputCollectionWithBOM
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> stringInvalidInputCollections [
	^ self binaryInvalidInputCollections collect: [:each |
		self stringFrom: each]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> stringInvalidInputCollectionsWithBOM [
	^ self binaryInvalidInputCollectionsWithBOM collect: [:each |
		self stringFrom: each]
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testHasDefaultStreamConverter [
	| adapter |

	adapter := self newStreamAdapter.
	self assert:
		adapter hasDefaultStreamConverter = adapter streamConverter isDefault.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testHasImplicitStreamConverter [
	| adapter |

	adapter := self newStreamAdapter.
	self assert:
		adapter hasImplicitStreamConverter = adapter streamConverter isImplicit.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testHasNullStreamConverter [
	| adapter |

	adapter := self newStreamAdapter.
	self assert: adapter hasNullStreamConverter = adapter streamConverter isNull.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testInvalidCharacters [
	self invalidInputCollections do: [:each | | streamAdapter |
		streamAdapter := self newStreamAdapterOn: (self newStreamOn: each).
		[streamAdapter atEnd]
			whileFalse: [
				self
					should: [streamAdapter next]
					raise: XMLEncodingException].
		self assert: streamAdapter atEnd]
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testIsXMLConvertingStreamAdapter [
	self assert: self newStreamAdapter isXMLConvertingStreamAdapter
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testNonDecodingOn [
	| adapter stream |

	stream := self newStream.
	adapter := self streamAdapterClass nonDecodingOn: stream.
	self assert: adapter hasNullStreamConverter.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testNonDecodingOnIfBinaryOrExternal [
	| adapter stream |

	stream := self newStreamOn: self binaryInputCollection.
	adapter := self streamAdapterClass nonDecodingOnIfBinaryOrExternal: stream.
	self
		assert: adapter class == self streamAdapterClass;
		assert: adapter hasNullStreamConverter.

	stream := self newStreamOn: self stringInputCollection.
	adapter := self streamAdapterClass nonDecodingOnIfBinaryOrExternal: stream.
	self assert: adapter isNil.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testOn [
	| adapter stream |

	super testOn.

	stream := self newStream.
	adapter := self streamAdapterClass on: stream.
	self assert: adapter hasDefaultStreamConverter.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testOnIfBinaryOrExternal [
	| adapter stream |

	super testOnIfBinaryOrExternal.

	stream := self newStreamOn: self binaryInputCollection.
	adapter := self streamAdapterClass onIfBinaryOrExternal: stream.
	self
		assert: adapter class == self streamAdapterClass;
		assert: adapter hasDefaultStreamConverter.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testStreamConverter [
	| adapter newConverter |

	adapter := self newStreamAdapter.
	self
		deny: adapter streamConverter isNil;
		assert: adapter streamConverter class == self streamConverterClass.

	newConverter := self streamConverterClass new.
	self
		assert: (adapter streamConverter: newConverter) == adapter;
		assert: adapter streamConverter == newConverter.

	self
		assert: (adapter streamConverter: nil) == adapter;
		assert: adapter streamConverter class == XMLNullStreamConverter.
]

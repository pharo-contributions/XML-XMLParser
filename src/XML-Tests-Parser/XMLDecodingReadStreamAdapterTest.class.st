Class {
	#name : #XMLDecodingReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> binaryInputCollectionWithBOM [
	^ self binaryFrom: self inputCollectionWithBOM
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> binaryReadStreamAdapterClass [
	^ self streamAdapterClass binaryReadStreamAdapterClass
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> inputCollectionWithBOM [
	^ self streamConverterClass byteOrderMark, self inputCollection
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> invalidEncodedInputCollections [
	^ #('')
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> invalidEncodedInputCollectionsWithBOM [
	^ self invalidEncodedInputCollections collect: [:each |
		self streamConverterClass byteOrderMark, each]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> invalidStreamCollections [
	^ self invalidEncodedInputCollections
]

{ #category : #testing }
XMLDecodingReadStreamAdapterTest >> isDetecting [
	^ false
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapterTest >> newStreamAdapterOn: aStream [
	| adapter |

	adapter := super newStreamAdapterOn: aStream.
	self isDetecting
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
	^ self isDetecting
		ifTrue: [
			self isBinary
				ifTrue: [self binaryInputCollectionWithBOM]
				ifFalse: [self inputCollectionWithBOM]]
		ifFalse: [
			self isBinary
				ifTrue: [self binaryInputCollection]
				ifFalse: [self inputCollection]]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> streamConverterClass [
	^ XMLNullStreamConverter
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
	self invalidStreamCollections do: [:each | | streamAdapter |
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
XMLDecodingReadStreamAdapterTest >> testNonDecodingOnIfBinary [
	| adapter stream |

	stream := self newStreamOn: #(1).
	adapter := self streamAdapterClass nonDecodingOnIfBinary: stream.
	self
		assert: adapter class == self binaryReadStreamAdapterClass;
		assert: adapter hasNullStreamConverter.
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
XMLDecodingReadStreamAdapterTest >> testOnIfBinary [
	| adapter stream |

	super testOnIfBinary.

	stream := self newStreamOn: #(1).
	adapter := self streamAdapterClass onIfBinary: stream.
	self
		assert: adapter class == self binaryReadStreamAdapterClass;
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

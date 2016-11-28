Class {
	#name : #XMLDecodingReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> inputCollectionWithBOM [
	^ self streamConverterClass byteOrderMark, self inputCollection
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> invalidEncodedInputCollection [
	^ ''
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> invalidEncodedInputCollectionWithBOM [
	^ self streamConverterClass byteOrderMark, self invalidEncodedInputCollection
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> invalidStreamCollection [
	^ self invalidEncodedInputCollection
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
XMLDecodingReadStreamAdapterTest >> testHasNullStreamConverter [
	| adapter |

	adapter := self newStreamAdapter.
	self assert: adapter hasNullStreamConverter = adapter streamConverter isNull.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testInvalidCharacters [
	| streamAdapter |

	streamAdapter :=
		self newStreamAdapterOn:
			self invalidStreamCollection readStream.
	[streamAdapter atEnd]
		whileFalse: [
			self
				should: [streamAdapter next]
				raise: XMLEncodingException].
	self assert: streamAdapter atEnd.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testIsXMLConvertingStreamAdapter [
	self assert: self newStreamAdapter isXMLConvertingStreamAdapter
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testOn [
	| stream adapter |

	super testOn.

	stream := #(1) readStream.
	adapter := self newStreamAdapterOn: stream.
	self
		assert: adapter class == self streamAdapterClass;
		assert: adapter stream class == XMLBinaryReadStreamAdapter;
		assert: adapter stream stream == stream.
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testOnStreamIfBinary [
	| stream adapter |

	stream := '1' readStream.
	self assert: (self streamAdapterClass onStreamIfBinary: stream) == stream.

	stream upToEnd.
	self assert: (self streamAdapterClass onStreamIfBinary: stream) == stream.

	stream := #(1) readStream.
	adapter := self streamAdapterClass onStreamIfBinary: stream.
	self
		assert: adapter class == self streamAdapterClass;
		assert: adapter hasDefaultStreamConverter.

	stream upToEnd.
	self assert: (self streamAdapterClass onStreamIfBinary: stream) == stream.
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

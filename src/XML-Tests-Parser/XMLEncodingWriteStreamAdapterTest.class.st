Class {
	#name : #XMLEncodingWriteStreamAdapterTest,
	#superclass : #XMLWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterTest >> invalidInputCollections [
	"code points greater than U+10FFFF aren't tested for because Characters on GS
	can only contain values in the range of 0-10FFFF"
	^ Array
		with: (String with: 16rD800 asCharacter) "first surrogate code point"
		with: (String with: 16rDFFF asCharacter) "last surrogate code point"
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterTest >> invalidStreamCollections [
	^ #()
]

{ #category : #'instance creation' }
XMLEncodingWriteStreamAdapterTest >> newStreamAdapterOn: aStream [
	^ (super newStreamAdapterOn: aStream)
		streamConverter: self streamConverterClass new
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterTest >> streamAdapterClass [
	^ XMLEncodingWriteStreamAdapter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterTest >> streamConverterClass [
	^ XMLNullStreamConverter
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testHasDefaultStreamConverter [
	| adapter |

	adapter := self newStreamAdapter.
	self assert:
		adapter hasDefaultStreamConverter = adapter streamConverter isDefault.
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testHasNullStreamConverter [
	| adapter |

	adapter := self newStreamAdapter.
	self assert: adapter hasNullStreamConverter = adapter streamConverter isNull.
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testInvalidCharacters [
	self invalidStreamCollections do: [:each | | streamAdapter |
		streamAdapter := self newStreamAdapter.
		self
			should: [streamAdapter nextPutAll: each]
			raise: XMLEncodingException].
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testIsXMLConvertingStreamAdapter [
	self assert: self newStreamAdapter isXMLConvertingStreamAdapter
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testNextPutByteOrderMark [
	| adapter |

	adapter := self newStreamAdapter.
	self
		assert: adapter nextPutByteOrderMark == adapter;
		assert: adapter contents = self streamConverterClass byteOrderMark.
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testStreamConverter [
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

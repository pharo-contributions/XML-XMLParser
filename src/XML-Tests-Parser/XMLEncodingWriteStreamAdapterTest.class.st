Class {
	#name : #XMLEncodingWriteStreamAdapterTest,
	#superclass : #XMLWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterTest >> adapterClass [
	^ XMLEncodingWriteStreamAdapter
]

{ #category : #'instance creation' }
XMLEncodingWriteStreamAdapterTest >> newAdapterOn: aStream [
	^ (super newAdapterOn: aStream)
		streamConverter: self streamConverterClass new
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterTest >> streamConverterClass [
	^ XMLByteStreamConverter
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testHasDefaultStreamConverter [
	self streamConverterClass == XMLUTF8StreamConverter
		ifTrue: [self assert: self newAdapter hasDefaultStreamConverter]
		ifFalse: [self deny: self newAdapter hasDefaultStreamConverter]
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testIsConvertingStreamAdapter [
	self assert: self newAdapter isConvertingStreamAdapter
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testNextPutByteOrderMark [
	| adapter |

	adapter := self newAdapter.
	self assert: adapter nextPutByteOrderMark == adapter.
]

{ #category : #tests }
XMLEncodingWriteStreamAdapterTest >> testStreamConverter [
	| adapter newConverter |

	adapter := self newAdapter.
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

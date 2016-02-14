Class {
	#name : #XMLDecodingReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> adapterClass [
	^ XMLDecodingReadStreamAdapter
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapterTest >> newAdapter [
	^ super newAdapter streamConverter: self streamConverterClass new
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterTest >> streamConverterClass [
	^ XMLByteStreamConverter
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testHasDefaultStreamConverter [
	| adapter |

	adapter := self newAdapter.
	adapter streamConverter class == XMLUTF8StreamConverter
		ifTrue: [self assert: adapter hasDefaultStreamConverter]
		ifFalse: [self deny: adapter hasDefaultStreamConverter]
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testIsConvertingStreamAdapter [
	self assert: self newAdapter isConvertingStreamAdapter
]

{ #category : #tests }
XMLDecodingReadStreamAdapterTest >> testStreamConverter [
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

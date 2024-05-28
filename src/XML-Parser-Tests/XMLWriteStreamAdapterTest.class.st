Class {
	#name : 'XMLWriteStreamAdapterTest',
	#superclass : 'XMLStreamAdapterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLWriteStreamAdapterTest class >> isAbstract [
	^ false
]

{ #category : 'converting' }
XMLWriteStreamAdapterTest >> contentsFromCharacter: aCharacter [
	^ aCharacter asString
]

{ #category : 'testing' }
XMLWriteStreamAdapterTest >> isBinary [
	^ self expectsBinaryInput
]

{ #category : 'accessing' }
XMLWriteStreamAdapterTest >> streamAdapterClass [
	^ XMLWriteStreamAdapter
]

{ #category : 'accessing' }
XMLWriteStreamAdapterTest >> streamClass [
	^ WriteStream
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testCR [

	| adapter |
	adapter := self newStreamAdapter.
	self
		assert: adapter cr equals: Character cr;
		assert: adapter contents
		equals: (self contentsFromCharacter: Character cr)
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testLF [

	| adapter |
	adapter := self newStreamAdapter.
	self
		assert: adapter lf equals: Character lf;
		assert: adapter contents
		equals: (self contentsFromCharacter: Character lf)
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testNextPut [

	| adapter |
	adapter := self newStreamAdapter.
	self inputCollection do: [ :each | 
		self assert: (adapter nextPut: each) identicalTo: each ].
		self assert: adapter contents equals: self outputCollection
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testNextPutAll [

	| adapter |
	adapter := self newStreamAdapter.
	self
		assert: (adapter nextPutAll: self inputCollection)
		equals: self inputCollection;
		assert: adapter contents equals: self outputCollection
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testPosition [

	| adapter startPosition position |
	adapter := self newStreamAdapter.
	startPosition := adapter position. "1 or 0 depending on the stream on GS"
	position := startPosition.
	self inputCollection do: [ :each |
		adapter nextPut: each.
		self assert: adapter position > position.
		position := adapter position ].

	adapter position: startPosition.
	self assert: adapter position equals: startPosition
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testReset [

	| adapter startPosition |
	adapter := self newStreamAdapter.
	startPosition := adapter position. "1 or 0 depending on the stream on GS"
	adapter nextPutAll: self inputCollection.
	self
		assert: adapter reset identicalTo: adapter;
		assert: adapter position equals: startPosition
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testSpace [

	| adapter |
	adapter := self newStreamAdapter.
	self
		assert: adapter space equals: Character space;
		assert: adapter contents
		equals: (self contentsFromCharacter: Character space)
]

{ #category : 'tests' }
XMLWriteStreamAdapterTest >> testTab [

	| adapter |
	adapter := self newStreamAdapter.
	self
		assert: adapter tab equals: Character tab;
		assert: adapter contents
		equals: (self contentsFromCharacter: Character tab)
]

Class {
	#name : #XMLReadStreamAdapterTest,
	#superclass : #XMLStreamAdapterTest,
	#category : #'XML-Parser-Tests-Streams'
}

{ #category : #testing }
XMLReadStreamAdapterTest class >> isAbstract [
	^ false
]

{ #category : #testing }
XMLReadStreamAdapterTest >> isBinary [
	^ self expectsBinaryOutput
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> streamAdapterClass [
	^ XMLReadStreamAdapter
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> streamClass [
	^ XMLExceptionRaisingReadStream
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> streamCollection [
	^ self inputCollection
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testAtEnd [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection size timesRepeat: [
		self deny: adapter atEnd.
		adapter next].
	self assert: adapter atEnd
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testContents [

	| adapter |
	adapter := self newStreamAdapter.
	self outputCollection do: [ :each | "use #= because wide chars aren't #== pre-Spur"
		self
			assert: adapter peek equals: each;
			assert: adapter contents equals: self outputCollection;
			assert: adapter peek equals: each;
			assert: adapter next equals: each ].
	self assert: adapter contents equals: self outputCollection
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testNext [

	| adapter |
	adapter := self newStreamAdapter.
	self outputCollection do: [ :each | "use #= because wide chars aren't #== pre-Spur"
		self assert: adapter next equals: each ].
	self assert: adapter next isNil.

	0 to: self outputCollection size do: [ :i |
		adapter := self newStreamAdapter.
		self
			assert: (adapter next: i)
			equals: (self outputCollection copyFrom: 1 to: i) ].

	adapter := self newStreamAdapter.
	self
		assert: (adapter next: self outputCollection size + 1)
		equals: self outputCollection.
	self assert: (adapter next: 1) isEmpty
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testOnIfBinaryOrExternal [

	| basicInputCollection stream adapter |
	basicInputCollection := self basicInputCollection.
	stream := self newStreamOn: (self binaryFrom: basicInputCollection).
	adapter := self streamAdapterClass onIfBinaryOrExternal: stream.
	self assert: adapter class identicalTo: self streamAdapterClass.

	stream := self newStreamOn: (self stringFrom: basicInputCollection).
	self assert:
		(self streamAdapterClass onIfBinaryOrExternal: stream) isNil.
	[ stream atEnd ] whileFalse: [
		stream next.
		self assert:
			(self streamAdapterClass onIfBinaryOrExternal: stream) isNil ]
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testPeek [

	| adapter |
	adapter := self newStreamAdapter.
	self outputCollection do: [ :each | "use #= because wide chars aren't #== pre-Spur"
		self assert: adapter peek equals: each.
		adapter next ].
	self assert: adapter peek isNil
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testPeekFor [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection do: [:each |
		self
			deny: (adapter peekFor: #absent);
			deny: (adapter peekFor: nil);
			assert: (adapter peekFor: each);
			deny: (adapter peekFor: #absent);
			deny: (adapter peekFor: nil)].
	self
		deny: (adapter peekFor: #absent);
		deny: (adapter peekFor: nil)
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testPosition [

	| adapter startPosition endPosition position |
	adapter := self newStreamAdapter.
	startPosition := adapter position. "1 or 0 depending on the stream on GS"
	endPosition := adapter
		               upToEnd;
		               position.
	adapter := self newStreamAdapter.
	position := startPosition.
	self outputCollection do: [ :each |
		self
			assert: adapter position equals: position;
			assert: adapter peek equals: each;
			assert: adapter position equals: position;
			assert: adapter next equals: each;
			assert: adapter position > position.

		adapter peek.
		self
			assert: (adapter position: position) identicalTo: adapter;
			assert: adapter peek equals: each;
			assert: adapter position equals: position;
			assert: adapter next equals: each;
			assert: adapter position > position.
		position := adapter position ].
	self assert: position equals: endPosition
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testReset [

	| adapter |
	adapter := self newStreamAdapter.
	self
		assert: adapter upToEnd equals: self outputCollection;
		assert: adapter upToEnd isEmpty;
		assert: adapter reset identicalTo: adapter;
		assert: adapter upToEnd equals: self outputCollection;
		assert: adapter upToEnd isEmpty
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testSkip [

	| adapter |
	0 to: self outputCollection size do: [ :i |
		adapter := self newStreamAdapter.
		self
			assert: (adapter skip: i) identicalTo: adapter;
			assert: adapter upToEnd
			equals: (self outputCollection allButFirst: i) ].

	adapter := self newStreamAdapter.
	self
		assert: (adapter skip: self outputCollection size + 1)
		identicalTo: adapter;
		assert: adapter upToEnd isEmpty
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testSkipTo [

	| adapter |
	self outputCollection do: [ :each |
		adapter := self newStreamAdapter.
		self
			assert: (adapter skipTo: each);
			assert: adapter upToEnd
			equals: (self outputCollection copyAfter: each) ].

	adapter := self newStreamAdapter.
	self
		deny: (adapter skipTo: #absent);
		assert: adapter atEnd
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testUpTo [

	self outputCollection do: [ :each |
		| adapter |
		adapter := self newStreamAdapter.
		self
			assert: (adapter upTo: each)
			equals: (self outputCollection copyUpTo: each).
		self
			assert: adapter upToEnd
			equals: (self outputCollection copyAfter: each) ].
	self
		assert: (self newStreamAdapter upTo: #absent)
		equals: self outputCollection
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testUpToEnd [

	| adapter |
	self outputCollection withIndexDo: [ :each :i |
		adapter := self newStreamAdapter.
		adapter skip: i.
		self
			assert: adapter upToEnd
			equals: (self outputCollection allButFirst: i);
			assert: adapter upToEnd equals: self emptyOutputCollection ].

	adapter := self newStreamAdapter.
	self
		assert: adapter upToEnd equals: self outputCollection;
		assert: adapter upToEnd equals: self emptyOutputCollection
]

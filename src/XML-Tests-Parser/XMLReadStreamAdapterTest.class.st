Class {
	#name : #XMLReadStreamAdapterTest,
	#superclass : #XMLStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLReadStreamAdapterTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> binaryInputCollection [
	^ self binaryFrom: self inputCollection
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> binaryReadStreamAdapterClass [
	^ self streamAdapterClass
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> inputCollection [
	^ 'test'
]

{ #category : #testing }
XMLReadStreamAdapterTest >> isBinary [
	^ false
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> outputCollection [
	^ self inputCollection
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
	^ self isBinary
		ifTrue: [self binaryInputCollection]
		ifFalse: [self inputCollection]
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testAtEnd [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection size timesRepeat: [
		self deny: adapter atEnd.
		adapter next].
	self assert: adapter atEnd.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testContents [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection do: [:each |
		"use #= because wide chars aren't #== pre-Spur"
		self
			assert: adapter peek = each;
			assert: adapter contents = self outputCollection;
			assert: adapter peek = each;
			assert: adapter next = each].
	self assert: adapter contents = self outputCollection.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testNext [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection do: [:each |
		"use #= because wide chars aren't #== pre-Spur"
		self assert: adapter next = each].
	self assert: adapter next isNil.

	0 to: self outputCollection size do: [:i |
		adapter := self newStreamAdapter.
		self assert:
			(adapter next: i) =
				(self outputCollection copyFrom: 1 to: i)].

	adapter := self newStreamAdapter.
	self assert:
		(adapter next: self outputCollection size + 1) =
			self outputCollection.
	self assert: (adapter next: 1) isEmpty.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testOn [
	| stream adapter |

	stream := self newStream.
	adapter := self newStreamAdapterOn: stream.
	self isBinary
		ifTrue: [self assert: adapter class == self binaryReadStreamAdapterClass]
		ifFalse: [self assert: adapter class == self streamAdapterClass].
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testOnIfBinary [
	| stream adapter |

	stream := self newStreamOn: '1'.
	self assert: (self streamAdapterClass onIfBinary: stream) isNil.

	stream next.
	self assert: (self streamAdapterClass onIfBinary: stream) isNil.

	stream := self newStreamOn: #(1).
	adapter := self streamAdapterClass onIfBinary: stream.
	self assert: adapter class == self binaryReadStreamAdapterClass.

	stream next.
	self assert: (self streamAdapterClass onIfBinary: stream) isNil.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testPeek [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection do: [:each |
		"use #= because wide chars aren't #== pre-Spur"
		self assert: adapter peek = each.
		adapter next].
	self assert: adapter peek isNil.
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
		deny: (adapter peekFor: nil).
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testPosition [
	| adapter startPosition endPosition position |

	adapter := self newStreamAdapter.
	startPosition := adapter position. "1 or 0 depending on the stream on GS"
	endPosition :=
		adapter
			upToEnd;
			position.
	adapter := self newStreamAdapter.
	position := startPosition.
	self outputCollection do: [:each |
		self
			assert: adapter position = position;
			"use #= because wide chars aren't #== pre-Spur"
			assert: adapter peek = each;
			assert: adapter position = position;
			assert: adapter next = each;
			assert: adapter position > position.
		
		adapter peek.
		self
			assert: (adapter position: position) == adapter;
			assert: adapter peek = each;
			assert: adapter position = position;
			assert: adapter next = each;
			assert: adapter position > position.
		position := adapter position].
	self assert: position = endPosition.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testReset [
	| adapter |

	adapter := self newStreamAdapter.
	self
		assert: adapter upToEnd = self outputCollection;
		assert: adapter upToEnd isEmpty;
		assert: adapter reset == adapter;
		assert: adapter upToEnd = self outputCollection;
		assert: adapter upToEnd isEmpty.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testSkip [
	| adapter |

	0 to: self outputCollection size do: [:i |
		adapter := self newStreamAdapter.
		self
			assert: (adapter skip: i) == adapter;
			assert: adapter upToEnd = (self outputCollection allButFirst: i)].

	adapter := self newStreamAdapter.
	self
		assert: (adapter skip: self outputCollection size + 1) == adapter;
		assert: adapter upToEnd isEmpty.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testSkipTo [
	| adapter |

	self outputCollection do: [:each |
		adapter := self newStreamAdapter.
		self
			assert: (adapter skipTo: each);
			assert: adapter upToEnd = (self outputCollection copyAfter: each)].

	adapter := self newStreamAdapter.
	self
		deny: (adapter skipTo: #absent);
		assert: adapter atEnd.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testUpTo [
	self outputCollection do: [:each | | adapter |
		adapter := self newStreamAdapter.
		self assert:
			(adapter upTo: each) =
				(self outputCollection copyUpTo: each).
		self assert:
			adapter upToEnd =
				(self outputCollection copyAfter: each)].
	self assert: (self newStreamAdapter upTo: #absent) = self outputCollection.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testUpToEnd [
	| adapter |

	self outputCollection withIndexDo: [:each :i |
		adapter := self newStreamAdapter.
		adapter skip: i.
		self
			assert: adapter upToEnd = (self outputCollection allButFirst: i);
			assert: adapter upToEnd = ''].

	adapter := self newStreamAdapter.
	self
		assert: adapter upToEnd = self outputCollection;
		assert: adapter upToEnd = ''.
]

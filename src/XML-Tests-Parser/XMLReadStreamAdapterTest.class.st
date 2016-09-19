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
XMLReadStreamAdapterTest >> inputCollection [
	^ 'test'
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> outputCollection [
	^ 'test'
]

{ #category : #accessing }
XMLReadStreamAdapterTest >> streamAdapterClass [
	^ XMLReadStreamAdapter
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
	self assert: adapter atEnd.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testNext [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection do: [:each |
		self assert: adapter next = each].
	self assert: adapter next isNil.

	0 to: self outputCollection size do: [:i |
		adapter := self newStreamAdapter.
		self assert: (adapter next: i) = (self outputCollection copyFrom: 1 to: i)].

	adapter := self newStreamAdapter.
	self
		assert: (adapter next: self outputCollection size + 1) = self outputCollection;
		assert: (adapter next: 1) isEmpty.
]

{ #category : #tests }
XMLReadStreamAdapterTest >> testPeek [
	| adapter |

	adapter := self newStreamAdapter.
	self outputCollection do: [:each |
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
			assert: (adapter peekFor: each);
			deny: (adapter peekFor: #absent)].
	self deny: (adapter peekFor: #absent).
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
XMLReadStreamAdapterTest >> testStreamReadingPortability [
	| stream adapter |

	stream := XMLExceptionRaisingReadStream on: self streamCollection.
	adapter := self newStreamAdapterOn: stream.
	self outputCollection do: [:each |
		self
			deny: adapter atEnd;
			assert: adapter peek = each;
			assert: adapter next = each].
	self assert: adapter atEnd.
	self
		shouldnt: [
			adapter
				peek;
				next]
		raise: Error.
	self
		assert: adapter peek isNil;
		assert: adapter next isNil.

	self assert: stream atEnd.
	self should: [stream peek] raise: Error.
	self should: [stream next] raise: Error.
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
		adapter next: i.
		self
			assert: adapter upToEnd = (self outputCollection allButFirst: i);
			assert: adapter upToEnd = ''].
	adapter := self newStreamAdapter.
	self
		assert: adapter upToEnd = self outputCollection;
		assert: adapter upToEnd = ''.
]

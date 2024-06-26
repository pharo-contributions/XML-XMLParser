"
Abstract, do not run.
"
Class {
	#name : 'XMLAbstractReadStreamTest',
	#superclass : 'TestCase',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLAbstractReadStreamTest class >> isAbstract [
	^ true
]

{ #category : 'testing' }
XMLAbstractReadStreamTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'accessing' }
XMLAbstractReadStreamTest >> inputCollection [
	^ #()
]

{ #category : 'instance creation' }
XMLAbstractReadStreamTest >> newStream [
	^ self newStreamOn: self inputCollection
]

{ #category : 'instance creation' }
XMLAbstractReadStreamTest >> newStreamOn: aCollection [
	^ self streamClass on: aCollection
]

{ #category : 'accessing' }
XMLAbstractReadStreamTest >> outputCollection [
	^ self inputCollection
]

{ #category : 'accessing' }
XMLAbstractReadStreamTest >> streamClass [
	^ XMLAbstractReadStream
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testAtEnd [
	| stream |

	stream := self newStream.
	self outputCollection size timesRepeat: [
		self deny: stream atEnd.
		stream next].
	self assert: stream atEnd
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testClose [

	| stream |
	stream := self newStream.
	self
		assert: stream close identicalTo: stream;
		assert: stream atEnd
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testContents [

	| stream |
	stream := self newStream.
	self outputCollection do: [ :each | "use #= because wide chars aren't #== pre-Spur"
		self
			assert: stream peek equals: each;
			assert: stream contents equals: self outputCollection;
			assert: stream peek equals: each;
			assert: stream next equals: each ].
	self assert: stream contents equals: self outputCollection
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testIsBinary [
	self deny: self newStream isBinary
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testIsStream [
	self assert: self newStream isStream
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testIsXMLBinaryOrExternalStream [

	| stream |
	stream := self newStream.
	self
		assert: stream isXMLBinaryOrExternalStream
		equals: stream isBinary
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testNew [
	self
		should: [self streamClass new]
		raise: Error
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testNext [

	| stream |
	stream := self newStream.
	self outputCollection do: [ :each | "use #= because wide chars aren't #== pre-Spur"
		self assert: stream next equals: each ].
	self assert: stream next isNil.

	0 to: self outputCollection size do: [ :i |
		stream := self newStream.
		self
			assert: (stream next: i)
			equals: (self outputCollection copyFrom: 1 to: i) ].

	stream := self newStream.
	self
		assert: (stream next: self outputCollection size + 1)
		equals: self outputCollection.
	self assert: (stream next: 1) isEmpty
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testPeek [

	| stream |
	stream := self newStream.
	self outputCollection do: [ :each | "use #= because wide chars aren't #== pre-Spur"
		self assert: stream peek equals: each.
		stream next ].
	self assert: stream peek isNil
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testPeekFor [
	| stream |

	stream := self newStream.
	self outputCollection do: [:each |
		self
			deny: (stream peekFor: #absent);
			deny: (stream peekFor: nil);
			assert: (stream peekFor: each);
			deny: (stream peekFor: #absent);
			deny: (stream peekFor: nil)].
	self
		deny: (stream peekFor: #absent);
		deny: (stream peekFor: nil)
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testPosition [

	| stream startPosition endPosition position |
	stream := self newStream.
	startPosition := stream position. "1 or 0 depending on the stream on GS"
	endPosition := stream
		               upToEnd;
		               position.
	stream := self newStream.
	position := startPosition.
	self outputCollection do: [ :each |
		self
			assert: stream position equals: position;
			assert: stream peek equals: each;
			assert: stream position equals: position;
			assert: stream next equals: each;
			assert: stream position > position.

		stream peek.
		self
			assert: (stream position: position) identicalTo: stream;
			assert: stream peek equals: each;
			assert: stream position equals: position;
			assert: stream next equals: each;
			assert: stream position > position.
		position := stream position ].
	self assert: position equals: endPosition
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testReset [

	| stream |
	stream := self newStream.
	self
		assert: stream upToEnd equals: self outputCollection;
		assert: stream upToEnd isEmpty;
		assert: stream reset identicalTo: stream;
		assert: stream upToEnd equals: self outputCollection;
		assert: stream upToEnd isEmpty
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testSkip [

	| stream |
	0 to: self outputCollection size do: [ :i |
		stream := self newStream.
		self
			assert: (stream skip: i) identicalTo: stream;
			assert: stream upToEnd
			equals: (self outputCollection allButFirst: i) ].

	stream := self newStream.
	self
		assert: (stream skip: self outputCollection size + 1)
		identicalTo: stream;
		assert: stream upToEnd isEmpty
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testSkipTo [

	| stream |
	self outputCollection do: [ :each |
		stream := self newStream.
		self
			assert: (stream skipTo: each);
			assert: stream upToEnd
			equals: (self outputCollection copyAfter: each) ].

	stream := self newStream.
	self
		deny: (stream skipTo: #absent);
		assert: stream atEnd
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testUpTo [

	self outputCollection do: [ :each |
		| stream |
		stream := self newStream.
		self
			assert: (stream upTo: each)
			equals: (self outputCollection copyUpTo: each).
		self
			assert: stream upToEnd
			equals: (self outputCollection copyAfter: each) ].
	self
		assert: (self newStream upTo: #absent)
		equals: self outputCollection
]

{ #category : 'tests' }
XMLAbstractReadStreamTest >> testUpToEnd [

	| stream |
	self outputCollection withIndexDo: [ :each :i |
		stream := self newStream.
		stream skip: i.
		self
			assert: stream upToEnd
			equals: (self outputCollection allButFirst: i);
			assert: stream upToEnd equals: '' ].

	stream := self newStream.
	self
		assert: stream upToEnd equals: self outputCollection;
		assert: stream upToEnd equals: ''
]

Class {
	#name : #XMLNullReadStreamTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #'instance creation' }
XMLNullReadStreamTest >> newStream [
	^ self streamClass new
]

{ #category : #accessing }
XMLNullReadStreamTest >> streamClass [
	^ XMLNullReadStream
]

{ #category : #tests }
XMLNullReadStreamTest >> testAtEnd [
	self assert: self newStream atEnd
]

{ #category : #tests }
XMLNullReadStreamTest >> testClose [
	| stream |

	stream := self newStream.
	self
		shouldnt: [
			stream
				close;
				close]
		raise: Error.
]

{ #category : #tests }
XMLNullReadStreamTest >> testContents [
	| stream |

	stream := self newStream.
	self
		assert: stream contents = '';
		assert: stream contents = ''.
]

{ #category : #tests }
XMLNullReadStreamTest >> testIsBinary [
	self deny: self newStream isBinary
]

{ #category : #tests }
XMLNullReadStreamTest >> testIsStream [
	self assert: self newStream isStream
]

{ #category : #tests }
XMLNullReadStreamTest >> testNext [
	| stream |

	stream := self newStream.
	self
		assert: stream next isNil;
		assert: stream next isNil.
]

{ #category : #tests }
XMLNullReadStreamTest >> testPeek [
	| stream |

	stream := self newStream.
	self assert: stream peek isNil.

	stream next.
	self assert: stream peek isNil.
]

{ #category : #tests }
XMLNullReadStreamTest >> testPosition [
	| stream |

	stream := self newStream.
	self
		assert: stream position = 0;
		assert: (stream position: 1) == stream;
		assert: stream position = 0.
]

{ #category : #tests }
XMLNullReadStreamTest >> testUpToEnd [
	| stream |

	stream := self newStream.
	self
		assert: stream upToEnd = '';
		assert: stream upToEnd = ''.
]

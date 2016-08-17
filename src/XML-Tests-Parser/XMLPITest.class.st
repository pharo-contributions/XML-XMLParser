Class {
	#name : #XMLPITest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLPITest >> nodeClass [
	^ XMLPI
]

{ #category : #tests }
XMLPITest >> testAcceptNodeVisitor [
	| visitor pi message |

	visitor := XMLRecordingNodeVisitor new.
	pi := self nodeClass new.
	self
		assert: (pi acceptNodeVisitor: visitor) == pi;
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector == #visitPI:;
		assert: message arguments = (Array with: pi);
		deny: visitor messageRecorder hasMessages.
]

{ #category : #tests }
XMLPITest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self assert:
		((self nodeClass target: 'one' data: 'two')
			canonicallyEquals: (self nodeClass target: 'one' data: 'two')).
	self deny: ((self nodeClass target: 'one' data: 'two') canonicallyEquals: self nodeClass new).
]

{ #category : #tests }
XMLPITest >> testData [
	| pi |

	pi := self nodeClass new.
	self assert: pi data isEmpty.
	pi data: 'test'.
	self assert: pi data = 'test'.
]

{ #category : #tests }
XMLPITest >> testIsPI [
	self assert: self nodeClass new isPI
]

{ #category : #tests }
XMLPITest >> testSortKey [
	self assert: (self nodeClass new target: 'test') sortKey = 'test'
]

{ #category : #tests }
XMLPITest >> testTarget [
	| pi |

	pi := self nodeClass new.
	self assert: pi target isEmpty.
	pi target: 'test'.
	self assert: pi target = 'test'.
]

{ #category : #tests }
XMLPITest >> testTargetData [
	| pi |

	pi := self nodeClass target: 'target' data: 'data'.
	self
		assert: pi target = 'target';
		assert: pi data = 'data'.
]

{ #category : #tests }
XMLPITest >> testWriteXMLOn [
	self
		assert: (self nodeClass target: 'target' data: 'data') printString = '<?target data?>';
		assert: (self nodeClass target: 'target ' data: ' data') printString = '<?target   data?>'.
]

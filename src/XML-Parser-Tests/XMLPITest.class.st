Class {
	#name : 'XMLPITest',
	#superclass : 'XMLNodeTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'instance creation' }
XMLPITest >> newPIWithTargetAndData [
	^ self nodeClass
		target: 'target'
		data: 'data'
]

{ #category : 'accessing' }
XMLPITest >> nodeClass [
	^ XMLPI
]

{ #category : 'tests' }
XMLPITest >> testAcceptNodeVisitor [

	| visitor pi message |
	visitor := XMLRecordingNodeVisitor new.
	pi := self newNode.
	self
		assert: (pi acceptNodeVisitor: visitor) identicalTo: pi;
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector identicalTo: #visitPI:;
		assert: message arguments equals: (Array with: pi);
		deny: visitor messageRecorder hasMessages
]

{ #category : 'tests' }
XMLPITest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self assert:
		(self newPIWithTargetAndData canonicallyEquals:
			self newPIWithTargetAndData).
	self deny:
		(self newPIWithTargetAndData canonicallyEquals:
			self newNode)
]

{ #category : 'tests' }
XMLPITest >> testData [

	| pi |
	pi := self newNode.
	self
		assert: pi data equals: '';
		assert: (pi data: 'test') identicalTo: pi;
		assert: pi data equals: 'test'
]

{ #category : 'tests' }
XMLPITest >> testHasData [
	| pi |

	pi := self newNode.
	self deny: pi hasData.

	pi data: 'data'.
	self assert: pi hasData.

	pi data: ''.
	self deny: pi hasData
]

{ #category : 'tests' }
XMLPITest >> testIsPI [
	self assert: self newNode isPI
]

{ #category : 'tests' }
XMLPITest >> testSortKey [

	self assert: self newPIWithTargetAndData sortKey equals: 'target'
]

{ #category : 'tests' }
XMLPITest >> testTarget [

	| pi |
	pi := self newNode.
	self
		assert: pi target equals: '';
		assert: (pi target: 'test') identicalTo: pi;
		assert: pi target equals: 'test'
]

{ #category : 'tests' }
XMLPITest >> testTargetData [

	| pi |
	pi := self nodeClass target: 'target' data: 'data'.
	self
		assert: pi class identicalTo: self nodeClass;
		assert: pi target equals: 'target';
		assert: pi data equals: 'data'
]

{ #category : 'tests' }
XMLPITest >> testWriteXMLOn [

	| pi |
	pi := self newPIWithTargetAndData.
	self assert: pi printString equals: '<?target data?>'.

	pi data: ' ' , pi data.
	self assert: pi printString equals: '<?target  data?>'
]

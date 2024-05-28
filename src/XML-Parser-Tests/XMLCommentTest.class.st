Class {
	#name : 'XMLCommentTest',
	#superclass : 'XMLNodeTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'accessing' }
XMLCommentTest >> nodeClass [
	^ XMLComment
]

{ #category : 'tests' }
XMLCommentTest >> testAcceptNodeVisitor [

	| visitor comment message |
	visitor := XMLRecordingNodeVisitor new.
	comment := self newNode.
	self
		assert: (comment acceptNodeVisitor: visitor) identicalTo: comment;
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector identicalTo: #visitComment:;
		assert: message arguments equals: (Array with: comment);
		deny: visitor messageRecorder hasMessages
]

{ #category : 'tests' }
XMLCommentTest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self assert:
		((self nodeClass string: 'test') canonicallyEquals:
			(self nodeClass string: 'test')).
	self deny:
		((self nodeClass string: 'test') canonicallyEquals:
			self newNode)
]

{ #category : 'tests' }
XMLCommentTest >> testIsComment [
	self assert: self newNode isComment
]

{ #category : 'tests' }
XMLCommentTest >> testSortKey [

	self assert: (self nodeClass string: 'test') sortKey equals: 'test'
]

{ #category : 'tests' }
XMLCommentTest >> testString [

	| comment |
	comment := self nodeClass string: self markupString.
	self
		assert: comment class identicalTo: self nodeClass;
		assert: comment string equals: self markupString.

	comment := self newNode.
	self assert: comment string equals: ''.

	comment string: self markupString.
	self assert: comment string equals: self markupString.

	comment string: ''.
	self assert: comment string equals: ''
]

{ #category : 'tests' }
XMLCommentTest >> testWriteXMLOn [

	self
		assert: self newNode printString equals: '<!---->';
		assert: (self nodeClass string: self markupString) printString
		equals: '<!--' , self markupString , '-->'
]

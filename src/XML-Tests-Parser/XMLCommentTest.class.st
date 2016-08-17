Class {
	#name : #XMLCommentTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLCommentTest >> nodeClass [
	^ XMLComment
]

{ #category : #tests }
XMLCommentTest >> testAcceptNodeVisitor [
	| visitor comment message |

	visitor := XMLRecordingNodeVisitor new.
	comment := self nodeClass new.
	self
		assert: (comment acceptNodeVisitor: visitor) == comment;
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector == #visitComment:;
		assert: message arguments = (Array with: comment);
		deny: visitor messageRecorder hasMessages.
]

{ #category : #tests }
XMLCommentTest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self
		assert: ((self nodeClass string: 'test') canonicallyEquals: (self nodeClass string: 'test'));
		deny: ((self nodeClass string: 'test') canonicallyEquals: self nodeClass new).
]

{ #category : #tests }
XMLCommentTest >> testIsComment [
	self assert: self nodeClass new isComment
]

{ #category : #tests }
XMLCommentTest >> testSortKey [
	self assert: (self nodeClass string: 'test') sortKey = 'test'
]

{ #category : #tests }
XMLCommentTest >> testString [
	| comment |

	comment := self nodeClass new.
	self assert: comment string isEmpty.
	comment string: self markupString.
	self assert: comment string = self markupString.

	self assert: (self nodeClass string: self markupString) string = self markupString.
]

{ #category : #tests }
XMLCommentTest >> testWriteXMLOn [
	self
		assert: self nodeClass new printString = '<!---->';
		assert: (self nodeClass string: self markupString) printString = ('<!--', self markupString, '-->')
]

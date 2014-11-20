Class {
	#name : #XMLCommentTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #assertions }
XMLCommentTest >> assertComment: aComment hasString: aString [
	self
		assert: aComment string = aString;
		assert: aComment printString = ('<!--', aString, '-->')
]

{ #category : #accessing }
XMLCommentTest >> nodeClass [
	^ XMLComment
]

{ #category : #tests }
XMLCommentTest >> test6commentNodes [
	| comment  |

	comment := XMLComment new.
	self
		assertComment: comment hasString: '';
		assertComment: (comment string: 'test') hasString: 'test';
		assertComment: (XMLComment string: 'test') hasString: 'test'.
]

{ #category : #tests }
XMLCommentTest >> testIsComment [
	self assert: self nodeClass new isComment
]

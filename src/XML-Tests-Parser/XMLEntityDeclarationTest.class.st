"
Abstract, do not run.
"
Class {
	#name : #XMLEntityDeclarationTest,
	#superclass : #XMLDeclarationNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLEntityDeclarationTest class >> isAbstract [
	^ true
]

{ #category : #accessing }
XMLEntityDeclarationTest >> nodeClass [
	^ XMLEntityDeclaration
]

{ #category : #tests }
XMLEntityDeclarationTest >> testIsParameter [
	self deny: self nodeClass new isParameter
]

{ #category : #tests }
XMLEntityDeclarationTest >> testName [
	self
		assert: self nodeClass new name isEmpty;
		assert: (self nodeClass new name: 'test') name = 'test'
]

{ #category : #tests }
XMLEntityDeclarationTest >> testNamePublicIDSystemID [
	| declaration |

	declaration := self nodeClass name: 'one' publicID: 'two' systemID: 'three'.
	self
		assert: declaration name = 'one';
		assert: declaration publicID = 'two';
		assert: declaration systemID = 'three'.
]

{ #category : #tests }
XMLEntityDeclarationTest >> testNameReplacement [
	| declaration |

	declaration := self nodeClass name: 'one' replacement: 'two'.
	self
		assert: declaration name = 'one';
		assert: declaration replacement = 'two'.
]

{ #category : #tests }
XMLEntityDeclarationTest >> testPublicID [
	self
		assert: self nodeClass new publicID isEmpty;
		assert: (self nodeClass new publicID: 'test') publicID = 'test'
]

{ #category : #tests }
XMLEntityDeclarationTest >> testReplacement [
	self
		assert: self nodeClass new replacement isEmpty;
		assert: (self nodeClass new replacement: 'test') replacement = 'test'
]

{ #category : #tests }
XMLEntityDeclarationTest >> testSystemID [
	self
		assert: self nodeClass new systemID isEmpty;
		assert: (self nodeClass new systemID: 'test') systemID = 'test'
]

Class {
	#name : #XMLNotationDeclarationTest,
	#superclass : #XMLDeclarationNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLNotationDeclarationTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLNotationDeclarationTest >> nodeClass [
	^ XMLNotationDeclaration
]

{ #category : #tests }
XMLNotationDeclarationTest >> testName [
	self
		assert: self nodeClass new name isEmpty;
		assert: (self nodeClass new name: 'test') name = 'test'
]

{ #category : #tests }
XMLNotationDeclarationTest >> testNamePublicIDSystemID [
	| declaration |

	declaration := self nodeClass name: 'one' publicID: 'two' systemID: 'three'.
	self
		assert: declaration name = 'one';
		assert: declaration publicID = 'two';
		assert: declaration systemID = 'three'.
]

{ #category : #tests }
XMLNotationDeclarationTest >> testPublicID [
	self
		assert: self nodeClass new publicID isEmpty;
		assert: (self nodeClass new publicID: 'test') publicID = 'test'
]

{ #category : #tests }
XMLNotationDeclarationTest >> testSystemID [
	self
		assert: self nodeClass new systemID isEmpty;
		assert: (self nodeClass new systemID: 'test') systemID = 'test'
]

{ #category : #tests }
XMLNotationDeclarationTest >> testWriteXMLOn [
	self assert:
		(self nodeClass name: 'one' publicID: 'two' systemID: 'three') printString =
			'<!NOTATION one PUBLIC "two" "three">'.
	self assert:
		(self nodeClass name: 'one' publicID: '' systemID: 'two') printString =
			'<!NOTATION one SYSTEM "two">'.
	self assert:
		(self nodeClass name: 'one' publicID: 'two' systemID: '') printString =
			'<!NOTATION one PUBLIC "two">'.
]

Class {
	#name : 'XMLNotationDeclarationTest',
	#superclass : 'XMLDeclarationNodeTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'testing' }
XMLNotationDeclarationTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLNotationDeclarationTest >> nodeClass [
	^ XMLNotationDeclaration
]

{ #category : 'tests' }
XMLNotationDeclarationTest >> testName [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration name equals: '';
		assert: (declaration name: 'test') identicalTo: declaration;
		assert: declaration name equals: 'test'
]

{ #category : 'tests' }
XMLNotationDeclarationTest >> testNamePublicIDSystemID [

	| declaration |
	declaration := self nodeClass
		               name: 'one'
		               publicID: 'two'
		               systemID: 'three'.
	self
		assert: declaration class identicalTo: self nodeClass;
		assert: declaration name equals: 'one';
		assert: declaration publicID equals: 'two';
		assert: declaration systemID equals: 'three'
]

{ #category : 'tests' }
XMLNotationDeclarationTest >> testPublicID [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration publicID equals: '';
		assert: (declaration publicID: 'test') identicalTo: declaration;
		assert: declaration publicID equals: 'test'
]

{ #category : 'tests' }
XMLNotationDeclarationTest >> testSystemID [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration systemID equals: '';
		assert: (declaration systemID: 'test') identicalTo: declaration;
		assert: declaration systemID equals: 'test'
]

{ #category : 'tests' }
XMLNotationDeclarationTest >> testWriteXMLOn [

	self
		assert:
			(self nodeClass name: 'one' publicID: 'two' systemID: 'three')
				printString
		equals: '<!NOTATION one PUBLIC "two" "three">'.
	self
		assert:
		(self nodeClass name: 'one' publicID: '' systemID: 'two')
			printString
		equals: '<!NOTATION one SYSTEM "two">'.
	self
		assert:
		(self nodeClass name: 'one' publicID: 'two' systemID: '')
			printString
		equals: '<!NOTATION one PUBLIC "two">'
]

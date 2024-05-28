"
Abstract, do not run.
"
Class {
	#name : 'XMLEntityDeclarationTest',
	#superclass : 'XMLDeclarationNodeTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'accessing' }
XMLEntityDeclarationTest >> nodeClass [
	^ XMLEntityDeclaration
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testIsExternal [
	| declaration |

	declaration := self newNode.
	self deny: declaration isExternal.

	declaration systemID: 'test'.
	self assert: declaration isExternal.

	declaration publicID: 'test'.
	self assert: declaration isExternal.

	declaration systemID: ''.
	self assert: declaration isExternal.

	declaration publicID: ''.
	self deny: declaration isExternal
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testIsParameter [
	self deny: self newNode isParameter
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testIsUnparsed [
	self deny: self newNode isUnparsed
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testName [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration name equals: '';
		assert: (declaration name: 'test') identicalTo: declaration;
		assert: declaration name equals: 'test'
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testNamePublicIDSystemID [

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
XMLEntityDeclarationTest >> testNameReplacement [

	| declaration |
	declaration := self nodeClass name: 'one' replacement: 'two'.
	self
		assert: declaration class identicalTo: self nodeClass;
		assert: declaration name equals: 'one';
		assert: declaration replacement equals: 'two'
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testPublicID [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration publicID equals: '';
		assert: (declaration publicID: 'test') identicalTo: declaration;
		assert: declaration publicID equals: 'test'
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testReplacement [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration replacement equals: '';
		assert: (declaration replacement: 'test') identicalTo: declaration;
		assert: declaration replacement equals: 'test'
]

{ #category : 'tests' }
XMLEntityDeclarationTest >> testSystemID [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration systemID equals: '';
		assert: (declaration systemID: 'test') identicalTo: declaration;
		assert: declaration systemID equals: 'test'
]

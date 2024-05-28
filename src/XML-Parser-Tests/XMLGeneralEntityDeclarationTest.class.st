Class {
	#name : 'XMLGeneralEntityDeclarationTest',
	#superclass : 'XMLEntityDeclarationTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'testing' }
XMLGeneralEntityDeclarationTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLGeneralEntityDeclarationTest >> nodeClass [
	^ XMLGeneralEntityDeclaration
]

{ #category : 'tests' }
XMLGeneralEntityDeclarationTest >> testIsUnparsed [
	super testIsUnparsed.

	self assert: (self newNode ndata: 'test') isUnparsed
]

{ #category : 'tests' }
XMLGeneralEntityDeclarationTest >> testNData [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration ndata equals: '';
		assert: (declaration ndata: 'test') identicalTo: declaration;
		assert: declaration ndata equals: 'test'
]

{ #category : 'tests' }
XMLGeneralEntityDeclarationTest >> testNamePublicIDSystemIDNdata [

	| declaration |
	declaration := self nodeClass
		               name: 'one'
		               publicID: 'two'
		               systemID: 'three'
		               ndata: 'four'.
	self
		assert: declaration class identicalTo: self nodeClass;
		assert: declaration name equals: 'one';
		assert: declaration publicID equals: 'two';
		assert: declaration systemID equals: 'three';
		assert: declaration ndata equals: 'four'
]

{ #category : 'tests' }
XMLGeneralEntityDeclarationTest >> testWriteXMLOn [

	self
		assert: (self nodeClass name: 'one' replacement: 'two') printString
		equals: '<!ENTITY one "two">'.
	self
		assert:
			(self nodeClass name: 'one' publicID: 'two' systemID: 'three')
				printString
		equals: '<!ENTITY one PUBLIC "two" "three">'.
	self
		assert: (self nodeClass name: 'one' publicID: '' systemID: 'three')
				printString
		equals: '<!ENTITY one SYSTEM "three">'.
	self
		assert: (self nodeClass
				 name: 'one'
				 publicID: 'two'
				 systemID: 'three'
				 ndata: 'four') printString
		equals: '<!ENTITY one PUBLIC "two" "three" NDATA four>'
]

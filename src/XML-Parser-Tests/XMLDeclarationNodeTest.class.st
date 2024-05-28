"
Abstract, do not run.
"
Class {
	#name : 'XMLDeclarationNodeTest',
	#superclass : 'XMLNodeTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'testing' }
XMLDeclarationNodeTest class >> isAbstract [
	^ true
]

{ #category : 'accessing' }
XMLDeclarationNodeTest >> nodeClass [
	^ XMLDeclarationNode
]

{ #category : 'tests' }
XMLDeclarationNodeTest >> testIsDeclaration [
	self assert: self newNode isDeclaration
]

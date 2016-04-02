"
This class allocates namespace scopes with a stack. Sending #enterScope pushes a new scope onto the stack that inherits all mappings from the previous (enclosing) scope, and #exitScop pops it off.
"
Class {
	#name : #XMLNamespaceScopeAllocator,
	#superclass : #Object,
	#instVars : [
		'scopes'
	],
	#category : #'XML-Parser-Namespaces'
}

{ #category : #accessing }
XMLNamespaceScopeAllocator >> currentScope [
	^ self scopes xmlLastOrNil ifNil: [self emptyScope]
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> currentScope: aScope [
	self scopes addLast: aScope
]

{ #category : #private }
XMLNamespaceScopeAllocator >> emptyScope [
	^ XMLNamespaceScope new
]

{ #category : #scope }
XMLNamespaceScopeAllocator >> enterScope [
	^ self scopes addLast: self currentScope copy
]

{ #category : #scope }
XMLNamespaceScopeAllocator >> exitScope [
	^ self scopes removeLast
]

{ #category : #testing }
XMLNamespaceScopeAllocator >> hasCurentScope [
	^ scopes notEmpty
]

{ #category : #initialization }
XMLNamespaceScopeAllocator >> initialize [
	super initialize.
	scopes := OrderedCollection new: 10.
]

{ #category : #printing }
XMLNamespaceScopeAllocator >> printOn: aStream [
	super printOn: aStream.
	self hasCurentScope
		ifTrue: [
			aStream
				nextPut: $(;
				print: self currentScope;
				nextPut: $)].
]

{ #category : #private }
XMLNamespaceScopeAllocator >> scopes [
	^ scopes
]

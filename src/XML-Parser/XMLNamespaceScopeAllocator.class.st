"
This class handles the allocation of namespace scopes using a stack. Sending #enterScope to an instance will cause it to push a new scope onto the stack that inherits all mappings from the previous, enclosing scope and makes it the current scope. Sending #exitScop causes that scope to be removed and the parent scope to again be the current scope.
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
	"for speed"
	^ self scopes size > 0
		ifTrue: [scopes at: scopes size]
		ifFalse: [self emptyScope]
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

{ #category : #accessing }
XMLNamespaceScopeAllocator >> scopes [
	^ scopes ifNil: [scopes := OrderedCollection new: 10]
]

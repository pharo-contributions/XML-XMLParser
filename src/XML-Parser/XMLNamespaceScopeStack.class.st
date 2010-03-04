"
A XMLNamespaceScopeStack keeps track of XMLNamespaceScopes. Sending #enterScope will cause an instance to push a new scope onto the stack that inherits all bindings from the current enclosing scope. Sending #leaveScop causes that scope to be removed.
"
Class {
	#name : #XMLNamespaceScopeStack,
	#superclass : #Object,
	#instVars : [
		'scopes'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLNamespaceScopeStack >> currentLevel [
	^ self scopes size
]

{ #category : #accessing }
XMLNamespaceScopeStack >> currentScope [
	^ self scopes
		at: self currentLevel
		ifAbsent: [self emptyScope]
]

{ #category : #scope }
XMLNamespaceScopeStack >> declareNamespace: aNamespace uri: aUri [
	"Declare the given name space prefix with the given URL"

	self currentScope bindNamespace: aNamespace to: aUri
]

{ #category : #accessing }
XMLNamespaceScopeStack >> defaultNamespace [
	^ self currentScope defaultNamespace
]

{ #category : #private }
XMLNamespaceScopeStack >> emptyScope [
	^ XMLNamespaceScope new
]

{ #category : #accessing }
XMLNamespaceScopeStack >> enclosingScope [
	^ self scopes
		at: self scopes size - 1
		ifAbsent: [self emptyScope]
]

{ #category : #scope }
XMLNamespaceScopeStack >> enterScope [
	self pushScope: (XMLNamespaceScope enclosingScope: self currentScope)
]

{ #category : #testing }
XMLNamespaceScopeStack >> isBoundNamespace: aNamespace [
	^ self currentScope isBoundNamespace: aNamespace
]

{ #category : #testing }
XMLNamespaceScopeStack >> isNamespace: aNamespace boundTo: aUri [
	^ self currentScope isNamespace: aNamespace boundTo: aUri
]

{ #category : #scope }
XMLNamespaceScopeStack >> leaveScope [
	self popScope
]

{ #category : #accessing }
XMLNamespaceScopeStack >> popScope [
	self scopes removeLast
]

{ #category : #accessing }
XMLNamespaceScopeStack >> pushScope: aScope [
	self scopes add: aScope
]

{ #category : #accessing }
XMLNamespaceScopeStack >> resolveNamespace: aNamespace [
	^ self currentScope resolveNamespace: aNamespace
]

{ #category : #accessing }
XMLNamespaceScopeStack >> resolveNamespace: aNamespace ifUnbound: aBlock [
	^ self currentScope resolveNamespace: aNamespace ifUnbound: aBlock
]

{ #category : #accessing }
XMLNamespaceScopeStack >> scopes [
	^ scopes ifNil: [scopes := OrderedCollection new: 20]
]

{ #category : #validation }
XMLNamespaceScopeStack >> validateAttributes: attributeList [
	self currentScope validateAttributes: attributeList
]

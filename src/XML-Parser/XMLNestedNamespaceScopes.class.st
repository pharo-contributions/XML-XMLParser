"
An XMLNestedNamespaceScopes represents a stack of XMLNamespaceScopes. Sending #enterScope to an instance will cause it to push a new scope onto the stack that inherits all bindings from the previous, enclosing scope. Sending #leaveScop causes that scope to be removed.
"
Class {
	#name : #XMLNestedNamespaceScopes,
	#superclass : #Object,
	#instVars : [
		'scopes'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLNestedNamespaceScopes >> currentLevel [
	^ self scopes size
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> currentScope [
	^ self scopes
		at: self currentLevel
		ifAbsent: [self emptyScope]
]

{ #category : #scope }
XMLNestedNamespaceScopes >> declareNamespace: aPrefix uri: aUri [
	"Declare the given name space prefix with the given URL"

	self currentScope mapPrefix: aPrefix to: aUri
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> defaultNamespace [
	^ self currentScope defaultNamespace
]

{ #category : #private }
XMLNestedNamespaceScopes >> emptyScope [
	^ XMLNamespaceScope new
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> enclosingScope [
	^ self scopes
		at: self scopes size - 1
		ifAbsent: [self emptyScope]
]

{ #category : #scope }
XMLNestedNamespaceScopes >> enterScope [
	self pushScope: (XMLNamespaceScope enclosingScope: self currentScope)
]

{ #category : #testing }
XMLNestedNamespaceScopes >> isMappedPrefix: aPrefix [
	^ self currentScope isMappedPrefix: aPrefix
]

{ #category : #testing }
XMLNestedNamespaceScopes >> isPrefix: aPrefix mappedTo: aUri [
	^ self currentScope isPrefix: aPrefix mappedTo: aUri
]

{ #category : #scope }
XMLNestedNamespaceScopes >> leaveScope [
	self popScope
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> popScope [
	self scopes removeLast
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> pushScope: aScope [
	self scopes add: aScope
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> resolvePrefix: aPrefix [
	^ self currentScope resolvePrefix: aPrefix
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> resolvePrefix: aPrefix ifUnmapped: aBlock [
	^ self currentScope resolvePrefix: aPrefix ifUnmapped: aBlock
]

{ #category : #accessing }
XMLNestedNamespaceScopes >> scopes [
	^ scopes ifNil: [scopes := OrderedCollection new: 20]
]

{ #category : #validation }
XMLNestedNamespaceScopes >> validateAttributes: attributeList [
	self currentScope validateAttributes: attributeList
]

{ #category : #validation }
XMLNestedNamespaceScopes >> validatePrefix: aPrefix [
	self currentScope validatePrefix: aPrefix
]

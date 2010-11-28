"
This class represents a stack of XMLNamespaceScopes. Sending #enterScope to an instance will cause it to push a new scope onto the stack that inherits all mappings from the previous, enclosing scope. Sending #leaveScop causes that scope to be removed.
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
	^ self scopes
		at: self scopes size
		ifAbsent: [self emptyScope]
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> currentScope: aScope [
	^ self pushScope: aScope
]

{ #category : #scope }
XMLNamespaceScopeAllocator >> declarePrefix: aPrefix uri: aUri [
	"Declare the given name space prefix with the given URL"

	self currentScope mapPrefix: aPrefix to: aUri
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> defaultNamespace [
	^ self currentScope defaultNamespace
]

{ #category : #private }
XMLNamespaceScopeAllocator >> emptyScope [
	^ XMLNamespaceScope new
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> enclosingScope [
	^ self scopes
		at: self scopes size - 1
		ifAbsent: [self emptyScope]
]

{ #category : #scope }
XMLNamespaceScopeAllocator >> enterScope [
	self pushScope: (XMLNamespaceScope enclosingScope: self currentScope)
]

{ #category : #scope }
XMLNamespaceScopeAllocator >> exitScope [
	self popScope
]

{ #category : #testing }
XMLNamespaceScopeAllocator >> includesPrefix: aPrefix [
	^ self currentScope includesPrefix: aPrefix
]

{ #category : #testing }
XMLNamespaceScopeAllocator >> includesPrefix: aPrefix mappedTo: aUri [
	^ self currentScope includesPrefix: aPrefix mappedTo: aUri
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> popScope [
	self scopes removeLast
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> pushScope: aScope [
	self scopes addLast: aScope
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> resolvePrefix: aPrefix [
	^ self currentScope resolvePrefix: aPrefix
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> resolvePrefix: aPrefix ifUnmapped: aBlock [
	^ self currentScope resolvePrefix: aPrefix ifUnmapped: aBlock
]

{ #category : #accessing }
XMLNamespaceScopeAllocator >> scopes [
	^ scopes ifNil: [scopes := OrderedCollection new: 20]
]

{ #category : #validation }
XMLNamespaceScopeAllocator >> validatePrefix: aPrefix ofElementName: anElementName [
	self currentScope
		validatePrefix: aPrefix
		ofElementName: anElementName
]

{ #category : #validation }
XMLNamespaceScopeAllocator >> validatePrefixedAttributeNames: aDictionary [
	self currentScope validatePrefixedAttributeNames: aDictionary.
]

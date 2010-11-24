"
This class represents a stack of XMLNamespaceScopes. Sending #enterScope to an instance will cause it to push a new scope onto the stack that inherits all mappings from the previous, enclosing scope. Sending #leaveScop causes that scope to be removed.
"
Class {
	#name : #XMLNamespaceScopeManager,
	#superclass : #Object,
	#instVars : [
		'scopes'
	],
	#category : #'XML-Parser-Namespaces'
}

{ #category : #accessing }
XMLNamespaceScopeManager >> currentScope [
	^ self scopes
		at: self scopes size
		ifAbsent: [self emptyScope]
]

{ #category : #scope }
XMLNamespaceScopeManager >> declarePrefix: aPrefix uri: aUri [
	"Declare the given name space prefix with the given URL"

	self currentScope mapPrefix: aPrefix to: aUri
]

{ #category : #accessing }
XMLNamespaceScopeManager >> defaultNamespace [
	^ self currentScope defaultNamespace
]

{ #category : #private }
XMLNamespaceScopeManager >> emptyScope [
	^ XMLNamespaceScope new
]

{ #category : #accessing }
XMLNamespaceScopeManager >> enclosingScope [
	^ self scopes
		at: self scopes size - 1
		ifAbsent: [self emptyScope]
]

{ #category : #scope }
XMLNamespaceScopeManager >> enterScope [
	self pushScope: (XMLNamespaceScope enclosingScope: self currentScope)
]

{ #category : #scope }
XMLNamespaceScopeManager >> exitScope [
	self popScope
]

{ #category : #testing }
XMLNamespaceScopeManager >> includesPrefix: aPrefix [
	^ self currentScope includesPrefix: aPrefix
]

{ #category : #testing }
XMLNamespaceScopeManager >> includesPrefix: aPrefix mappedTo: aUri [
	^ self currentScope includesPrefix: aPrefix mappedTo: aUri
]

{ #category : #accessing }
XMLNamespaceScopeManager >> popScope [
	self scopes removeLast
]

{ #category : #accessing }
XMLNamespaceScopeManager >> pushScope: aScope [
	self scopes addLast: aScope
]

{ #category : #accessing }
XMLNamespaceScopeManager >> resolvePrefix: aPrefix [
	^ self currentScope resolvePrefix: aPrefix
]

{ #category : #accessing }
XMLNamespaceScopeManager >> resolvePrefix: aPrefix ifUnmapped: aBlock [
	^ self currentScope resolvePrefix: aPrefix ifUnmapped: aBlock
]

{ #category : #accessing }
XMLNamespaceScopeManager >> scopes [
	^ scopes ifNil: [scopes := OrderedCollection new: 20]
]

{ #category : #validation }
XMLNamespaceScopeManager >> validatePrefix: aPrefix ofElementName: anElementName [
	self currentScope
		validatePrefix: aPrefix
		ofElementName: anElementName
]

{ #category : #validation }
XMLNamespaceScopeManager >> validatePrefixedAttributeNames: aDictionary [
	self currentScope validatePrefixedAttributeNames: aDictionary.
]

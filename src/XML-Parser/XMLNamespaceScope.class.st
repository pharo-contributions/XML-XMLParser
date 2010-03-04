"
An XMLNamespaceScope is a set of bindings between namespaces prefixes and URIs, and also a default URI. Scopes can be created from other scopes by sending #enclosingScope: to XMLNamespaceScope with the other XMLNamespaceScope as the argument.
"
Class {
	#name : #XMLNamespaceScope,
	#superclass : #Object,
	#instVars : [
		'currentBindings',
		'defaultNamespace'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLNamespaceScope class >> enclosingScope: aScope [
	^ self new inheritBindingsFromScope: aScope
]

{ #category : #accessing }
XMLNamespaceScope >> aliasesFor: namespace [
	"Locate all namespaces that are aliases of the given URI."
	| uri |

	uri := self
		namespaceURIOf: namespace
		ifAbsent: [self errorUndefinedAttributeNamespace: namespace asString].

	^ (self boundNamespaces select: [:ns |
		(self isNamespace: ns boundTo: uri)
			and: [ns ~= namespace]]) asSet
]

{ #category : #accessing }
XMLNamespaceScope >> bindNamespace: aNamespace to: aUri [
	((aNamespace = 'xmlns') or: [aNamespace isEmptyOrNil])
		ifTrue: [self defaultNamespace: aUri]
		ifFalse: [self currentBindings at: aNamespace put: aUri]
]

{ #category : #enumerating }
XMLNamespaceScope >> bindingsDo: aTwoArgumentBlock [
	self boundNamespaces do: [:namespace |
		aTwoArgumentBlock
			value: namespace
			value: (self resolveNamespace: namespace)]
]

{ #category : #accessing }
XMLNamespaceScope >> boundNamespaces [
	^ self currentBindings keys asSortedCollection
]

{ #category : #accessing }
XMLNamespaceScope >> currentBindings [
	^ currentBindings ifNil: [currentBindings := Dictionary new]
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace [
	^ defaultNamespace
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace: aNamespaceUri [
	defaultNamespace := aNamespaceUri
]

{ #category : #errors }
XMLNamespaceScope >> errorAttribute: anAttribute isAliasFor: anAlias withURI: aNamespaceUri [
	self error: ('Attributes ', anAttribute, ' and ',
		anAlias, ' are aliased to namespace ', aNamespaceUri)
]

{ #category : #errors }
XMLNamespaceScope >> errorUndefinedAttributeNamespace: aNamespace [
	self error: 'Attribute refers to undefined namespace ', aNamespace
]

{ #category : #initializing }
XMLNamespaceScope >> inheritBindingsFromScope: anEnclosingScope. [
	self defaultNamespace
		ifNil: [self defaultNamespace: anEnclosingScope defaultNamespace].

	anEnclosingScope bindingsDo: [:prefix :uri |
		(self isBoundNamespace: prefix)
			ifFalse: [self bindNamespace: prefix to: uri]].
]

{ #category : #testing }
XMLNamespaceScope >> isBoundNamespace: aNamespace [
	^ self currentBindings includesKey: aNamespace
]

{ #category : #testing }
XMLNamespaceScope >> isNamespace: aNamespace boundTo: aUri [
	^ ((self isBoundNamespace: aNamespace)
		and: [(self resolveNamespace: aNamespace) = aUri])
]

{ #category : #accessing }
XMLNamespaceScope >> resolveNamespace: aNamespace [
	"Retrieve the URI of the given namespace prefix, if it is defined. A nil namespace
	returns the global namespace"

	^ self resolveNamespace: aNamespace ifUnbound: [nil]
]

{ #category : #accessing }
XMLNamespaceScope >> resolveNamespace: aNamespace ifUnbound: aBlock [
	"Retrieve the URI of the given namespace prefix, if it is defined. 
	A nil namespace returns the default namespace. 
	If no namespace can be found the value of the block is returned"

	^ (aNamespace isEmptyOrNil or: [aNamespace = 'xmlns'])
		ifTrue: [self defaultNamespace]
		ifFalse: [self currentBindings at: aNamespace ifAbsent: aBlock]
]

{ #category : #validation }
XMLNamespaceScope >> validateAttributes: attributeList [
	"check all attribute namespaces are defined and not duplicated by aliasing"
	| namespace localName qualifiedAlias |

	attributeList keysDo: [:attrName |
		attrName splitQualifiedNameInto: [:ns :ln |
			namespace := ns.
			localName := ln].
		namespace ifNotNil: [
			(self currentScope aliasesFor: namespace) do: [:alias |
				qualifiedAlias := alias , ':' , localName.
				(attributeList includesKey: qualifiedAlias)
					ifTrue: [
						self
							errorAttribute: attrName
							isAliasFor: qualifiedAlias
							withURI: (self resolveNamespace: namespace)]]]]
]

"
A namespace scope is a possibly empty set of mappings from namespace prefixes to URIs and an optional default namespace URI to be used for unprefixed elements. Scopes can be created from other scopes by copying.
"
Class {
	#name : #XMLNamespaceScope,
	#superclass : #Object,
	#instVars : [
		'defaultNamespace',
		'prefixMappings'
	],
	#category : #'XML-Parser-Namespaces'
}

{ #category : #comparing }
XMLNamespaceScope >> = anObject [
	^ self == anObject
		or: [self class == anObject class
			and: [self defaultNamespace = anObject defaultNamespace
				and: [self prefixMappings = anObject prefixMappings]]]
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace [
	"Rather than lazily initializing this to an empty string, we leave it as nil, so we can
	distinguish between no default namespace being set and an empty default namespace
	intended to override a non-empty declaration in a parent."

	^ defaultNamespace ifNil: ['']
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace: aUri [
	aUri = self xmlNamespaceURI
		ifTrue: [XMLNamespaceException signal: 'Cannot use "xml" namespace URI as default namespace'].
	aUri = self xmlnsNamespaceURI
		ifTrue: [XMLNamespaceException signal: 'Cannot use "xmlns" namespace URI as default namespace'].

	defaultNamespace := aUri.
]

{ #category : #testing }
XMLNamespaceScope >> hasDefaultNamespace [
	^ defaultNamespace notNil
]

{ #category : #testing }
XMLNamespaceScope >> hasNamespaces [
	^ defaultNamespace notNil or: [prefixMappings notNil and: [prefixMappings notEmpty]]
]

{ #category : #testing }
XMLNamespaceScope >> hasPrefixMappings [
	^ prefixMappings notNil and: [prefixMappings notEmpty]
]

{ #category : #comparing }
XMLNamespaceScope >> hash [
	^ self defaultNamespace hash bitXor: self prefixMappings hash
]

{ #category : #testing }
XMLNamespaceScope >> includesPrefix: aPrefix [
	^ self prefixMappings includesKey: aPrefix
]

{ #category : #testing }
XMLNamespaceScope >> includesPrefix: aPrefix mappedTo: aUri [
	^ (self includesPrefix: aPrefix)
		and: [(self resolvePrefix: aPrefix) = aUri]
]

{ #category : #initializing }
XMLNamespaceScope >> inheritMappingsFrom: anEnclosingScope [
	anEnclosingScope hasNamespaces
		ifFalse: [^ self].

	(anEnclosingScope defaultNamespace notEmpty and: [self hasDefaultNamespace not])
		ifTrue: [self defaultNamespace: anEnclosingScope defaultNamespace].

	anEnclosingScope hasPrefixMappings
		ifTrue: [
			anEnclosingScope prefixesAndURIsDo: [:prefix :uri |
				(self includesPrefix: prefix)
					ifFalse: [self mapPrefix: prefix to: uri]]].
]

{ #category : #accessing }
XMLNamespaceScope >> mapPrefix: aPrefix to: aUri [
	aPrefix isEmptyOrNil
		ifTrue: [^ self defaultNamespace: aUri].
	aUri isEmptyOrNil
		ifTrue: [XMLNamespaceException signal: 'Cannot clear prefix by mapping it to nil or an empty string.'].

	aPrefix = 'xml'
		ifTrue: [
			aUri = self xmlNamespaceURI
				ifFalse: [
					XMLNamespaceException signal:
						'Cannot rebind the "xml" prefix to a different namespace URI'].
			^ self].

	aPrefix = 'xmlns'
		ifTrue: [XMLNamespaceException signal: 'Cannot bind "xmlns" prefix at all'].

	(aUri = self xmlNamespaceURI or: [aUri = self xmlnsNamespaceURI])
		ifTrue: [XMLNamespaceException signal: 'Cannot alias the "xml" or "xmlns" prefixes'].

	self prefixMappings at: aPrefix put: aUri.
]

{ #category : #copying }
XMLNamespaceScope >> postCopy [
	defaultNamespace ifNotNil: [defaultNamespace := defaultNamespace copy].
	prefixMappings ifNotNil: [prefixMappings := prefixMappings copy].
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := OrderPreservingDictionary new: 5 withDefaultValue: '']
]

{ #category : #accessing }
XMLNamespaceScope >> prefixes [
	^ self prefixMappings keys
]

{ #category : #enumerating }
XMLNamespaceScope >> prefixesAndURIsDo: aTwoArgumentBlock [
	self prefixMappings keysAndValuesDo: aTwoArgumentBlock
]

{ #category : #accessing }
XMLNamespaceScope >> resolvePrefix: aPrefix [
	^ self resolvePrefix: aPrefix ifUnmapped: ['']
]

{ #category : #accessing }
XMLNamespaceScope >> resolvePrefix: aPrefix ifUnmapped: aBlock [
	(aPrefix isNil or: [aPrefix isEmpty])
		ifTrue: [^ self defaultNamespace].

	^ self prefixMappings
		at: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self xmlNamespaceURI]
				ifFalse: [
					aPrefix = 'xmlns'
						ifTrue: [self xmlnsNamespaceURI]
						ifFalse: [aBlock value]]]
]

{ #category : #accessing }
XMLNamespaceScope >> unmapPrefix: aPrefix [
	self prefixMappings
		removeKey: aPrefix
		ifAbsent: [XMLNamespaceException signal: 'Prefix ', aPrefix, ' cannot be unmapped']
]

{ #category : #private }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix ofName: aName [
	aPrefix = 'xmlns'
		ifTrue: [
			XMLNamespaceException signal:
				'Cannot use reserved "xmlns" prefix in "', aName, '"'].
	^ self
		resolvePrefix:  aPrefix
		ifUnmapped: [
			XMLNamespaceException signal:
				'Unmapped prefix "', aPrefix, '" in "', aName, '"'].
]

{ #category : #validation }
XMLNamespaceScope >> validateAttributePrefixes: aDictionary [
	"performance critical method"
	| namespacedAttributes |

	aDictionary keysDo: [:each | | prefix |
		(prefix := each qualifiedNamePrefix) isEmpty
			ifFalse: [ | namespace oldSize |
				"not initialized unless needed"
				namespacedAttributes
					ifNil: [namespacedAttributes := Set new: aDictionary size].
				namespace := self validateAndResolvePrefix: prefix ofName: each.

				"checking size after is faster than an includes: hash lookup"
				oldSize := namespacedAttributes size.
				namespacedAttributes add: namespace, (each qualifiedNameLocalPart: prefix).
				namespacedAttributes size > oldSize
					ifFalse: [
						XMLNamespaceException signal:
							'Attribute "', each, '" has alias for namespace "', namespace. '"']]].
]

{ #category : #accessing }
XMLNamespaceScope >> xmlNamespaceURI [
	^ 'http://www.w3.org/XML/1998/namespace'
]

{ #category : #accessing }
XMLNamespaceScope >> xmlnsNamespaceURI [
	^ 'http://www.w3.org/2000/xmlns/'
]

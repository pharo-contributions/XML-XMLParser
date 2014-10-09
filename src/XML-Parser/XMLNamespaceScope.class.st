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

{ #category : #'predefined namespaces' }
XMLNamespaceScope class >> xmlNamespaceURI [
	^ 'http://www.w3.org/XML/1998/namespace'
]

{ #category : #'predefined namespaces' }
XMLNamespaceScope class >> xmlnsNamespaceURI [
	^ 'http://www.w3.org/2000/xmlns/'
]

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
	aUri = self class xmlNamespaceURI
		ifTrue: [XMLNamespaceException signal: 'Cannot use "xml" namespace URI as default namespace'].
	aUri = self class xmlnsNamespaceURI
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

	(anEnclosingScope hasDefaultNamespace and: [self hasDefaultNamespace not])
		ifFalse: [self defaultNamespace: anEnclosingScope defaultNamespace].
	anEnclosingScope hasPrefixMappings
		ifTrue: [
			anEnclosingScope prefixesAndURIsDo: [:prefix :uri |
				(self includesPrefix: prefix)
					ifFalse: [self mapPrefix: prefix to: uri]]].
]

{ #category : #accessing }
XMLNamespaceScope >> mapPrefix: aPrefix to: aUri [
	aPrefix isEmpty
		ifTrue: [^ self defaultNamespace: aUri].
	(aPrefix at: 1) == $x "skip comparisons below"
		ifTrue: [
			aPrefix = 'xml'
				ifTrue: [
					aUri = self class xmlNamespaceURI
						ifTrue: [^ self].
					XMLNamespaceException signal:
						'Cannot rebind the "xml" prefix to a different namespace URI'].
			aPrefix = 'xmlns'
				ifTrue: [XMLNamespaceException signal: 'Cannot bind "xmlns" prefix at all']].
	(aPrefix indexOf: $:) > 0 
		ifTrue: [XMLNamespaceException signal: 'Prefix "', aPrefix, '" contains ":" character'].

	aUri isEmpty
		ifTrue: [XMLNamespaceException signal: 'Empty URIs cannot be mapped to prefixes'].
	(aUri = self class xmlNamespaceURI or: [aUri = self class xmlnsNamespaceURI])
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
	aPrefix isEmpty
		ifTrue: [^ self defaultNamespace].

	^ self prefixMappings
		at: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self class xmlNamespaceURI]
				ifFalse: [
					aPrefix = 'xmlns'
						ifTrue: [self class xmlnsNamespaceURI]
						ifFalse: [aBlock value]]]
]

{ #category : #accessing }
XMLNamespaceScope >> unmapPrefix: aPrefix [
	(aPrefix = 'xml' or: [aPrefix = 'xmlns'])
		ifTrue: [XMLNamespaceException signal: 'Cannot unmap "xmlns" or "xml" prefixes'].

	self prefixMappings
		removeKey: aPrefix
		ifAbsent: [
			XMLNamespaceException signal:
				'Prefix "', aPrefix, '" was not mapped and cannot be unmapped']
]

{ #category : #private }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix [
	^ self prefixMappings
		at: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self class xmlNamespaceURI]
				ifFalse: [
					aPrefix isEmpty
						ifTrue: [self defaultNamespace]
						ifFalse: [
							XMLNamespaceException signal:
								((aPrefix = 'xmlns')
									ifTrue: ['Cannot use reserved "xmlns" prefix for elements or attributes']
									ifFalse: ['Unmapped namespace prefix "', aPrefix, '" in name'])]]]
]

{ #category : #validation }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix ofElement: aName [
	aPrefix isEmpty
		ifTrue: [
			self validateUnprefixedName: aName.
			^ self defaultNamespace]
		ifFalse: [^ self validateAndResolvePrefix: aPrefix]
]

{ #category : #validation }
XMLNamespaceScope >> validateAttributePrefixes: aDictionary [
	"performance critical method"
	| namespacedAttributes |

	aDictionary keysDo: [:each | | prefix |
		(prefix := each qualifiedNamePrefix) isEmpty "avoid ifNotEmpty: closure overhead"
			ifTrue: [self validateUnprefixedName: each]
			ifFalse: [ | namespace oldSize |
				"not initialized unless needed"
				namespacedAttributes
					ifNil: [namespacedAttributes := Set new: aDictionary size].
				namespace := self validateAndResolvePrefix: prefix.

				"checking size after is faster than includes:"
				oldSize := namespacedAttributes size.
				namespacedAttributes add: namespace, (each qualifiedNameLocalPartFromPrefix: prefix).
				namespacedAttributes size > oldSize
					ifFalse: [
						XMLNamespaceException signal:
							'Attribute "', each, '" has alias for namespace "', namespace, '"']]].
]

{ #category : #private }
XMLNamespaceScope >> validateUnprefixedName: aName [
	"catch names like ':name' with an empty prefix"
	(aName size > 0
		and: [(aName at: 1) == $:])
		ifTrue: [XMLNamespaceException signal: 'Name "', aName, '" contains ":" character'].
]

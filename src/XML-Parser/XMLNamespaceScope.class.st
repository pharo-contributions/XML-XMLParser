"
A namespace scope is a possibly empty set of mappings from namespace prefixes to URIs and an optional default namespace URI to be used for unprefixed elements. Scopes can be created from other scopes by copying.
"
Class {
	#name : #XMLNamespaceScope,
	#superclass : #Object,
	#instVars : [
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
	self == anObject
		ifTrue: [^ true].
	self class == anObject class
		ifFalse: [^ false].

	^ self hasNamespaces
		ifTrue: [anObject hasNamespaces and: [prefixMappings = anObject prefixMappings]]
		ifFalse: [anObject hasNamespaces not].
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace [
	^ prefixMappings
		ifNil: ['']
		ifNotNil: [prefixMappings at: '' ifAbsent: ['']]
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace: aUri [
	(aUri = self class xmlNamespaceURI
		or: [aUri = self class xmlnsNamespaceURI])
		ifTrue: [
			XMLNamespaceException signal:
				'Cannot use "xml" or  "xmlns" namespace URI as default namespace'].

	self prefixMappings at: '' put: aUri.
]

{ #category : #testing }
XMLNamespaceScope >> hasDefaultNamespace [
	^ self includesPrefix: ''
]

{ #category : #testing }
XMLNamespaceScope >> hasNamespaces [
	^ prefixMappings notNil and: [prefixMappings notEmpty]
]

{ #category : #comparing }
XMLNamespaceScope >> hash [
	| hash |

	hash := self class hash.
	self prefixesAndURIsDo: [:prefix :uri | hash := hash bitXor: uri hash].
	^ hash.
]

{ #category : #testing }
XMLNamespaceScope >> includesPrefix: aPrefix [
	self prefixMappingsAt: aPrefix ifAbsent: [^ false].
	^ true.
]

{ #category : #testing }
XMLNamespaceScope >> includesPrefix: aPrefix mappedTo: aUri [
	^ (self prefixMappingsAt: aPrefix ifAbsent: [^ false]) = aUri
]

{ #category : #initializing }
XMLNamespaceScope >> inheritMappingsFrom: anEnclosingScope [
	anEnclosingScope hasNamespaces
		ifTrue: [
			anEnclosingScope prefixesAndURIsDo: [:prefix :uri |
				(self includesPrefix: prefix)
					ifFalse: [self mapPrefix: prefix to: uri]]]
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
						ifFalse: [
							XMLNamespaceException signal:
								'Cannot map the "xml" prefix to a new namespace URI'].
					self prefixMappings at: 'xml' put: aUri.
					^ self].
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
	prefixMappings ifNotNil: [prefixMappings := prefixMappings copy].
]

{ #category : #private }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := OrderPreservingDictionary new: 5 withDefaultValue: '']
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappingsAt: aPrefix ifAbsent: aBlock [
	^ prefixMappings
		ifNil: [aBlock value]
		ifNotNil: [prefixMappings at: aPrefix ifAbsent: aBlock]
]

{ #category : #enumerating }
XMLNamespaceScope >> prefixesAndURIsDo: aTwoArgumentBlock [
	prefixMappings ifNotNil: [prefixMappings keysAndValuesDo: aTwoArgumentBlock]
]

{ #category : #printing }
XMLNamespaceScope >> printOn: aStream [
	self prefixesAndURIsDo: [:prefix :uri |
		aStream nextPutAll: 'xmlns'.
		prefix ifNotEmpty: [
			aStream
				nextPut: $:;
				nextPutAll: prefix].
		aStream
			nextPut: $=;
			nextPut: $";
			nextPutAll: uri;
			nextPut: $";
			space]
]

{ #category : #resolving }
XMLNamespaceScope >> resolvePrefix: aPrefix [
	^ self resolvePrefix: aPrefix ifUnresolvable: ['']
]

{ #category : #resolving }
XMLNamespaceScope >> resolvePrefix: aPrefix ifUnresolvable: aBlock [
	^ self
		prefixMappingsAt: aPrefix
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
	self prefixMappings
		removeKey: aPrefix
		ifAbsent: [
			XMLNamespaceException signal:
				'Prefix "', aPrefix, '" was not mapped and cannot be unmapped']
]

{ #category : #private }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix [
	^ self
		prefixMappingsAt: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self class xmlNamespaceURI]
				ifFalse: [
					XMLNamespaceException signal:
						(aPrefix = 'xmlns'
							ifTrue: ['Cannot use reserved "xmlns" prefix for elements or attributes']
							ifFalse: ['Unmapped namespace prefix "', aPrefix, '" in name'])]]
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

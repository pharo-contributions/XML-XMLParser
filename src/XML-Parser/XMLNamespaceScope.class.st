"
A namespace scope is a possibly empty set of mappings from namespace prefixes to URIs and an optional default namespace URI to be used for unprefixed elements. Scopes can be created from other scopes by copying. (Uses copy-on-write to reduce memory use.)
"
Class {
	#name : #XMLNamespaceScope,
	#superclass : #Object,
	#instVars : [
		'prefixMappings'
	],
	#category : #'XML-Parser-Namespaces'
}

{ #category : #accessing }
XMLNamespaceScope class >> xmlNamespaceURI [
	^ 'http://www.w3.org/XML/1998/namespace'
]

{ #category : #accessing }
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

{ #category : #private }
XMLNamespaceScope >> copiedPrefixMappings [
	"replaces current mappings with copy for copy-on-write"
	prefixMappings
		ifNil: [^ self prefixMappings]
		ifNotNil: [^ prefixMappings := prefixMappings copy]
]

{ #category : #mapping }
XMLNamespaceScope >> defaultNamespace [
	^ prefixMappings
		ifNil: ['']
		ifNotNil: [prefixMappings at: '' ifAbsent: ['']]
]

{ #category : #mapping }
XMLNamespaceScope >> defaultNamespace: aURI [
	self
		validatePrefix: ''
		beforeMappingTo: aURI.

	"copy-on-write"
	self copiedPrefixMappings
		at: ''
		put: aURI.
]

{ #category : #private }
XMLNamespaceScope >> errorAttribute: anAttribute aliasesNamespace: aNamespace [
	XMLNamespaceException
		formatSignal: 'Attribute "{1}" has alias for namespace "{2}"'
		with: anAttribute
		with: aNamespace
]

{ #category : #private }
XMLNamespaceScope >> errorCannotAliasXMLOrXMLNSWithPrefix: aPrefix [
	aPrefix
		ifEmpty: [
			XMLNamespaceException signal:
				'Cannot use "xml" or  "xmlns" namespace URI as default namespace']
		ifNotEmpty: [
			XMLNamespaceException
				formatSignal:
					'Cannot alias the "xml" or "xmlns" namespace URIs with prefix "{1}"'
				with: aPrefix]
]

{ #category : #private }
XMLNamespaceScope >> errorCannotMapPrefixToEmptyURI [
	XMLNamespaceException signal: 'Cannot map namespace prefixes to empty URIs'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotMapXMLNSPrefix [
	XMLNamespaceException signal:
		'Cannot map "xmlns" prefix to any namespace, even the current "xmlns" namespace'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotRemapXMLPrefix [
	XMLNamespaceException signal: 'Cannot map the "xml" prefix to a new namespace URI'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotUnmapPrefix: aPrefix [
	XMLNamespaceException
		formatSignal: 'Prefix "{1}" was not mapped and cannot be unmapped'
		with: aPrefix
]

{ #category : #private }
XMLNamespaceScope >> errorCannotUseXMLNSPrefix [	
	XMLNamespaceException signal: 'Cannot use reserved "xmlns" prefix for elements or attributes'
]

{ #category : #private }
XMLNamespaceScope >> errorInvalidPrefix: aPrefix [	
	XMLNamespaceException
		formatSignal: 'Prefix "{1}" contains ":" character'
		with: aPrefix
]

{ #category : #private }
XMLNamespaceScope >> errorInvalidUnprefixedName: aName [
	XMLNamespaceException
		formatSignal: 'Name "{1}" contains ":" character'
		with: aName
]

{ #category : #private }
XMLNamespaceScope >> errorUnmappedPrefix: aPrefix [
	XMLNamespaceException
		formatSignal: 'Unmapped namespace prefix "{1}" in name'
		with: aPrefix
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
	self hasNamespaces
		ifTrue: [hash := hash bitXor: self prefixMappings hash].
	^ hash.
]

{ #category : #testing }
XMLNamespaceScope >> includesPrefix: aPrefix [
	self prefixMappingAt: aPrefix ifAbsent: [^ false].
	^ true.
]

{ #category : #testing }
XMLNamespaceScope >> includesPrefix: aPrefix mappedTo: aURI [
	^ (self prefixMappingAt: aPrefix ifAbsent: [^ false]) = aURI
]

{ #category : #mapping }
XMLNamespaceScope >> inheritMappingsFrom: anEnclosingScope [
	anEnclosingScope hasNamespaces
		ifFalse: [^ self].
	self hasNamespaces
		ifTrue: [| copiedPrefixMappings |
			anEnclosingScope prefixesAndURIsDo: [:prefix :uri |
				(self includesPrefix: prefix)
					ifFalse: [
						"nil test ensures we only copy the first time when needed"
						(copiedPrefixMappings
							ifNil: [copiedPrefixMappings := self copiedPrefixMappings])
							at: prefix
							put: uri]]]
		ifFalse: [
			"can safely share anEnclosingScope's prefixMappings because of
			copy-on-write behavior"
			prefixMappings := anEnclosingScope prefixMappings].
]

{ #category : #mapping }
XMLNamespaceScope >> mapPrefix: aPrefix to: aURI [
	self
		validatePrefix: aPrefix
		beforeMappingTo: aURI.

	"copy-on-write"
	self copiedPrefixMappings
		at: aPrefix
		put: aURI.
]

{ #category : #mapping }
XMLNamespaceScope >> mapPrefixesAndURIs: anAssociationCollection [
	| copiedPrefixMappings |

	anAssociationCollection associationsDo: [:each |
		self
			validatePrefix: each key
			beforeMappingTo: each value.
		"nil test ensures we only copy the first time when needed"
		(copiedPrefixMappings
			ifNil: [copiedPrefixMappings := self copiedPrefixMappings])
			at: each key
			put: each value]
]

{ #category : #accessing }
XMLNamespaceScope >> mappedPrefixes [
	^ prefixMappings
		ifNil: [Array new]
		ifNotNil: [prefixMappings keys]
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappingAt: aPrefix [
	^ self
		prefixMappingAt: aPrefix
		ifAbsent: ['']
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappingAt: aPrefix ifAbsent: aBlock [
	^ prefixMappings
		ifNil: [aBlock value]
		ifNotNil: [prefixMappings at: aPrefix ifAbsent: aBlock]
]

{ #category : #private }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := OrderPreservingStringDictionary new: 5]
]

{ #category : #enumerating }
XMLNamespaceScope >> prefixesAndURIsDo: aTwoArgumentBlock [
	prefixMappings
		ifNotNil: [prefixMappings keysAndValuesDo: aTwoArgumentBlock]
]

{ #category : #printing }
XMLNamespaceScope >> printDeclarationsOn: aStream [
	| isFirst |

	isFirst := true.
	self prefixesAndURIsDo: [:prefix :uri |
		isFirst 
			ifTrue: [isFirst := false]
			ifFalse: [aStream space].
		aStream nextPutAll: 'xmlns'.
		prefix
			ifNotEmpty: [
				aStream
					nextPut: $:;
					nextPutAll: prefix].
		aStream
			nextPut: $=;
			nextPut: $";
			nextPutAll: uri;
			nextPut: $"].
]

{ #category : #printing }
XMLNamespaceScope >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self printDeclarationsOn: aStream.
	aStream nextPut: $).
]

{ #category : #printing }
XMLNamespaceScope >> printedDeclarations [
	^ String streamContents: [:stream | self printDeclarationsOn: stream]
]

{ #category : #resolving }
XMLNamespaceScope >> resolvePrefix: aPrefix [
	"resolve namespace from prefix"
	^ self
		resolvePrefix: aPrefix
		ifUnresolvable: ''
]

{ #category : #resolving }
XMLNamespaceScope >> resolvePrefix: aPrefix ifUnresolvable: aBlock [
	"resolve namespace from prefix"
	^ self
		prefixMappingAt: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self xmlNamespaceURI]
				ifFalse: [
					aPrefix = 'xmlns'
						ifTrue: [self xmlnsNamespaceURI]
						ifFalse: [aBlock value]]]
]

{ #category : #resolving }
XMLNamespaceScope >> resolvePrefixesOfNamespaceURI: aURI [
	| prefixes |

	prefixes := Set new.
	aURI = self xmlNamespaceURI
		ifTrue: [prefixes add: 'xml'] "cannot be aliased"
		ifFalse: [
			aURI = self xmlnsNamespaceURI
				ifTrue: [prefixes add: 'xmlns'] "cannot be aliased"
				ifFalse: [
					self prefixesAndURIsDo: [:prefix :uri |
						uri = aURI
							ifTrue: [prefixes add: prefix]]]].
	^ prefixes.
]

{ #category : #accessing }
XMLNamespaceScope >> size [
	^ prefixMappings
		ifNil: [0]
		ifNotNil: [prefixMappings size]
]

{ #category : #unmapping }
XMLNamespaceScope >> unmapPrefix: aPrefix [
	^ self
		unmapPrefix: aPrefix
		ifAbsent: [self errorCannotUnmapPrefix: aPrefix]
]

{ #category : #unmapping }
XMLNamespaceScope >> unmapPrefix: aPrefix ifAbsent: aBlock [
	prefixMappings
		ifNil: [^ aBlock value]
		ifNotNil: [
			"copy-on-write"
			^ self copiedPrefixMappings 
				removeKey: aPrefix
				ifAbsent: aBlock]
]

{ #category : #unmapping }
XMLNamespaceScope >> unmapPrefixes [
	self hasNamespaces
		ifTrue: [
			"copy-on-write"
			self copiedPrefixMappings removeAll]
]

{ #category : #private }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix [
	^ self
		prefixMappingAt: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self xmlNamespaceURI]
				ifFalse: [					
					(aPrefix = 'xmlns'
						ifTrue: [self errorCannotUseXMLNSPrefix]
						ifFalse: [self errorUnmappedPrefix: aPrefix])]]
]

{ #category : #validating }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix ofElement: aName [
	aPrefix size = 0 "optimization"
		ifTrue: [
			self validateUnprefixedName: aName.
			^ self defaultNamespace]
		ifFalse: [^ self validateAndResolvePrefix: aPrefix]
]

{ #category : #validating }
XMLNamespaceScope >> validateAttributePrefixes: aDictionary [
	"performance critical method"
	| namespacedAttributes |

	aDictionary keysDo: [:each | | prefix |
		(prefix := each prefixBeforeLocalName) size > 0 "optimization"
			ifTrue: [| namespace oldSize |
				"not initialized unless needed"
				namespacedAttributes
					ifNil: [namespacedAttributes := Set new: aDictionary size].
				namespace := self validateAndResolvePrefix: prefix.

				"checking size after is faster than includes:"
				oldSize := namespacedAttributes size.
				namespacedAttributes add: namespace, (each localNameAfterPrefix: prefix).
				namespacedAttributes size > oldSize
					ifFalse: [self errorAttribute: each aliasesNamespace: namespace]]
			ifFalse: [self validateUnprefixedName: each]]
]

{ #category : #private }
XMLNamespaceScope >> validatePrefix: aPrefix beforeMappingTo: aURI [
	aPrefix size > 0 "optimization"
		ifTrue: ["non-default namespace"
			aPrefix = 'xml' "cannot be remapped"
				ifTrue: [
					aURI = self xmlNamespaceURI
						ifFalse: [self errorCannotRemapXMLPrefix].
					^ self].
			aPrefix = 'xmlns' "cannot be mapped, even to the same URI"
				ifTrue: [self errorCannotMapXMLNSPrefix].
			(aPrefix indexOf: $:) > 0 
				ifTrue: [self errorInvalidPrefix: aPrefix].
			"non-default namespaces cannot be mapped to empty uris, even
			to shadow an inherited namesapce"
			aURI size > 0
				ifFalse: [self errorCannotMapPrefixToEmptyURI]].

	"these URIs cannot be aliased, even by the default namespace"
	(aURI = self xmlNamespaceURI
		or: [aURI = self xmlnsNamespaceURI])
		ifTrue: [self errorCannotAliasXMLOrXMLNSWithPrefix: aPrefix].
]

{ #category : #private }
XMLNamespaceScope >> validateUnprefixedName: aName [
	"catch names like ':name' with an empty prefix"
	(aName size > 0
		and: [(aName at: 1) == $:])
		ifTrue: [self errorInvalidUnprefixedName: aName]
]

{ #category : #accessing }
XMLNamespaceScope >> xmlNamespaceURI [
	^ self class xmlNamespaceURI
]

{ #category : #accessing }
XMLNamespaceScope >> xmlnsNamespaceURI [
	^ self class xmlnsNamespaceURI
]

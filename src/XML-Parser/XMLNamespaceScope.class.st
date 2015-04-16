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

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace [
	^ prefixMappings
		ifNil: ['']
		ifNotNil: [prefixMappings at: '' ifAbsent: ['']]
]

{ #category : #accessing }
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
	prefixMappings
		ifNotNil: [hash := hash bitXor: prefixMappings hash].
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

{ #category : #accessing }
XMLNamespaceScope >> inheritMappingsFrom: anEnclosingScope [
	anEnclosingScope hasNamespaces
		ifFalse: [^ self].
	self hasNamespaces
		ifTrue: [| copiedPrefixMappings |
			anEnclosingScope prefixesAndURIsDo: [:prefix :uri |
				(self includesPrefix: prefix)
					ifFalse: [
						(copiedPrefixMappings "used so we only copy once"
							ifNil: [copiedPrefixMappings := self copiedPrefixMappings])
							at: prefix
							put: uri]]]
		ifFalse: [
			"can reuse because of copy-on-write"
			prefixMappings := anEnclosingScope prefixMappings].
]

{ #category : #accessing }
XMLNamespaceScope >> mapPrefix: aPrefix to: aURI [
	self
		validatePrefix: aPrefix
		beforeMappingTo: aURI.

	"copy-on-write"
	self copiedPrefixMappings
		at: aPrefix
		put: aURI.
]

{ #category : #accessing }
XMLNamespaceScope >> mapPrefixesAndURIs: anAssociationCollection [
	| copiedPrefixMappings |

	anAssociationCollection associationsDo: [:each |
		self
			validatePrefix: each key
			beforeMappingTo: each value.
		(copiedPrefixMappings "used so we only copy once"
			ifNil: [copiedPrefixMappings := self copiedPrefixMappings])
			at: each key
			put: each value]
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

{ #category : #accessing }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := OrderPreservingStringDictionary new: 5]
]

{ #category : #enumerating }
XMLNamespaceScope >> prefixesAndURIsDo: aTwoArgumentBlock [
	prefixMappings
		ifNotNil: [prefixMappings keysAndValuesDo: aTwoArgumentBlock]
]

{ #category : #accessing }
XMLNamespaceScope >> prefixesOfNamespaceURI: aURI [
	| prefixes |

	prefixes := Set new.
	aURI = self class xmlNamespaceURI
		ifTrue: [prefixes add: 'xml']
		ifFalse: [
			aURI = self class xmlnsNamespaceURI
				ifTrue: [prefixes add: 'xmlns']
				ifFalse: [
					self prefixesAndURIsDo: [:prefix :uri |
						uri = aURI
							ifTrue: [prefixes add: prefix]]]].
	^ prefixes.
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
				ifTrue: [self class xmlNamespaceURI]
				ifFalse: [
					aPrefix = 'xmlns'
						ifTrue: [self class xmlnsNamespaceURI]
						ifFalse: [aBlock value]]]
]

{ #category : #accessing }
XMLNamespaceScope >> size [
	^ prefixMappings
		ifNil: [0]
		ifNotNil: [prefixMappings size]
]

{ #category : #accessing }
XMLNamespaceScope >> unmapPrefix: aPrefix [
	"copy-on-write"
	^ self copiedPrefixMappings 
		removeKey: aPrefix
		ifAbsent: [
			XMLNamespaceException
				formatSignal: 'Prefix "{1}" was not mapped and cannot be unmapped'
				with: aPrefix]
]

{ #category : #private }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix [
	^ self
		prefixMappingAt: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self class xmlNamespaceURI]
				ifFalse: [					
					(aPrefix = 'xmlns'
						ifTrue: [self errorCannotUseXMLNSPrefix]
						ifFalse: [self errorUnmappedPrefix: aPrefix])]]
]

{ #category : #validating }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix ofElement: aName [
	aPrefix isEmpty "avoid ifEmpty: closure overhead"
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
		(prefix := each prefixBeforeLocalName) isEmpty "avoid ifNotEmpty: closure overhead"
			ifTrue: [self validateUnprefixedName: each]
			ifFalse: [ | namespace oldSize |
				"not initialized unless needed"
				namespacedAttributes
					ifNil: [namespacedAttributes := Set new: aDictionary size].
				namespace := self validateAndResolvePrefix: prefix.

				"checking size after is faster than includes:"
				oldSize := namespacedAttributes size.
				namespacedAttributes add: namespace, (each localNameAfterPrefix: prefix).
				namespacedAttributes size > oldSize
					ifFalse: [self errorAttribute: each aliasesNamespace: namespace]]]
]

{ #category : #private }
XMLNamespaceScope >> validatePrefix: aPrefix beforeMappingTo: aURI [
	aPrefix = 'xml'
		ifTrue: [
			aURI = self class xmlNamespaceURI
				ifFalse: [self errorCannotRemapXMLPrefix]]
		ifFalse: [
			aPrefix isEmpty "avoid ifEmpty: overhead"
				ifFalse: [
					aPrefix = 'xmlns'
						ifTrue: [self errorCannotMapXMLNSPrefix].
					(aPrefix indexOf: $:) > 0 
						ifTrue: [self errorInvalidPrefix: aPrefix].
					aURI isEmpty
						ifTrue: [self errorCannotMapPrefixToEmptyURI]].
			(aURI = self class xmlNamespaceURI
				or: [aURI = self class xmlnsNamespaceURI])
				ifTrue: [self errorCannotAliasXMLOrXMLNSWithPrefix: aPrefix]]
]

{ #category : #private }
XMLNamespaceScope >> validateUnprefixedName: aName [
	"catch names like ':name' with an empty prefix"
	(aName size > 0
		and: [(aName at: 1) == $:])
		ifTrue: [self errorInvalidUnprefixedName: aName]
]

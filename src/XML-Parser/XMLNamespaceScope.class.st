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
		ifTrue: [self errorCannotUseXmlOrXmlnsURIAsDefault].

	self prefixMappings at: '' put: aUri.
]

{ #category : #private }
XMLNamespaceScope >> errorAttribute: anAttribute aliasesNamespace: aNamespace [
	XMLNamespaceException
		formatSignal: 'Attribute "{1}" has alias for namespace "{2}"'
		with: anAttribute
		with: aNamespace
]

{ #category : #private }
XMLNamespaceScope >> errorCannotAliasXmlOrXmlnsURI [
	XMLNamespaceException signal: 'Cannot alias the "xml" or "xmlns" prefixes'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotMapPrefixToEmptyURI [
	XMLNamespaceException signal: 'Cannot map namespace prefixes to empty URIs'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotMapXmlnsPrefix [
	XMLNamespaceException signal:
		'Cannot map "xmlns" prefix to any namespace, even the current "xmlns" namespace'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotRemapXmlPrefix [
	XMLNamespaceException signal: 'Cannot map the "xml" prefix to a new namespace URI'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotUseXmlOrXmlnsURIAsDefault [
	XMLNamespaceException signal:
		'Cannot use "xml" or  "xmlns" namespace URI as default namespace'
]

{ #category : #private }
XMLNamespaceScope >> errorCannotUseXmlnsPrefix [	
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
						ifFalse: [self errorCannotRemapXmlPrefix].
					self prefixMappings at: 'xml' put: aUri.
					^ self].
			aPrefix = 'xmlns'
				ifTrue: [self errorCannotMapXmlnsPrefix]].
	(aPrefix indexOf: $:) > 0 
		ifTrue: [self errorInvalidPrefix: aPrefix].

	aUri isEmpty
		ifTrue: [self errorCannotMapPrefixToEmptyURI].
	(aUri = self class xmlNamespaceURI or: [aUri = self class xmlnsNamespaceURI])
		ifTrue: [self errorCannotAliasXmlOrXmlnsURI].
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
			XMLNamespaceException
				formatSignal: 'Prefix "{1}" was not mapped and cannot be unmapped'
				with: aPrefix]
]

{ #category : #private }
XMLNamespaceScope >> validateAndResolvePrefix: aPrefix [
	^ self
		prefixMappingsAt: aPrefix
		ifAbsent: [
			aPrefix = 'xml'
				ifTrue: [self class xmlNamespaceURI]
				ifFalse: [					
					(aPrefix = 'xmlns'
						ifTrue: [self errorCannotUseXmlnsPrefix]
						ifFalse: [self errorUnmappedPrefix: aPrefix])]]
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
					ifFalse: [self errorAttribute: each aliasesNamespace: namespace]]]
]

{ #category : #private }
XMLNamespaceScope >> validateUnprefixedName: aName [
	"catch names like ':name' with an empty prefix"
	(aName size > 0
		and: [(aName at: 1) == $:])
		ifTrue: [self errorInvalidUnprefixedName: aName]
]

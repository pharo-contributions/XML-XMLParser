"
A namespace scope is a possibly empty set of mappings from namespace prefixes to URIs and an optional default namespace URI to be used for unprefixed elements. Scopes can be created from other scopes by sending #enclosingScope: to the class with the other scope as the argument; the new scope will inherit the mappings from the parent.
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

{ #category : #'instance creation' }
XMLNamespaceScope class >> enclosingScope: aScope [
	^ self new inheritMappingsFrom: aScope
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

{ #category : #private }
XMLNamespaceScope >> ensureAttributePrefix: aPrefix localName: aLocalName hasNoAliasIn: aDictionary [
	| namespaceUri aliasingAttributeName |

	namespaceUri := self resolvePrefix: aPrefix.

	(self prefixesAliasing: aPrefix) do: [:aliasingPrefix |
		aliasingAttributeName := aliasingPrefix, ':', aLocalName.
		(aDictionary includesKey: aliasingAttributeName)
			ifTrue: [
				self
					errorAttribute: aliasingAttributeName
					aliases: aPrefix, ':', aLocalName
					with: namespaceUri]].
]

{ #category : #private }
XMLNamespaceScope >> errorAttribute: anAttribute aliases: anAliasedAttribute with: aUri [
	XMLNamespaceException signal:
		('Attribute "{1}" aliases attribute "{2}"; both prefixes map to {3}'
			format: (Array with: anAttribute with: anAliasedAttribute with: aUri))
]

{ #category : #testing }
XMLNamespaceScope >> hasDefaultNamespace [
	^ defaultNamespace notNil
]

{ #category : #testing }
XMLNamespaceScope >> hasNamespaces [
	^ self hasDefaultNamespace or: [self hasPrefixMappings]
]

{ #category : #testing }
XMLNamespaceScope >> hasPrefixMappings [
	^ prefixMappings notNil and: [prefixMappings notEmpty]
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

{ #category : #accessing }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := OrderPreservingDictionary defaultValue: '']
]

{ #category : #accessing }
XMLNamespaceScope >> prefixes [
	^ self prefixMappings keys
]

{ #category : #accessing }
XMLNamespaceScope >> prefixesAliasing: aPrefix [
	"Locate all prefixes that map to the same URI the given prefix does."
	| uri |
	
	uri := self resolvePrefix: aPrefix ifUnmapped: [^ #()].

	^ (self prefixesMappedTo: uri) copyWithout: aPrefix
]

{ #category : #enumerating }
XMLNamespaceScope >> prefixesAndURIsDo: aTwoArgumentBlock [
	self prefixMappings keysAndValuesDo: aTwoArgumentBlock
]

{ #category : #accessing }
XMLNamespaceScope >> prefixesMappedTo: aUri [
	^ self prefixes select: [:each | self includesPrefix: each mappedTo: aUri]
]

{ #category : #accessing }
XMLNamespaceScope >> resolvePrefix: aPrefix [
	^ self resolvePrefix: aPrefix ifUnmapped: ['']
]

{ #category : #accessing }
XMLNamespaceScope >> resolvePrefix: aPrefix ifUnmapped: aBlock [
	aPrefix isEmptyOrNil
		ifTrue: [^ self defaultNamespace].
	aPrefix = 'xml'
		ifTrue: [^ self xmlNamespaceURI].
	aPrefix = 'xmlns'
		ifTrue: [^ self xmlnsNamespaceURI].

	^ self prefixMappings at: aPrefix ifAbsent: aBlock
]

{ #category : #accessing }
XMLNamespaceScope >> unmapPrefix: aPrefix [
	(self includesPrefix: aPrefix)
		ifFalse: [XMLNamespaceException signal: 'Prefix ', aPrefix, ' cannot be unmapped'].

	self prefixMappings removeKey: aPrefix.
]

{ #category : #private }
XMLNamespaceScope >> validatePrefix: aPrefix of: aMarkupEntityType named: aName [
	(aPrefix isEmptyOrNil or: [aPrefix = 'xml'])
		ifTrue: [^ self].

	aPrefix = 'xmlns'
		ifTrue: [
			XMLNamespaceException signal:
				('Cannot use reserved "xmlns" prefix for {1} {2}' format:
					(Array with: aMarkupEntityType with: aName))].

	(self includesPrefix: aPrefix)
		ifFalse: [
			XMLNamespaceException signal:
				('Unmapped prefix "{1}" in {2} {3}' format:
					(Array with: aPrefix with: aMarkupEntityType with: aName))].
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefix: aPrefix ofAttributeName: anAttributeName [
	self validatePrefix: aPrefix of: 'attribute' named: anAttributeName
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefix: aPrefix ofElementName: anElementName [
	self validatePrefix: aPrefix of: 'element' named: anElementName
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefixedAttributeName: anAttributeName in: aDictionary [
	anAttributeName splitQualifiedNameInto: [:prefix :localName |
		prefix ifEmpty: [^ self].

		self
			validatePrefix: prefix
			ofAttributeName: anAttributeName.
		self
			ensureAttributePrefix: prefix
			localName: localName
			hasNoAliasIn: aDictionary]
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefixedAttributeNames: aDictionary [
	aDictionary keysDo: [:each | self validatePrefixedAttributeName: each in: aDictionary]
]

{ #category : #accessing }
XMLNamespaceScope >> xmlNamespaceURI [
	^ 'http://www.w3.org/XML/1998/namespace'
]

{ #category : #accessing }
XMLNamespaceScope >> xmlnsNamespaceURI [
	^ 'http://www.w3.org/2000/xmlns/'
]

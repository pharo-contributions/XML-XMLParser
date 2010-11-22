"
An XMLNamespaceScope is a set of mappings from namespace prefixes to URIs, and also a default URI. Scopes can be created from other scopes by sending #enclosingScope: to XMLNamespaceScope with the other XMLNamespaceScope as the argument.
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
	^ defaultNamespace ifNil: [defaultNamespace := '']
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace: aUri [
	aUri = self xmlNamespaceURI
		ifTrue: [XMLNamespaceException signal: 'Cannot use "xml" namespace URI as default namespace'].
	aUri = self xmlnsNamespaceURI
		ifTrue: [XMLNamespaceException signal: 'Cannot use "xmlns" namespace URI as default namespace'].

	defaultNamespace := aUri.
]

{ #category : #validation }
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

{ #category : #errors }
XMLNamespaceScope >> errorAttribute: anAttribute aliases: anAliasedAttribute with: aUri [
	XMLNamespaceException signal:
		('Attribute "{1}" aliases attribute "{2}"; both prefixes map to {3}'
			format: (Array with: anAttribute with: anAliasedAttribute with: aUri))
]

{ #category : #testing }
XMLNamespaceScope >> hasDefaultNamespace [
	^ defaultNamespace notNil and: [defaultNamespace notEmpty]
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

	self hasDefaultNamespace
		ifFalse: [self defaultNamespace: anEnclosingScope defaultNamespace].

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

	self prefixMappings at: aPrefix put: (aUri ifNil: [''])
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := OrderPreservingDictionary new]
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
	"Retrieve the URI of the given namespace prefix, if it is defined."

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
	aDictionary keysDo: [:attributeName |
		self
			validatePrefixedAttributeName: attributeName
			in: aDictionary]
]

{ #category : #accessing }
XMLNamespaceScope >> xmlNamespaceURI [
	^ 'http://www.w3.org/XML/1998/namespace'
]

{ #category : #accessing }
XMLNamespaceScope >> xmlnsNamespaceURI [
	^ 'http://www.w3.org/2000/xmlns/'
]

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
	defaultNamespace := aUri
]

{ #category : #validation }
XMLNamespaceScope >> ensureAttributePrefix: aPrefix localName: aLocalName hasNoAliasesIn: aDictionary [
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
	(aPrefix isEmptyOrNil or: [aPrefix = 'xmlns'])
		ifTrue: [^ self defaultNamespace: aUri].
	
	self prefixMappings at: aPrefix put: (aUri ifNil: [''])
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := XMLOrderPreservingDictionary new]
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
	"Retrieve the URI of the given namespace prefix, if it is defined.

	If prefix is empty, nil, or xmlns, the default namespace will be returned."

	^ self resolvePrefix: aPrefix ifUnmapped: ['']
]

{ #category : #accessing }
XMLNamespaceScope >> resolvePrefix: aPrefix ifUnmapped: aBlock [
	"Retrieve the URI of the given namespace prefix, if it is defined. 
	A nil namespace returns the default namespace. 
	If no namespace can be found the value of the block is returned"

	^ (aPrefix isEmptyOrNil or: [aPrefix = 'xmlns'])
		ifTrue: [self defaultNamespace]
		ifFalse: [self prefixMappings at: aPrefix ifAbsent: aBlock]
]

{ #category : #private }
XMLNamespaceScope >> validatePrefix: aPrefix of: aName [
	(self includesPrefix: aPrefix)
		ifFalse: [
			XMLNamespaceException signal:
				('Unmapped prefix "{1}" in {2}' format:
					(Array with: aPrefix with: aName))].
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefix: aPrefix ofAttributeName: anAttributeName [
	aPrefix ifNil: [^ self].
	self validatePrefix: aPrefix of: anAttributeName, ' attribute'
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefix: aPrefix ofElementName: anElementName [
	aPrefix ifNil: [^ self].
	self validatePrefix: aPrefix of: anElementName, ' element'
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
			hasNoAliasesIn: aDictionary]
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefixedAttributeNames: aDictionary [
	aDictionary keysDo: [:attributeName |
		self
			validatePrefixedAttributeName: attributeName
			in: aDictionary]
]

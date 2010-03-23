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
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLNamespaceScope class >> enclosingScope: aScope [
	^ self new inheritMappingsFrom: aScope
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
XMLNamespaceScope >> errorAttribute: anAttribute aliases: anAliasedAttribute with: aUri [
	self namespaceError:
		('Attribute "{1}" aliases attribute "{2}"; both prefixes map to {3}'
			format: (Array with: anAttribute with: anAliasedAttribute with: aUri))
]

{ #category : #errors }
XMLNamespaceScope >> errorUnmappedPrefix: aPrefix [
	self namespaceError: 'Unmapped namespace prefix "', aPrefix, '"'
]

{ #category : #initializing }
XMLNamespaceScope >> inheritMappingsFrom: anEnclosingScope. [
	self defaultNamespace
		ifNil: [self defaultNamespace: anEnclosingScope defaultNamespace].

	anEnclosingScope prefixMappingsDo: [:prefix :uri |
		(self isMappedPrefix: prefix)
			ifFalse: [self mapPrefix: prefix to: uri]].
]

{ #category : #testing }
XMLNamespaceScope >> isMappedPrefix: aPrefix [
	^ self prefixMappings includesKey: aPrefix
]

{ #category : #testing }
XMLNamespaceScope >> isPrefix: aPrefix mappedTo: aUri [
	^ ((self isMappedPrefix: aPrefix)
		and: [(self resolvePrefix: aPrefix) = aUri])
]

{ #category : #accessing }
XMLNamespaceScope >> mapPrefix: aPrefix to: aUri [
	(aPrefix isEmptyOrNil or: [aPrefix = 'xmlns'])
		ifTrue: [self defaultNamespace: aUri]
		ifFalse: [self prefixMappings at: aPrefix put: (aUri ifNil: [''])]
]

{ #category : #accessing }
XMLNamespaceScope >> mappedPrefixes [
	^ self prefixMappings keys
]

{ #category : #errors }
XMLNamespaceScope >> namespaceError: anErrorMessage [
	^ XMLNamespaceException signal: anErrorMessage
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := XMLOrderPreservingDictionary new]
]

{ #category : #enumerating }
XMLNamespaceScope >> prefixMappingsDo: aTwoArgumentBlock [
	self prefixMappings keysAndValuesDo: [:prefix :uri |
		aTwoArgumentBlock value: prefix value: uri]
]

{ #category : #accessing }
XMLNamespaceScope >> prefixesAliasing: aPrefix [
	"Locate all prefixes that map to the same URI the given prefix does."
	| uri |

	uri := self
		resolvePrefix: aPrefix
		ifUnmapped: [self errorUnmappedPrefix: aPrefix].

	^ self mappedPrefixes select: [:each |
		(each ~= aPrefix)
			and: [self isPrefix: each mappedTo: uri]].
]

{ #category : #accessing }
XMLNamespaceScope >> resolvePrefix: aPrefix [
	"Retrieve the URI of the given namespace prefix, if it is defined. A nil namespace
	returns the global namespace"

	^ self resolvePrefix: aPrefix ifUnmapped: [nil]
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

{ #category : #validation }
XMLNamespaceScope >> validateAttribute: anAttributeName in: aDictionary [
	| namespaceUri aliasingAttributeName |
	
	anAttributeName splitQualifiedNameInto: [:prefix :localName |
		prefix ifNil: [^ self].
		self validatePrefix: prefix.
		namespaceUri := self resolvePrefix: prefix.

		(self prefixesAliasing: prefix) do: [:aliasingPrefix |
			aliasingAttributeName := aliasingPrefix, ':', localName.
			(aDictionary includesKey: aliasingAttributeName)
				ifTrue: [
					self
						errorAttribute: aliasingAttributeName
						aliases: anAttributeName
						with: namespaceUri]]].
]

{ #category : #validation }
XMLNamespaceScope >> validateAttributes: attributeList [
	"check all attribute namespaces are defined and not duplicated by aliasing"
	| prefix localName qualifiedAlias |

	attributeList keysDo: [:attrName |
		self
			validateAttribute: attrName
			in: attributeList]
]

{ #category : #validation }
XMLNamespaceScope >> validatePrefix: aPrefix [
	(self isMappedPrefix: aPrefix)
		ifFalse: [self errorUnmappedPrefix: aPrefix].
]

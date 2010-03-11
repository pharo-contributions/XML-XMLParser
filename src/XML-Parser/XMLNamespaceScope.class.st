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
XMLNamespaceScope >> aliasesOf: aPrefix [
	"Locate all prefixes that alias the URI of the given prefix."
	| uri |

	uri := self
		resolvePrefix: aPrefix
		ifUnmapped: [self errorUndefinedAttributePrefix: aPrefix asString].

	^ self mappedPrefixes keys select: [:each |
		(each ~= aPrefix) and: [self isPrefix: each mappedTo: uri]].
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
XMLNamespaceScope >> errorAttribute: anAttribute aliases: aPrefix with: aUri [
	self error:
		('Attributes ', anAttribute, ' and ',
		aPrefix, ' are aliased to namespace ', aUri)
]

{ #category : #errors }
XMLNamespaceScope >> errorUndefinedAttributePrefix: aPrefix [
	self error: 'Attribute refers to undefined namespace ', aPrefix
]

{ #category : #errors }
XMLNamespaceScope >> errorUnmappedPrefix: aPrefix [
	self error: 'Unmapped namespace prefix "', aPrefix, '"'
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
		ifFalse: [self prefixMappings at: aPrefix put: aUri]
]

{ #category : #accessing }
XMLNamespaceScope >> mappedPrefixes [
	^ self prefixMappings keys
]

{ #category : #accessing }
XMLNamespaceScope >> prefixMappedTo: aUri [
	self prefixMappings keyAtValue: aUri
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

{ #category : #accessing }
XMLNamespaceScope >> unmapPrefix: aPrefix [
	self prefixMappings removeKey: aPrefix ifAbsent: [nil]
]

{ #category : #validation }
XMLNamespaceScope >> validateAttribute: attrName in: attributeList [
	| qualifiedAlias |
	
	attrName splitQualifiedNameInto: [:prefix :localName |
		prefix ifNil: [^ self].

		self validatePrefix: prefix.
		(self aliasesOf: prefix) do: [:alias |
			qualifiedAlias := alias qualifyName: localName.
			(attributeList includesKey: qualifiedAlias)
				ifTrue: [
					self
						errorAttribute: attrName
						aliases: qualifiedAlias
						with: (self resolvePrefix: prefix)]]].
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

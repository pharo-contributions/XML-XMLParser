Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'localName',
		'attributes',
		'namespace',
		'namespaceScope'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLElement class >> named: aString [
	^ self new name: aString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString attributes: attributeList [
	^ self new
		name: aString;
		setAttributes: attributeList
]

{ #category : #'instance creation' }
XMLElement class >> named: aString attributes: attributeList contentString: aContentString [
	^ self new
		name: aString;
		setAttributes: attributeList;
		contentString: aContentString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString contentString: aContentString [
	^ self new
		name: aString;
		contentString: aContentString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString namespace: ns attributes: attributeList scope: namespaceScope [
	^ self new
		setScope: namespaceScope;
		setAttributes: attributeList;
		name: aString namespace: ns
]

{ #category : #'instance creation' }
XMLElement class >> named: aString namespace: ns uri: uri attributes: attributeList [
	^ self new
		name: aString namespace: ns uri: uri;
		setAttributes: attributeList
]

{ #category : #accessing }
XMLElement >> @ aSymbolOrString [
	"shorthand form"
	^ self at: aSymbolOrString
]

{ #category : #accessing }
XMLElement >> addContent: aStringOrStringNode [
	"Adds a string or string node. If the last child node is already a string node,
	then contentString gets concatenated to it."

	(self hasContents and: [self nodes last isText])
		ifTrue: [self nodes last addContent: aStringOrStringNode]
		ifFalse: [self addNode: (XMLStringNode string: aStringOrStringNode)]
]

{ #category : #accessing }
XMLElement >> allAttributeAssociations [
	^ self attributes associations asSortedCollection asOrderedCollection
]

{ #category : #accessing }
XMLElement >> allAttributes [
	^ self attributes keys asSortedCollection asOrderedCollection
]

{ #category : #accessing }
XMLElement >> at: aSymbol [
    ^ self at: aSymbol ifAbsent: ['']

]

{ #category : #accessing }
XMLElement >> at: aSymbol ifAbsent: aBlock [
    ^ self attributeAt: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> at: aSymbol put: aValue [
    ^ self attributeAt: aSymbol put: aValue
]

{ #category : #accessing }
XMLElement >> attributeAt: aSymbolOrString [
	^self attributeAt: aSymbolOrString ifAbsent: [nil]
]

{ #category : #accessing }
XMLElement >> attributeAt: aSymbolOrString ifAbsent: aBlock [
	^self attributes at: aSymbolOrString asSymbol ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aSymbol put: aValue [
	^ self attributes at: aSymbol asSymbol put: aValue
]

{ #category : #accessing }
XMLElement >> attributes [
	^ attributes ifNil: [attributes := IdentityDictionary new]
]

{ #category : #private }
XMLElement >> bindNamespace: aPrefix to: aUri [
	| oldBinding |

	oldBinding := self namespaceScope
		resolveNamespace: aPrefix
		ifUnbound: [nil].
	self
		updateEnclosedScopesWith: [:scope |
			scope bindNamespace: aPrefix to: aUri]
		where: [:scope |
			(scope resolveNamespace: aPrefix ifUnbound: [nil]) = oldBinding]
]

{ #category : #accessing }
XMLElement >> characterData [
	^ self contentString
]

{ #category : #accessing }
XMLElement >> contentString [
	| firstContentNode |

	firstContentNode := self elementsAndContents at: 1 ifAbsent: [^ ''].
	^ firstContentNode isText
		ifTrue: [firstContentNode string]
		ifFalse: ['']
]

{ #category : #accessing }
XMLElement >> contentString: aString [
	self
		removeNodes;
		addContent: aString
]

{ #category : #accessing }
XMLElement >> contentStringAt: aSymbol [
	^ (self elementAt: aSymbol ifAbsent: [^ '']) contentString
]

{ #category : #accessing }
XMLElement >> contents [
	^ self nodes select: [:each | each isText]
]

{ #category : #enumerating }
XMLElement >> contentsDo: aBlock [
	self nodesDo: [:each | each isText ifTrue: [aBlock value: each]]
]

{ #category : #namespace }
XMLElement >> defaultNamespace [
	^ self namespaceScope defaultNamespace
]

{ #category : #namespace }
XMLElement >> defaultNamespace: aNamespaceUri [
	| oldDefaultNamespace |

	oldDefaultNamespace := self defaultNamespace.
	self
		updateEnclosedScopesWith: [:scope |
			scope defaultNamespace: aNamespaceUri]
		where: [:scope |
			scope defaultNamespace = oldDefaultNamespace].
]

{ #category : #accessing }
XMLElement >> elementsAndContents [
	^ self nodes select: [:each | each isTagOrText]
]

{ #category : #enumerating }
XMLElement >> elementsAndContentsDo: aBlock [
	self nodesDo: [:each | each isTagOrText ifTrue: [aBlock value: each]]
]

{ #category : #errors }
XMLElement >> errorUnboundNamespace: aPrefix [
	self error: 'Unbound namespace "', aPrefix, '"'
]

{ #category : #namespace }
XMLElement >> expandedName [
	"Returns a string containing the local name expanded with its namespace URI"
	^ self namespaceURI
		ifNil: [self localName asString]
		ifNotNil: ['{', self namespaceURI, '}', self localName asString]
]

{ #category : #testing }
XMLElement >> hasAttributes [
	^ self attributes notEmpty
]

{ #category : #testing }
XMLElement >> hasContents [
	^ self contents notEmpty
]

{ #category : #testing }
XMLElement >> hasPrefix [
	^ self localName ~~ self qualifiedName
]

{ #category : #searching }
XMLElement >> ifNamed: aSymbol do: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock with the receiver"

	(self isNamed: aSymbol)
		ifTrue: [aOneArgumentBlock valueWithPossibleArgument: self]

]

{ #category : #testing }
XMLElement >> includesAttribute: aSymbol [
	^ self attributes includesKey: aSymbol asSymbol
]

{ #category : #private }
XMLElement >> inheritBindingsFromScope: aScope [
	self recurse: [:each |
		each namespaceScope inheritBindingsFromScope: aScope]
]

{ #category : #testing }
XMLElement >> isNamed: aSymbol [
	^ (self localName == aSymbol asSymbol)
		or: [self qualifiedName == aSymbol asSymbol]
]

{ #category : #testing }
XMLElement >> isNamedAny: aSymbolArray [
	^ aSymbolArray anySatisfy: [:each | self isNamed: each]
]

{ #category : #testing }
XMLElement >> isTag [
	^ true
]

{ #category : #accessing }
XMLElement >> localName [
	^ localName ifNil: [#'']
]

{ #category : #accessing }
XMLElement >> name [
	^ self qualifiedName
]

{ #category : #accessing }
XMLElement >> name: aLocalName [
	name :=
		(self namespace
			ifNil: [aLocalName]
			ifNotNil: [self namespace asString, ':', aLocalName asString]) asSymbol.
	localName := aLocalName asSymbol.

	self notifyParentOfChange.
]

{ #category : #namespace }
XMLElement >> name: aLocalName namespace: aPrefix [
	self
		name: aLocalName
		namespace: aPrefix
		uri: nil
]

{ #category : #namespace }
XMLElement >> name: aLocalName namespace: aPrefix uri: aUri [
	(aPrefix isEmptyOrNil or: [aPrefix = 'xmlns'])
		ifTrue: [
			aUri ifNotNil: [self defaultNamespace: aUri].
			namespace := nil]
		ifFalse: [
			aUri
				ifNotNil: [self bindNamespace: aPrefix to: aUri]
				ifNil: [
					(self namespaceScope isBoundNamespace: aPrefix)
						ifFalse: [self errorUnboundNamespace: aPrefix]].
			namespace := aPrefix].

	self name: aLocalName.
]

{ #category : #namespace }
XMLElement >> namespace [
	^ namespace
]

{ #category : #namespace }
XMLElement >> namespace: aPrefix [
	self
		name: self localName
		namespace: aPrefix
]

{ #category : #namespace }
XMLElement >> namespace: aPrefix uri: aUri [
	self
		name: self localName
		namespace: aPrefix
		uri: aUri
]

{ #category : #namespace }
XMLElement >> namespaceScope [
	^ namespaceScope ifNil: [namespaceScope := XMLNamespaceScope new]
]

{ #category : #namespace }
XMLElement >> namespaceURI [
	^ self namespaceScope resolveNamespace: self namespace
]

{ #category : #accessing }
XMLElement >> nextElement [
	^ self hasParent ifTrue: [self parent elementAfter: self]
]

{ #category : #private }
XMLElement >> notifyParentOfChange [
	self hasParent ifTrue: [self parent changedChildElement: self]
]

{ #category : #accessing }
XMLElement >> previousElement [
	^ self hasParent ifTrue: [self parent elementBefore: self]
]

{ #category : #printing }
XMLElement >> printXMLOn: writer [
	writer
		startElement: self name
		attributeList: self attributes
		scope: self namespaceScope.
	(writer canonical not
		and: [self isEmpty and: [self attributes isEmpty not]])
		ifTrue: [writer endEmptyTag: self name]
		ifFalse: [
			writer endTag.
			super printXMLOn: writer.
			writer endTag: self name]
]

{ #category : #accessing }
XMLElement >> qualifiedName [
	^ name ifNil: [#'']
]

{ #category : #searching }
XMLElement >> recurse: aBlock [
	"See superclass version."

	aBlock valueWithPossibleArgument: self.

	super recurse: aBlock.
]

{ #category : #searching }
XMLElement >> recurseUntilTrue: aBlock [
	"See superclass version."

	(aBlock valueWithPossibleArgument: self)
		ifTrue: [^ self].

	^ super recurseUntilTrue: aBlock.
]

{ #category : #accessing }
XMLElement >> removeAttribute: aSymbol [
	^ self attributes removeKey: aSymbol asSymbol
]

{ #category : #initialize }
XMLElement >> setAttributes: aDictionary [
	self attributes removeAll.
	aDictionary ifNil: [^ self].
	aDictionary keysAndValuesDo: [:key :value | self at: key put: value].
]

{ #category : #initialize }
XMLElement >> setScope: aNamespaceScope [
	namespaceScope := XMLNamespaceScope enclosingScope: aNamespaceScope
]

{ #category : #accessing }
XMLElement >> tag [
	^ self name
]

{ #category : #private }
XMLElement >> updateEnclosedScopesWith: aBlock where: aConditional [
	"Updates the receiver's scope and the scopes of all descendants with aBlock
	where aConditional is true. It stops descending down a path of a subtree
	as soon as aConditional is false, but continues down other paths."

	(aConditional value: self namespaceScope)
		ifTrue: [aBlock value: self namespaceScope]
		ifFalse: [^ self].

	self elementsDo: [:each |
		each updateEnclosedScopesWith: aBlock where: aConditional]
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol [
	self deprecated: 'use #at: as a shortcut instead'.

	^ self at: aSymbol.
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol ifAbsent: aBlock [ 
	self deprecated: 'use #at:ifAbsent: as a shortcut instead'.

	^ self at: aSymbol ifAbsent: aBlock
]

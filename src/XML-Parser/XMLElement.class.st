Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'attributeList',
		'scope'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #private }
XMLElement class >> localName: aString prefix: ns attributes: attributeList scope: namespaceScope [
	| element |
	element := self new
		setScope: namespaceScope;
		setPrefix: ns localName: aString.
	attributeList keysAndValuesDo: [:key :value |
		element attributeList addName: key value: value scope: namespaceScope].
	^ element.
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName [
	^ self new qualifiedName: aQualifiedName
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName attributes: aDictionaryOrArray [
	^ (self named: aQualifiedName)
		setAttributes: aDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaceURI: aUri [
	^ aQualifiedName splitQualifiedNameInto: [:prefixPart :localPart |
		self new
			declareNamespace: prefixPart uri: aUri;
			setPrefix: prefixPart localName: localPart]
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaceURI: aUri attributes: aDictionaryOrArray [
	^ (self named: aQualifiedName namespaceURI: aUri)
		setAttributes: aDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaces: aNamespaceDictionary [
	^ self new
		declareNamespaces: aNamespaceDictionary;
		qualifiedName: aQualifiedName
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaces: aNamespaceDictionary attributes: aDictionaryOrArray [
	^ (self named: aQualifiedName namespaces: aNamespaceDictionary)
		setAttributes: aDictionaryOrArray
]

{ #category : #accessing }
XMLElement >> @ aString [
	"shorthand form"
	^ self at: aString
]

{ #category : #accessing }
XMLElement >> addContent: aString [
	"Adds a string or string node. If the last child node is already a string node,
	the characters being added are concatenated to it."

	(self hasContents and: [self nodes last isText])
		ifTrue: [self nodes last addContent: aString]
		ifFalse: [self addNode: (XMLStringNode string: aString)]
]

{ #category : #accessing }
XMLElement >> at: aString [
	^ self at: aString ifAbsent: ['']

]

{ #category : #accessing }
XMLElement >> at: aString ifAbsent: aBlock [
	^ self attributeAt: aString ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> at: aString put: aValue [
	^ self attributeAt: aString put: aValue
]

{ #category : #accessing }
XMLElement >> attributeAssociations [
	^ self attributeNodes collect: [:each | each name -> each value]
]

{ #category : #accessing }
XMLElement >> attributeAt: aString [
	^ self attributeAt: aString ifAbsent: [nil]
]

{ #category : #accessing }
XMLElement >> attributeAt: aString ifAbsent: aBlock [
	^ self attributeList valueAt: aString ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aString ifAbsentPut: aBlock [
	^ self attributeList valueAt: aString ifAbsentPut: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aString put: aValue [
	^ self attributeList valueAt: aString put: aValue
]

{ #category : #accessing }
XMLElement >> attributeList [
	^ attributeList ifNil: [attributeList := XMLAttributeList parent: self]
]

{ #category : #accessing }
XMLElement >> attributeNames [
	^ self attributeList names
]

{ #category : #enumerating }
XMLElement >> attributeNamesAndValuesDo: aTwoArgumentBlock [
	self attributeList namesAndValuesDo: aTwoArgumentBlock
]

{ #category : #enumerating }
XMLElement >> attributeNamesDo: aBlock [
	self attributeList namesDo: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aName [
	^ self attributeList nodeNamed: aName
]

{ #category : #accessing }
XMLElement >> attributeNodes [
	^ self attributeList
]

{ #category : #accessing }
XMLElement >> attributes [
	^ XMLOrderPreservingDictionary withAll: self attributeAssociations
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
XMLElement >> contentStringAt: aString [
	^ (self elementAt: aString ifAbsent: [^ '']) contentString
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
XMLElement >> declareNamespace: aPrefix uri: aUri [
	(self scope isPrefix: aPrefix mappedTo: aUri)
		ifTrue: [^ self].

	self mapPrefix: aPrefix to: aUri.
]

{ #category : #namespace }
XMLElement >> declareNamespaces: aDictionaryOrArray [
	(aDictionaryOrArray isDictionary
		ifTrue: [aDictionaryOrArray associations]
		ifFalse: [aDictionaryOrArray])
			do: [:association |
				association key splitQualifiedNameInto: [:xmlns :name |
					(name = 'xmlns')
						ifTrue: [self defaultNamespace: association value]
						ifFalse: [self declareNamespace: name uri: association value]]]
]

{ #category : #namespace }
XMLElement >> defaultNamespace [
	^ self scope defaultNamespace
]

{ #category : #namespace }
XMLElement >> defaultNamespace: aNamespaceUri [
	| oldDefaultNamespace |

	oldDefaultNamespace := self defaultNamespace.
	self
		updateEnclosedScopesWith: [:each |
			each defaultNamespace: aNamespaceUri]
		where: [:each |
			each defaultNamespace = oldDefaultNamespace].
]

{ #category : #accessing }
XMLElement >> elementsAndContents [
	^ self nodes select: [:each | each isTagOrText]
]

{ #category : #enumerating }
XMLElement >> elementsAndContentsDo: aBlock [
	self nodesDo: [:each | each isTagOrText ifTrue: [aBlock value: each]]
]

{ #category : #namespace }
XMLElement >> expandedName [
	^ self namespacedName expandedName
]

{ #category : #testing }
XMLElement >> hasAttributes [
	^ self attributeList notEmpty
]

{ #category : #testing }
XMLElement >> hasContents [
	^ self contents notEmpty
]

{ #category : #testing }
XMLElement >> hasPrefix [
	^ self namespacedName hasPrefix
]

{ #category : #searching }
XMLElement >> ifNamed: aString do: aOneArgumentBlock [
	"If the receiver tag equals aString, evaluate aOneArgumentBlock with the receiver"

	(self isNamed: aString)
		ifTrue: [aOneArgumentBlock valueWithPossibleArgument: self]

]

{ #category : #testing }
XMLElement >> includesAttribute: aString [
	^ self attributeList includesName: aString
]

{ #category : #private }
XMLElement >> inheritMappingsFrom: aScope [
	self recurse: [:each | each scope inheritMappingsFrom: aScope]
]

{ #category : #testing }
XMLElement >> isNamed: aString [
	^ (self localName = aString)
		or: [self qualifiedName = aString]
]

{ #category : #testing }
XMLElement >> isNamedAny: aStringArray [
	^ aStringArray anySatisfy: [:each | self isNamed: each]
]

{ #category : #testing }
XMLElement >> isTag [
	^ true
]

{ #category : #accessing }
XMLElement >> localName [
	^ self namespacedName localName
]

{ #category : #accessing }
XMLElement >> localName: aLocalName [
	self namespacedName localName: aLocalName.
	self notifyParentOfRenaming.
]

{ #category : #private }
XMLElement >> mapPrefix: aPrefix to: aUri [
	| oldMapping |

	oldMapping := self scope resolvePrefix: aPrefix ifUnmapped: [nil].
	self
		updateEnclosedScopesWith: [:each |
			each mapPrefix: aPrefix to: aUri]
		where: [:each |
			(each resolvePrefix: aPrefix ifUnmapped: [nil]) = oldMapping]
]

{ #category : #accessing }
XMLElement >> name [
	^ self qualifiedName
]

{ #category : #accessing }
XMLElement >> name: aName [
	self qualifiedName: aName
]

{ #category : #namespace }
XMLElement >> namespace [
	^ self namespacedName namespace
]

{ #category : #namespace }
XMLElement >> namespaceURI [
	^ self namespacedName namespaceURI
]

{ #category : #private }
XMLElement >> namespacedName [
	^ name ifNil: [name := XMLNamespacedName new]
]

{ #category : #accessing }
XMLElement >> nextElement [
	^ self hasParent ifTrue: [self parent elementAfter: self]
]

{ #category : #accessing }
XMLElement >> parent: aNode [
	super parent: aNode.

	(aNode notNil and: [aNode isTag])
		ifTrue: [self inheritMappingsFrom: aNode scope].
]

{ #category : #namespace }
XMLElement >> prefix [
	^ self namespacedName prefix
]

{ #category : #namespace }
XMLElement >> prefix: aPrefix [
	self namespacedName prefix: aPrefix.
	self notifyParentOfRenaming.
]

{ #category : #namespace }
XMLElement >> prefix: aPrefix uri: aUri [
	self declareNamespace: aPrefix uri: aUri.
	self prefix: aPrefix.
]

{ #category : #accessing }
XMLElement >> previousElement [
	^ self hasParent ifTrue: [self parent elementBefore: self]
]

{ #category : #printing }
XMLElement >> printXMLOn: writer [
	writer
		startElement: self name
		attributeList: self attributeList
		scope: self scope.
	(writer canonical not
		and: [self isEmpty and: [self attributeList notEmpty]])
		ifTrue: [writer endEmptyTag: self name]
		ifFalse: [
			writer endTag.
			super printXMLOn: writer.
			writer endTag: self name]
]

{ #category : #accessing }
XMLElement >> qualifiedName [
	^ self namespacedName qualifiedName
]

{ #category : #accessing }
XMLElement >> qualifiedName: aQualifiedName [
	self namespacedName qualifiedName: aQualifiedName.
	self notifyParentOfRenaming.
]

{ #category : #searching }
XMLElement >> recurse: aBlock [
	"See superclass version."

	aBlock value: self.

	super recurse: aBlock.
]

{ #category : #searching }
XMLElement >> recurseUntilTrue: aBlock [
	"See superclass version."

	(aBlock value: self)
		ifTrue: [^ self].

	^ super recurseUntilTrue: aBlock.
]

{ #category : #accessing }
XMLElement >> removeAttribute: aString [
	^ self attributeList removeNodeNamed: aString
]

{ #category : #'as yet unclassified' }
XMLElement >> renamedChildNode: aNode [
	super renamedChildNode: aNode.
	aNode isAttribute ifTrue: [self attributeList renamedNode: aNode]
]

{ #category : #private }
XMLElement >> scope [
	^ scope ifNil: [self setScope: XMLNamespaceScope new. scope]
]

{ #category : #initialization }
XMLElement >> setAttributes: aDictionaryOrArray [
	self attributeList removeAll.
	aDictionaryOrArray isEmptyOrNil ifTrue: [^ self].
	(aDictionaryOrArray isDictionary
		ifTrue: [aDictionaryOrArray associations]
		ifFalse: [aDictionaryOrArray]) do: [:association |
			self attributeList
				addName: association key
				value: association value
				scope: self scope].
]

{ #category : #initialization }
XMLElement >> setPrefix: aPrefix localName: aLocalName [
	self namespacedName setPrefix: aPrefix localName: aLocalName
]

{ #category : #initialization }
XMLElement >> setScope: aNamespaceScope [
	scope := (XMLNamespaceScope enclosingScope: aNamespaceScope).
	scope isValidating: aNamespaceScope isValidating.
	self namespacedName setScope: scope.
	self attributeList do: [:each | each setScope: scope]
]

{ #category : #accessing }
XMLElement >> tag [
	^ self qualifiedName
]

{ #category : #private }
XMLElement >> updateEnclosedScopesWith: aBlock where: aConditional [
	"Updates the receiver's scope and the scopes of all descendants with aBlock
	where aConditional is true. It stops descending down a path of a subtree
	as soon as aConditional is false, but continues down other paths."

	(aConditional value: self scope)
		ifTrue: [aBlock value: self scope]
		ifFalse: [^ self].

	self elementsDo: [:each |
		each updateEnclosedScopesWith: aBlock where: aConditional]
]

{ #category : #accessing }
XMLElement >> valueFor: aString [
	self deprecated: 'use #at: as a shortcut instead'.

	^ self at: aString.
]

{ #category : #accessing }
XMLElement >> valueFor: aString ifAbsent: aBlock [ 
	self deprecated: 'use #at:ifAbsent: as a shortcut instead'.

	^ self at: aString ifAbsent: aBlock
]

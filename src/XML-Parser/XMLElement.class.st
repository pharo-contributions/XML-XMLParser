Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'attributes',
		'scope',
		'usesNamespaces'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #private }
XMLElement class >> localName: aString prefix: aPrefix attributes: anAttributeDictionary scope: aNamespaceScope [
	| element attributeNodes |

	element := self new.
	element setScope: aNamespaceScope.
	element nodeName setPrefix: aPrefix localName: aString.
	attributeNodes := XMLAttributeList new.
	anAttributeDictionary keysAndValuesDo: [:key :value |
		attributeNodes addLast: (XMLAttribute name: key value: value)].
	element setAttributeNodes: attributeNodes.

	^ element.
]

{ #category : #'instance creation' }
XMLElement class >> named: aLocalName [
	^ self new name: aLocalName
]

{ #category : #'instance creation' }
XMLElement class >> named: aLocalName attributes: aDictionaryOrArray [
	^ (self named: aLocalName)
		setAttributes: aDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaceURI: aUri [
	^ self new name: aQualifiedName namespaceURI: aUri
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaceURI: aUri attributes: aDictionaryOrArray [
	^ (self named: aQualifiedName namespaceURI: aUri)
		setAttributes: aDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaces: aNamespaceDictionaryOrArray [
	^ self new
		declareNamespaces: aNamespaceDictionaryOrArray;
		named: aQualifiedName
]

{ #category : #'instance creation' }
XMLElement class >> named: aQualifiedName namespaces: aNamespaceDictionaryOrArray attributes: aDictionaryOrArray [
	^ (self
		named: aQualifiedName
		namespaces: aNamespaceDictionaryOrArray)
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

	(self hasContents and: [self lastNode isText])
		ifTrue: [self lastNode addContent: aString]
		ifFalse: [self addNode: (XMLString string: aString)]
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
	^ self attributeNodes valueAt: aString ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aString ifAbsentPut: aBlock [
	^ self attributeNodes valueAt: aString ifAbsentPut: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aString put: aValue [
	^ self attributeNodes valueAt: aString put: aValue
]

{ #category : #accessing }
XMLElement >> attributeNames [
	^ self attributeNodes names
]

{ #category : #enumerating }
XMLElement >> attributeNamesAndValuesDo: aTwoArgumentBlock [
	self attributeNodes namesAndValuesDo: aTwoArgumentBlock
]

{ #category : #enumerating }
XMLElement >> attributeNamesDo: aBlock [
	self attributeNodes namesDo: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aName [
	^ self attributeNodes nodeNamed: aName
]

{ #category : #accessing }
XMLElement >> attributeNodes [
	^ attributes ifNil: [self setAttributeNodes: XMLAttributeList new. attributes]
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

	firstContentNode := self elementsAndContents first.
	^ (firstContentNode notNil and:[firstContentNode isText])
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

{ #category : #namespaces }
XMLElement >> declareNamespace: aPrefix uri: aUri [
	(self scope isPrefix: aPrefix mappedTo: aUri)
		ifTrue: [^ self].

	self mapPrefix: aPrefix to: aUri.
]

{ #category : #namespaces }
XMLElement >> declareNamespaces: aDictionaryOrArray [
	self
		from: aDictionaryOrArray 
		keysAndValuesDo: [:namespaceName :uri |
			namespaceName splitQualifiedNameInto: [:xmlns :prefix |
				(prefix = 'xmlns')
					ifTrue: [self defaultNamespace: uri]
					ifFalse: [self declareNamespace: prefix uri: uri]]]
]

{ #category : #namespaces }
XMLElement >> declaredNamespaces [
	| namespaces |
	namespaces := self scope prefixMappings copy.
	self defaultNamespace notNil
		ifTrue: [namespaces at: 'xmlns' put: self defaultNamespace].
	^ namespaces.
]

{ #category : #namespaces }
XMLElement >> defaultNamespace [
	^ self scope defaultNamespace
]

{ #category : #namespaces }
XMLElement >> defaultNamespace: aNamespaceUri [
	| oldDefaultNamespace |

	oldDefaultNamespace := self defaultNamespace.
	self
		updateEnclosedScopesWith: [:each | each defaultNamespace: aNamespaceUri]
		where: [:each | each defaultNamespace = oldDefaultNamespace].
]

{ #category : #accessing }
XMLElement >> elementsAndContents [
	^ self nodes select: [:each | each isTagOrText]
]

{ #category : #enumerating }
XMLElement >> elementsAndContentsDo: aBlock [
	self nodesDo: [:each | each isTagOrText ifTrue: [aBlock value: each]]
]

{ #category : #namespaces }
XMLElement >> expandedName [
	^ self nodeName expandedWith: self namespaceURI
]

{ #category : #private }
XMLElement >> from: aDictionaryOrArray keysAndValuesDo: aBlock [
	aDictionaryOrArray isEmptyOrNil ifTrue: [^ self].

	(aDictionaryOrArray isDictionary
		ifTrue: [aDictionaryOrArray associations]
		ifFalse: [aDictionaryOrArray])
			do: [:association |
				aBlock
					value: association key
					value: association value]
]

{ #category : #testing }
XMLElement >> hasAttributes [
	^ self attributeNodes notEmpty
]

{ #category : #testing }
XMLElement >> hasContents [
	^ self contents notEmpty
]

{ #category : #testing }
XMLElement >> hasPrefix [
	^ self nodeName hasPrefix
]

{ #category : #searching }
XMLElement >> ifNamed: aString do: aOneArgumentBlock [
	"If the receiver tag equals aString, evaluate aOneArgumentBlock with the receiver"

	(self isNamed: aString)
		ifTrue: [aOneArgumentBlock valueWithPossibleArgument: self]

]

{ #category : #testing }
XMLElement >> includesAttribute: aString [
	^ self attributeNodes includesName: aString
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
	^ self nodeName localName
]

{ #category : #private }
XMLElement >> mapPrefix: aPrefix to: aUri [
	| oldMapping |

	oldMapping := self scope resolvePrefix: aPrefix ifUnmapped: [nil].
	self
		updateEnclosedScopesWith: [:each | each mapPrefix: aPrefix to: aUri]
		where: [:each |
			(each isPrefix: aPrefix mappedTo: oldMapping)
				or: [(each isMappedPrefix: aPrefix) not]]
]

{ #category : #accessing }
XMLElement >> name [
	^ self nodeName asString
]

{ #category : #accessing }
XMLElement >> name: aName [
	self notifyParentAfterRenamingWith: [self nodeName name: aName].
	self validateName.
]

{ #category : #namespaces }
XMLElement >> name: aQualifiedName namespaceURI: aUri [
	aQualifiedName splitQualifiedNameInto: [:prefixPart :localPart |
		self declareNamespace: prefixPart uri: aUri].
	self name: aQualifiedName.
]

{ #category : #namespaces }
XMLElement >> namespaceURI [
	^ self resolvePrefix: self prefix
]

{ #category : #accessing }
XMLElement >> nextElement [
	^ self hasParent ifTrue: [self parent elementAfter: self]
]

{ #category : #announcements }
XMLElement >> nodeAdded: aNode [
	super nodeAdded: aNode.
	
	(aNode isTag and: [self usesNamespaces])
		ifTrue: [aNode inheritMappingsFrom: self scope].
	aNode isAttribute
		ifTrue: [self validateAttribute: aNode name]
		
]

{ #category : #private }
XMLElement >> nodeName [
	^ name ifNil: [name := XMLNodeName new]
]

{ #category : #announcements }
XMLElement >> nodeRemoved: anAnnoucement [
	super nodeRemoved: anAnnoucement
]

{ #category : #announcements }
XMLElement >> nodeRenamed: aNode from: anOldName to: aNewName [
	super nodeRenamed: aNode from: aNode to: aNewName.
	aNode isAttribute
		ifTrue: [
			self validateAttribute: aNewName.
			self attributeNodes nodeRenamed: aNode from: anOldName to: aNewName]
]

{ #category : #namespaces }
XMLElement >> prefix [
	^ self nodeName prefix
]

{ #category : #namespaces }
XMLElement >> prefix: aPrefix [
	self notifyParentAfterRenamingWith: [self nodeName prefix: aPrefix].
	self validateName.
]

{ #category : #namespaces }
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
		attributeList: self attributeNodes
		namespaces: self declaredNamespaces.
	(writer canonical not
		and: [self isEmpty and: [self attributeNodes notEmpty]])
		ifTrue: [writer endEmptyTag: self name]
		ifFalse: [
			writer endTag.
			super printXMLOn: writer.
			writer endTag: self name]
]

{ #category : #accessing }
XMLElement >> qualifiedName [
	^ self nodeName qualifiedName
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
	^ self attributeNodes removeNodeNamed: aString
]

{ #category : #namespaces }
XMLElement >> resolvePrefix: aPrefix [
	^ self scope resolvePrefix: aPrefix
]

{ #category : #private }
XMLElement >> scope [
	^ scope ifNil: [self setScope: XMLNamespaceScope new. scope]
]

{ #category : #initialization }
XMLElement >> setAttributeNodes: anAttributeList [
	(attributes := anAttributeList) parent: self.
	attributes do: [:each | each parent: self]
]

{ #category : #initialization }
XMLElement >> setAttributes: aDictionaryOrArray [
	self attributeNodes removeAll.
	self
		from: aDictionaryOrArray
		keysAndValuesDo: [:attributeName :attributevalue |
			self attributeNodes
				addName: attributeName
				value: attributevalue].
]

{ #category : #initialization }
XMLElement >> setScope: aNamespaceScope [
	scope := aNamespaceScope.
	self useNamespaces: aNamespaceScope notNil.
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
XMLElement >> useNamespaces: aBoolean [
	usesNamespaces := aBoolean
]

{ #category : #testing }
XMLElement >> usesNamespaces [
	^ usesNamespaces ifNil: [usesNamespaces := true]
]

{ #category : #namespaces }
XMLElement >> validateAttribute: anAttributeName [
	self usesNamespaces ifFalse: [^ self].

	self scope
		validateAttribute: anAttributeName
		in: self attributes.
]

{ #category : #namespaces }
XMLElement >> validateName [
	(self usesNamespaces and: [self hasPrefix])
		ifTrue: [self scope validatePrefix: self prefix]
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

"
The class represents an XML element node. It can have a name, attributes, associated namespace declarations and any number child nodes and elements.

The #attribute- messages provide a Dictionary-like prototcol for manipulating attribute nodes. The underlying XMLAttributeList can be accessed using #attributeNodes, and an order-preserving dictionary of attribute names/values can be obtained using #attributes. Namespaces can be declared using #declareNamespace:uri: or simultaniously with changing the element's name using #name:namespaceURI:. The default namespace can be accessed through #defaultNamespace and #defaultNamespace:.

See the comment for the superclass for how to access child nodes and elements.
"
Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'attributes',
		'namespaceScope',
		'document'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLElement class >> name: aLocalName attributes: aDictionaryOrArray [
	^ (self named: aLocalName)
		setAttributes: aDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> name: aQualifiedName namespaceURI: aUri [
	^ self new name: aQualifiedName namespaceURI: aUri
]

{ #category : #'instance creation' }
XMLElement class >> name: aQualifiedName namespaceURI: aUri attributes: aDictionaryOrArray [
	^ (self name: aQualifiedName namespaceURI: aUri)
		setAttributes: aDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> name: aQualifiedName namespaces: aNamespaceDictionaryOrArray [
	^ self new
		declareNamespaces: aNamespaceDictionaryOrArray;
		name: aQualifiedName
]

{ #category : #'instance creation' }
XMLElement class >> name: aQualifiedName namespaces: aNamespaceDictionaryOrArray attributes: anAttributeDictionaryOrArray [
	^ (self
		name: aQualifiedName
		namespaces: aNamespaceDictionaryOrArray)
			setAttributes: anAttributeDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> named: aLocalName [
	^ self new name: aLocalName
]

{ #category : #'instance creation' }
XMLElement class >> named: aName attributes: aDictionary [
	self deprecated: 'use #name:attributes: instead'.

	^ self name: aName attributes: aDictionary.
]

{ #category : #'instance creation' }
XMLElement class >> named: aLocalName namespace: aPrefix uri: aUri attributes: aDictionary [
	self deprecated: 'use #name:namespaceURI:attributes: with a qualified name instead'.

	^ self
		name: aPrefix, ':', aLocalName
		namespaceURI: aUri
		attributes: aDictionary.
]

{ #category : #private }
XMLElement class >> qualifiedName: aQualifiedName prefix: aPrefix localName: aLocalName attributes: anAttributeDictionary namespaceScope: aNamespaceScope [
	^ self new
		setQualifiedName: aQualifiedName
		prefix: aPrefix
		localName: aLocalName
		attributes: anAttributeDictionary
		namespaceScope: aNamespaceScope
]

{ #category : #accessing }
XMLElement >> @ aName [
	^ self attributeAt: aName
]

{ #category : #accessing }
XMLElement >> addContent: aStringOrStringNode [
	"Adds a string or string node. If the last child node is already a string node,
	the characters being added are concatenated to it."

	(self hasChildren and: [self lastNode isStringNode])
		ifTrue: [self lastNode addContent: aStringOrStringNode]
		ifFalse: [self addNode: aStringOrStringNode asXMLString]
]

{ #category : #notifications }
XMLElement >> addedAttribute: anAttribute [
	anAttribute
		addObserver: self;
		element: self.
	self validateAttributeName: anAttribute name.
]

{ #category : #notifications }
XMLElement >> addedElement: anElement [
	super addedElement: anElement.
	self hasNamespaces
		ifTrue: [anElement inheritMappingsFrom: self namespaceScope]
]

{ #category : #accessing }
XMLElement >> at: aName [
	self deprecated: 'use #attributeAt: or @ instead'.

	^ self attributeAt: aName
]

{ #category : #accessing }
XMLElement >> at: aName ifAbsent: aBlock [	
	self deprecated: 'use #attributeAt:ifAbsent: instead'.

	^ self attributeAt: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> at: aName ifAbsentPut: aBlock [
	self deprecated: 'use #attributeAt:ifAbsentPut: instead'.

	^ self attributeAt: aName ifAbsentPut: aBlock
]

{ #category : #accessing }
XMLElement >> at: aName put: aValue [
	self deprecated: 'use #attributeAt:put: instead'.

	^ self attributeAt: aName put: aValue
]

{ #category : #accessing }
XMLElement >> attributeAssociations [
	^ self attributeNodes asNameValueAssociations
]

{ #category : #accessing }
XMLElement >> attributeAt: aName [
	^ self attributeAt: aName ifAbsent: ['']
]

{ #category : #accessing }
XMLElement >> attributeAt: aName ifAbsent: aBlock [
	^ self attributeNodes attributeValueAt: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aName ifAbsentPut: aBlock [
	^ self attributeNodes attributeValueAt: aName ifAbsentPut: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aName put: aValue [
	^ self attributeNodes attributeValueAt: aName put: aValue
]

{ #category : #accessing }
XMLElement >> attributeNames [
	^ self attributeNodes attributeNames
]

{ #category : #enumerating }
XMLElement >> attributeNamesAndValuesDo: aTwoArgumentBlock [
	self attributeNodes attributeNamesAndValuesDo: aTwoArgumentBlock
]

{ #category : #enumerating }
XMLElement >> attributeNamesDo: aBlock [
	self attributeNodes attributeNamesDo: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aName [
	^ self attributeNodes attributeNamed: aName
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aName ifAbsent: aBlock [
	^ self attributeNodes attributeNamed: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aUri [
	^ self attributeNodes attributeNamed: aLocalName namespaceURI: aUri
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aUri ifAbsent: aBlock [
	^ self attributeNodes attributeNamed: aLocalName namespaceURI: aUri ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodes [
	^ attributes ifNil: [
		(attributes := XMLAttributeList new)
			addObserver: self;
			yourself]
]

{ #category : #accessing }
XMLElement >> attributes [
	^ self attributeNodes asDictionary
]

{ #category : #accessing }
XMLElement >> contentString: aString [
	self
		removeNodes;
		addContent: aString
]

{ #category : #accessing }
XMLElement >> contents [
	self deprecated: 'use #stringNodes instead'.

	^ self stringNodes.
]

{ #category : #enumerating }
XMLElement >> contentsDo: aBlock [
	self deprecated: 'use #stringNodesDo: instead'.

	self stringNodesDo: aBlock.
]

{ #category : #namespaces }
XMLElement >> declareNamespaces: aDictionaryOrArray [
	aDictionaryOrArray associationsDo: [:each |
		(each key isEmptyOrNil or: [each key = 'xmlns'])
			ifTrue: [self defaultNamespace: each value]
			ifFalse: [self declarePrefix: each key uri: each value]]
]

{ #category : #namespaces }
XMLElement >> declarePrefix: aPrefix uri: aUri [
	(self namespaceScope includesPrefix: aPrefix mappedTo: aUri)
		ifTrue: [^ self].

	self mapPrefix: aPrefix to: aUri.
]

{ #category : #namespaces }
XMLElement >> defaultNamespace [
	^ self namespaceScope defaultNamespace
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
XMLElement >> document [
	^ document
]

{ #category : #accessing }
XMLElement >> document: aDocument [
	document := aDocument
]

{ #category : #accessing }
XMLElement >> elementsAndContents [
	self deprecated: 'use #contentNodes instead'.

	^ self contentNodes.
]

{ #category : #enumerating }
XMLElement >> elementsAndContentsDo: aBlock [
	self deprecated: 'use contentNodesDo: instead'.

	self contentNodesDo: aBlock.
]

{ #category : #namespaces }
XMLElement >> expandedName [
	^ self nodeName expandWith: self namespaceURI
]

{ #category : #testing }
XMLElement >> hasAttributes [
	^ self attributeNodes notEmpty
]

{ #category : #testing }
XMLElement >> hasContents [
	self deprecated: 'use #hasStringNodes instead'.

	^ self hasStringNodes.
]

{ #category : #private }
XMLElement >> hasNamespaces [
	^ namespaceScope notNil and: [namespaceScope hasNamespaces]
]

{ #category : #testing }
XMLElement >> hasPrefix [
	^ self nodeName isPrefixed
]

{ #category : #testing }
XMLElement >> hasStringNodes [
	^ self nodes anySatisfy: [:each | each isStringNode]
]

{ #category : #testing }
XMLElement >> includesAttribute: aName [
	^ self attributeNodes includesAttributeNamed: aName
]

{ #category : #private }
XMLElement >> inheritMappingsFrom: aScope [
	self recurse: [:each | each namespaceScope inheritMappingsFrom: aScope]
]

{ #category : #testing }
XMLElement >> isElement [
	^ true
]

{ #category : #testing }
XMLElement >> isNamed: aName [
	^ self nodeName isSameAs: aName
]

{ #category : #testing }
XMLElement >> isNamedAny: aNameArray [
	^ aNameArray anySatisfy: [:each | self isNamed: each]
]

{ #category : #accessing }
XMLElement >> localName [
	^ self nodeName localPart
]

{ #category : #private }
XMLElement >> mapPrefix: aPrefix to: aUri [
	| oldMapping |

	oldMapping :=
		self namespaceScope
			resolvePrefix: aPrefix
			ifUnmapped: [nil].
	self
		updateEnclosedScopesWith: [:each | each mapPrefix: aPrefix to: aUri]
		where: [:each |
			(each includesPrefix: aPrefix mappedTo: oldMapping)
				or: [(each includesPrefix: aPrefix) not]]
]

{ #category : #accessing }
XMLElement >> name [
	^ self nodeName qualified
]

{ #category : #accessing }
XMLElement >> name: aName [
	self nodeName qualified: aName
]

{ #category : #namespaces }
XMLElement >> name: aQualifiedName namespaceURI: aUri [
	aQualifiedName splitQualifiedNameInto: [:prefix :localPart |
		self declarePrefix: prefix uri: aUri].
	self name: aQualifiedName.
]

{ #category : #private }
XMLElement >> namespaceScope [
	^ namespaceScope ifNil: [namespaceScope := XMLNamespaceScope new]
]

{ #category : #namespaces }
XMLElement >> namespaceURI [
	^ self resolvePrefix: self prefix
]

{ #category : #accessing }
XMLElement >> nextElement [
	^ self hasParent ifTrue: [self parent elementAfter: self]
]

{ #category : #private }
XMLElement >> nodeName [
	^ name ifNil: [
		(name := XMLNodeName new)
			addObserver: self;
			yourself]
]

{ #category : #notifications }
XMLElement >> nodeNameChangedFrom: anOldName to: aNewName [
	self validateName.
	self
		notifyOf: #renamedElement:from:to:
		with: self
		with: anOldName
		with: aNewName
]

{ #category : #namespaces }
XMLElement >> prefix [
	^ self nodeName prefix
]

{ #category : #namespaces }
XMLElement >> prefix: aPrefix [
	self nodeName prefix: aPrefix
]

{ #category : #accessing }
XMLElement >> previousElement [
	^ self hasParent ifTrue: [self parent elementBefore: self]
]

{ #category : #printing }
XMLElement >> printXMLOn: aWriter [
	| tagWriter |

	(tagWriter := aWriter tag)
		name: self name.
	self hasNamespaces
		ifTrue: [
			tagWriter
				xmlns: self defaultNamespace;
				xmlnsDeclarations: self namespaceScope prefixMappings].
	tagWriter
		attributes: self attributes;
		content: [super printXMLOn: aWriter]
]

{ #category : #accessing }
XMLElement >> qualifiedName [
	self deprecated: 'use #name instead'.

	^ self nodeName qualified
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
XMLElement >> removeAttribute: aName [
	^ (self attributeNodes removeAttributeNamed: aName) value
]

{ #category : #accessing }
XMLElement >> removeAttributeNode: aNode [
	^ self attributeNodes remove: aNode
]

{ #category : #notifications }
XMLElement >> removedAttribute: anAttribute [
	anAttribute
		removeObserver: self;
		element: nil
]

{ #category : #notifications }
XMLElement >> renamedAttribute: anAttribute from: anOldName to: aNewName [
	self validateAttributeName: aNewName
]

{ #category : #namespaces }
XMLElement >> resolvePrefix: aPrefix [
	^ self namespaceScope resolvePrefix: aPrefix
]

{ #category : #initialization }
XMLElement >> setAttributes: aDictionaryOrArray [
	self attributeNodes removeAll.
	aDictionaryOrArray associationsDo: [:each |
		self attributeNodes
			addName: each key
			value: each value].
]

{ #category : #initialization }
XMLElement >> setQualifiedName: aQualifiedName prefix: aPrefix localName: aLocalName attributes: anAttributeDictionary namespaceScope: aNamespaceScope [
	self nodeName
		setQualified: aQualifiedName
		prefix: aPrefix
		localPart: aLocalName.

	anAttributeDictionary
		ifNotEmpty: [
			"By not observing 'attributes' until after it is filled, we avoid
			re-validating the attributes, which the parser should have already done"
			attributes := XMLAttributeList new: anAttributeDictionary size.
			anAttributeDictionary keysAndValuesDo: [:key :value |
				(attributes addName: key value: value)
					addObserver: self;
					element: self].
			attributes addObserver: self].

	namespaceScope := aNamespaceScope.
]

{ #category : #accessing }
XMLElement >> stringNodes [
	^ self nodes select: [:each | each isStringNode]
]

{ #category : #enumerating }
XMLElement >> stringNodesDo: aBlock [
	self nodes do: [:each | each isStringNode ifTrue: [aBlock value: each]]
]

{ #category : #accessing }
XMLElement >> strings [
	^ self stringNodes collect: [:each | each string]
]

{ #category : #enumerating }
XMLElement >> stringsDo: aBlock [
	self stringNodesDo: [:each | aBlock value: each string]
]

{ #category : #accessing }
XMLElement >> tag [
	self deprecated: 'use #name instead'.

	^ self name.
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

{ #category : #testing }
XMLElement >> usesNamespaces [
	^ namespaceScope notNil
]

{ #category : #private }
XMLElement >> validateAttributeName: anAttributeName [
	self usesNamespaces ifFalse: [^ self].

	self namespaceScope
		validatePrefixedAttributeName: anAttributeName
		in: self attributeNodes attributesByName.
]

{ #category : #private }
XMLElement >> validateName [
	(self usesNamespaces and: [self hasPrefix])
		ifTrue: [
			self namespaceScope
				validatePrefix: self prefix
				ofElementName: self name]
]

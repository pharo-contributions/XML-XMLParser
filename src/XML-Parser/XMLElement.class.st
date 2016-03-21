"
The class represents an element node, which has a qualified or unqualified name and optionally attributes, namespace declarations and child nodes.

Element names can be tested using #isNamed: and #isNamedAny:, which test both the qualified and local name.

If the name is qualified and namespace support is enabled (the default), then the prefix must be mapped to a namespace URI in the element or an ancestor. The class-side instance creation #name:namespaceURI:* and #name:namespaces:* messages and the instance-side #name:namespaceURI: message can set both simultaneously. If namespace support is disabled, prefixes are not checked.

The #attribute* messages provide a Dictionary-like protocol for manipulating attribute nodes. Attribute value accessors return empty strings if the attribute is absent. The underlying attribute node list can be accessed using #attributeNodes (copy before modifying if you don't want to add/remove attribute nodes from the element), and the names/values can be obtained as an (order-preserving) dictionary using #attributes.

See the superclasses for more info.
"
Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'localName',
		'attributes',
		'namespaceScope'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLElement class >> name: aLocalName [
	^ self new name: aLocalName
]

{ #category : #'instance creation' }
XMLElement class >> name: aLocalName attributes: aDictionaryOrArray [
	^ (self named: aLocalName)
		setAttributes: aDictionaryOrArray
]

{ #category : #'instance creation' }
XMLElement class >> name: aQualifiedName namespaceURI: aURI [
	^ self new name: aQualifiedName namespaceURI: aURI
]

{ #category : #'instance creation' }
XMLElement class >> name: aQualifiedName namespaceURI: aURI attributes: aDictionaryOrArray [
	^ (self name: aQualifiedName namespaceURI: aURI)
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

{ #category : #adding }
XMLElement >> addElementNamed: aName [
	| elementPrefix elementClass |

	elementPrefix := aName prefixBeforeLocalName.
	elementClass :=
		self nodeFactory
			classForElement: aName
			prefix: elementPrefix
			uri: (self resolvePrefix: elementPrefix)
			localName: (aName localNameAfterPrefix: elementPrefix).

	"added first to inherit the config and namespaces before setting the name"
	^ (self addNode: elementClass new) name: aName.
]

{ #category : #notifying }
XMLElement >> addedAttribute: anAttribute [
	anAttribute element: self.
	self validateAttributes.
]

{ #category : #notifying }
XMLElement >> addedElement: anElement [
	super addedElement: anElement.
	(self hasNamespaces
		and: [self namespaceScope ~= anElement namespaceScope])
		ifTrue: [
			anElement allNamespaceScopesDo: [:each |
				each inheritMappingsFrom: self namespaceScope]]
]

{ #category : #notifying }
XMLElement >> addingAttribute: anAttribute [
	anAttribute element
		ifNotNil: [self errorAddingAttributeWithElement]
]

{ #category : #enumerating }
XMLElement >> allElementsDo: aBlock [
	aBlock value: self.
	self hasChildren
		ifTrue: [self elementsDo: [:each | each allElementsDo: aBlock]].
]

{ #category : #private }
XMLElement >> allNamespaceScopesDo: aBlock [
	self allElementsDo: [:each |
		aBlock value: each namespaceScope]
]

{ #category : #private }
XMLElement >> allNamespaceScopesDo: aBlock whileTrue: aConditionalBlock [
	"Updates the receiver's scope and the scopes of all descendants with aBlock
	where aConditional is true but does not validate the namespaces after"

	(aConditionalBlock value: self namespaceScope)
		ifTrue: [
			aBlock value: self namespaceScope.
			self elementsDo: [:each |
				each
					allNamespaceScopesDo: aBlock
					whileTrue: aConditionalBlock]]
]

{ #category : #private }
XMLElement >> allNamespaceScopesWithValidationDo: aBlock whileTrue: aConditionalBlock [
	"Updates the receiver's scope and the scopes of all descendants with aBlock
	where aConditional is true and validates the namespaces after"

	(aConditionalBlock value: self namespaceScope)
		ifTrue: [
			aBlock value: self namespaceScope.
			self
				validateName;
				validateAttributes.
			self elementsDo: [:each |
				each
					allNamespaceScopesWithValidationDo: aBlock
					whileTrue: aConditionalBlock]]
]

{ #category : #accessing }
XMLElement >> attributeAssociations [
	"returns attribute name->value associations"
	^ self attributeNodes attributeAssociations
]

{ #category : #accessing }
XMLElement >> attributeAt: aName [
	"returns empty string when absent"
	^ self attributeNodes attributeValueAt: aName
]

{ #category : #accessing }
XMLElement >> attributeAt: aName ifAbsent: aBlock [
	^ self attributeNodes
		attributeValueAt: aName
		ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aName ifAbsentPut: aBlock [
	^ self attributeNodes
		attributeValueAt: aName
		ifAbsentPut: aBlock
]

{ #category : #accessing }
XMLElement >> attributeAt: aName put: aValue [
	^ self attributeNodes
		attributeValueAt: aName
		put: aValue
]

{ #category : #private }
XMLElement >> attributeListClass [
	^ XMLAttributeList
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
	"returns nil if absent"
	^ self attributeNodes attributeNodeAt: aName
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aName ifAbsent: aBlock [
	^ self attributeNodes
		attributeNodeAt: aName
		ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aURI [
	"returns nil if absent"
	^ self attributeNodes
		attributeNodeAt: aLocalName
		namespaceURI: aURI
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aURI ifAbsent: aBlock [
	^ self attributeNodes
		attributeNodeAt: aLocalName
		namespaceURI: aURI
		ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodes [
	"Returns the attribute node list. Can be modified, but adding or removing
	attributes modify the element"
	^ attributes ifNil: [attributes := self attributeListClass observer: self]
]

{ #category : #enumerating }
XMLElement >> attributeNodesDo: aBlock [
	self attributeNodes do: aBlock
]

{ #category : #accessing }
XMLElement >> attributes [
	"returns a new dictionary of attribute names and values"
	^ self attributeNodes asDictionary
]

{ #category : #namespacing }
XMLElement >> declareNamespaces: anAssociationCollection [
	anAssociationCollection associationsDo: [:each |
		self
			declarePrefix: each key
			uri: each value]
]

{ #category : #namespacing }
XMLElement >> declarePrefix: aPrefix uri: aURI [
	| oldMapping |

	oldMapping :=
		self namespaceScope
			prefixMappingAt: aPrefix
			ifAbsent: [nil].
	(oldMapping notNil
		and: [oldMapping = aURI])
		ifFalse: [
			self
				allNamespaceScopesDo: [:scope |
					scope
						mapPrefix: aPrefix
						to: aURI]
				whileTrue: [:scope |
					(scope includesPrefix: aPrefix) not
						or: [
							scope
								includesPrefix: aPrefix
								mappedTo: oldMapping]]]
]

{ #category : #namespacing }
XMLElement >> declaredPrefixes [
	^ self namespaceScope mappedPrefixes
]

{ #category : #testing }
XMLElement >> declaresDefaultNamespace [
	"Did the receiver declare a new default namespace rather than inheriting one?"

	^ self namespaceScope hasDefaultNamespace
		and: [self isRoot
			or: [self defaultNamespace ~= self parent defaultNamespace]]
]

{ #category : #testing }
XMLElement >> declaresPrefix: aPrefix uri: aURI [
	"Did the receiver declare a new prefix/uri pair rather than inheriting one?"

	^ (self isDeclaredPrefix: aPrefix uri: aURI)
		and: [self isRoot
			or: [(self parent isDeclaredPrefix: aPrefix uri: aURI) not]]
]

{ #category : #namespacing }
XMLElement >> defaultNamespace [
	^ self namespaceScope defaultNamespace
]

{ #category : #namespacing }
XMLElement >> defaultNamespace: aURI [
	"unlike non-default namespaces, the uri can be empty to shadow an
	inherited default namesapce"
	| oldNamespace |

	oldNamespace := self defaultNamespace.
	self
		allNamespaceScopesDo: [:scope |
			scope defaultNamespace: aURI]
		whileTrue: [:scope |
			scope defaultNamespace = oldNamespace].
]

{ #category : #private }
XMLElement >> errorAddingAttributeWithElement [
	XMLDOMException signal: 'Cannot add attribute node from other element'
]

{ #category : #accessing }
XMLElement >> expandedName [
	^ self localName expandWithNamespaceURI: self namespaceURI
]

{ #category : #testing }
XMLElement >> hasAttributes [
	"nil test and size check to avoid lazy initializing"
	^ attributes notNil
		and: [attributes size > 0]
]

{ #category : #testing }
XMLElement >> hasNamespaceURI [
	^ self namespaceURI notEmpty
]

{ #category : #testing }
XMLElement >> hasNamespaces [
	^ namespaceScope notNil and: [namespaceScope hasNamespaces]
]

{ #category : #testing }
XMLElement >> hasPrefix [
	^ self name size > self localName size
]

{ #category : #testing }
XMLElement >> includesAttribute: aName [
	^ self attributeNodes includesAttribute: aName.
]

{ #category : #testing }
XMLElement >> isDeclaredPrefix: aPrefix [
	"is namespace prefix in scope for use by receiver and descendants"
	^ self namespaceScope includesPrefix: aPrefix
]

{ #category : #testing }
XMLElement >> isDeclaredPrefix: aPrefix uri: aURI [
	"is namespace prefix mapped to uri in scope for use by receiver and descendants"
	^ self namespaceScope
		includesPrefix: aPrefix
		mappedTo: aURI
]

{ #category : #testing }
XMLElement >> isElement [
	^ true
]

{ #category : #testing }
XMLElement >> isElementNamed: aName [
	^ self isNamed: aName
]

{ #category : #testing }
XMLElement >> isElementNamedAny: aNameCollection [
	^ self isNamedAny: aNameCollection
]

{ #category : #testing }
XMLElement >> isInLanguage: aLanguage [
	^ (self
		attributeNodeAt: 'xml:lang'
		ifAbsent: [
			^ self hasParent
				and: [self parent isInLanguage: aLanguage]])
			hasLanguage: aLanguage
]

{ #category : #testing }
XMLElement >> isNamed: aName [
	"Does the receiver's qualified or local name match the argument?'"
	^ aName
		isQualifiedName: self name
		orLocalName: self localName
]

{ #category : #testing }
XMLElement >> isNamedAny: aNameCollection [
	"Does the receiver's qualified or local name match any of the names supplied as the argument?'"
	^ aNameCollection
		includesQualifiedName: self name
		orLocalName: self localName
]

{ #category : #testing }
XMLElement >> isRoot [
	"Is the receiver the root element?"
	^ (self hasParent and: [self parent isElement]) not
]

{ #category : #accessing }
XMLElement >> localName [
	^ localName ifNil: [localName := self name localNameAfterPrefix]
]

{ #category : #accessing }
XMLElement >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XMLElement >> name: aName [
	self renameWith: [
		name := aName.
		localName := aName localNameAfterPrefix]
]

{ #category : #accessing }
XMLElement >> name: aQualifiedName namespaceURI: aURI [
	self
		declarePrefix: (aQualifiedName prefixBeforeLocalName) uri: aURI;
		name: aQualifiedName
]

{ #category : #private }
XMLElement >> namespaceScope [
	^ namespaceScope ifNil: [namespaceScope := XMLNamespaceScope new]
]

{ #category : #accessing }
XMLElement >> namespaceURI [
	^ self resolvePrefix: self prefix
]

{ #category : #accessing }
XMLElement >> nextElement [
	^ self parent ifNotNil: [:node | node elementAfter: self]
]

{ #category : #copying }
XMLElement >> postCopy [
	super postCopy.

	namespaceScope
		ifNotNil: [namespaceScope := namespaceScope copy].
	attributes
		ifNotNil: [| copiedAttributes |
			copiedAttributes := attributes copyEmpty observer: self.
			attributes do: [:each | copiedAttributes addLast: each copy].
			attributes := copiedAttributes].
]

{ #category : #accessing }
XMLElement >> prefix [
	^ self name prefixBeforeLocalName: self localName
]

{ #category : #accessing }
XMLElement >> prefix: aPrefix [
	self renameWith: [name := self localName qualifyWithPrefix:  aPrefix]
]

{ #category : #accessing }
XMLElement >> previousElement [
	^ self parent ifNotNil: [:node | node elementBefore: self]
]

{ #category : #removing }
XMLElement >> removeAttribute: aName [
	^ (self attributeNodes removeAttributeNodeAt: aName) value.
]

{ #category : #removing }
XMLElement >> removeAttribute: aName ifAbsent: aBlock [
	^ (self attributeNodes
		removeAttributeNodeAt: aName
		ifAbsent: [^ aBlock value]) value.
]

{ #category : #removing }
XMLElement >> removeAttributeNode: aNode [
	^ self attributeNodes remove: aNode
]

{ #category : #removing }
XMLElement >> removeAttributeNode: aNode ifAbsent: aBlock [
	^ self attributeNodes
		remove: aNode
		ifAbsent: aBlock
]

{ #category : #removing }
XMLElement >> removeAttributes [
	self attributeNodes removeAll
]

{ #category : #notifying }
XMLElement >> removedAttribute: anAttribute [
	anAttribute element: nil
]

{ #category : #private }
XMLElement >> renameWith: aBlock [
	| oldName |

	oldName := self name.
	aBlock value.
	self name = oldName
		ifFalse: [
			self validateName.
			self hasParent
				ifTrue: [
					self parent
						renamedElement: self
						from: oldName
						to: self name]].
]

{ #category : #notifying }
XMLElement >> renamedAttribute: anAttribute from: anOldName to: aNewName [
	self attributeNodes	
		renamedAttribute: anAttribute
		from: anOldName
		to: aNewName.
	self validateAttributes.
]

{ #category : #namespacing }
XMLElement >> resolvePrefix: aPrefix [
	"Resolves the namespace URI of aPrefix (the defualt namespace URI if aPrefix
	is empty), including the predefined 'xml' and 'xmlns' prefixes. Returns an
	empty string if aPrefix is unresolvable."

	^ self
		resolvePrefix: aPrefix
		ifUnresolvable: ''
]

{ #category : #namespacing }
XMLElement >> resolvePrefix: aPrefix ifUnresolvable: aBlock [
	"Resolves the namespace URI of aPrefix (the defualt namespace URI if aPrefix
	is empty), including the predefined 'xml' and 'xmlns' prefixes. Returns the
	value of aBlock if aPrefix is unresolvable."

	self hasNamespaces "avoid lazy initializing the scope"
		ifTrue: [
			^ self namespaceScope
				resolvePrefix: aPrefix
				ifUnresolvable: aBlock]
		ifFalse: [^ aBlock value]
]

{ #category : #namespacing }
XMLElement >> resolvePrefixesOfNamespaceURI: aURI [
	"returns a set of all the namespace prefixes of aURI"
	^ self namespaceScope resolvePrefixesOfNamespaceURI: aURI
]

{ #category : #initialization }
XMLElement >> setAttributes: anAssociationCollection [
	self hasAttributes
		ifTrue: [self removeAttributes].
	anAssociationCollection associationsDo: [:each |
		self attributeNodes addAttributeAssociation: each].
]

{ #category : #private }
XMLElement >> setNamespaceScope: aNamespaceScope [
	namespaceScope := aNamespaceScope
]

{ #category : #private }
XMLElement >> setQualifiedName: aQualifiedName localName: aLocalName attributes: anAttributeDictionary [
	name := aQualifiedName.
	localName := aLocalName.
	anAttributeDictionary size > 0 "optimization"
		ifTrue: [
			"setWithOrderPreservingDictionary: is used to initialize the attribute
			node list with anAttributeDictionary without revalidation"
			(attributes := self attributeListClass new: anAttributeDictionary size)
				observer: self;
				setWithOrderPreservingDictionary: anAttributeDictionary].
]

{ #category : #private }
XMLElement >> sortKey [
	^ self name
]

{ #category : #namespacing }
XMLElement >> undeclareDefaultNamespace [
	self undeclarePrefix: ''
]

{ #category : #namespacing }
XMLElement >> undeclarePrefix: aPrefix [
	| currentNamespaceURI |

	currentNamespaceURI :=
		self namespaceScope
			prefixMappingAt: aPrefix
			ifAbsent: [^ self].
	self
		allNamespaceScopesWithValidationDo: [:scope |
			scope unmapPrefix: aPrefix]
		whileTrue: [:scope |
			scope
				includesPrefix: aPrefix
				mappedTo: currentNamespaceURI].
]

{ #category : #namespacing }
XMLElement >> undeclarePrefixes [
	self declaredPrefixes do: [:each |
		self undeclarePrefix: each]
]

{ #category : #private }
XMLElement >> validateAttributes [
	self usesNamespaces
		ifTrue: [
			self namespaceScope validateAttributePrefixes:
				self attributeNodes attributesByName]
]

{ #category : #private }
XMLElement >> validateName [
	self usesNamespaces
		ifTrue: [
			self namespaceScope
				validateAndResolvePrefix: self prefix
				ofElement: self name]
]

{ #category : #validating }
XMLElement >> validateWith: aValidator [
	| attributeDictionary |

	attributeDictionary := 
		self hasAttributes
			ifTrue: [self attributeNodes asDictionary]
			ifFalse: [Dictionary new].
	aValidator
		validateStartTag: self name
		attributes: attributeDictionary.
	"validation can change/add attribute values"
	self setAttributes: attributeDictionary.

	super validateWith: aValidator.

	aValidator validateEndTag: self name.
]

{ #category : #printing }
XMLElement >> writeXMLOn: aWriter [
	| tagWriter |

	tagWriter := aWriter tag: self name.
	self hasNamespaces
		ifTrue: [
			"non-standard setXMLNSDeclarations: use for performance"
			tagWriter setXMLNSDeclarations: self namespaceScope prefixMappings].
	self hasAttributes
		ifTrue: [
			"non-standard setAttributes: use for performance"
			tagWriter setAttributes: self attributeNodes].
	self hasChildren
		ifTrue: [tagWriter with: [self writeInnerXMLOn: aWriter]]
		ifFalse: [tagWriter write].
]

"
The class represents an element node. An element consists of a name and optionally attributes, namespace declarations and any number child nodes and elements.

The name can consist of a local name only or a qualified name, which is a namespace prefix and local name separated by a colon. If the name is qualfied and namespace support is enabled (the default), then the prefix must be mapped to a namespace URI in the element or its parent at the time the name is set. The class-side instance creation #name:namespaceURI:* messages and #name:namespaces:* messages allow you set both simulaniously, as does the instance-side #name:namespaceURI: message. If namespace support is disabled, prefixes are ignored (not validated). You can test the name of an element using #isNamed: and #isNamedAny:, which test the qualified and local names of an element for a match.

Namespaces can be declared using #declareNamespace:uri:, using #declareNamespaces: with a collection of associations (where an empty prefix represents the default namespace) or simultaniously while changing the element's name using #name:namespaceURI:. The default namespace can be accessed through #defaultNamespace and #defaultNamespace:. When you print an element, the minimum number of xmlns declarations necessary for it to be valid will be printed. You can query an element's namespace information using #namespaceURI, #prefix, #expandedName. For an element to be namespaced, it must have a qualified name with a valid prefix or have a default namespace declaration in scope for it.

The #attribute- messages provide a Dictionary-like prototcol for manipulating attribute nodes. Attribute value accessors return empty strings when the specified value is not present. The underlying attribute node list can be accessed using #attributeNodes, and an order-preserving dictionary of attribute names/values can be obtained using #attributes.

See the comment for the superclass for how to access child nodes and elements.
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
		ifTrue: [anElement inheritNamespacesFrom: self]
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

{ #category : #accessing }
XMLElement >> attributeAssociations [
	^ self attributeNodes attributeAssociations
]

{ #category : #accessing }
XMLElement >> attributeAt: aName [
	"returns empty string when absent"
	^ self attributeNodes attributeValueAt: aName
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
	^ self attributeNodes attributeNodeAt: aName
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aName ifAbsent: aBlock [
	^ self attributeNodes attributeNodeAt: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aURI [
	^ self attributeNodes attributeNodeAt: aLocalName namespaceURI: aURI
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aURI ifAbsent: aBlock [
	^ self attributeNodes attributeNodeAt: aLocalName namespaceURI: aURI ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodes [
	^ attributes ifNil: [attributes := self attributeListClass observer: self]
]

{ #category : #enumerating }
XMLElement >> attributeNodesDo: aBlock [
	self attributeNodes do: aBlock
]

{ #category : #accessing }
XMLElement >> attributes [
	^ self attributeNodes asDictionary
]

{ #category : #namespacing }
XMLElement >> declareNamespaces: aDictionaryOrArray [
	aDictionaryOrArray associationsDo: [:each |
		self
			declarePrefix: each key
			uri: each value]
]

{ #category : #namespacing }
XMLElement >> declarePrefix: aPrefix uri: aURI [
	| oldMapping |

	(oldMapping := self namespaceScope prefixMappingAt: aPrefix ifAbsent: [nil]) = aURI
		ifFalse: [
			self
				updateEnclosedScopesWith: [:scope | scope mapPrefix: aPrefix to: aURI]
				whileTrue: [:scope |
					(scope includesPrefix: aPrefix) not
						or: [scope includesPrefix: aPrefix mappedTo: oldMapping]]
				validateAfter: false]
]

{ #category : #testing }
XMLElement >> declaresDefaultNamespace [
	"Did the receiver declare a new default namespace rather than inheriting one?"

	^ self namespaceScope hasDefaultNamespace
		and: [self isRoot or: [self defaultNamespace ~= self parent defaultNamespace]]
]

{ #category : #testing }
XMLElement >> declaresPrefix: aPrefix uri: aURI [
	"Did the receiver declare a new prefix/uri pair rather than inheriting one?"

	^ (self isDeclaredPrefix: aPrefix uri: aURI)
		and: [self isRoot or: [(self parent isDeclaredPrefix: aPrefix uri: aURI) not]]
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
		updateEnclosedScopesWith: [:scope | scope defaultNamespace: aURI]
		whileTrue: [:scope | scope defaultNamespace = oldNamespace]
		validateAfter: false.
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
	^ attributes notNil and: [attributes notEmpty]
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

{ #category : #private }
XMLElement >> inheritNamespacesFrom: anElement [
	self allElementsDo: [:each |
		each namespaceScope inheritMappingsFrom:
			anElement namespaceScope]
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
		name: aQualifiedName.
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
		ifNotNil: [attributes := attributes deepCopyWithObserver: self].
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
	^ self attributeNodes remove: aNode ifAbsent: aBlock
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
	^ self namespaceScope resolvePrefix: aPrefix
]

{ #category : #initialization }
XMLElement >> setAttributes: aDictionaryOrArray [
	self hasAttributes
		ifTrue: [self attributeNodes removeAll].
	aDictionaryOrArray associationsDo: [:each |
		self attributeNodes
			addName: each key
			value: each value].
]

{ #category : #initialization }
XMLElement >> setNamespaceScope: aNamespaceScope [
	namespaceScope := aNamespaceScope
]

{ #category : #initialization }
XMLElement >> setQualifiedName: aQualifiedName localName: aLocalName attributes: anAttributeDictionary [
	name := aQualifiedName.
	localName := aLocalName.
	anAttributeDictionary isEmpty "avoid ifNotEmpty: closure overhead"
		ifFalse: [
			"The setFrom method is used to avoid revalidating the
			attributes when adding them to the list"
			(attributes := self attributeListClass new: anAttributeDictionary size)
					observer: self;
					setFromDictionary: anAttributeDictionary].
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
	| currentMapping |

	currentMapping := self namespaceScope prefixMappingAt: aPrefix ifAbsent: [^ self].
	self
		updateEnclosedScopesWith: [:scope | scope unmapPrefix: aPrefix]
		whileTrue: [:scope | scope includesPrefix: aPrefix mappedTo: currentMapping]
		validateAfter: true.
]

{ #category : #private }
XMLElement >> updateEnclosedScopesWith: aBlock whileTrue: aConditionalBlock validateAfter: aBoolean [
	"Updates the receiver's scope and the scopes of all descendants with aBlock
	where aConditional is true. It stops descending down a path of a subtree
	as soon as aConditional is false, but continues down other paths."

	(aConditionalBlock value: self namespaceScope)
		ifFalse: [^ self].

	aBlock value: self namespaceScope.
	aBoolean
		ifTrue: [
			self
				validateName;
				validateAttributes].
	self elementsDo: [:each |
		each
			updateEnclosedScopesWith: aBlock
			whileTrue: aConditionalBlock
			validateAfter: aBoolean]
]

{ #category : #private }
XMLElement >> validateAttributes [
	self usesNamespaces
		ifTrue: [
			self namespaceScope
				validateAttributePrefixes: self attributeNodes attributesByName]
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
	self setAttributes: attributeDictionary.

	super validateWith: aValidator.

	aValidator validateEndTag: self name.
]

{ #category : #printing }
XMLElement >> writeXMLOn: aWriter [
	| tagWriter |

	tagWriter := aWriter tag: self name.

	"non-standard use for performance"
	self hasNamespaces
		ifTrue: [tagWriter setXMLNSDeclarations: self namespaceScope prefixMappings].
	self hasAttributes
		ifTrue: [tagWriter setAttributes: self attributeNodes].
	self hasChildren
		ifTrue: [tagWriter with: [self writeInnerXMLOn: aWriter]]
		ifFalse: [tagWriter write].
]

"
The class represents an element node. An element consists of a name and optionally attributes, namespace declarations and any number child nodes and elements.

The name can consist of a local name only or a qualified name, which is a namespace prefix and local name separated by a colon. If the name is qualfied and namespace support is enabled (the default), then the prefix must be mapped to a namespace URI in the element or its parent at the time the name is set. The class-side instance creation #name:namespaceURI:* messages and #name:namespaces:* messages allow you set both simulaniously, as does the instance-side #name:namespaceURI: message. If namespace support is disabled, prefixes are ignored (not validated). You can test the name of an element using #isNamed: and #isNamedAny:, which test the qualified and local names of an element for a match.

Namespaces can be declared using #declareNamespace:uri:, using #declareNamespaces: with a collection of associations (where an empty prefix represents the default namespace) or simultaniously while changing the element's name using #name:namespaceURI:. The default namespace can be accessed through #defaultNamespace and #defaultNamespace:. When you print an element, the minimum number of xmlns declarations necessary for it to be valid will be printed. You can query an element's namespace information using #namespaceURI, #prefix, #expandedName and other messages under ""namespaces."""" For an element to be namespaced, it must have a qualified name with a valid prefix or have a default namespace declaration in scope for it.

The #attribute- messages provide a Dictionary-like prototcol for manipulating attribute nodes. Attribute value accessors return empty strings when the specified value is not present. The underlying attribute node list can be accessed using #attributeNodes, and an order-preserving dictionary of attribute names/values can be obtained using #attributes.

See the comment for the superclass for how to access child nodes and elements.
"
Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'attributes',
		'namespaceScope',
		'document',
		'notifier'
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

{ #category : #accessing }
XMLElement >> addContent: aStringOrStringNode [
	"Adds a string or string node. If the last child node is already a string node,
	the characters being added are concatenated to it."

	(self hasChildren and: [self lastNode acceptsContent])
		ifTrue: [self lastNode addContent: aStringOrStringNode]
		ifFalse: [self addNode: aStringOrStringNode asXMLString]
]

{ #category : #notifications }
XMLElement >> addedAttribute: anAttribute [
	anAttribute
		addObserver: self;
		element: self.
	self validateAttributes.
]

{ #category : #notifications }
XMLElement >> addedElement: anElement [
	super addedElement: anElement.
	(self hasNamespaces
		and: [self namespaceScope ~= anElement namespaceScope])
		ifTrue: [anElement inheritNamespacesFrom: self]
]

{ #category : #enumerating }
XMLElement >> allElementsDo: aBlock [
	"See superclass version."

	aBlock value: self.

	super allElementsDo: aBlock.
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
	^ self attributeNodes attributeNodeAt: aName
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aName ifAbsent: aBlock [
	^ self attributeNodes attributeNodeAt: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aUri [
	^ self attributeNodes attributeNodeAt: aLocalName namespaceURI: aUri
]

{ #category : #accessing }
XMLElement >> attributeNodeAt: aLocalName namespaceURI: aUri ifAbsent: aBlock [
	^ self attributeNodes attributeNodeAt: aLocalName namespaceURI: aUri ifAbsent: aBlock
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

{ #category : #namespaces }
XMLElement >> declareNamespaces: aDictionaryOrArray [
	aDictionaryOrArray associationsDo: [:each |
		each key isEmptyOrNil
			ifTrue: [self defaultNamespace: each value]
			ifFalse: [self declarePrefix: each key uri: each value]]
]

{ #category : #namespaces }
XMLElement >> declarePrefix: aPrefix uri: aUri [
	| oldMapping |

	oldMapping := self namespaceScope resolvePrefix: aPrefix.
	oldMapping = aUri
		ifTrue: [^ self].

	self
		updateEnclosedScopesWith: [:scope | scope mapPrefix: aPrefix to: aUri]
		whileTrue: [:scope |
			(scope includesPrefix: aPrefix) not
				or: [scope includesPrefix: aPrefix mappedTo: oldMapping]].
]

{ #category : #namespaces }
XMLElement >> declaresDefaultNamespace [
	"Did the receiver declare a new default namespace rather than inheriting one?"

	^ self namespaceScope hasDefaultNamespace
		and: [self defaultNamespace isEmpty
			or: [self isRoot
				or: [self defaultNamespace ~= self parent defaultNamespace]]]
]

{ #category : #namespaces }
XMLElement >> declaresPrefix: aPrefix uri: aUri [
	"Did the receiver declare a new prefix/uri pair rather than inheriting one?"

	^ (self isDeclaredPrefix: aPrefix uri: aUri)
		and: [self isRoot
			or: [(self parent resolvePrefix: aPrefix) ~= aUri]]
]

{ #category : #namespaces }
XMLElement >> defaultNamespace [
	^ self namespaceScope defaultNamespace
]

{ #category : #namespaces }
XMLElement >> defaultNamespace: aUri [
	| oldNamespace |

	oldNamespace := self defaultNamespace.
	self
		updateEnclosedScopesWith: [:scope |
			scope defaultNamespace:
				(aUri
					ifEmpty: [scope == self namespaceScope ifTrue: [''] ifFalse: [nil]]
					ifNotEmpty: [aUri])]
		whileTrue: [:scope |
			scope hasDefaultNamespace not
				or: [scope defaultNamespace = oldNamespace]]
]

{ #category : #accessing }
XMLElement >> document [
	^ document
]

{ #category : #accessing }
XMLElement >> document: aDocument [
	document := aDocument.

	self hasElements
		ifTrue: [self elementsDo: [:each | each document: aDocument]]
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
XMLElement >> hasNamespaces [
	^ namespaceScope notNil and: [namespaceScope hasNamespaces]
]

{ #category : #namespaces }
XMLElement >> hasPrefix [
	^ self nodeName isPrefixed
]

{ #category : #testing }
XMLElement >> hasStringNodes [
	^ self nodes anySatisfy: [:each | each isStringNode]
]

{ #category : #testing }
XMLElement >> includesAttribute: aName [
	^ self attributeNodes includesAttribute: aName.
]

{ #category : #private }
XMLElement >> inheritNamespacesFrom: anElement [
	self allElementsDo: [:each |
		each namespaceScope inheritMappingsFrom: anElement namespaceScope]
]

{ #category : #namespaces }
XMLElement >> isDeclaredPrefix: aPrefix [
	^ self namespaceScope includesPrefix: aPrefix
]

{ #category : #namespaces }
XMLElement >> isDeclaredPrefix: aPrefix uri: aUri [
	^ self namespaceScope includesPrefix: aPrefix mappedTo: aUri
]

{ #category : #testing }
XMLElement >> isElement [
	^ true
]

{ #category : #testing }
XMLElement >> isNamed: aName [
	"Does the receiver's qualified or local name match the argument?'"
	^ self nodeName isSameAs: aName
]

{ #category : #testing }
XMLElement >> isNamedAny: aNameCollection [
	"Does the receiver's qualified or local name match any of the names supplied as the argument?'"
	^ aNameCollection anySatisfy: [:each |
		"inline isNamed:"
		self nodeName isSameAs: each]
]

{ #category : #testing }
XMLElement >> isRoot [
	"Is the receiver the root element?"
	^ (self hasParent and: [self parent isElement]) not
]

{ #category : #accessing }
XMLElement >> localName [
	^ self nodeName localPart
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
	self
		declarePrefix: (aQualifiedName qualifiedNamePrefix) uri: aUri;
		name: aQualifiedName.
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
	^ self parent ifNotNil: [self parent elementAfter: self]
]

{ #category : #private }
XMLElement >> nodeName [
	^ name
		ifNil: [ 
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

{ #category : #private }
XMLElement >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
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
	^ self parent ifNotNil: [self parent elementBefore: self]
]

{ #category : #accessing }
XMLElement >> removeAttribute: aName [
	^ (self attributeNodes removeAttributeNodeAt: aName) value.
]

{ #category : #accessing }
XMLElement >> removeAttributeNode: aNode [
	^ self attributeNodes remove: aNode
]

{ #category : #accessing }
XMLElement >> removeAttributes [
	^ self attributeNodes removeAll
]

{ #category : #notifications }
XMLElement >> removedAttribute: anAttribute [
	anAttribute
		removeObserver: self;
		element: nil
]

{ #category : #notifications }
XMLElement >> renamedAttribute: anAttribute from: anOldName to: aNewName [
	self validateAttributes
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
XMLElement >> setNamespaceScope: aNamespaceScope [
	namespaceScope := aNamespaceScope
]

{ #category : #initialization }
XMLElement >> setQualifiedName: aQualifiedName prefix: aPrefix localName: aLocalName attributes: anAttributeDictionary [
	"This is used instead of using #nodeName's ifNil: initialization to avoid
	sending a name-changed notification"
	(name := XMLNodeName new)
		setQualified: aQualifiedName prefix: aPrefix localPart: aLocalName;
		addObserver: self.

	anAttributeDictionary isEmpty "avoid ifNotEmpty: closure overhead"
		ifFalse: [
			"The setFrom method is used to avoid revalidating the
			attributes when adding them to the list"
			(attributes := XMLAttributeList new: anAttributeDictionary size)
				setFromDictionary: anAttributeDictionary andElement: self;
				addObserver: self].
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

{ #category : #namespaces }
XMLElement >> undeclarePrefix: aPrefix [
	self namespaceScope unmapPrefix: aPrefix
]

{ #category : #private }
XMLElement >> updateEnclosedScopesWith: aBlock whileTrue: aConditionalBlock [
	"Updates the receiver's scope and the scopes of all descendants with aBlock
	where aConditional is true. It stops descending down a path of a subtree
	as soon as aConditional is false, but continues down other paths."

	(aConditionalBlock value: self namespaceScope)
		ifTrue: [aBlock value: self namespaceScope]
		ifFalse: [^ self].

	self elementsDo: [:each |
		each
			updateEnclosedScopesWith: aBlock
			whileTrue: aConditionalBlock]
]

{ #category : #private }
XMLElement >> validateAttributes [
	self usesNamespaces
		ifFalse: [^ self].

	self namespaceScope validateAttributePrefixes: self attributeNodes attributesByName.
]

{ #category : #private }
XMLElement >> validateName [
	(self usesNamespaces and: [self hasPrefix])
		ifTrue: [
			self namespaceScope
				validateAndResolvePrefix: self prefix
				ofName: self name]
]

{ #category : #printing }
XMLElement >> writeNamespaceDeclarationsOn: aTagWriter [
	(self declaresDefaultNamespace
		or: [self defaultNamespace notEmpty
			and: [aTagWriter isEmbedded not]])
		ifTrue: [aTagWriter xmlns: self defaultNamespace].

	self namespaceScope prefixesAndURIsDo: [:prefix :uri |
		((self declaresPrefix: prefix uri: uri) or: [aTagWriter isEmbedded not])
			ifTrue: [aTagWriter xmlnsAt: prefix put: uri]]
]

{ #category : #printing }
XMLElement >> writeXMLOn: aWriter [
	| tagWriter |

	tagWriter := aWriter tag: self name.

	self hasNamespaces
		ifTrue: [self writeNamespaceDeclarationsOn: tagWriter].
	self hasAttributes 
		ifTrue: [
			self attributeNodes do: [:each |
				tagWriter attributeAt: each name put: each value]].

	tagWriter with: [self writeInnerXMLOn: aWriter].
]

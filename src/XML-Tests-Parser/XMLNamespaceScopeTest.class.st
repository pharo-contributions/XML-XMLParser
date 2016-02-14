Class {
	#name : #XMLNamespaceScopeTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Namespaces'
}

{ #category : #accessing }
XMLNamespaceScopeTest >> namespaces [
	^ OrderPreservingStringDictionary new
		at: 'prefix1' put: 'ns1';
		at: 'prefix2' put: 'ns2';
		at: '' put: 'defaultNS';
		yourself
]

{ #category : #'instance creation' }
XMLNamespaceScopeTest >> newNamespaceScope [
	^ XMLNamespaceScope new
]

{ #category : #'instance creation' }
XMLNamespaceScopeTest >> newNamespaceScopeWithNamespaces [
	| scope |

	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |
		scope
			mapPrefix: prefix
			to: uri].
	^ scope.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testCopy [
	| scope oldPrefixMappings |

	scope := self newNamespaceScopeWithNamespaces.
	oldPrefixMappings := scope prefixMappings.
	self assert: scope copy prefixMappings == oldPrefixMappings.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testDefaultNamespace [
	| namespaceScope oldPrefixMappings |

	namespaceScope := self newNamespaceScope.
	self assert: namespaceScope defaultNamespace isEmpty.

	oldPrefixMappings := namespaceScope prefixMappings.
	namespaceScope defaultNamespace: 'test'.
	self
		assert: namespaceScope defaultNamespace = 'test';
		assert: (namespaceScope prefixMappings at: '') = 'test';
		deny: namespaceScope prefixMappings = oldPrefixMappings.

	namespaceScope unmapPrefix: ''.
	self assert: namespaceScope defaultNamespace isEmpty.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testEquals [
	self
		assert: self newNamespaceScope = self newNamespaceScope;
		assert: self newNamespaceScopeWithNamespaces = self newNamespaceScopeWithNamespaces;
		deny: self newNamespaceScope = self newNamespaceScopeWithNamespaces;
		deny: self newNamespaceScopeWithNamespaces = self newNamespaceScope
]

{ #category : #tests }
XMLNamespaceScopeTest >> testHasDefaultNamespace [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self deny: namespaceScope hasDefaultNamespace.

	namespaceScope defaultNamespace: 'test'.
	self assert: namespaceScope hasDefaultNamespace.

	namespaceScope defaultNamespace: ''.
	self assert: namespaceScope hasDefaultNamespace.

	namespaceScope unmapPrefix: ''.
	self deny: namespaceScope hasDefaultNamespace.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testHasNamespaces [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self deny: namespaceScope hasNamespaces.

	namespaceScope mapPrefixesAndURIs: self namespaces.
	self assert: namespaceScope hasNamespaces.
	self namespaces keysDo: [:each |
		self assert: namespaceScope hasNamespaces.
		namespaceScope unmapPrefix: each].
	self deny: namespaceScope hasNamespaces.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testIncludesPrefix [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self
		deny: (namespaceScope includesPrefix: 'xml');
		deny: (namespaceScope includesPrefix: 'xmlns').

	"cannot map xmlns prefix, but can map xml"
	namespaceScope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert: (namespaceScope includesPrefix: 'xml').

	self namespaces keysAndValuesDo: [:prefix :uri |
		self deny: (namespaceScope includesPrefix: prefix).
		namespaceScope mapPrefix: prefix to: uri.
		self assert: (namespaceScope includesPrefix: prefix)].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testIncludesPrefixMappedTo [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self
		deny: (namespaceScope includesPrefix: 'xml' mappedTo: XMLNamespaceScope xmlNamespaceURI);
		deny: (namespaceScope includesPrefix: 'xmlns' mappedTo: XMLNamespaceScope xmlnsNamespaceURI).

	"cannot map xmlns prefix, but can map xml"
	namespaceScope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert: (namespaceScope includesPrefix: 'xml' mappedTo: XMLNamespaceScope xmlNamespaceURI).

	self namespaces keysAndValuesDo: [:prefix :uri |
		self deny: (namespaceScope includesPrefix: prefix mappedTo: uri).
		namespaceScope mapPrefix: prefix to: uri.
		self assert: (namespaceScope includesPrefix: prefix mappedTo: uri)].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testInheritMappingsFrom [
	| outerScope innerScope |

	outerScope := self newNamespaceScopeWithNamespaces.
	innerScope := self newNamespaceScope.
	innerScope inheritMappingsFrom: outerScope.
	self assert: innerScope prefixMappings == outerScope prefixMappings.

	innerScope := self newNamespaceScopeWithNamespaces.
	innerScope inheritMappingsFrom: outerScope.
	self
		assert: innerScope prefixMappings = outerScope prefixMappings;
		deny: innerScope prefixMappings == outerScope prefixMappings.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testMapPrefixTo [
	| scope oldPrefixMappings |

	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |
		oldPrefixMappings := scope prefixMappings.
		scope
			mapPrefix: prefix
			to: uri.
		"ensure prefixMappings is copied when adding"
		self
			assert: (scope prefixMappings at: prefix) = uri;
			deny: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings.

		oldPrefixMappings := scope prefixMappings.
		scope
			mapPrefix: prefix
			to: uri.
		"ensure prefixMappings is copied, even if it is unchanged"
		self
			assert: (scope prefixMappings at: prefix) = uri;
			assert: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings].
	self assert: scope prefixMappings associations asArray = self namespaces associations asArray.

	self namespaces keysAndValuesDo: [:prefix :uri |
		scope
			mapPrefix: prefix
			to: 'newNS'.
		self
			assert: (scope prefixMappings at: prefix) = 'newNS';
			deny: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testMapPrefixesAndURIs [
	| outerScope innerScope namespaces |

	namespaces := self namespaces.
	(outerScope := self newNamespaceScope) mapPrefixesAndURIs: namespaces.
	self
		assert: outerScope prefixMappings = namespaces;
		deny: outerScope prefixMappings == namespaces.

	"copying shares dictionary until modified"
	innerScope := outerScope copy.
	self
		assert: innerScope prefixMappings = outerScope prefixMappings;
		assert: innerScope prefixMappings == outerScope prefixMappings.

	"modifying creates new dictionary"
	innerScope mapPrefixesAndURIs: namespaces.
	self
		assert: innerScope prefixMappings = outerScope prefixMappings;
		deny: innerScope prefixMappings == outerScope prefixMappings.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testPrefixMappingAt [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self
		assert: (namespaceScope prefixMappingAt: 'xml') isEmpty;
		assert: (namespaceScope prefixMappingAt: 'xmlns') isEmpty.

	"cannot map xmlns prefix, but can map xml"
	namespaceScope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert: (namespaceScope prefixMappingAt: 'xml') = XMLNamespaceScope xmlNamespaceURI.

	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (namespaceScope prefixMappingAt: prefix) isEmpty.
		namespaceScope mapPrefix: prefix to: uri.
		self assert: (namespaceScope prefixMappingAt: prefix) = uri].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testPrefixMappingAtIfAbsent [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self
		assert: (namespaceScope prefixMappingAt: 'xml' ifAbsent: [#absent]) = #absent;
		assert: (namespaceScope prefixMappingAt: 'xmlns'ifAbsent: [#absent]) = #absent.

	"cannot map xmlns prefix, but can map xml"
	namespaceScope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert:
		(namespaceScope
			prefixMappingAt: 'xml'
			ifAbsent: [#absent]) = XMLNamespaceScope xmlNamespaceURI.

	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert:
			(namespaceScope
				prefixMappingAt: prefix
				ifAbsent: [#absent]) = #absent.
		namespaceScope mapPrefix: prefix to: uri.
		self assert:
			(namespaceScope
				prefixMappingAt: prefix
				ifAbsent: [#absent]) = uri].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testPrefixesAndURIsDo [
	| associations |

	associations := OrderedCollection new.
	self newNamespaceScope prefixesAndURIsDo: [:prefix :uri |
		associations addLast: prefix -> uri].
	self assert: associations isEmpty.

	self newNamespaceScopeWithNamespaces prefixesAndURIsDo: [:prefix :uri |
		associations addLast: prefix -> uri].
	self assert: associations asArray = self namespaces associations asArray.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testPrefixesOfNamespaceURI [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self assert:
		(namespaceScope prefixesOfNamespaceURI: XMLNamespaceScope xmlNamespaceURI) =
			(Set with: 'xml').
	self assert:
		(namespaceScope prefixesOfNamespaceURI: XMLNamespaceScope xmlnsNamespaceURI) =
			(Set with: 'xmlns').

	"cannot map xmlns prefix, but can map xml"
	namespaceScope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert:
		(namespaceScope prefixesOfNamespaceURI: XMLNamespaceScope xmlNamespaceURI) =
			(Set with: 'xml').

	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (namespaceScope prefixesOfNamespaceURI: uri) isEmpty.

		namespaceScope mapPrefix: prefix to: uri.
		self assert: (namespaceScope prefixesOfNamespaceURI: uri) = (Set with: prefix).

		namespaceScope mapPrefix: 'newPrefix' to: uri.
		self assert:
			(namespaceScope prefixesOfNamespaceURI: uri) =
				(Set with: prefix with: 'newPrefix')].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testResolvePrefix [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (namespaceScope resolvePrefix: prefix) isEmpty.
		namespaceScope mapPrefix: prefix to: uri.
		self assert: (namespaceScope resolvePrefix: prefix) = uri].

	self
		assert: (namespaceScope resolvePrefix: 'xml') = XMLNamespaceScope xmlNamespaceURI;
		assert: (namespaceScope resolvePrefix: 'xmlns') = XMLNamespaceScope xmlnsNamespaceURI.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testResolvePrefixIfUnresolvable [
	| namespaceScope |

	namespaceScope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert:
			(namespaceScope
				resolvePrefix: prefix
				ifUnresolvable: [#unresolvable]) = #unresolvable.
		namespaceScope mapPrefix: prefix to: uri.
		self assert:
			(namespaceScope
				resolvePrefix: prefix
				ifUnresolvable: [#unresolvable]) = uri].

	self assert:
		(namespaceScope
			resolvePrefix: 'xml'
			ifUnresolvable: [#unresolvable]) = XMLNamespaceScope xmlNamespaceURI.
	self  assert:
		(namespaceScope
			resolvePrefix: 'xmlns'
			ifUnresolvable: [#unresolvable]) = XMLNamespaceScope xmlnsNamespaceURI.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testSize [
	self
		assert: self newNamespaceScope size = 0;
		assert: self newNamespaceScopeWithNamespaces size = self namespaces size
]

{ #category : #tests }
XMLNamespaceScopeTest >> testUnmapPrefix [
	| scope oldPrefixMappings |

	scope := self newNamespaceScopeWithNamespaces.
	self namespaces keysAndValuesDo: [:prefix :uri |
		oldPrefixMappings := scope prefixMappings.
		scope unmapPrefix: prefix.
		"ensure prefixMappings is copied when removing"
		self
			deny: (scope prefixMappings includesKey: prefix);
			deny: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings.

		self
			should: [scope unmapPrefix: prefix]
			raise: XMLNamespaceException].
	self assert: scope prefixMappings isEmpty.
]

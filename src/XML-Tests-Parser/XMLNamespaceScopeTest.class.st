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
	| scope oldPrefixMappings |

	scope := self newNamespaceScope.
	self assert: scope defaultNamespace isEmpty.

	oldPrefixMappings := scope prefixMappings.
	scope defaultNamespace: 'test'.
	self
		assert: scope defaultNamespace = 'test';
		assert: (scope prefixMappings at: '') = 'test';
		deny: scope prefixMappings = oldPrefixMappings.

	scope unmapPrefix: ''.
	self assert: scope defaultNamespace isEmpty.
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
	| scope |

	scope := self newNamespaceScope.
	self deny: scope hasDefaultNamespace.

	scope defaultNamespace: 'test'.
	self assert: scope hasDefaultNamespace.

	scope defaultNamespace: ''.
	self assert: scope hasDefaultNamespace.

	scope unmapPrefix: ''.
	self deny: scope hasDefaultNamespace.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testHasNamespaces [
	| scope |

	scope := self newNamespaceScope.
	self deny: scope hasNamespaces.

	scope mapPrefixesAndURIs: self namespaces.
	self assert: scope hasNamespaces.
	self namespaces keysDo: [:each |
		self assert: scope hasNamespaces.
		scope unmapPrefix: each].
	self deny: scope hasNamespaces.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testHash [
	self assert:
		self newNamespaceScope hash =
			self newNamespaceScope hash.
	self assert:
		self newNamespaceScopeWithNamespaces hash =
			self newNamespaceScopeWithNamespaces hash.
	self assert:
		self newNamespaceScope hash =
			(self newNamespaceScopeWithNamespaces
				unmapPrefixes;
				hash).
]

{ #category : #tests }
XMLNamespaceScopeTest >> testIncludesPrefix [
	| scope |

	scope := self newNamespaceScope.
	self
		deny: (scope includesPrefix: 'xml');
		deny: (scope includesPrefix: 'xmlns').

	"cannot map xmlns prefix, but can map xml"
	scope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert: (scope includesPrefix: 'xml').

	self namespaces keysAndValuesDo: [:prefix :uri |
		self deny: (scope includesPrefix: prefix).
		scope mapPrefix: prefix to: uri.
		self assert: (scope includesPrefix: prefix)].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testIncludesPrefixMappedTo [
	| scope |

	scope := self newNamespaceScope.
	self
		deny: (scope includesPrefix: 'xml' mappedTo: XMLNamespaceScope xmlNamespaceURI);
		deny: (scope includesPrefix: 'xmlns' mappedTo: XMLNamespaceScope xmlnsNamespaceURI).

	"cannot map xmlns prefix, but can map xml"
	scope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert: (scope includesPrefix: 'xml' mappedTo: XMLNamespaceScope xmlNamespaceURI).

	self namespaces keysAndValuesDo: [:prefix :uri |
		self deny: (scope includesPrefix: prefix mappedTo: uri).
		scope mapPrefix: prefix to: uri.
		self assert: (scope includesPrefix: prefix mappedTo: uri)].
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
		"save to ensure prefixMappings is copied, even if unchanged"
		oldPrefixMappings := scope prefixMappings.
		scope
			mapPrefix: prefix
			to: uri.
		self
			assert: (scope prefixMappings at: prefix) = uri;
			deny: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings.

		"save to ensure prefixMappings is copied, even if unchanged"
		oldPrefixMappings := scope prefixMappings.
		scope
			mapPrefix: prefix
			to: uri.
		self
			assert: (scope prefixMappings at: prefix) = uri;
			assert: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings].
	self assert:
		scope prefixMappings associations asArray =
			self namespaces associations asArray.

	self namespaces keysDo: [:each |
		"save to ensure prefixMappings is copied, even if unchanged"
		oldPrefixMappings := scope prefixMappings.
		scope
			mapPrefix: each
			to: 'newNS'.
		self
			assert: (scope prefixMappings at: each) = 'newNS';
			deny: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings].

	"save to ensure prefixMappings is copied, even if unchanged"
	oldPrefixMappings := scope prefixMappings.
	scope
		mapPrefix: 'xml'
		to: scope xmlNamespaceURI.
	self
		assert: (scope prefixMappings at: 'xml') = scope xmlNamespaceURI;
		deny: scope prefixMappings = oldPrefixMappings;
		deny: scope prefixMappings == oldPrefixMappings.

	"cannot rebind xmlns prefix at all, even to the same URI"
	self
		should: [
			scope
				mapPrefix: 'xmlns'
				to: scope xmlnsNamespaceURI]
		raise: XMLNamespaceException.

	"cannot bind a new prefix to the xml, xmlns, or empty namespace URI"
	(Array
		with: scope xmlNamespaceURI
		with: scope xmlnsNamespaceURI
		with: '') do: [:each |
		self
			should: [
				scope
					mapPrefix: 'newPrefix'
					to: each]
			raise: XMLNamespaceException].
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
XMLNamespaceScopeTest >> testMappedPrefixes [
	| scope prefixes |

	scope := self newNamespaceScope.
	prefixes := OrderedCollection new.
	self namespaces keysAndValuesDo: [:prefix :uri |
		scope
			mapPrefix: prefix
			to: uri.
		prefixes addLast: prefix.
		self assert: scope mappedPrefixes = prefixes asArray].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testPrefixMappingAt [
	| scope |

	scope := self newNamespaceScope.
	self
		assert: (scope prefixMappingAt: 'xml') isEmpty;
		assert: (scope prefixMappingAt: 'xmlns') isEmpty.

	"cannot map xmlns prefix, but can map xml"
	scope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert: (scope prefixMappingAt: 'xml') = XMLNamespaceScope xmlNamespaceURI.

	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (scope prefixMappingAt: prefix) isEmpty.
		scope mapPrefix: prefix to: uri.
		self assert: (scope prefixMappingAt: prefix) = uri].
]

{ #category : #tests }
XMLNamespaceScopeTest >> testPrefixMappingAtIfAbsent [
	| scope |

	scope := self newNamespaceScope.
	self
		assert: (scope prefixMappingAt: 'xml' ifAbsent: [#absent]) = #absent;
		assert: (scope prefixMappingAt: 'xmlns'ifAbsent: [#absent]) = #absent.

	"cannot map xmlns prefix, but can map xml"
	scope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self assert:
		(scope
			prefixMappingAt: 'xml'
			ifAbsent: [#absent]) = XMLNamespaceScope xmlNamespaceURI.

	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert:
			(scope
				prefixMappingAt: prefix
				ifAbsent: [#absent]) = #absent.
		scope mapPrefix: prefix to: uri.
		self assert:
			(scope
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
XMLNamespaceScopeTest >> testResolvePrefix [
	| scope |

	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert: (scope resolvePrefix: prefix) isEmpty.
		scope mapPrefix: prefix to: uri.
		self assert: (scope resolvePrefix: prefix) = uri].

	self assert:
		(scope resolvePrefix: 'xml') = scope xmlNamespaceURI.

	self assert:
		(scope resolvePrefix: 'xmlns') = scope xmlnsNamespaceURI.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testResolvePrefixIfUnresolvable [
	| scope |

	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert:
			(scope
				resolvePrefix: prefix
				ifUnresolvable: [#unresolvable]) = #unresolvable.
		scope mapPrefix: prefix to: uri.
		self assert:
			(scope
				resolvePrefix: prefix
				ifUnresolvable: [#unresolvable]) = uri].

	self assert:
		(scope
			resolvePrefix: 'xml'
			ifUnresolvable: [#unresolvable]) = scope xmlNamespaceURI.

	self  assert:
		(scope
			resolvePrefix: 'xmlns'
			ifUnresolvable: [#unresolvable]) = scope xmlnsNamespaceURI.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testResolvePrefixesOfNamespaceURI [
	| scope |

	scope := self newNamespaceScope.

	self namespaces keysAndValuesDo: [:prefix :uri |
		self assert:
			(scope resolvePrefixesOfNamespaceURI: uri) isEmpty.

		scope
			mapPrefix: prefix
			to: uri.
		self assert:
			(scope resolvePrefixesOfNamespaceURI: uri) =
				(Set with: prefix).

		scope
			mapPrefix: 'newPrefix'
			to: uri.
		self assert:
			(scope resolvePrefixesOfNamespaceURI: uri) =
				(Set with: prefix with: 'newPrefix')].

	self assert:
		(scope resolvePrefixesOfNamespaceURI: scope xmlNamespaceURI) =
			(Set with: 'xml').
	self assert:
		(scope resolvePrefixesOfNamespaceURI: scope xmlnsNamespaceURI) =
			(Set with: 'xmlns').

	"cannot map xmlns prefix at all, but can map xml to the same URI"
	scope
		mapPrefix: 'xml'
		to: scope xmlNamespaceURI.
	self assert:
		(scope resolvePrefixesOfNamespaceURI: scope xmlNamespaceURI) =
			(Set with: 'xml').
]

{ #category : #tests }
XMLNamespaceScopeTest >> testSize [
	self
		assert: self newNamespaceScope size = 0;
		assert: self newNamespaceScopeWithNamespaces size = self namespaces size
]

{ #category : #tests }
XMLNamespaceScopeTest >> testUnmapPrefix [
	| scope |

	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |  | oldPrefixMappings |
		self
			should: [scope unmapPrefix: prefix]
			raise: XMLNamespaceException.
		scope
			mapPrefix: prefix
			to: uri.
	
		oldPrefixMappings := scope prefixMappings.
		self assert: (scope unmapPrefix: prefix) = uri.

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

{ #category : #tests }
XMLNamespaceScopeTest >> testUnmapPrefixIfAbsent [
	| scope |

	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |  | oldPrefixMappings |
		self assert:
			(scope
				unmapPrefix: prefix
				ifAbsent: [#absent]) = #absent.
		scope
			mapPrefix: prefix
			to: uri.

		oldPrefixMappings := scope prefixMappings.
		self assert:
			(scope
				unmapPrefix: prefix
				ifAbsent: [#absent]) = uri.

		"ensure prefixMappings is copied when removing"
		self
			deny: (scope prefixMappings includesKey: prefix);
			deny: scope prefixMappings = oldPrefixMappings;
			deny: scope prefixMappings == oldPrefixMappings.

		self
			assert:
				(scope
					unmapPrefix: prefix
					ifAbsent: [#absent]) = #absent].
	self assert: scope prefixMappings isEmpty.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testXMLNSNamespaceURI [
	| namespaceURI |

	namespaceURI := 'http://www.w3.org/2000/xmlns/'.
	self
		assert: self newNamespaceScope xmlnsNamespaceURI = namespaceURI;
		assert: XMLNamespaceScope xmlnsNamespaceURI = namespaceURI.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testXMLNamespaceURI [
	| namespaceURI |

	namespaceURI := 'http://www.w3.org/XML/1998/namespace'.
	self
		assert: self newNamespaceScope xmlNamespaceURI = namespaceURI;
		assert: XMLNamespaceScope xmlNamespaceURI = namespaceURI.
]

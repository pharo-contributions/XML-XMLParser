Class {
	#name : 'XMLNamespaceScopeTest',
	#superclass : 'TestCase',
	#category : 'XML-Parser-Tests-Namespaces',
	#package : 'XML-Parser-Tests',
	#tag : 'Namespaces'
}

{ #category : 'accessing' }
XMLNamespaceScopeTest >> namespaces [
	^ OrderPreservingStringDictionary new
		at: 'prefix1' put: 'ns1';
		at: 'prefix2' put: 'ns2';
		at: '' put: 'defaultNS';
		yourself
]

{ #category : 'instance creation' }
XMLNamespaceScopeTest >> newNamespaceScope [
	^ XMLNamespaceScope new
]

{ #category : 'instance creation' }
XMLNamespaceScopeTest >> newNamespaceScopeWithNamespaces [
	| scope |

	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [:prefix :uri |
		scope
			mapPrefix: prefix
			to: uri].
	^ scope
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testCopy [

	| scope oldPrefixMappings copy |
	scope := self newNamespaceScopeWithNamespaces.
	oldPrefixMappings := scope prefixMappings.
	copy := scope copy.
	self
		deny: copy identicalTo: scope;
		assert: copy equals: scope;
		assert: copy prefixMappings identicalTo: oldPrefixMappings
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testDefaultNamespace [

	| scope oldPrefixMappings |
	scope := self newNamespaceScope.
	self assert: scope defaultNamespace equals: ''.

	oldPrefixMappings := scope prefixMappings.
	scope defaultNamespace: 'test'.
	self
		assert: scope defaultNamespace equals: 'test';
		assert: (scope prefixMappings at: '') equals: 'test';
		deny: scope prefixMappings equals: oldPrefixMappings.

	scope unmapPrefix: ''.
	self assert: scope defaultNamespace equals: ''
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testEquals [

	self
		assert: self newNamespaceScope equals: self newNamespaceScope;
		assert: self newNamespaceScopeWithNamespaces
		equals: self newNamespaceScopeWithNamespaces;
		deny: self newNamespaceScope
		equals: self newNamespaceScopeWithNamespaces;
		deny: self newNamespaceScopeWithNamespaces
		equals: self newNamespaceScope
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testHasDefaultNamespace [
	| scope |

	scope := self newNamespaceScope.
	self deny: scope hasDefaultNamespace.

	scope defaultNamespace: 'test'.
	self assert: scope hasDefaultNamespace.

	scope defaultNamespace: ''.
	self assert: scope hasDefaultNamespace.

	scope unmapPrefix: ''.
	self deny: scope hasDefaultNamespace
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testHasNamespaces [
	| scope |

	scope := self newNamespaceScope.
	self deny: scope hasNamespaces.

	scope mapPrefixesAndURIs: self namespaces.
	self assert: scope hasNamespaces.
	self namespaces keysDo: [:each |
		self assert: scope hasNamespaces.
		scope unmapPrefix: each].
	self deny: scope hasNamespaces
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testHash [
	"We can only safely test that equal objects have the same hash; testing
	that different objects have different hashes would be unreliable
	because #hash is non-cryptographic and has collisions."

	self
		assert: self newNamespaceScope hash
		equals: self newNamespaceScope hash.
	self
		assert: self newNamespaceScopeWithNamespaces hash
		equals: self newNamespaceScopeWithNamespaces hash.
	self
		assert: self newNamespaceScope hash
		equals: (self newNamespaceScopeWithNamespaces
				 unmapPrefixes;
				 hash)
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testIncludesPrefix [
	| scope |

	scope := self newNamespaceScope.
	self
		deny: (scope includesPrefix: 'xml');
		deny: (scope includesPrefix: 'xmlns').

	"cannot map xmlns prefix, but can map xml"
	scope
		mapPrefix: 'xml'
		to: scope xmlNamespaceURI.
	self assert: (scope includesPrefix: 'xml').

	self namespaces keysAndValuesDo: [:prefix :uri |
		self deny: (scope includesPrefix: prefix).
		scope
			mapPrefix: prefix
			to: uri.
		self assert: (scope includesPrefix: prefix)]
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testIncludesPrefixMappedTo [
	| scope |

	scope := self newNamespaceScope.
	"these are not mapped by default, but are still resolvable"
	self deny:
		(scope
			includesPrefix: 'xml'
			mappedTo: scope xmlNamespaceURI).
	self deny:
		(scope
			includesPrefix: 'xmlns'
			mappedTo: scope xmlnsNamespaceURI).

	"cannot map xmlns prefix, but can map xml"
	scope
		mapPrefix: 'xml'
		to: scope xmlNamespaceURI.
	self assert:
		(scope
			includesPrefix: 'xml'
			mappedTo: scope xmlNamespaceURI).

	self namespaces keysAndValuesDo: [:prefix :uri |
		self deny:
			(scope
				includesPrefix: prefix
				mappedTo: uri).
		scope
			mapPrefix: prefix
			to: uri.
		self assert:
			(scope
				includesPrefix: prefix
				mappedTo: uri)]
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testInheritMappingsFrom [

	| outerScope innerScope |
	outerScope := self newNamespaceScopeWithNamespaces.
	innerScope := self newNamespaceScope.
	innerScope inheritMappingsFrom: outerScope.
	self
		assert: innerScope prefixMappings
		identicalTo: outerScope prefixMappings.

	innerScope := self newNamespaceScopeWithNamespaces.
	innerScope inheritMappingsFrom: outerScope.
	self
		assert: innerScope prefixMappings equals: outerScope prefixMappings;
		deny: innerScope prefixMappings
		identicalTo: outerScope prefixMappings
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testMapPrefixTo [

	| scope oldPrefixMappings |
	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [ :prefix :uri | "save to ensure prefixMappings is copied, even if unchanged"
		oldPrefixMappings := scope prefixMappings.
		scope mapPrefix: prefix to: uri.
		self
			assert: (scope prefixMappings at: prefix) equals: uri;
			deny: scope prefixMappings equals: oldPrefixMappings;
			deny: scope prefixMappings identicalTo: oldPrefixMappings.

		"save to ensure prefixMappings is copied, even if unchanged"
		oldPrefixMappings := scope prefixMappings.
		scope mapPrefix: prefix to: uri.
		self
			assert: (scope prefixMappings at: prefix) equals: uri;
			assert: scope prefixMappings equals: oldPrefixMappings;
			deny: scope prefixMappings identicalTo: oldPrefixMappings ].
	self
		assert: scope prefixMappings associations asArray
		equals: self namespaces associations asArray.

	self namespaces keysDo: [ :each | "save to ensure prefixMappings is copied, even if unchanged"
		oldPrefixMappings := scope prefixMappings.
		scope mapPrefix: each to: 'newNS'.
		self
			assert: (scope prefixMappings at: each) equals: 'newNS';
			deny: scope prefixMappings equals: oldPrefixMappings;
			deny: scope prefixMappings identicalTo: oldPrefixMappings ].

	"save to ensure prefixMappings is copied, even if unchanged"
	oldPrefixMappings := scope prefixMappings.
	scope mapPrefix: 'xml' to: scope xmlNamespaceURI.
	self
		assert: (scope prefixMappings at: 'xml')
		equals: scope xmlNamespaceURI;
		deny: scope prefixMappings equals: oldPrefixMappings;
		deny: scope prefixMappings identicalTo: oldPrefixMappings.

	"cannot rebind xmlns prefix at all, even to the same URI"
	self
		should: [ scope mapPrefix: 'xmlns' to: scope xmlnsNamespaceURI ]
		raise: XMLNamespaceException.

	"cannot bind a new prefix to the xml, xmlns, or empty namespace URIs"
	(Array
		 with: scope xmlNamespaceURI
		 with: scope xmlnsNamespaceURI
		 with: '') do: [ :each |
		self
			should: [ scope mapPrefix: 'newPrefix' to: each ]
			raise: XMLNamespaceException ]
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testMapPrefixesAndURIs [

	| outerScope innerScope namespaces |
	namespaces := self namespaces.
	(outerScope := self newNamespaceScope) mapPrefixesAndURIs: namespaces.
	self
		assert: outerScope prefixMappings equals: namespaces;
		deny: outerScope prefixMappings identicalTo: namespaces.

	"copying shares dictionary until modified"
	innerScope := outerScope copy.
	self
		assert: innerScope prefixMappings equals: outerScope prefixMappings;
		assert: innerScope prefixMappings
		identicalTo: outerScope prefixMappings.

	"modifying creates new dictionary"
	innerScope mapPrefixesAndURIs: namespaces.
	self
		assert: innerScope prefixMappings equals: outerScope prefixMappings;
		deny: innerScope prefixMappings
		identicalTo: outerScope prefixMappings
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testMappedPrefixes [

	| scope prefixes |
	scope := self newNamespaceScope.
	prefixes := OrderedCollection new.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		scope mapPrefix: prefix to: uri.
		prefixes addLast: prefix.
		self assert: scope mappedPrefixes equals: prefixes asArray ]
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testPrefixMappingAt [

	| scope |
	scope := self newNamespaceScope.
	self
		assert: (scope prefixMappingAt: 'xml') equals: '';
		assert: (scope prefixMappingAt: 'xmlns') equals: ''.

	"cannot map xmlns prefix, but can map xml"
	scope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self
		assert: (scope prefixMappingAt: 'xml')
		equals: XMLNamespaceScope xmlNamespaceURI.

	self namespaces keysAndValuesDo: [ :prefix :uri |
		self assert: (scope prefixMappingAt: prefix) equals: ''.
		scope mapPrefix: prefix to: uri.
		self assert: (scope prefixMappingAt: prefix) equals: uri ]
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testPrefixMappingAtIfAbsent [

	| scope |
	scope := self newNamespaceScope.
	self
		assert: (scope prefixMappingAt: 'xml' ifAbsent: [ #absent ])
		equals: #absent.
	self
		assert: (scope prefixMappingAt: 'xmlns' ifAbsent: [ #absent ])
		equals: #absent.
	scope mapPrefix: 'xml' to: XMLNamespaceScope xmlNamespaceURI.
	self
		assert: (scope prefixMappingAt: 'xml' ifAbsent: [ self fail ])
		equals: XMLNamespaceScope xmlNamespaceURI.

	self namespaces keysAndValuesDo: [ :prefix :uri |
		self
			assert: (scope prefixMappingAt: prefix ifAbsent: [ #absent ])
			equals: #absent.
		scope mapPrefix: prefix to: uri.
		self
			assert: (scope prefixMappingAt: prefix ifAbsent: [ self fail ])
			equals: uri ]
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testPrefixesAndURIsDo [

	| associations |
	associations := OrderedCollection new.
	self newNamespaceScope prefixesAndURIsDo: [ :prefix :uri |
		associations addLast: prefix -> uri ].
	self assert: associations isEmpty.

	self newNamespaceScopeWithNamespaces prefixesAndURIsDo: [ :prefix :uri |
		associations addLast: prefix -> uri ].
	self
		assert: associations asArray
		equals: self namespaces associations asArray
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testResolvePrefix [

	| scope |
	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		self assert: (scope resolvePrefix: prefix) equals: ''.
		scope mapPrefix: prefix to: uri.
		self assert: (scope resolvePrefix: prefix) equals: uri ].
	self
		assert: (scope resolvePrefix: 'xml')
		equals: scope xmlNamespaceURI.
	self
		assert: (scope resolvePrefix: 'xmlns')
		equals: scope xmlnsNamespaceURI
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testResolvePrefixIfUnresolvable [

	| scope |
	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		self
			assert:
			(scope resolvePrefix: prefix ifUnresolvable: [ 'unresolvable' ])
			equals: 'unresolvable'.
		scope mapPrefix: prefix to: uri.
		self
			assert: (scope resolvePrefix: prefix ifUnresolvable: [ self fail ])
			equals: uri ].
	self
		assert: (scope resolvePrefix: 'xml' ifUnresolvable: [ self fail ])
		equals: scope xmlNamespaceURI.
	self
		assert: (scope resolvePrefix: 'xmlns' ifUnresolvable: [ self fail ])
		equals: scope xmlnsNamespaceURI
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testResolvePrefixesOfNamespaceURI [

	| scope |
	scope := self newNamespaceScope.

	self namespaces keysAndValuesDo: [ :prefix :uri |
		self assert: (scope resolvePrefixesOfNamespaceURI: uri) isEmpty.

		scope mapPrefix: prefix to: uri.
		self
			assert: (scope resolvePrefixesOfNamespaceURI: uri)
			equals: (Set with: prefix).

		scope mapPrefix: 'newPrefix' to: uri.
		self
			assert: (scope resolvePrefixesOfNamespaceURI: uri)
			equals: (Set with: prefix with: 'newPrefix') ].
	self
		assert: (scope resolvePrefixesOfNamespaceURI: scope xmlNamespaceURI)
		equals: (Set with: 'xml').
	self
		assert:
		(scope resolvePrefixesOfNamespaceURI: scope xmlnsNamespaceURI)
		equals: (Set with: 'xmlns').
	scope mapPrefix: 'xml' to: scope xmlNamespaceURI.
	self
		assert: (scope resolvePrefixesOfNamespaceURI: scope xmlNamespaceURI)
		equals: (Set with: 'xml')
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testSize [

	self
		assert: self newNamespaceScope size equals: 0;
		assert: self newNamespaceScopeWithNamespaces size
		equals: self namespaces size
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testUnmapPrefix [

	| scope |
	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		| oldPrefixMappings |
		self
			should: [ scope unmapPrefix: prefix ]
			raise: XMLNamespaceException.
		self deny: (scope includesPrefix: prefix).
		scope mapPrefix: prefix to: uri.

		oldPrefixMappings := scope prefixMappings.
		self
			assert: (scope unmapPrefix: prefix) equals: uri;
			deny: (scope includesPrefix: prefix).

		"ensure prefixMappings is copied when removing"
		self
			assert: (oldPrefixMappings includesKey: prefix);
			deny: scope prefixMappings equals: oldPrefixMappings;
			deny: scope prefixMappings identicalTo: oldPrefixMappings.

		self
			should: [ scope unmapPrefix: prefix ]
			raise: XMLNamespaceException ].
	self assert: scope prefixMappings isEmpty
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testUnmapPrefixIfAbsent [

	| scope |
	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		| oldPrefixMappings |
		self
			assert: (scope unmapPrefix: prefix ifAbsent: [ #absent ])
			equals: #absent.
		self deny: (scope includesPrefix: prefix).
		scope mapPrefix: prefix to: uri.

		oldPrefixMappings := scope prefixMappings.
		self
			assert: (scope unmapPrefix: prefix ifAbsent: [ self fail ])
			equals: uri.
		self deny: (scope includesPrefix: prefix).

		"ensure prefixMappings is copied when removing"
		self
			assert: (oldPrefixMappings includesKey: prefix);
			deny: scope prefixMappings equals: oldPrefixMappings;
			deny: scope prefixMappings identicalTo: oldPrefixMappings.
		self
			assert: (scope unmapPrefix: prefix ifAbsent: [ #absent ])
			equals: #absent ].
	self assert: scope prefixMappings isEmpty
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testUnmapPrefixes [

	| scope oldPrefixMappings |
	scope := self newNamespaceScopeWithNamespaces.
	oldPrefixMappings := scope prefixMappings.
	self
		assert: scope unmapPrefixes identicalTo: scope;
		deny: scope hasNamespaces.

	"ensure prefixMappings is copied when removing"
	self
		assert: oldPrefixMappings equals: self namespaces;
		deny: scope prefixMappings equals: oldPrefixMappings;
		deny: scope prefixMappings identicalTo: oldPrefixMappings
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testValidateAndResolvePrefixOfAttribute [

	| scope |
	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		| attribute |
		attribute := 'name' qualifyWithXMLPrefix: prefix.
		"unprefixed attributes have no namespace URI"
		prefix
			ifEmpty: [
				scope mapPrefix: prefix to: uri.
				self
					assert:
					(scope validateAndResolvePrefix: prefix ofAttribute: attribute)
					equals: '' ]
			ifNotEmpty: [
				self
					should: [
					scope validateAndResolvePrefix: prefix ofAttribute: attribute ]
					raise: XMLNamespaceException.
				scope mapPrefix: prefix to: uri.
				self
					assert:
					(scope validateAndResolvePrefix: prefix ofAttribute: attribute)
					equals: uri ] ].
	self
		assert: (scope
				 validateAndResolvePrefix: 'xml'
				 ofAttribute: ('name' qualifyWithXMLPrefix: 'xml'))
		equals: scope xmlNamespaceURI.
	self
		should: [
			scope
				validateAndResolvePrefix: 'xmlns'
				ofAttribute: ('name' qualifyWithXMLPrefix: 'xmlns') ]
		raise: XMLNamespaceException.
	self
		should: [ scope validateAndResolvePrefix: '' ofAttribute: ':name' ]
		raise: XMLNamespaceException
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testValidateAndResolvePrefixOfElement [

	| scope |
	scope := self newNamespaceScope.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		| element |
		element := 'name' qualifyWithXMLPrefix: prefix.
		prefix ifNotEmpty: [
			self
				should: [
				scope validateAndResolvePrefix: prefix ofElement: element ]
				raise: XMLNamespaceException ].
		scope mapPrefix: prefix to: uri.
		self
			assert: (scope validateAndResolvePrefix: prefix ofElement: element)
			equals: uri ].
	self
		assert: (scope
				 validateAndResolvePrefix: 'xml'
				 ofElement: ('name' qualifyWithXMLPrefix: 'xml'))
		equals: scope xmlNamespaceURI.
	self
		should: [
			scope
				validateAndResolvePrefix: 'xmlns'
				ofElement: ('name' qualifyWithXMLPrefix: 'xmlns') ]
		raise: XMLNamespaceException.
	self
		should: [ scope validateAndResolvePrefix: '' ofElement: ':name' ]
		raise: XMLNamespaceException
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testValidatePrefixesOfAttributes [
	| scope attributes |

	scope := self newNamespaceScopeWithNamespaces.
	attributes :=
		self namespaces keys collect: [:each |
			'name' qualifyWithXMLPrefix: each].
	self
		shouldnt: [
			scope validatePrefixesOfAttributes: attributes]
		raise: XMLNamespaceException.
	self
		should: [
			scope validatePrefixesOfAttributes:
				(attributes copyWith: ('name' qualifyWithXMLPrefix: 'undeclared'))]
		raise: XMLNamespaceException.
	self
		should: [
			scope validatePrefixesOfAttributes:
				(attributes copyWith: ':name')]
		raise: XMLNamespaceException.

	self namespaces keysAndValuesDo: [:prefix :uri | | aliasPrefix attribute |
		aliasPrefix := 'alias', prefix.
		scope
			mapPrefix: aliasPrefix
			to: uri.
		attribute := 'name' qualifyWithXMLPrefix: aliasPrefix.
		prefix = ''
			ifTrue: [
				self
					shouldnt: [
						scope validatePrefixesOfAttributes:
							(attributes copyWith: attribute)]
					raise: XMLNamespaceException]
			ifFalse: [
				self
					should: [
						scope validatePrefixesOfAttributes:
							(attributes copyWith: attribute)]
					raise: XMLNamespaceException]].
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testXMLNSNamespaceURI [

	| namespaceURI |
	namespaceURI := 'http://www.w3.org/2000/xmlns/'.
	self
		assert: self newNamespaceScope xmlnsNamespaceURI
		equals: namespaceURI;
		assert: XMLNamespaceScope xmlnsNamespaceURI equals: namespaceURI
]

{ #category : 'tests' }
XMLNamespaceScopeTest >> testXMLNamespaceURI [

	| namespaceURI |
	namespaceURI := 'http://www.w3.org/XML/1998/namespace'.
	self
		assert: self newNamespaceScope xmlNamespaceURI equals: namespaceURI;
		assert: XMLNamespaceScope xmlNamespaceURI equals: namespaceURI
]

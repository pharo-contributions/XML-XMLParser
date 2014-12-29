Class {
	#name : #XMLNamespaceScopeTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #accessing }
XMLNamespaceScopeTest >> namespaces [
	^ Dictionary new
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
	| scope |

	scope := self newNamespaceScopeWithNamespaces.
	self assert: scope prefixMappings == scope copy prefixMappings.
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
	| scope oldPrefixMappings association |

	scope := self newNamespaceScopeWithNamespaces.
	oldPrefixMappings := scope prefixMappings.
	association := oldPrefixMappings associations anyOne.
	scope
		mapPrefix: association key
		to: association value.
	self
		assert: scope prefixMappings = oldPrefixMappings;
		deny: scope prefixMappings == oldPrefixMappings.
	scope
		mapPrefix: association key
		to: 'newNS'.
	self
		deny: scope prefixMappings = oldPrefixMappings;
		deny: scope prefixMappings == oldPrefixMappings.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testSetPrefixMappingsFrom [
	| outerScope innerScope |

	(outerScope := self newNamespaceScope)
		setPrefixMappingsFrom: self namespaces.
	self assert: outerScope = self newNamespaceScopeWithNamespaces.

	innerScope := outerScope copy.
	self assert: innerScope prefixMappings == outerScope prefixMappings.

	innerScope setPrefixMappingsFrom: self namespaces.
	self
		assert: innerScope prefixMappings = outerScope prefixMappings;
		deny: innerScope prefixMappings == outerScope prefixMappings.
]

{ #category : #tests }
XMLNamespaceScopeTest >> testSize [
	self
		assert: self newNamespaceScope size = 0;
		assert: self newNamespaceScopeWithNamespaces size = self namespaces size
]

{ #category : #tests }
XMLNamespaceScopeTest >> testUnmapPrefix [
	| scope oldPrefixMappings unmappedPrefix |

	scope := self newNamespaceScopeWithNamespaces.
	oldPrefixMappings := scope prefixMappings.
	unmappedPrefix := oldPrefixMappings keys anyOne.
	scope unmapPrefix: unmappedPrefix.
	self
		deny: scope prefixMappings = oldPrefixMappings;
		deny: scope prefixMappings == oldPrefixMappings.
]

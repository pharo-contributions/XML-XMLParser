Class {
	#name : #DTDPluggableExternalEntityResolverTest,
	#superclass : #DTDExternalEntityResolverTest,
	#category : #'XML-Tests-Parser-DTD'
}

{ #category : #accessing }
DTDPluggableExternalEntityResolverTest >> entityAssociations [
	^ Array
		with: 'extern.dtd' -> '<!ENTITY extern SYSTEM "extern/extern.ent">'
		with: 'extern/extern.ent' -> '<!ENTITY extern SYSTEM "extern2.ent">'
		with: 'extern/extern2.ent' -> '<!ELEMENT test ANY>'
]

{ #category : #accessing }
DTDPluggableExternalEntityResolverTest >> entityDictionary [
	| entities |

	entities := Dictionary new.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		entities
			at: uriString asXMLURI
			put: replacement].
	^ entities.
]

{ #category : #enumerating }
DTDPluggableExternalEntityResolverTest >> entityURIStringsAndReplacementsDo: aBlock [
	self entityAssociations do: [:each |
		aBlock
			value: each key
			value: each value]
]

{ #category : #accessing }
DTDPluggableExternalEntityResolverTest >> newEntityReplacement [
	^ '<!--new replacement-->'
]

{ #category : #'instance creation' }
DTDPluggableExternalEntityResolverTest >> newResolverWithEntities [
	^ self newResolver entities: self entityAssociations
]

{ #category : #accessing }
DTDPluggableExternalEntityResolverTest >> resolverClass [
	^ DTDPluggableExternalEntityResolver
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testEntities [
	| resolver replacementAssociation |

	resolver := self newResolver.
	self
		assert: resolver entities class == Dictionary;
		assert: resolver entities isEmpty.

	resolver entities: self entityAssociations.
	self assert: resolver entities = self entityDictionary.

	replacementAssociation := 'new.ent' asXMLURI -> self newEntityReplacement.
	resolver entities: (Array with: replacementAssociation).
	self assert: resolver entities = (Dictionary with: replacementAssociation).

	resolver := self resolverClass entities: self entityAssociations.
	self
		assert: resolver class == self resolverClass;
		assert: resolver entities = self entityDictionary.
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testEntityAtURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			assert: (resolver entityAtURI: uriString) = '';
			assert: (resolver entityAtURI: uriString asXMLURI) = ''.

		resolver
			entityAtURI: uriString
			put: replacement.
		self
			assert: (resolver entityAtURI: uriString) = replacement;
			assert: (resolver entityAtURI: uriString asXMLURI) = replacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testEntityAtURIIfAbsent [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				entityAtURI: uriString
				ifAbsent: [#absent]) = #absent.
		self assert:
			(resolver
				entityAtURI: uriString asXMLURI
				ifAbsent: [#absent]) = #absent.

		resolver
			entityAtURI: uriString
			put: replacement.
		self assert:
			(resolver
				entityAtURI: uriString
				ifAbsent: [#absent]) = replacement.
		self assert:
			(resolver
				entityAtURI: uriString asXMLURI
				ifAbsent: [#absent]) = replacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testEntityAtURIIfAbsentPut [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				entityAtURI: uriString
				ifAbsentPut: [replacement]) = replacement.
		self assert:
			(resolver
				entityAtURI: uriString asXMLURI
				ifAbsentPut: [#absent]) = replacement.
		self assert: (resolver entityAtURI: uriString) = replacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testEntityAtURIPut [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				entityAtURI: uriString
				put: replacement) = replacement.
		self assert: (resolver entityAtURI: uriString) = replacement.

		self assert:
			(resolver
				entityAtURI: uriString asXMLURI
				put: self newEntityReplacement) = self newEntityReplacement.
		self assert:
			(resolver entityAtURI: uriString asXMLURI) = self newEntityReplacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testHasEntities [
	self
		deny: self newResolver hasEntities;
		assert: self newResolverWithEntities hasEntities
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testIncludesEntityURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			deny: (resolver includesEntityURI: uriString);
			deny: (resolver includesEntityURI: uriString asXMLURI).

		resolver
			entityAtURI: uriString
			put: replacement.
		self
			assert: (resolver includesEntityURI: uriString);
			assert: (resolver includesEntityURI: uriString asXMLURI)].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testRemoveEntities [
	| resolver |

	resolver := self newResolverWithEntities.
	self
		assert: resolver removeEntities == resolver;
		deny: resolver hasEntities.
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testRemoveEntityURI [
	| resolver |

	resolver := self newResolverWithEntities.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			assert: (resolver removeEntityURI: uriString) = replacement;
			deny: (resolver includesEntityURI: uriString).
		self
			should: [resolver removeEntityURI: uriString]
			raise: Error.
		self
			should: [resolver removeEntityURI: uriString asXMLURI]
			raise: Error.].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testRemoveEntityURIIfAbsent [
	| resolver |

	resolver := self newResolverWithEntities.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				removeEntityURI: uriString
				ifAbsent: [#absent]) = replacement.
		self deny: (resolver includesEntityURI: uriString).
		self assert:
			(resolver
				removeEntityURI: uriString
				ifAbsent: [#absent]) = #absent.
		self assert:
			(resolver
				removeEntityURI: uriString asXMLURI
				ifAbsent: [#absent]) = #absent].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testResolveEntityURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			should: [resolver resolveEntityURI: uriString]
			raise: XMLParserException.
		self
			should: [resolver resolveEntityURI: uriString asXMLURI]
			raise: XMLParserException.

		resolver
			maxExternalEntitySize: replacement size;
			entityAtURI: uriString
			put: replacement.
		self
			assert: (resolver resolveEntityURI: uriString) = replacement;
			assert: (resolver resolveEntityURI: uriString asXMLURI) = replacement.

		resolver maxExternalEntitySize: replacement size - 1.
		self
			should: [resolver resolveEntityURI: uriString]
			raise: XMLLimitException.
		self
			should: [resolver resolveEntityURI: uriString asXMLURI]
			raise: XMLLimitException].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testStreamResolveEntityURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement | | stream |
		self
			should: [resolver streamResolveEntityURI: uriString]
			raise: XMLParserException.
		self
			should: [resolver streamResolveEntityURI: uriString asXMLURI]
			raise: XMLParserException.

		resolver
			maxExternalEntitySize: replacement size;
			entityAtURI: uriString
			put: replacement.
		stream := resolver streamResolveEntityURI: uriString.
		self
			assert: (stream isKindOf: ReadStream);
			assert: stream contents = replacement.
		stream := resolver streamResolveEntityURI: uriString asXMLURI.
		self
			assert: (stream isKindOf: ReadStream);
			assert: stream contents = replacement.

		resolver maxExternalEntitySize: replacement size - 1.
		self
			should: [resolver streamResolveEntityURI: uriString]
			raise: XMLLimitException.
		self
			should: [resolver streamResolveEntityURI: uriString asXMLURI]
			raise: XMLLimitException].
]

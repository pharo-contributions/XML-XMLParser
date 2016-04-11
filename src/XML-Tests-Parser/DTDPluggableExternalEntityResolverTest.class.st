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
	^ self newResolver externalEntities: self entityAssociations
]

{ #category : #accessing }
DTDPluggableExternalEntityResolverTest >> resolverClass [
	^ DTDPluggableExternalEntityResolver
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testExternalEntities [
	| resolver replacementAssociation |

	resolver := self newResolver.
	self
		assert: resolver externalEntities class == Dictionary;
		assert: resolver externalEntities isEmpty.

	resolver externalEntities: self entityAssociations.
	self assert: resolver externalEntities = self entityDictionary.

	replacementAssociation := 'new.ent' asXMLURI -> self newEntityReplacement.
	resolver externalEntities: (Array with: replacementAssociation).
	self assert: resolver externalEntities = (Dictionary with: replacementAssociation).

	resolver := self resolverClass externalEntities: self entityAssociations.
	self
		assert: resolver class == self resolverClass;
		assert: resolver externalEntities = self entityDictionary.
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testExternalEntityAtURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			assert: (resolver externalEntityAtURI: uriString) = '';
			assert: (resolver externalEntityAtURI: uriString asXMLURI) = ''.

		resolver
			externalEntityAtURI: uriString
			put: replacement.
		self
			assert: (resolver externalEntityAtURI: uriString) = replacement;
			assert: (resolver externalEntityAtURI: uriString asXMLURI) = replacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testExternalEntityAtURIIfAbsent [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				externalEntityAtURI: uriString
				ifAbsent: [#absent]) = #absent.
		self assert:
			(resolver
				externalEntityAtURI: uriString asXMLURI
				ifAbsent: [#absent]) = #absent.

		resolver
			externalEntityAtURI: uriString
			put: replacement.
		self assert:
			(resolver
				externalEntityAtURI: uriString
				ifAbsent: [#absent]) = replacement.
		self assert:
			(resolver
				externalEntityAtURI: uriString asXMLURI
				ifAbsent: [#absent]) = replacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testExternalEntityAtURIIfAbsentPut [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				externalEntityAtURI: uriString
				ifAbsentPut: [replacement]) = replacement.
		self assert:
			(resolver
				externalEntityAtURI: uriString asXMLURI
				ifAbsentPut: [#absent]) = replacement.
		self assert: (resolver externalEntityAtURI: uriString) = replacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testExternalEntityAtURIPut [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				externalEntityAtURI: uriString
				put: replacement) = replacement.
		self assert: (resolver externalEntityAtURI: uriString) = replacement.

		self assert:
			(resolver
				externalEntityAtURI: uriString asXMLURI
				put: self newEntityReplacement) = self newEntityReplacement.
		self assert:
			(resolver externalEntityAtURI: uriString asXMLURI) = self newEntityReplacement].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testHasExternalEntities [
	self
		deny: self newResolver hasExternalEntities;
		assert: self newResolverWithEntities hasExternalEntities
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testIncludesExternalEntityURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			deny: (resolver includesExternalEntityURI: uriString);
			deny: (resolver includesExternalEntityURI: uriString asXMLURI).

		resolver
			externalEntityAtURI: uriString
			put: replacement.
		self
			assert: (resolver includesExternalEntityURI: uriString);
			assert: (resolver includesExternalEntityURI: uriString asXMLURI)].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testRemoveExternalEntities [
	| resolver |

	resolver := self newResolverWithEntities.
	self
		assert: resolver removeExternalEntities == resolver;
		deny: resolver hasExternalEntities.
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testRemoveExternalEntityURI [
	| resolver |

	resolver := self newResolverWithEntities.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			assert: (resolver removeExternalEntityURI: uriString) = replacement;
			deny: (resolver includesExternalEntityURI: uriString).
		self
			should: [resolver removeExternalEntityURI: uriString]
			raise: Error.
		self
			should: [resolver removeExternalEntityURI: uriString asXMLURI]
			raise: Error.].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testRemoveExternalEntityURIIfAbsent [
	| resolver |

	resolver := self newResolverWithEntities.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self assert:
			(resolver
				removeExternalEntityURI: uriString
				ifAbsent: [#absent]) = replacement.
		self deny: (resolver includesExternalEntityURI: uriString).
		self assert:
			(resolver
				removeExternalEntityURI: uriString
				ifAbsent: [#absent]) = #absent.
		self assert:
			(resolver
				removeExternalEntityURI: uriString asXMLURI
				ifAbsent: [#absent]) = #absent].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testResolveExternalEntityURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement |
		self
			should: [resolver resolveExternalEntityURI: uriString]
			raise: XMLParserException.
		self
			should: [resolver resolveExternalEntityURI: uriString asXMLURI]
			raise: XMLParserException.

		resolver
			maxExternalEntitySize: replacement size;
			externalEntityAtURI: uriString
			put: replacement.
		self
			assert: (resolver resolveExternalEntityURI: uriString) = replacement;
			assert: (resolver resolveExternalEntityURI: uriString asXMLURI) = replacement.

		resolver maxExternalEntitySize: replacement size - 1.
		self
			should: [resolver resolveExternalEntityURI: uriString]
			raise: XMLLimitException.
		self
			should: [resolver resolveExternalEntityURI: uriString asXMLURI]
			raise: XMLLimitException].
]

{ #category : #tests }
DTDPluggableExternalEntityResolverTest >> testStreamResolveExternalEntityURI [
	| resolver |

	resolver := self newResolver.
	self entityURIStringsAndReplacementsDo: [:uriString :replacement | | stream |
		self
			should: [resolver streamResolveExternalEntityURI: uriString]
			raise: XMLParserException.
		self
			should: [resolver streamResolveExternalEntityURI: uriString asXMLURI]
			raise: XMLParserException.

		resolver
			maxExternalEntitySize: replacement size;
			externalEntityAtURI: uriString
			put: replacement.
		stream := resolver streamResolveExternalEntityURI: uriString.
		self
			assert: (stream isKindOf: ReadStream);
			assert: stream contents = replacement.
		stream := resolver streamResolveExternalEntityURI: uriString asXMLURI.
		self
			assert: (stream isKindOf: ReadStream);
			assert: stream contents = replacement.

		resolver maxExternalEntitySize: replacement size - 1.
		self
			should: [resolver streamResolveExternalEntityURI: uriString]
			raise: XMLLimitException.
		self
			should: [resolver streamResolveExternalEntityURI: uriString asXMLURI]
			raise: XMLLimitException].
]

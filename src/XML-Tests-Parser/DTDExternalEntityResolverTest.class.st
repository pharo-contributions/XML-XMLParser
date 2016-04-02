Class {
	#name : #DTDExternalEntityResolverTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-DTD'
}

{ #category : #testing }
DTDExternalEntityResolverTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
DTDExternalEntityResolverTest >> entityLimitsClass [
	^ DTDExternalEntityLimits
]

{ #category : #'instance creation' }
DTDExternalEntityResolverTest >> newEntityLimits [
	^ self entityLimitsClass new
]

{ #category : #'instance creation' }
DTDExternalEntityResolverTest >> newResolver [
	^ self resolverClass new
]

{ #category : #accessing }
DTDExternalEntityResolverTest >> resolverClass [
	^ DTDExternalEntityResolver
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testCopy [
	| resolver copy |

	(resolver := self newResolver)
		externalSubsetReadLimit: 1000000;
		maxExternalEntities: 10;
		maxExternalEntitySize: 10000;
		resolvesLocalFromNonLocal: true;
		incrementTotalResolvedEntities.
	copy := resolver copy.
	self
		deny: resolver == copy;
		assert: resolver totalResolvedEntities = 1;
		assert: copy totalResolvedEntities = 0;
		deny: copy externalEntityLimits == resolver externalEntityLimits;
		assert: copy externalSubsetReadLimit = 1000000;
		assert: copy maxExternalEntities = 10;
		assert: copy maxExternalEntitySize = 10000;
		assert: copy resolvesLocalFromNonLocal.
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testExternalEntityLimits [
	| resolver newEntityLimits |

	resolver := self newResolver.
	self assert: resolver externalEntityLimits class == self entityLimitsClass.

	newEntityLimits := self newEntityLimits.
	self
		assert: (resolver externalEntityLimits: newEntityLimits) == resolver;
		assert: resolver externalEntityLimits == newEntityLimits.
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testExternalSubsetReadLimit [
	| resolver |

	resolver := self newResolver.
	self
		assert: resolver externalSubsetReadLimit = self newEntityLimits externalSubsetReadLimit;
		assert: (resolver externalSubsetReadLimit: 1000000) == resolver;
		assert: resolver externalSubsetReadLimit = 1000000;
		assert: (resolver externalSubsetReadLimit: nil) == resolver;
		assert: resolver externalSubsetReadLimit isNil.
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testMaxExternalEntities [
	| resolver |

	resolver := self newResolver.
	self
		assert: resolver maxExternalEntities = self newEntityLimits maxExternalEntities;
		assert: (resolver maxExternalEntities: 10) == resolver;
		assert: resolver maxExternalEntities = 10;
		assert: (resolver maxExternalEntities: nil) == resolver;
		assert: resolver maxExternalEntities isNil.
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testMaxExternalEntitySize [
	| resolver |

	resolver := self newResolver.
	self
		assert: resolver maxExternalEntitySize = self newEntityLimits maxExternalEntitySize;
		assert: (resolver maxExternalEntitySize: 10000) == resolver;
		assert: resolver maxExternalEntitySize = 10000;
		assert: (resolver maxExternalEntitySize: nil) == resolver;
		assert: resolver maxExternalEntitySize isNil.
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testResolvesLocalFromNonLocal [
	| resolver |

	resolver := self newResolver.
	self
		assert: resolver resolvesLocalFromNonLocal = self newEntityLimits resolvesLocalFromNonLocal;
		assert: (resolver resolvesLocalFromNonLocal: false) == resolver;
		deny: resolver resolvesLocalFromNonLocal;
		assert: (resolver resolvesLocalFromNonLocal: true) == resolver;
		assert: resolver resolvesLocalFromNonLocal.
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testTotalResolvedEntities [
	| resolver |

	resolver := self newResolver.
	self assert: resolver totalResolvedEntities = 0.

	resolver incrementTotalResolvedEntities.
	self assert: resolver totalResolvedEntities = 1.

	self assert:
		(self newResolver
			incrementTotalResolvedEntities;
			totalResolvedEntities) = 1.
]

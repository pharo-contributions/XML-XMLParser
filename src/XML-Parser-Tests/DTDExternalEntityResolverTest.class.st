Class {
	#name : #DTDExternalEntityResolverTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-DTD'
}

{ #category : #testing }
DTDExternalEntityResolverTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
DTDExternalEntityResolverTest >> entityLimitsClass [
	^ DTDExternalEntityLimits
]

{ #category : #testing }
DTDExternalEntityResolverTest >> isTestingLimiting [
	^ false
]

{ #category : #'instance creation' }
DTDExternalEntityResolverTest >> newEntityLimits [
	^ self entityLimitsClass new
]

{ #category : #'instance creation' }
DTDExternalEntityResolverTest >> newResolver [
	^ self isTestingLimiting
		ifTrue: [self resolverClass new asLimitingExternalEntityResolver]
		ifFalse: [self resolverClass new]
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
		resolvesLocalFromNonLocal: true.
	copy := resolver copy.
	self
		deny: copy identicalTo: resolver;
		assert: copy externalSubsetReadLimit equals: 1000000;
		assert: copy maxExternalEntities equals: 10;
		assert: copy maxExternalEntitySize equals: 10000;
		assert: copy resolvesLocalFromNonLocal.

	self isTestingLimiting
		ifTrue: [
			self
				assert: copy externalEntityResolver
				identicalTo: resolver externalEntityResolver;
				assert: copy externalEntityLimits
				identicalTo: resolver externalEntityLimits ]
		ifFalse: [
			self
				deny: copy externalEntityLimits
				identicalTo: resolver externalEntityLimits ]
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testDecoratorInterfaceCompatibility [
	| resolver resolverBaseClass |

	self isTestingLimiting
		ifFalse: [^ self].

	"decorators must support the resolver base class's public interface"
	resolver := self newResolver.
	resolverBaseClass := DTDExternalEntityResolver.
	"avoid #methodsDo: for GS compatibility"
	resolverBaseClass selectorsDo: [:each |
		"use #whichCategoryIncludesSelector: for backwards compatibility"
		((resolverBaseClass whichCategoryIncludesSelector: each)
			asString beginsWith: 'private')
			ifFalse: [
				self assert: (resolver respondsTo: each)]]
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testExternalEntityLimits [

	| resolver newEntityLimits |
	resolver := self newResolver.
	self
		assert: resolver externalEntityLimits class
		identicalTo: self entityLimitsClass.

	newEntityLimits := self newEntityLimits.
	self
		assert: (resolver externalEntityLimits: newEntityLimits)
		identicalTo: resolver;
		assert: resolver externalEntityLimits identicalTo: newEntityLimits
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testExternalSubsetReadLimit [

	| resolver |
	resolver := self newResolver.
	self
		assert: resolver externalSubsetReadLimit
		equals: DTDExternalEntityLimits defaultExternalSubsetReadLimit.
	self
		assert: (resolver externalSubsetReadLimit: 1000000)
		identicalTo: resolver;
		assert: resolver externalSubsetReadLimit equals: 1000000;
		assert: (resolver externalSubsetReadLimit: nil)
		identicalTo: resolver;
		assert: resolver externalSubsetReadLimit isNil
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testMaxExternalEntities [

	| resolver |
	resolver := self newResolver.
	self
		assert: resolver maxExternalEntities > 0;
		assert: (resolver maxExternalEntities: 10) identicalTo: resolver;
		assert: resolver maxExternalEntities equals: 10;
		assert: (resolver maxExternalEntities: nil) identicalTo: resolver;
		assert: resolver maxExternalEntities isNil
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testMaxExternalEntitySize [

	| resolver |
	resolver := self newResolver.
	self
		assert: resolver maxExternalEntitySize
		equals: DTDExternalEntityLimits defaultMaxExternalEntitySize.
	self
		assert: (resolver maxExternalEntitySize: 10000)
		identicalTo: resolver;
		assert: resolver maxExternalEntitySize equals: 10000;
		assert: (resolver maxExternalEntitySize: nil) identicalTo: resolver;
		assert: resolver maxExternalEntitySize isNil
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testRemoveLimits [
	| readLimit entityLimit entitySizeLimit resolver |
	readLimit := 100.
	entityLimit := 10.
	entitySizeLimit := 100.
	(resolver := self newResolver)
		externalSubsetReadLimit: readLimit;
		maxExternalEntities: entityLimit;
		maxExternalEntitySize: entitySizeLimit;
		resolvesLocalFromNonLocal: true.
	self
		assert: resolver externalSubsetReadLimit equals: readLimit;
		assert: resolver maxExternalEntities equals: entityLimit;
		assert: resolver maxExternalEntitySize equals: entitySizeLimit;
		assert: resolver resolvesLocalFromNonLocal.
	resolver removeLimits.
	self
		assert: resolver externalSubsetReadLimit isNil;
		assert: resolver maxExternalEntities isNil;
		assert: resolver maxExternalEntitySize isNil;
		assert: resolver resolvesLocalFromNonLocal
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testResolvesLocalFromNonLocal [

	| resolver |
	resolver := self newResolver.
	self
		deny: resolver resolvesLocalFromNonLocal;
		assert: (resolver resolvesLocalFromNonLocal: false)
		identicalTo: resolver;
		deny: resolver resolvesLocalFromNonLocal;
		assert: (resolver resolvesLocalFromNonLocal: true)
		identicalTo: resolver;
		assert: resolver resolvesLocalFromNonLocal
]

{ #category : #tests }
DTDExternalEntityResolverTest >> testTotalResolvedExternalEntities [
	| resolver |
	self isTestingLimiting
		ifFalse: [ ^ self ].
	resolver := self newResolver.
	self assert: resolver totalResolvedExternalEntities equals: 0.
	resolver incrementTotalResolvedExternalEntities.
	self assert: resolver totalResolvedExternalEntities equals: 1.
	self
		assert:
			(self newResolver
				incrementTotalResolvedExternalEntities;
				totalResolvedExternalEntities)
		equals: 1
]

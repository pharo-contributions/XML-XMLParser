Class {
	#name : #XMLExternalEntityLimitsTest,
	#superclass : #XMLExternalEntityTest,
	#category : #'XML-Tests-Parser'
}

{ #category : #tests }
XMLExternalEntityLimitsTest >> testDefaultLimits [
	| resolver |

	resolver := (SAXHandler on: '') externalEntityResolver.
	self
		assert: resolver externalSubsetReadLimit = DTDExternalEntityLimits defaultExternalSubsetReadLimit;
		assert: resolver maxExternalEntities > 0;
		assert: resolver maxExternalEntitySize = DTDExternalEntityLimits defaultMaxExternalEntitySize;
		deny: resolver resolvesLocalFromNonLocal.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testExternalEntitiesLimit [
	| parser xml entityLimit |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	entityLimit := 2.
	xml := self doctypeWithDeclarationsForEntityURIs: (self externalEntityURLs copyFrom: 1 to: entityLimit).
	((parser := SAXHandler on: xml)
		resolvesExternalEntities: true;
		externalEntityResolver)
			clearEntityCache;
			maxExternalEntities: entityLimit.
	self
		shouldnt: [parser parseDocument]
		raise: XMLLimitException.

	((parser := SAXHandler on: xml)
		resolvesExternalEntities: true;
		externalEntityResolver)
			clearEntityCache;
			maxExternalEntities: entityLimit - 1.
	self
		should: [parser parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testExternalEntitySizeLimit [
	| parser url xml size |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	url := self externalEntityURLs first asXMLURI.
	xml := self doctypeWithDeclarationsForEntityURIs: (Array with: url asString).
	size := url get contents size.
	((parser := SAXHandler on: xml)
		resolvesExternalEntities: true;
		externalEntityResolver)
			clearEntityCache;
			maxExternalEntitySize: size.
	self
		shouldnt: [parser parseDocument]
		raise: XMLLimitException.

	((parser := SAXHandler on: xml)
		resolvesExternalEntities: true;
		externalEntityResolver)
			clearEntityCache;
			maxExternalEntitySize: size - 1.
	self
		should: [parser parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testExternalSubsetReadLimit [
	| xml externalSubset fileName parser |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	fileName := 'externalSubset.dtd'.
	externalSubset := '<?xml encoding="UTF-8"?><!ELEMENT test EMPTY>'.
	self fileNamed: fileName write: externalSubset.
	xml := '<!DOCTYPE test SYSTEM "', fileName, '"><test/>'.
	self
		shouldnt: [
			(parser := SAXHandler on: xml)
				externalEntityResolver externalSubsetReadLimit: externalSubset size.
			parser
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLLimitException.
	self
		should: [
			(parser := SAXHandler on: xml)
				externalEntityResolver externalSubsetReadLimit: externalSubset size - 1.
			parser
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLLimitException.
	self deleteFileNamed: fileName.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testOnURLUpToLimit [
	| parser size |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	size := (self feedURL asXMLURI get) contents size.
	self
		shouldnt: [
			parser :=
				SAXHandler
					onURL: self feedURL
					upToLimit: size]
		raise: XMLLimitException.
	self assert: parser documentReadLimit = size.

	self
		should: [
			(SAXHandler
				onURL: self feedURL
				upToLimit: size - 1)
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testRemoveLimits [
	|  readLimit entityLimit entitySizeLimit parser resolver |

	readLimit := 100.
	entityLimit := 10.
	entitySizeLimit := 100.
	parser := SAXHandler on: ''.
	(resolver := parser externalEntityResolver)
		externalSubsetReadLimit: readLimit;
		maxExternalEntities: entityLimit;
		maxExternalEntitySize: entitySizeLimit;
		resolvesLocalFromNonLocal: true.
	self
		assert: resolver externalSubsetReadLimit = readLimit;
		assert: resolver maxExternalEntities = entityLimit;
		assert: resolver maxExternalEntitySize = entitySizeLimit;
		assert: resolver resolvesLocalFromNonLocal.

	parser removeLimits.
	self
		assert: resolver externalSubsetReadLimit isNil;
		assert: resolver maxExternalEntities isNil;
		assert: resolver maxExternalEntitySize isNil;
		assert: resolver resolvesLocalFromNonLocal isNil.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testResolvingLocalFromNonLocal [
	| parser |

	self
		should: [
			(parser :=
				SAXHandler
					on: '<!DOCTYPE root SYSTEM "file://local/uri">'
					documentURI: 'http://www.example.com')
				externalEntityResolver resolvesLocalFromNonLocal: false.
			parser
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLLimitException.
]

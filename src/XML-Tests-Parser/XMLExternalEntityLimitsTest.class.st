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
		assert: resolver maxExternalEntities > 0;
		assert: resolver maxExternalEntitySize = DTDExternalEntityLimits defaultMaxExternalEntitySize;
		assert: (resolver resolvesLocalFromNonLocal isKindOf: Boolean).
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testExternalEntitiesLimit [
	"
	(self isSkipping: false) testExternalEntitiesLimit
	"
	| parser xml entityLimit |

	self isSkipping
		ifTrue: [self skip].

	entityLimit := 2.
	xml := self doctypeWithDeclarationsForEntityURIs: (self externalEntityURLs first: entityLimit).
	parser := SAXHandler on: xml.
	parser externalEntityResolver
		clearEntityCache;
		maxExternalEntities: entityLimit.
	self
		shouldnt: [
			parser
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLLimitException.

	parser := SAXHandler on: xml.
	parser externalEntityResolver
		clearEntityCache;
		maxExternalEntities: 0.
	self
		should: [
			parser
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testExternalEntitySizeLimit [
	"
	(self isSkipping: false) testExternalEntitySizeLimit
	"
	| parser url xml size |

	self isSkipping
		ifTrue: [self skip].

	url := self externalEntityURLs first asXMLURI.
	xml := self doctypeWithDeclarationsForEntityURIs: (Array with: url asString).
	size := url get contents size.
	parser := SAXHandler on: xml.
	parser externalEntityResolver
		clearEntityCache;
		maxExternalEntitySize: size.
	self
		shouldnt: [parser parseDocument]
		raise: XMLLimitException.

	parser := SAXHandler on: xml.
	parser externalEntityResolver
		clearEntityCache;
		maxExternalEntitySize: size - 1.
	self
		should: [parser parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testExternalSubsetReadLimit [
	"
	(self isSkipping: false) testExternalSubsetReadLimit
	"
	| xml externalSubset fileName parser |

	self isSkipping
		ifTrue: [self skip].

	fileName := 'externalSubset.dtd'.
	externalSubset := '<?xml encoding="UTF-8"?><!ELEMENT test EMPTY>'.
	self fileNamed: fileName write: externalSubset.
	xml := '<!DOCTYPE test SYSTEM "', fileName, '"><test/>'.
	self
		shouldnt: [
			(parser := SAXHandler on: xml)
				externalSubsetReadLimit: externalSubset size;
				parseDocument]
		raise: XMLLimitException.
	self
		should: [
			(parser := SAXHandler on: xml)
				externalSubsetReadLimit: externalSubset size - 1;
				parseDocument]
		raise: XMLLimitException.
	self deleteFileNamed: fileName.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testOnURLUpToLimit [
	"
	(self isSkipping: false) testOnURLUpToLimit
	"
	| parser size |

	self isSkipping
		ifTrue: [self skip].

	size := (self rssURL asXMLURI get) contents size.
	self
		shouldnt: [
			parser :=
				SAXHandler
					onURL: self rssURL
					upToLimit: size]
		raise: XMLLimitException.
	self assert: parser documentReadLimit = size.

	self
		should: [
			(SAXHandler
				onURL: self rssURL
				upToLimit: size - 1)
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testRemoveLimits [
	|  parser resolver entityLimit entitySizeLimit |

	parser := SAXHandler new.
	entityLimit := 10.
	entitySizeLimit := 100.
	(resolver := parser externalEntityResolver)
		maxExternalEntities: entityLimit;
		maxExternalEntitySize: entitySizeLimit;
		resolvesLocalFromNonLocal: true.
	self
		assert: resolver maxExternalEntities = entityLimit;
		assert: resolver maxExternalEntitySize = entitySizeLimit;
		assert: resolver resolvesLocalFromNonLocal.

	parser removeLimits.
	self
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

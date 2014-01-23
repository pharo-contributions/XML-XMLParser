Class {
	#name : #XMLExternalEntityLimitsTest,
	#superclass : #XMLExternalEntityTest,
	#category : #'XML-Tests-Parser'
}

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
		shouldnt: [parser parseDocument]
		raise: XMLLimitException.

	parser := SAXHandler on: xml.
	parser externalEntityResolver
		clearEntityCache;
		maxExternalEntities: entityLimit - 1.
	self
		should: [parser parseDocument]
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
XMLExternalEntityLimitsTest >> testRemoveLimits [
	|  parser resolver entityLimit entitySizeLimit |

	parser := SAXHandler new.
	entityLimit := 10.
	entitySizeLimit := 100.
	(resolver := parser externalEntityResolver)
		maxExternalEntities: entityLimit;
		maxExternalEntitySize: entitySizeLimit.
	self
		assert: resolver maxExternalEntities = entityLimit;
		assert: resolver maxExternalEntitySize = entitySizeLimit.

	parser removeLimits.
	self
		assert: resolver maxExternalEntities isNil;
		assert: resolver maxExternalEntitySize isNil.
]

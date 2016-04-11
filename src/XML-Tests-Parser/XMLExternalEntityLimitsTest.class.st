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
XMLExternalEntityLimitsTest >> testExternalSubsetReadLimit [
	| xml fileHandle externalSubset parser |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	fileHandle := self fileHandleForNewFileSuffixed: 'externalSubset.dtd'.
	externalSubset := '<?xml encoding="UTF-8"?><!ELEMENT test EMPTY>'.
	fileHandle writeStreamDo: [:writeStream |
		writeStream nextPutAll: externalSubset].
	xml := '<!DOCTYPE test SYSTEM "', fileHandle path, '"><test/>'.

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

	fileHandle delete.
]

{ #category : #tests }
XMLExternalEntityLimitsTest >> testOnURLUpToLimit [
	| parser size |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	size :=
		(self feedURL asXMLURI
			getUpToLimit: nil
			decoding: false) size.
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
		assert: resolver resolvesLocalFromNonLocal.
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

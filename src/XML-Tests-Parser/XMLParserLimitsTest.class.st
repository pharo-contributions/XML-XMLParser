Class {
	#name : #XMLParserLimitsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
XMLParserLimitsTest >> recursiveEntitiesNamed: aName depth: aLimit isParameter: aBoolean [
	| xml |

	xml := String new writeStream.
	1 to: aLimit do: [:i |
		xml
			cr;
			nextPutAll: '<!ENTITY '.
		aBoolean
			ifTrue: [xml nextPutAll: '% '].
		xml
			nextPutAll: aName, i printString;
			nextPutAll: ' "'.
			(i = aLimit)
				ifTrue: [xml nextPutAll: '<!--last-->']
				ifFalse: [
					aBoolean
						ifTrue: [xml nextPutAll: '&#37;']
						ifFalse: [xml nextPut: $&].
					xml
						nextPutAll: aName, (i + 1) printString;
						nextPut: $;].
		xml nextPutAll: '">'].
	^ xml contents.
]

{ #category : #tests }
XMLParserLimitsTest >> testDefaultLimits [
	| parser |

	parser := SAXHandler on: ''.
	self
		assert: parser documentReadLimit = XMLParserLimits defaultDocumentReadLimit;
		assert: parser maxEntityReplacementDepth > 0.
]

{ #category : #tests }
XMLParserLimitsTest >> testDocumentReadLimit [
	| xml replacement |

	replacement := 'entity replacement'.
	xml := '<!DOCTYPE test [<!ENTITY entity "', replacement, '">]><test>&entity;</test>'.
	self
		shouldnt: [
			(SAXHandler on: xml)
				documentReadLimit: xml size + replacement size;
				parseDocument]
		raise: XMLLimitException.
	self
		should: [
			(SAXHandler on: xml)
				documentReadLimit: xml size + replacement size - 1;
				parseDocument]
		raise: XMLLimitException.
	self
		shouldnt: [
			(SAXHandler on: xml)
				documentReadLimit: nil;
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLParserLimitsTest >> testRecursiveGeneralEntityReplacement [
	| limit xml |

	limit := 3.
	xml :=
		self
			xmlWithRecursiveEntitiesNamed: 'entity'
			depth: limit
			isParameter: false.
	self
		shouldnt: [
			(SAXHandler on: xml)
				maxEntityReplacementDepth: limit;
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLParserLimitsTest >> testRecursiveGeneralEntityReplacementPastLimit [
	| limit xml |

	limit := 3.
	xml :=
		self
			xmlWithRecursiveEntitiesNamed: 'entity'
			depth: limit + 1
			isParameter: false.
	self
		should: [
			(SAXHandler on: xml)
				maxEntityReplacementDepth: limit;
				parseDocument]
		raise: XMLLimitException.
	self
		shouldnt: [
			(SAXHandler on: xml)
				maxEntityReplacementDepth: nil;
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLParserLimitsTest >> testRecursiveParameterEntityReplacement [
	| limit xml |

	limit := 3.
	xml :=
		self
			xmlWithRecursiveEntitiesNamed: 'entity'
			depth: limit
			isParameter: true.
	self
		shouldnt: [
			(SAXHandler on: xml)
				maxEntityReplacementDepth: limit;
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLParserLimitsTest >> testRecursiveParameterEntityReplacementPastLimit [
	| limit xml |

	limit := 3.
	xml :=
		self
			xmlWithRecursiveEntitiesNamed: 'entity'
			depth: limit + 1
			isParameter: true.
	self
		should: [
			(SAXHandler on: xml)
				maxEntityReplacementDepth: limit;
				parseDocument]
		raise: XMLLimitException.
	self
		shouldnt: [
			(SAXHandler on: xml)
				maxEntityReplacementDepth: nil;
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLParserLimitsTest >> testRemoveLimits [
	| parser readLimit depthLimit |

	readLimit := 100.
	depthLimit := 5.
	(parser := SAXHandler on: '')
		documentReadLimit: readLimit;
		maxEntityReplacementDepth: depthLimit.
	self
		assert: parser documentReadLimit = readLimit;
		assert: parser maxEntityReplacementDepth = depthLimit.

	parser removeLimits.
	self
		assert: parser documentReadLimit isNil;
		assert: parser maxEntityReplacementDepth isNil.
]

{ #category : #tests }
XMLParserLimitsTest >> testTokenizerMaxPushBack [
	| tokenizer |

	tokenizer :=
		XMLWellFormedParserTokenizer
			driver: nil
			on: '' readStream.
	self
		shouldnt: [
			tokenizer streamReader maxNestedStreams
				timesRepeat: [tokenizer streamReader pushBack: 'test']]
		raise: XMLLimitException.
	self
		should: [tokenizer streamReader pushBack: 'test']
		raise: XMLLimitException.
]

{ #category : #source }
XMLParserLimitsTest >> xmlWithRecursiveEntitiesNamed: aName depth: aLimit isParameter: aBoolean [
	| xml |

	(xml := String new writeStream)
		nextPutAll: '<!DOCTYPE test ['.
	xml nextPutAll:
		(self
			recursiveEntitiesNamed: aName
			depth: aLimit
			isParameter: aBoolean).
	aBoolean
		ifTrue: [xml nextPutAll: '%', aName, '1;]><test/>']
		ifFalse: [xml nextPutAll: ']><test>&', aName, '1;</test>'].

	^ xml contents.
]

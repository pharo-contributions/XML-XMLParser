Class {
	#name : #XMLLimitTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #private }
XMLLimitTest >> recursiveEntityDeclarationsNamed: aName depth: aLimit isParameter: aBoolean [
	| entityDeclarations |

	entityDeclarations := String new writeStream.
	1 to: aLimit do: [:i |
		entityDeclarations
			cr;
			nextPutAll: '<!ENTITY '.
		aBoolean
			ifTrue: [entityDeclarations nextPutAll: '% '].

		entityDeclarations
			nextPutAll: aName, i printString;
			nextPutAll: ' "'.
			(i = aLimit)
				ifTrue: [entityDeclarations nextPutAll: '<!--last-->']
				ifFalse: [
					aBoolean
						ifTrue: [entityDeclarations nextPutAll: '&#37;']
						ifFalse: [entityDeclarations nextPut: $&].
					entityDeclarations
						nextPutAll: aName, (i + 1) printString;
						nextPut: $;].
		entityDeclarations nextPutAll: '">'].

	^ entityDeclarations contents.
]

{ #category : #tests }
XMLLimitTest >> testLocalURIFromNonLocalURI [
	self
		should: [
			(SAXHandler
				on: '<!DOCTYPE root SYSTEM "file://local/uri">'
				documentURI: 'http://www.example.com')
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLLimitTest >> testRecursiveGeneralEntityReplacement [
	| limit entityDeclarations xml |

	limit := XMLTokenizer new maxEntityReplacementDepth.
	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit
			isParameter: false.
	xml := '<!DOCTYPE root [', entityDeclarations, ']><root>&entity1;</root>'.

	self
		shouldnt: [SAXHandler parse: xml]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLLimitTest >> testRecursiveGeneralEntityReplacementPastLimit [
	| limit entityDeclarations xml |

	limit := XMLTokenizer new maxEntityReplacementDepth.
	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit + 1
			isParameter: false.
	xml := '<!DOCTYPE root [', entityDeclarations, ']><root>&entity1;</root>'.

	self
		should: [SAXHandler parse: xml]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLLimitTest >> testRecursiveParameterEntityReplacement [
	| limit entityDeclarations xml |

	limit := XMLTokenizer new maxEntityReplacementDepth.
	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit
			isParameter: true.
	xml := '<!DOCTYPE root [', entityDeclarations, ' %entity1;]><root/>'.

	self
		shouldnt: [SAXHandler parse: xml]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLLimitTest >> testRecursiveParameterEntityReplacementPastLimit [
	| limit xml entityDeclarations |

	limit := XMLTokenizer new maxEntityReplacementDepth.
	entityDeclarations :=
		self
			recursiveEntityDeclarationsNamed: 'entity'
			depth: limit + 1
			isParameter: true.
	xml := '<!DOCTYPE root [', entityDeclarations, ' %entity1;]><root/>'.

	self
		should: [SAXHandler parse: xml]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLLimitTest >> testTokenizerMaxPushBack [
	| tokenizer |

	tokenizer :=
		XMLTokenizer
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

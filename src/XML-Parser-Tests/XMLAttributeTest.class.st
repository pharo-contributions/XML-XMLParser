Class {
	#name : 'XMLAttributeTest',
	#superclass : 'XMLNodeTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'accessing' }
XMLAttributeTest >> escapedString [
	^ '&lt;test name=&quot;&amp;name;&quot;>''&amp;value;''&lt;/test>'
]

{ #category : 'accessing' }
XMLAttributeTest >> nodeClass [
	^ XMLAttribute
]

{ #category : 'tests' }
XMLAttributeTest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self assert:
		((self nodeClass name: 'one' value: 'two') canonicallyEquals:
			(self nodeClass name: 'one' value: 'two')).
	self deny:
		((self nodeClass name: 'one' value: 'two') canonicallyEquals:
			self newNode)
]

{ #category : 'tests' }
XMLAttributeTest >> testCopy [

	| node copy |
	(node := self newNode) element: self newElement.
	copy := node copy.
	self
		deny: copy identicalTo: node;
		assert: copy element isNil
]

{ #category : 'tests' }
XMLAttributeTest >> testElement [

	| attribute element |
	attribute := self newNode.
	self assert: attribute element isNil.

	element := self newElement.
	self
		assert: (attribute element: element) identicalTo: attribute;
		assert: attribute element identicalTo: element
]

{ #category : 'tests' }
XMLAttributeTest >> testExpandedName [

	| element attribute |
	element := self newElement.
	attribute := self nodeClass name: 'one' value: 'two'.
	element attributeNodes add: attribute.
	self assert: attribute expandedName equals: 'one'.

	element defaultNamespace: 'defaultNS'.
	self assert: attribute expandedName equals: 'one'.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	attribute name: 'prefix:two'.
	self assert: attribute expandedName equals: 'Q{prefixNS}two'
]

{ #category : 'tests' }
XMLAttributeTest >> testHasNamespaceURI [
	| element attribute |

	attribute := self nodeClass name: 'test' value: ''.
	self deny: attribute hasNamespaceURI.

	element :=
		self elementClass
			name: 'test'
			namespaceURI: 'defaultNS'.
	element attributeNodes add: attribute.
	self deny: attribute hasNamespaceURI.

	element
		declarePrefix: 'prefix'
		uri: 'prefixNS'.
	attribute name: 'prefix:test'.
	self assert: attribute hasNamespaceURI.

	attribute name: 'test'.
	self deny: attribute hasNamespaceURI
]

{ #category : 'tests' }
XMLAttributeTest >> testHasPrefix [
	| attribute |

	attribute := self newNode.
	self deny: attribute hasPrefix.

	attribute name: 'one'.
	self deny: attribute hasPrefix.

	attribute name: 'prefix:two'.
	self assert: attribute hasPrefix.

	attribute name: 'three'.
	self deny: attribute hasPrefix
]

{ #category : 'tests' }
XMLAttributeTest >> testIsAttribute [
	self assert: self newNode isAttribute
]

{ #category : 'tests' }
XMLAttributeTest >> testIsInLanguage [
	| element |

	super testIsInLanguage.

	element := self newElementWithAttributes.
	self languageTagsAndFilters do: [:tagAndFilters |
		| tag matchingFilters nonMatchingFilters |

		tag := tagAndFilters first.
		matchingFilters := tagAndFilters second.
		nonMatchingFilters := tagAndFilters third.
		element attributeNodesDo: [:attributeNode |
			(matchingFilters, nonMatchingFilters) do: [:each |
				self deny: (attributeNode isInLanguage: each)]].

		element
			attributeAt: 'xml:lang'
			put: tag.
		element attributeNodesDo: [:attributeNode |
			matchingFilters do: [:each |
				self assert: (attributeNode isInLanguage: each)].
			nonMatchingFilters do: [:each |
				self deny: (attributeNode isInLanguage: each)]].

		element removeAttribute: 'xml:lang']
]

{ #category : 'tests' }
XMLAttributeTest >> testIsNamed [
	| attribute |

	(attribute := self newNode)
		name: 'one'.
	self
		assert: (attribute isNamed: 'one');
		deny: (attribute isNamed: 'two').

	attribute name: 'one:two'.
	self
		assert: (attribute isNamed: 'one:two');
		assert: (attribute isNamed: 'two');
		deny: (attribute isNamed: 'one')
]

{ #category : 'tests' }
XMLAttributeTest >> testIsNamedAny [
	| attribute |

	(attribute := self newNode) name: 'one'.
	self
		assert: (attribute isNamedAny: #('two' 'one' 'three') asSet);
		deny: (attribute isNamedAny: #('two' 'three') asSet).

	attribute name: 'one:two'.
	self
		assert: (attribute isNamedAny: #('one' 'one:two' 'three'));
		assert: (attribute isNamedAny: #('one' 'two' 'three'));
		deny: (attribute isNamedAny: #('one' 'three'))
]

{ #category : 'tests' }
XMLAttributeTest >> testLocalName [

	| attribute |
	attribute := self newNode.
	self assert: attribute name equals: ''.

	attribute name: 'one'.
	self assert: attribute localName equals: 'one'.

	attribute name: 'two'.
	self assert: attribute localName equals: 'two'.

	attribute name: 'prefix:three'.
	self assert: attribute localName equals: 'three'.

	attribute name: 'four'.
	self assert: attribute localName equals: 'four'
]

{ #category : 'tests' }
XMLAttributeTest >> testMatchesLanguage [
	| attribute |

	attribute := self nodeClass named: 'xml:lang'.
	self languageTagsAndFilters do: [:tagAndFilters |
		| tag matchingFilters nonMatchingFilters |

		tag := tagAndFilters first.
		matchingFilters := tagAndFilters second.
		nonMatchingFilters := tagAndFilters third.
		(matchingFilters, nonMatchingFilters) do: [:each |
			self deny: (attribute matchesLanguage: each)].

		attribute value: tag.
		matchingFilters do: [:each |
			self assert: (attribute matchesLanguage: each)].
		nonMatchingFilters do: [:each |
			self deny: (attribute matchesLanguage: each)].

		attribute value: '']
]

{ #category : 'tests' }
XMLAttributeTest >> testName [

	| attribute |
	"XMLAttribute class>>#name: is not tested here because it is soft-deprecated"
	attribute := self newNode.
	self
		assert: attribute name equals: '';
		assert: (attribute name: 'one') identicalTo: attribute;
		assert: attribute name equals: 'one';
		assert: (attribute name: 'prefix:two') identicalTo: attribute;
		assert: attribute name equals: 'prefix:two'
]

{ #category : 'tests' }
XMLAttributeTest >> testNameValue [

	| attribute |
	attribute := self nodeClass name: 'one' value: 'two'.
	self
		assert: attribute class identicalTo: self nodeClass;
		assert: attribute name equals: 'one';
		assert: attribute value equals: 'two'
]

{ #category : 'tests' }
XMLAttributeTest >> testNamed [

	| attribute |
	attribute := self nodeClass named: 'test'.
	self
		assert: attribute class identicalTo: self nodeClass;
		assert: attribute name equals: 'test'
]

{ #category : 'tests' }
XMLAttributeTest >> testNamespaceURI [

	| element attribute |
	element := self newElement.
	attribute := self newNode.
	element attributeNodes add: attribute.
	self assert: attribute namespaceURI equals: ''.

	element defaultNamespace: 'defaultNS'.
	self assert: attribute namespaceURI equals: ''.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	attribute name: 'prefix:test'.
	self assert: attribute namespaceURI equals: 'prefixNS'.

	attribute name: 'test'.
	self assert: attribute namespaceURI equals: ''
]

{ #category : 'tests' }
XMLAttributeTest >> testPrefix [

	| attribute |
	attribute := self newNode.
	self assert: attribute prefix equals: ''.

	attribute name: 'one'.
	self assert: attribute prefix equals: ''.

	attribute name: 'prefix:two'.
	self assert: attribute prefix equals: 'prefix'.

	attribute name: 'three'.
	self assert: attribute prefix equals: ''
]

{ #category : 'tests' }
XMLAttributeTest >> testResolvePrefix [

	| element attribute |
	element := self newElementWithAttributes.
	attribute := element attributeNodes first.
	self namespaces keysAndValuesDo: [ :prefix :uri | "no default namespace for attributes"
		prefix = ''
			ifTrue: [
			self assert: (attribute resolvePrefix: prefix) equals: '' ]
			ifFalse: [
			self assert: (attribute resolvePrefix: prefix) equals: uri ] ].
	self
		assert: (attribute resolvePrefix: 'xml')
		equals: XMLNamespaceScope xmlNamespaceURI.
	self
		assert: (attribute resolvePrefix: 'xmlns')
		equals: XMLNamespaceScope xmlnsNamespaceURI
]

{ #category : 'tests' }
XMLAttributeTest >> testResolvePrefixIfUnresolvable [

	| element attribute |
	element := self newElementWithAttributes.
	attribute := element attributeNodes first.
	self namespaces keysAndValuesDo: [ :prefix :uri |
		prefix = ''
			ifTrue: [ "no default namespace for attributes"
				self
					assert:
					(attribute
						 resolvePrefix: prefix
						 ifUnresolvable: [ 'unresolvable' ])
					equals: 'unresolvable' ]
			ifFalse: [
				self
					assert:
					(attribute resolvePrefix: prefix ifUnresolvable: [ self fail ])
					equals: uri ] ].
	self
		assert:
		(attribute resolvePrefix: 'xml' ifUnresolvable: [ self fail ])
		equals: XMLNamespaceScope xmlNamespaceURI.
	self
		assert:
		(attribute resolvePrefix: 'xmlns' ifUnresolvable: [ self fail ])
		equals: XMLNamespaceScope xmlnsNamespaceURI
]

{ #category : 'tests' }
XMLAttributeTest >> testSortKey [

	self assert: (self newNode name: 'test') sortKey equals: 'test'
]

{ #category : 'tests' }
XMLAttributeTest >> testValue [

	| attribute |
	attribute := self newNode.
	self
		assert: attribute value equals: '';
		assert: (attribute value: 'test') identicalTo: attribute;
		assert: attribute value equals: 'test'
]

{ #category : 'tests' }
XMLAttributeTest >> testWriteXMLOn [

	self
		assert: (self nodeClass name: 'name' value: '') printString
		equals: 'name=""';
		assert: (self nodeClass name: 'name' value: 'value') printString
		equals: 'name="value"';
		assert:
			(self nodeClass name: 'name' value: self markupString) printString
		equals: 'name="' , self escapedString , '"'
]

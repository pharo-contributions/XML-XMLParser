Class {
	#name : #XMLAttributeTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLAttributeTest >> escapedString [
	^ '&lt;test name=&quot;&amp;name;&quot;>''&amp;value;''&lt;/test>'
]

{ #category : #accessing }
XMLAttributeTest >> nodeClass [
	^ XMLAttribute
]

{ #category : #tests }
XMLAttributeTest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self assert:
		((self nodeClass name: 'one' value: 'two') canonicallyEquals:
			(self nodeClass name: 'one' value: 'two')).
	self deny: ((self nodeClass name: 'one' value: 'two') canonicallyEquals: self nodeClass new).
]

{ #category : #tests }
XMLAttributeTest >> testCopy [
	| node copy |

	(node := self nodeClass new)
		element: XMLElement new.
	copy := node copy.
	self
		deny: copy == node;
		assert: copy element isNil.
]

{ #category : #tests }
XMLAttributeTest >> testElement [
	| node element |

	node := self nodeClass new.
	element := XMLElement new.
	node element: element.
	self assert: node element == element.
]

{ #category : #tests }
XMLAttributeTest >> testExpandedName [
	| element attribute |

	element := XMLElement new.
	attribute := self nodeClass name: 'one' value: 'two'.
	element attributeNodes add: attribute.
	self assert: (attribute expandedName = 'one').

	element defaultNamespace: 'defaultNS'.
	self assert: (attribute expandedName = 'one').

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	attribute name: 'prefix:two'.
	self assert: (attribute expandedName = 'Q{prefixNS}two').
]

{ #category : #tests }
XMLAttributeTest >> testHasLanguage [
	| attribute |

	attribute := self nodeClass new.
	attribute name: 'xml:lang'.
	self
		deny: (attribute hasLanguage: 'en-us');
		deny: (attribute hasLanguage: 'EN-US');
		deny: (attribute hasLanguage: 'En');
		deny: (attribute hasLanguage: 'de-de');
		deny: (attribute hasLanguage: 'DE-DE');
		deny: (attribute hasLanguage: 'De').

	attribute value: 'En-Us'.
	self
		assert: (attribute hasLanguage: 'en-us');
		assert: (attribute hasLanguage: 'EN-US');
		assert: (attribute hasLanguage: 'En');
		deny: (attribute hasLanguage: 'de-de');
		deny: (attribute hasLanguage: 'DE-DE');
		deny: (attribute hasLanguage: 'De').
]

{ #category : #tests }
XMLAttributeTest >> testHasPrefix [
	| attribute |

	attribute := self nodeClass new.
	self deny: attribute hasPrefix.

	attribute name: 'one'.
	self deny: attribute hasPrefix.

	attribute name: 'prefix:two'.
	self assert: attribute hasPrefix.

	attribute name: 'three'.
	self deny: attribute hasPrefix.
]

{ #category : #tests }
XMLAttributeTest >> testIsInLanguage [
	| element |

	super testIsInLanguage.
	element := self newElementWithAttributes.	
	element attributeNodesDo: [:each |
		self
			deny: (each isInLanguage: 'en');
			deny: (each isInLanguage: 'EN');
			deny: (each isInLanguage: 'En');
			deny: (each isInLanguage: 'en-us');
			deny: (each isInLanguage: 'EN-US');
			deny: (each isInLanguage: 'En-Us')].

	element attributeAt: 'xml:lang' put: 'En'.
	element attributeNodesDo: [:each |
		self
			assert: (each isInLanguage: 'en');
			assert: (each isInLanguage: 'EN');
			assert: (each isInLanguage: 'En');
			deny: (each isInLanguage: 'en-us');
			deny: (each isInLanguage: 'EN-US');
			deny: (each isInLanguage: 'En-Us')].
]

{ #category : #tests }
XMLAttributeTest >> testIsNamed [
	| attribute |

	(attribute := self nodeClass new) name: 'one'.
	self
		assert: (attribute isNamed: 'one');
		deny: (attribute isNamed: 'two').
	attribute name: 'one:two'.
	self
		assert: (attribute isNamed: 'one:two');
		assert: (attribute isNamed: 'two');
		deny: (attribute isNamed: 'one').
]

{ #category : #tests }
XMLAttributeTest >> testIsNamedAny [
	| attribute |

	(attribute := self nodeClass new) name: 'one'.
	self
		assert: (attribute isNamedAny: #('two' 'one' 'three'));
		deny: (attribute isNamedAny: #('two' 'three')).
	attribute name: 'one:two'.
	self
		assert: (attribute isNamedAny: #('one' 'one:two' 'three'));
		assert: (attribute isNamedAny: #('one' 'two' 'three'));
		deny: (attribute isNamedAny: #('one' 'three')).
]

{ #category : #tests }
XMLAttributeTest >> testLocalName [
	| attribute |

	attribute := self nodeClass new.
	self assert: attribute name isEmpty.

	attribute name: 'one'.
	self assert: attribute localName = 'one'.

	attribute name: 'two'.
	self assert: attribute localName = 'two'.

	attribute name: 'prefix:three'.
	self assert: attribute localName = 'three'.

	attribute name: 'four'.
	self assert: attribute localName = 'four'.
]

{ #category : #tests }
XMLAttributeTest >> testName [
	| attribute |

	attribute := self nodeClass new.
	self assert: attribute name isEmpty.

	attribute name: 'one'.
	self assert: attribute name = 'one'.

	attribute name: 'prefix:two'.
	self assert: attribute name = 'prefix:two'.
]

{ #category : #tests }
XMLAttributeTest >> testNameValue [
	| attribute |

	attribute := self nodeClass name: 'one' value: 'two'.
	self
		assert: attribute name = 'one';
		assert: attribute value = 'two'
]

{ #category : #tests }
XMLAttributeTest >> testNamespaceURI [
	| element attribute|

	element := XMLElement new.
	attribute := self nodeClass new.
	element attributeNodes add: attribute.
	self assert: attribute namespaceURI isEmpty.

	element defaultNamespace: 'defaultNS'.
	self assert: attribute namespaceURI isEmpty.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	attribute name: 'prefix:test'.
	self assert: attribute namespaceURI = 'prefixNS'.
	
	attribute name: 'test'.
	self assert: attribute namespaceURI isEmpty.
]

{ #category : #tests }
XMLAttributeTest >> testPrefix [
	| attribute |

	attribute := self nodeClass new.
	self assert: attribute prefix isEmpty.

	attribute name: 'one'.
	self assert: attribute prefix isEmpty.

	attribute name: 'prefix:two'.
	self assert: attribute prefix = 'prefix'.

	attribute name: 'three'.
	self assert: attribute prefix isEmpty.
]

{ #category : #tests }
XMLAttributeTest >> testSortKey [
	self assert: (self nodeClass new name: 'test') sortKey = 'test'
]

{ #category : #tests }
XMLAttributeTest >> testValue [
	self
		assert: self nodeClass new value isEmpty;
		assert: (self nodeClass new value: 'test') value = 'test'
]

{ #category : #tests }
XMLAttributeTest >> testWriteXMLOn [
	self
		assert: (self nodeClass name: 'name' value: '') printString = 'name=""';
		assert: (self nodeClass name: 'name' value: 'value') printString = 'name="value"';
		assert:
			(self nodeClass
				name: 'name'
				value: self markupString) printString = ('name="', self escapedString, '"')
]

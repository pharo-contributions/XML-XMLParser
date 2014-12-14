Class {
	#name : #XMLStringMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #tests }
XMLStringMethodsTest >> testHasPrefixBeforeLocalName [
	self
		deny: 'name' hasPrefixBeforeLocalName;
		deny: ':name' hasPrefixBeforeLocalName;
		assert: 'prefix:name' hasPrefixBeforeLocalName;
		assert: '::name' hasPrefixBeforeLocalName;
		assert: 'invalid:prefix:name' hasPrefixBeforeLocalName;
		assert: ':::name' hasPrefixBeforeLocalName;
		assert: ':invalid:prefix:name' hasPrefixBeforeLocalName.
]

{ #category : #tests }
XMLStringMethodsTest >> testIsQualifiedNameOrLocalName [
	self
		assert: ('name' isQualifiedName: 'name' orLocalName: 'name');
		assert: ('name' isQualifiedName: 'prefix:name' orLocalName: 'name');
		assert: ('prefix:name' isQualifiedName: 'prefix:name' orLocalName: 'name');
		deny: ('name' isQualifiedName: 'different' orLocalName: 'different');
		deny: ('name' isQualifiedName: 'prefix:different' orLocalName: 'different');
		deny: ('prefix:name' isQualifiedName: 'prefix:different' orLocalName: 'different').
]

{ #category : #tests }
XMLStringMethodsTest >> testLocalNameAfterPrefix [
	self
		assert: 'name' localNameAfterPrefix = 'name';
		assert: ':name' localNameAfterPrefix = ':name';
		assert: 'prefix:name' localNameAfterPrefix = 'name';
		assert: '::name' localNameAfterPrefix = 'name';
		assert: 'invalid:prefix:name' localNameAfterPrefix = 'name';
		assert: ':::name' localNameAfterPrefix = 'name';
		assert: ':invalid:prefix:name' localNameAfterPrefix = 'name'.
]

{ #category : #tests }
XMLStringMethodsTest >> testParseXML [
	| xml |

	xml := XMLParserTest addressBookXML.
	self assert: xml parseXML printString = (XMLDOMParser parse: xml) printString.
	self assert: '' parseXML printString = (XMLDOMParser parse: '') printString.
]

{ #category : #tests }
XMLStringMethodsTest >> testPrefixBeforeLocalName [
	self
		assert: 'name' prefixBeforeLocalName = '';
		assert: ':name' prefixBeforeLocalName = '';
		assert: 'prefix:name' prefixBeforeLocalName = 'prefix';
		assert: '::name' prefixBeforeLocalName = ':';
		assert: 'invalid:prefix:name' prefixBeforeLocalName = 'invalid:prefix';
		assert: ':::name' prefixBeforeLocalName = '::';
		assert: ':invalid:prefix:name' prefixBeforeLocalName = ':invalid:prefix'.
]

{ #category : #tests }
XMLStringMethodsTest >> testSplit [

	self
		assert: ($: xmlParserSplit: '') = (OrderedCollection with: '');
		assert: ($: xmlParserSplit: 'abc') = (OrderedCollection with: 'abc');
		assert: ($: xmlParserSplit: ':') = #('' '') asOrderedCollection;
		assert: ($: xmlParserSplit: '::') = #('' '' '') asOrderedCollection;
		assert: ($: xmlParserSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlParserSplit: ':ab:c:') = #('' 'ab' 'c' '') asOrderedCollection;
		assert: ($: xmlParserSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlParserSplit: 'ab::cd::ef') = #('ab'  '' 'cd' '' 'ef') asOrderedCollection;
		assert: ($: xmlParserSplit: '::ab:::cd:::ef::') = #('' '' 'ab'  '' '' 'cd' '' '' 'ef' '' '') asOrderedCollection.
]

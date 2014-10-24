Class {
	#name : #XMLStringMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

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
XMLStringMethodsTest >> testParseXML [
	| xml |

	xml := XMLParserTest addressBookXML.
	self assert: xml parseXML printString = (XMLDOMParser parse: xml) printString.
	self assert: '' parseXML printString = (XMLDOMParser parse: '') printString.
]

{ #category : #tests }
XMLStringMethodsTest >> testQualifiedNameLocalPart [
	self
		assert: 'name' qualifiedNameLocalPart = 'name';
		assert: ':name' qualifiedNameLocalPart = ':name';
		assert: 'prefix:name' qualifiedNameLocalPart = 'name';
		assert: '::name' qualifiedNameLocalPart = 'name';
		assert: 'invalid:prefix:name' qualifiedNameLocalPart = 'name';
		assert: ':::name' qualifiedNameLocalPart = 'name';
		assert: ':invalid:prefix:name' qualifiedNameLocalPart = 'name'.
]

{ #category : #tests }
XMLStringMethodsTest >> testQualifiedNamePrefix [
	self
		assert: 'name' qualifiedNamePrefix = '';
		assert: ':name' qualifiedNamePrefix = '';
		assert: 'prefix:name' qualifiedNamePrefix = 'prefix';
		assert: '::name' qualifiedNamePrefix = ':';
		assert: 'invalid:prefix:name' qualifiedNamePrefix = 'invalid:prefix';
		assert: ':::name' qualifiedNamePrefix = '::';
		assert: ':invalid:prefix:name' qualifiedNamePrefix = ':invalid:prefix'.
]

{ #category : #tests }
XMLStringMethodsTest >> testXMLSplit [

	self
		assert: ($: xmlSplit: '') = (OrderedCollection with: '');
		assert: ($: xmlSplit: 'abc') = (OrderedCollection with: 'abc');
		assert: ($: xmlSplit: ':') = #('' '') asOrderedCollection;
		assert: ($: xmlSplit: '::') = #('' '' '') asOrderedCollection;
		assert: ($: xmlSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlSplit: ':ab:c:') = #('' 'ab' 'c' '') asOrderedCollection;
		assert: ($: xmlSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlSplit: 'ab::cd::ef') = #('ab'  '' 'cd' '' 'ef') asOrderedCollection;
		assert: ($: xmlSplit: '::ab:::cd:::ef::') = #('' '' 'ab'  '' '' 'cd' '' '' 'ef' '' '') asOrderedCollection.
]

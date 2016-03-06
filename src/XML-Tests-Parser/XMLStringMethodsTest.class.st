Class {
	#name : #XMLStringMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLEscapedString [
	self assert:
		'<test name="&name;">''&value;''</test>' asXMLEscapedString =
			'&lt;test name="&amp;name;"&gt;''&amp;value;''&lt;/test&gt;'
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLFileHandle [
	XMLFileHandle hasSupportedImplementation
		ifTrue: [| path fileHandle |
			path := 'test.xml'.
			fileHandle := path asXMLFileHandle.
			self
				assert: (fileHandle isKindOf: XMLFileHandle);
				assert: fileHandle path = path]
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLHTTPRequest [
	XMLHTTPRequest hasSupportedImplementation
		ifTrue: [| url request |
			url := 'test.xml'.
			request := url asXMLHTTPRequest.
			self
				assert: (request isKindOf: XMLHTTPRequest);
				assert: request url = url]
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLStreamConverter [
	XMLStreamConverter allSubclassesDo: [:class |
		class encodingNames do: [:each |
			self assert: each asXMLStreamConverter class == class]]
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLString [
	| node |

	node := 'test' asXMLString.
	self
		assert: node class == XMLString;
		assert: node string = 'test'.
]

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

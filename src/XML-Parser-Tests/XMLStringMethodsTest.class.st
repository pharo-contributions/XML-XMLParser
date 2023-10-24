Class {
	#name : #XMLStringMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-Base'
}

{ #category : #accessing }
XMLStringMethodsTest class >> badNCNames [
	"all NC (non-qualified) names are names, but not all names are NC names"
	^ self badNames, self nonNCNameNames
]

{ #category : #accessing }
XMLStringMethodsTest class >> badNames [
	"all names are Nmtokens, but not all Nmtokens are names"
	^ self badNmtokens, self nonNameNmtokens
]

{ #category : #accessing }
XMLStringMethodsTest class >> badNmtokens [
	^ #('' ' ' '	'),
		(XMLCharacterMethodsTest nonNameChars collect: [:each |
			'test' copyWith: each])
]

{ #category : #accessing }
XMLStringMethodsTest class >> nonNCNameNames [
	^ #(':' 'test:test' 'test:' ':test')
]

{ #category : #accessing }
XMLStringMethodsTest class >> nonNameNmtokens [
	^ XMLCharacterMethodsTest nonNameStartCharNameChars collect: [:each |
		'test' copyWithFirst: each]
]

{ #category : #accessing }
XMLStringMethodsTest >> badNCNames [
	^ self class badNCNames
]

{ #category : #accessing }
XMLStringMethodsTest >> badNames [
	^ self class badNames
]

{ #category : #accessing }
XMLStringMethodsTest >> badNmtokens [
	^ self class badNmtokens
]

{ #category : #accessing }
XMLStringMethodsTest >> nonNCNameNames [
	^ self class nonNCNameNames
]

{ #category : #accessing }
XMLStringMethodsTest >> nonNameNmtokens [
	^ self class nonNameNmtokens
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLEscapedString [

	self
		assert: '<test name="&name;">''&value;''</test>' asXMLEscapedString
		equals: '&lt;test name="&amp;name;"&gt;''&amp;value;''&lt;/test&gt;'
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLFileHandle [

	| path fileHandle |
	XMLFileHandle hasSupportedImplementation ifFalse: [ ^ self ].
	path := 'test.xml'.
	fileHandle := path asXMLFileHandle.
	self
		assert: fileHandle class identicalTo: XMLFileHandle implementation;
		assert: fileHandle path equals: path
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLHTTPRequest [

	| url request |
	XMLHTTPRequest hasSupportedImplementation ifFalse: [ ^ self ].
	url := 'test.xml'.
	request := url asXMLHTTPRequest.
	self
		assert: request class identicalTo: XMLHTTPRequest implementation;
		assert: request url equals: url
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLStreamConverter [

	XMLStreamConverter allSubclassesDo: [ :class |
		(class class includesSelector: #encodingNames) ifTrue: [
			class encodingNames do: [ :each |
				self assert: each asXMLStreamConverter class identicalTo: class ] ] ]
]

{ #category : #tests }
XMLStringMethodsTest >> testAsXMLStringNode [

	| node |
	node := 'test' asXMLStringNode.
	self
		assert: node class identicalTo: XMLString;
		assert: node string equals: 'test'
]

{ #category : #tests }
XMLStringMethodsTest >> testIsXMLNCName [
	self badNCNames do: [:each |
		self deny: each isXMLNCName]
]

{ #category : #tests }
XMLStringMethodsTest >> testIsXMLNSAttributeName [
	self
		deny: '' isXMLNSAttributeName;
		deny: 'name' isXMLNSAttributeName;
		deny: 'name:xml' isXMLNSAttributeName;
		deny: 'name:xmlns' isXMLNSAttributeName;
		deny: 'xml:base' isXMLNSAttributeName;
		deny: 'xml:space' isXMLNSAttributeName;
		assert: 'xmlns' isXMLNSAttributeName;
		assert: 'xmlns:' isXMLNSAttributeName;
		assert: 'xmlns:name' isXMLNSAttributeName
]

{ #category : #tests }
XMLStringMethodsTest >> testIsXMLName [
	self nonNCNameNames do: [:each |
		self assert: each isXMLName].
	self badNames do: [:each |
		self deny: each isXMLName].
]

{ #category : #tests }
XMLStringMethodsTest >> testIsXMLNmtoken [
	self nonNCNameNames do: [:each |
		self assert: each isXMLNmtoken].
	self nonNameNmtokens do: [:each |
		self assert: each isXMLNmtoken].
	self badNmtokens do: [:each |
		self deny: each isXMLNmtoken].
]

{ #category : #tests }
XMLStringMethodsTest >> testIsXMLQualifiedOrLocalName [
	self
		deny: ('' isXMLQualifiedOrLocalName: 'name');
		deny: ('' isXMLQualifiedOrLocalName: 'prefix:name');
		assert: ('name' isXMLQualifiedOrLocalName: 'name');
		assert: ('prefix:name' isXMLQualifiedOrLocalName: 'name');
		assert: ('prefix:name' isXMLQualifiedOrLocalName: 'prefix:name');
		deny: ('name' isXMLQualifiedOrLocalName: 'different');
		deny: ('name' isXMLQualifiedOrLocalName: 'prefix:name');
		deny: ('prefix:name' isXMLQualifiedOrLocalName: 'prefix:different');
		deny: ('prefix:name' isXMLQualifiedOrLocalName: 'different:name').

	"test wide char equality (redundant on Spur, but should remain as long
	as Cog and older VMs are supported)"
	self assert:
		((String with: 256 asCharacter)
			isXMLQualifiedOrLocalName:
				(String with: 256 asCharacter)).
	self assert:
		((String with: 16r039A asCharacter with: $: with: 16r039B asCharacter)
			isXMLQualifiedOrLocalName:
				(String with: 16r039B asCharacter)).
]

{ #category : #tests }
XMLStringMethodsTest >> testIsXMLReservedAttributeName [
	self
		deny: '' isXMLReservedAttributeName;
		deny: 'name' isXMLReservedAttributeName;
		deny: 'name:xml' isXMLReservedAttributeName;
		deny: 'name:xmlns' isXMLReservedAttributeName;
		assert: 'xml:base' isXMLReservedAttributeName;
		assert: 'xml:space' isXMLReservedAttributeName;
		assert: 'xmlns' isXMLReservedAttributeName;
		assert: 'xmlns:' isXMLReservedAttributeName;
		assert: 'xmlns:name' isXMLReservedAttributeName
]

{ #category : #tests }
XMLStringMethodsTest >> testParseXML [

	| xml |
	xml := XMLParserTest addressBookXML.
	self
		assert: xml parseXML printString
		equals: (XMLDOMParser parse: xml) printString
]

{ #category : #tests }
XMLStringMethodsTest >> testXMLLocalNameAfterPrefix [

	self
		assert: 'name' xmlLocalNameAfterPrefix equals: 'name';
		assert: ':name' xmlLocalNameAfterPrefix equals: ':name';
		assert: 'prefix:name' xmlLocalNameAfterPrefix equals: 'name';
		assert: '::name' xmlLocalNameAfterPrefix equals: 'name';
		assert: 'invalid:prefix:name' xmlLocalNameAfterPrefix
		equals: 'name';
		assert: ':::name' xmlLocalNameAfterPrefix equals: 'name';
		assert: ':invalid:prefix:name' xmlLocalNameAfterPrefix
		equals: 'name'
]

{ #category : #tests }
XMLStringMethodsTest >> testXMLPrefixBeforeLocalName [

	self
		assert: 'name' xmlPrefixBeforeLocalName equals: '';
		assert: ':name' xmlPrefixBeforeLocalName equals: '';
		assert: 'prefix:name' xmlPrefixBeforeLocalName equals: 'prefix';
		assert: '::name' xmlPrefixBeforeLocalName equals: ':';
		assert: 'invalid:prefix:name' xmlPrefixBeforeLocalName
		equals: 'invalid:prefix';
		assert: ':::name' xmlPrefixBeforeLocalName equals: '::';
		assert: ':invalid:prefix:name' xmlPrefixBeforeLocalName
		equals: ':invalid:prefix'
]

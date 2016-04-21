Class {
	#name : #XMLStringMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #accessing }
XMLStringMethodsTest class >> badNCNames [
	"all NC (non-qualified) names are names, but not all names are NC names"
	^ self badNames, self nonNCNameNames
]

{ #category : #accessing }
XMLStringMethodsTest class >> badNames [
	"all names are Nmtokens, but not all Nmtokesn are names"
	^ self badNmtokens, self nonNameNmtokens
]

{ #category : #accessing }
XMLStringMethodsTest class >> badNmtokenChars [
	"16r10FFFF is the max value a char can hold on GS, so nothing above it
	is tested for, and 16r0 is not tested for because it terminates strings
	on GS"
	^ #(16r01 16r0F 16r10
			16r2C 16r2F 16r40 16r5B
			16r5E 16r60 16r7B 16r80
			16rBF 16rD7 16rF7 16r37E
			16r2000 16r200B 16r200E 16r206F
			16r2190 16r2BFF 16r2FFF 16r3000
			16rD800 16rF8FF 16rFDD0 16rFDEF
			16rFFFE 16r0FFFF 16rF0000 16r10FFFF)
			collect: [:each | each asCharacter]
]

{ #category : #accessing }
XMLStringMethodsTest class >> badNmtokens [
	^ #('' ' ' '	'), (self badNmtokenChars collect: [:each | 'test' copyWith: each])
]

{ #category : #accessing }
XMLStringMethodsTest class >> nonNCNameNames [
	^ #(':' 'test:test' 'test:' ':test')
]

{ #category : #accessing }
XMLStringMethodsTest class >> nonNameNmtokens [
	^ self nonNameStartCharNameChars collect: [:each | 'test' copyWithFirst: each]
]

{ #category : #accessing }
XMLStringMethodsTest class >> nonNameStartCharNameChars [
	"NameChars that aren't NameStartChars"
	^ #($- $.
			$0 $1 $2 $3 $4 $5 $6 $7 $8 $9
			16rB7 16r0300 16r036F 16r203F 16r2040)
			collect: [:each | each asCharacter]
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
XMLStringMethodsTest >> testIsXMLNCName [
	self badNCNames do: [:each |
		self deny: each isXMLNCName]
]

{ #category : #tests }
XMLStringMethodsTest >> testIsXMLNSAttributeName [
	self
		deny: '' isXMLNSAttributeName;
		deny: 'name' isXMLNSAttributeName;
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

	"test wide char equality for pre-Spur images"
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
	self assert: xml parseXML printString = (XMLDOMParser parse: xml) printString.
]

{ #category : #tests }
XMLStringMethodsTest >> testXMLLocalNameAfterPrefix [
	self
		assert: 'name' xmlLocalNameAfterPrefix = 'name';
		assert: ':name' xmlLocalNameAfterPrefix = ':name';
		assert: 'prefix:name' xmlLocalNameAfterPrefix = 'name';
		assert: '::name' xmlLocalNameAfterPrefix = 'name';
		assert: 'invalid:prefix:name' xmlLocalNameAfterPrefix = 'name';
		assert: ':::name' xmlLocalNameAfterPrefix = 'name';
		assert: ':invalid:prefix:name' xmlLocalNameAfterPrefix = 'name'.
]

{ #category : #tests }
XMLStringMethodsTest >> testXMLPrefixBeforeLocalName [
	self
		assert: 'name' xmlPrefixBeforeLocalName = '';
		assert: ':name' xmlPrefixBeforeLocalName = '';
		assert: 'prefix:name' xmlPrefixBeforeLocalName = 'prefix';
		assert: '::name' xmlPrefixBeforeLocalName = ':';
		assert: 'invalid:prefix:name' xmlPrefixBeforeLocalName = 'invalid:prefix';
		assert: ':::name' xmlPrefixBeforeLocalName = '::';
		assert: ':invalid:prefix:name' xmlPrefixBeforeLocalName = ':invalid:prefix'.
]

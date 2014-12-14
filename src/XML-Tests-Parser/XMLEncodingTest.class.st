Class {
	#name : #XMLEncodingTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #private }
XMLEncodingTest >> convertableStreamOn: aString [
	^ aString readStream
]

{ #category : #source }
XMLEncodingTest >> encodingDeclaration: anEncoding [
	^ '<?xml version="1.0" encoding="', anEncoding, '"?>'
]

{ #category : #source }
XMLEncodingTest >> encodingDeclaration: anEncoding withUTF16XML: anXml littleEndian: aBoolean [
	^ ((self encodingDeclaration: anEncoding) allButLast: 2),
		(self toUTF16: '?>', anXml littleEndian: aBoolean)
]

{ #category : #source }
XMLEncodingTest >> encodingDeclaration: anEncoding withUTF32XML: anXml littleEndian: aBoolean [
	^ ((self encodingDeclaration: anEncoding) allButLast: 2),
		(self toUTF32: '?>', anXml littleEndian: aBoolean)
]

{ #category : #source }
XMLEncodingTest >> sourceXML [
	^ self sourceXMLWith: 'encoding test'
]

{ #category : #source }
XMLEncodingTest >> sourceXMLWith: aCharacterOrString [
	^ '<encoding-test>', aCharacterOrString asString, '</encoding-test>'
]

{ #category : #private }
XMLEncodingTest >> stringFromValues: aCollection [
	"avoid asString for portability"
	^ String withAll: (aCollection collect: [:each | Character value: each])
]

{ #category : #tests }
XMLEncodingTest >> testBinaryDecoding [
	| xml binaryXml |
	
	xml := XMLParserTest addressBookXML.
	binaryXml := xml asArray collect: [:each | each asciiValue].
	self assert:
		(XMLDOMParser parse: binaryXml) printString =
			(XMLDOMParser parse: xml) printString.
]

{ #category : #tests }
XMLEncodingTest >> testDecodingCharacters [
	| xml document  |

	xml := '<?xml version="1.0" encoding="UTF-8"?>
			<test-data>&#{1};</test-data>'.

	document := XMLDOMParser parse: (xml format: (Array with: '8230')).
	self assert: document root contentString first charCode = 8230.

	self
		should: [XMLDOMParser parse: (xml format: (Array with: ''))]
		raise: XMLWellFormednessException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: '0'))]
		raise: XMLWellFormednessException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: '-1'))]
		raise: XMLWellFormednessException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: '9:'))]
		raise: XMLWellFormednessException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: 'xFG'))]
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationLatin1 [
	| xml |

	"avoid asString for portability"
	xml := self sourceXMLWith: (String withAll: (#(126 127 128) collect: [:each | each asCharacter])).
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf8BOM, (self encodingDeclaration: 'UTF-8'), xml)]
		raise: XMLEncodingException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf8BOM, (self encodingDeclaration: 'latin-1'), xml)]
		raise: XMLEncodingException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF16BE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'UTF-16-BE'
						withUTF16XML: self sourceXML
						littleEndian: true))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'UTF-16-BE'
						withUTF16XML: self sourceXML
						littleEndian: false))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF16LE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'UTF-16LE'
						withUTF16XML: self sourceXML
						littleEndian: false))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'UTF-16LE'
						withUTF16XML: self sourceXML
						littleEndian: true))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF32BE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'utf-32be'
						withUTF32XML: self sourceXML
						littleEndian: true))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'utf-32be'
						withUTF32XML: self sourceXML
						littleEndian: false))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF32LE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'utf-32-le'
						withUTF32XML: self sourceXML
						littleEndian: false))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'utf-32-le'
						withUTF32XML: self sourceXML
						littleEndian: true))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF8 [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'UTF8'
						withUTF16XML: self sourceXML
						littleEndian: false))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						encodingDeclaration: 'UTF-8'
						withUTF16XML: self sourceXML
						littleEndian: true))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self encodingDeclaration: 'UTF-8'), self sourceXML)]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF16EncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self toUTF16: self sourceXML littleEndian: true))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self toUTF16: self sourceXML littleEndian: false))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF32EncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self toUTF32: self sourceXML littleEndian: true))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self toUTF32: self sourceXML littleEndian: false))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF16BigEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16BigEndianBOM, self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16BigEndianBOM, (self toUTF16: self sourceXML littleEndian: true))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16BigEndianBOM, (self toUTF16: self sourceXML littleEndian: false))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF16Characters [
	| document source decoded |

	source :=
		self stringFromValues:
			#(256
				16rD7FF
				16rE000
				16rFFFF
				16rD800 16rDC00 "first surrogate"
				16rDBFF 16rDFFF). "last surrogate"
	decoded := self stringFromValues: #(256 16rD7FF 16rE000 16rFFFF 16r10000 16r10FFFF).

	document :=
		XMLDOMParser parse:
			(self
				encodingDeclaration: 'UTF-16LE'
				withUTF16XML: (self sourceXMLWith: source)
				littleEndian: true).
	self assert: document firstElement contentString = decoded.

	document :=
		XMLDOMParser parse:
			(self
				encodingDeclaration: 'UTF-16BE'
				withUTF16XML: (self sourceXMLWith: source)
				littleEndian: false).
	self assert: document firstElement contentString = decoded.
]

{ #category : #tests }
XMLEncodingTest >> testUTF16LittleEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16LittleEndianBOM, self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16LittleEndianBOM, (self toUTF16: self sourceXML littleEndian: false))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16LittleEndianBOM, (self toUTF16: self sourceXML littleEndian: true))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF32BigEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32BigEndianBOM, self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32BigEndianBOM, (self toUTF32: self sourceXML littleEndian: true))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32BigEndianBOM, (self toUTF32: self sourceXML littleEndian: false))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF32Characters [
	| document source decoded |

	source :=
		self stringFromValues:
			#(16r000000FE
				16r0000D7FE
				16r0010FFFF).
	decoded := self stringFromValues: #(16rFE 16rD7FE 16r10FFFF).

	document :=
		XMLDOMParser parse:
			(self
				encodingDeclaration: 'UTF-32-LE'
				withUTF32XML: (self sourceXMLWith: source)
				littleEndian: true).
	self assert: document firstElement contentString = decoded.

	document :=
		XMLDOMParser parse:
			(self
				encodingDeclaration: 'UTF-32BE'
				withUTF32XML: (self sourceXMLWith: source)
				littleEndian: false).
	self assert: document firstElement contentString = decoded.
]

{ #category : #tests }
XMLEncodingTest >> testUTF32LittleEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32LittleEndianBOM, self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32LittleEndianBOM, (self toUTF32: self sourceXML littleEndian: false))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32LittleEndianBOM, (self toUTF32: self sourceXML littleEndian: true))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF8ByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf8BOM, (self toUTF16: self sourceXML littleEndian: true))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf8BOM, (self toUTF16: self sourceXML littleEndian: false))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: self utf8BOM, self sourceXML)]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF8Characters [
	| document source decoded |

	source :=
		self stringFromValues:
			#(16r7F
				16rC2 16r80
				16rDF 16rBF
				16rE0 16rA0 16r80
				16rEF 16rBF 16rBF
				16rF0 16r90 16r80 16r80
				16rF4 16r8F 16rBF 16rBF).
	decoded := self stringFromValues: #(16r7F 16r80 16r7FF 16r800 16rFFFF 16r10000 16r10FFFF).

	document :=
		XMLDOMParser parse:
			self utf8BOM, (self encodingDeclaration: 'UTF-8'), (self sourceXMLWith: source).
	self assert: document firstElement contentString = decoded.
]

{ #category : #private }
XMLEncodingTest >> toUTF16: aString littleEndian: aBoolean [
	^ String streamContents: [:stream |
		aString do: [:each |
			aBoolean
				ifTrue: [
					stream
						nextPut: (each asciiValue bitAnd: 16r00FF) asCharacter;
						nextPut: ((each asciiValue bitAnd: 16rFF00) bitShift: -8) asCharacter]
				ifFalse: [
					stream
						nextPut: ((each asciiValue bitAnd: 16rFF00) bitShift: -8) asCharacter;
						nextPut: (each asciiValue bitAnd: 16r00FF) asCharacter]]]
]

{ #category : #private }
XMLEncodingTest >> toUTF32: aString littleEndian: aBoolean [
	^ String streamContents: [:stream |
		aString do: [:each |
			aBoolean
				ifTrue: [
					stream
						nextPut: (each asciiValue bitAnd: 16r000000FF) asCharacter;
						nextPut: ((each asciiValue bitAnd: 16r0000FF00) bitShift: -8) asCharacter;
						nextPut: ((each asciiValue bitAnd: 16r00FF0000) bitShift: -16) asCharacter;
						nextPut: ((each asciiValue bitAnd: 16rFF000000) bitShift: -24) asCharacter]
				ifFalse: [
					stream
						nextPut: ((each asciiValue bitAnd: 16rFF000000) bitShift: -24) asCharacter;
						nextPut: ((each asciiValue bitAnd: 16r00FF0000) bitShift: -16) asCharacter;
						nextPut: ((each asciiValue bitAnd: 16r0000FF00) bitShift: -8) asCharacter;
						nextPut: (each asciiValue bitAnd: 16r000000FF) asCharacter]]]
]

{ #category : #private }
XMLEncodingTest >> utf16BigEndianBOM [
	^ XMLUTF16BigEndianStreamDecoder byteOrderMark
]

{ #category : #private }
XMLEncodingTest >> utf16LittleEndianBOM [
	^ XMLUTF16LittleEndianStreamDecoder byteOrderMark
]

{ #category : #private }
XMLEncodingTest >> utf32BigEndianBOM [
	^ XMLUTF32BigEndianStreamDecoder byteOrderMark
]

{ #category : #private }
XMLEncodingTest >> utf32LittleEndianBOM [
	^ XMLUTF32LittleEndianStreamDecoder byteOrderMark
]

{ #category : #private }
XMLEncodingTest >> utf8BOM [
	^ XMLUTF8StreamDecoder byteOrderMark
]

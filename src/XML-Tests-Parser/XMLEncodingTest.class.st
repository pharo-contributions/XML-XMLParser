Class {
	#name : #XMLEncodingTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #converting }
XMLEncodingTest >> asciiToUTF16BE: anASCIIString [
	^ XMLStreamAdapterTest asciiToUTF16BE: anASCIIString
]

{ #category : #converting }
XMLEncodingTest >> asciiToUTF16LE: anASCIIString [
	^ XMLStreamAdapterTest asciiToUTF16LE: anASCIIString
]

{ #category : #converting }
XMLEncodingTest >> asciiToUTF32BE: anASCIIString [
	^ XMLStreamAdapterTest asciiToUTF32BE: anASCIIString
]

{ #category : #converting }
XMLEncodingTest >> asciiToUTF32LE: anASCIIString [
	^ XMLStreamAdapterTest asciiToUTF32LE: anASCIIString
]

{ #category : #converting }
XMLEncodingTest >> convertableStreamOn: aString [
	^ aString readStream
]

{ #category : #source }
XMLEncodingTest >> encodingDeclaration: anEncoding [
	^ '<?xml version="1.0" encoding="', anEncoding, '"?>'
]

{ #category : #source }
XMLEncodingTest >> sourceContent [
	^ 'encoding test'
]

{ #category : #source }
XMLEncodingTest >> sourceXML [
	^ self sourceXMLWithContent: self sourceContent
]

{ #category : #source }
XMLEncodingTest >> sourceXMLWithContent: aCharacterOrString [
	^ '<encoding-test>', aCharacterOrString asString, '</encoding-test>'
]

{ #category : #source }
XMLEncodingTest >> sourceXMLWithEncoding: anEncoding andASCIIContentAsUTF16BE: anASCIIContentString [
	^ ((self encodingDeclaration: anEncoding) allButLast: 2),
		(self asciiToUTF16BE: '?>', anASCIIContentString)
]

{ #category : #source }
XMLEncodingTest >> sourceXMLWithEncoding: anEncoding andASCIIContentAsUTF16LE: anASCIIContentString [
	^ ((self encodingDeclaration: anEncoding) allButLast: 2),
		(self asciiToUTF16LE: '?>', anASCIIContentString)
]

{ #category : #source }
XMLEncodingTest >> sourceXMLWithEncoding: anEncoding andASCIIContentAsUTF32BE: anASCIIContentString [
	^ ((self encodingDeclaration: anEncoding) allButLast: 2),
		(self asciiToUTF32BE: '?>', anASCIIContentString)
]

{ #category : #source }
XMLEncodingTest >> sourceXMLWithEncoding: anEncoding andASCIIContentAsUTF32LE: anASCIIContentString [
	^ ((self encodingDeclaration: anEncoding) allButLast: 2),
		(self asciiToUTF32LE: '?>', anASCIIContentString)
]

{ #category : #converting }
XMLEncodingTest >> stringFrom: aCollection [
	^ XMLStreamAdapterTest stringFrom: aCollection
]

{ #category : #tests }
XMLEncodingTest >> testDecodingBinary [
	| source binarySource |
	
	source := self sourceXML.
	binarySource := source asArray collect: [:each | each asciiValue].
	self assert:
		(XMLDOMParser parse: binarySource) printString =
			(XMLDOMParser parse: source) printString.
]

{ #category : #tests }
XMLEncodingTest >> testDecodingCharacterReferences [
	| document |

	document :=
		XMLDOMParser parse:
			(self sourceXMLWithContent:
				(String streamContents: [:stream |
					self sourceContent do: [:each |
						stream
							nextPutAll: '&#';
							nextPutAll: each asciiValue asString;
							nextPut: $;]])).
	self assert: document root contentString = self sourceContent.

	document :=
		XMLDOMParser parse:
			(self sourceXMLWithContent:
				(String streamContents: [:stream |
					self sourceContent do: [:each |
						stream
							nextPutAll: '&#x';
							nextPutAll: each asciiValue printStringHex asLowercase;
							nextPut: $;]])).
	self assert: document root contentString = self sourceContent.

	document :=
		XMLDOMParser parse:
			(self sourceXMLWithContent:
				(String streamContents: [:stream |
					self sourceContent do: [:each |
						stream
							nextPutAll: '&#x';
							nextPutAll: each asciiValue printStringHex asUppercase;
							nextPut: $;]])).
	self assert: document root contentString = self sourceContent.

	#('&#0;' '&#x110000;' '&#-1;' '&#9:;' '&#xFFG;') do: [:each |
		self
			should: [XMLDOMParser parse: (self sourceXMLWithContent: each)]
			raise: XMLWellFormednessException].

	XMLCharacterMethodsTest nonChars do: [:each |
		self
			should: [
				XMLDOMParser parse:
					(self sourceXMLWithContent: '&#', each asciiValue asString, ';')]
			raise: XMLWellFormednessException].
]

{ #category : #tests }
XMLEncodingTest >> testDecodingDisabledEncodingDeclaration [
	| xml |

	xml := 
		self
			sourceXMLWithEncoding: 'UTF-16-BE'
			andASCIIContentAsUTF16BE: self sourceXML.
	self
		should: [
			(SAXHandler on: (self convertableStreamOn: xml))
				decodesCharacters: false;
				parseDocument]
		raise: XMLParserException.
	self
		shouldnt: [
			(SAXHandler on: (self convertableStreamOn: xml))
				decodesCharacters: true;
				parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testDecodingDisabledEncodingDetection [
	| xml |

	xml := self asciiToUTF16LE: self sourceXML.
	self
		should: [
			(SAXHandler on: (self convertableStreamOn: xml))
				decodesCharacters: false;
				parseDocument]
		raise: XMLParserException.
	self
		shouldnt: [
			(SAXHandler on: (self convertableStreamOn: xml))
				decodesCharacters: true;
				parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationLatin1 [
	| xml |

	xml := self sourceXMLWithContent: (self stringFrom: #(126 127 128 255)).
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
						sourceXMLWithEncoding: 'UTF-16-BE'
						andASCIIContentAsUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-BE'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF16LE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16LE'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16BE'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF32BE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'utf-32be'
						andASCIIContentAsUTF32LE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'utf-32be'
						andASCIIContentAsUTF32BE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF32LE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'utf-32-le'
						andASCIIContentAsUTF32BE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'utf-32-le'
						andASCIIContentAsUTF32LE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF8 [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF8'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-8'
						andASCIIContentAsUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self encodingDeclaration: 'UTF-8'), self sourceXML)]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testExternalReadStreamDecoder [
	| readStreamAdapter |

	readStreamAdapter :=
		XMLDecodingReadStreamAdapter on: 
			(self convertableStreamOn:
				self utf16LittleEndianBOM, (self asciiToUTF16LE: self sourceXML)).

	self
		shouldnt: [SAXHandler parse: readStreamAdapter]
		raise: XMLParserException.

	self
		assert: readStreamAdapter atEnd;
		assert: (readStreamAdapter streamConverter isKindOf: XMLUTF16StreamConverter).
]

{ #category : #tests }
XMLEncodingTest >> testExternalSubsetByteOrderMarkDetection [
	| document dtd encodedDTDWithBOM |

	document := '<!DOCTYPE test SYSTEM "extern.dtd"><test/>'.
	dtd := '<!ELEMENT test EMPTY>'.
	self
		shouldnt: [
			encodedDTDWithBOM := self utf16BigEndianBOM, (self asciiToUTF16BE: dtd).
			(SAXHandler on: document)
				externalEntityResolver:
					(DTDPluggableExternalEntityResolver entities:
						(Array with: 'extern.dtd' -> encodedDTDWithBOM));
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLParserException.
	self
		shouldnt: [
			encodedDTDWithBOM := self utf16LittleEndianBOM, (self asciiToUTF16LE: dtd).
			(SAXHandler on: document)
				externalEntityResolver:
					(DTDPluggableExternalEntityResolver entities:
						(Array with: 'extern.dtd' -> encodedDTDWithBOM));
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testExternalSubsetImplicitEncodingDetection [	
	| document dtd |

	document := '<!DOCTYPE test SYSTEM "extern.dtd"><test/>'.
	dtd := '<!ELEMENT test EMPTY>'.
	self
		shouldnt: [
			(SAXHandler on: document)
				externalEntityResolver:
					(DTDPluggableExternalEntityResolver entities:
						(Array with: 'extern.dtd' -> (self asciiToUTF16BE: dtd)));
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLParserException.
	self
		shouldnt: [
			(SAXHandler on: document)
				externalEntityResolver:
					(DTDPluggableExternalEntityResolver entities:
						(Array with: 'extern.dtd' -> (self asciiToUTF16LE: dtd)));
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF16EncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self asciiToUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn: (self asciiToUTF16BE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF32EncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self asciiToUTF32LE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self asciiToUTF32BE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF16BigEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn: self utf16BigEndianBOM, self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16BigEndianBOM, (self asciiToUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16BigEndianBOM, (self asciiToUTF16BE: self sourceXML))]
		raise: XMLParserException.
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
					self utf16LittleEndianBOM, (self asciiToUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf16LittleEndianBOM, (self asciiToUTF16LE: self sourceXML))]
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
					self utf32BigEndianBOM, (self asciiToUTF32LE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32BigEndianBOM, (self asciiToUTF32BE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF32LittleEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn: self utf32LittleEndianBOM, self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32LittleEndianBOM, (self asciiToUTF32BE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf32LittleEndianBOM, (self asciiToUTF32LE: self sourceXML))]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF8ByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf8BOM, (self asciiToUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf8BOM, (self asciiToUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					self utf8BOM, self sourceXML)]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testWideCharacterNames [
	| wideNames document |

	(wideNames := OrderedCollection new)
		addLast: (self stringFrom: #(16rC0 16rD6 16rD8 16rF6 16rF8 16r2FF $- $.));
		addLast: (self stringFrom: #(16r370 16r37D 16r37F 16r1FFF 16r200C $0 $9));
		addLast: (self stringFrom: #(16r200D 16r2070 16r218F 16r2C00 16r2FEF 16rB7));
		addLast: (self stringFrom: #(16r3001 16rD7FF 16rF900 16rFDCF 16rFDF0 16r0300));
		addLast: (self stringFrom: #(16rFFFD 16r10000 16rEFFFF 16r036F 16r203F 16r2040)).

	self
		shouldnt: [| source |
			source :=
				'<!DOCTYPE {1} [
					<!ELEMENT {1} ({2}, {3}, {4})>
					<!ELEMENT {2} EMPTY>
					<!ELEMENT {3} (#PCDATA)*>
					<!ELEMENT {4} EMPTY>
					<!ATTLIST {1} {5} ({3} | {4} | {5}) #IMPLIED>
				]>
				<{1} {5}="{4}">
					<{2}/>
					<{3}>{5}</{3}>
					<{4}/>
				</{1}>' format: wideNames.

			"a char-wise copy of source is parsed because wide chars aren't immediate
			types in pre-Spur Pharo/Squeak, so this can catch improper use of == on
			wide chars in those images"
			document := XMLDOMParser parse: (source collect: [:each | each copy])]
		raise: XMLParserException.

	self
		assert: document root name = wideNames first;
		assert: (document root attributeAt: wideNames fifth) = wideNames fourth;
		assert: (document root elementNames) asOrderedCollection = (wideNames copyFrom: 2 to: 4);
		assert: document contentString = wideNames fifth.
]

{ #category : #accessing }
XMLEncodingTest >> utf16BigEndianBOM [
	^ XMLUTF16BigEndianStreamConverter byteOrderMark
]

{ #category : #accessing }
XMLEncodingTest >> utf16LittleEndianBOM [
	^ XMLUTF16LittleEndianStreamConverter byteOrderMark
]

{ #category : #accessing }
XMLEncodingTest >> utf32BigEndianBOM [
	^ XMLUTF32BigEndianStreamConverter byteOrderMark
]

{ #category : #accessing }
XMLEncodingTest >> utf32LittleEndianBOM [
	^ XMLUTF32LittleEndianStreamConverter byteOrderMark
]

{ #category : #accessing }
XMLEncodingTest >> utf8BOM [
	^ XMLUTF8StreamConverter byteOrderMark
]

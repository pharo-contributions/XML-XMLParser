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
	^ XMLDecodingReadStreamAdapter on: aString readStream
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
	| source binarySource parser stream |

	source := self sourceXML.
	binarySource := source asArray collect: [:each | each asciiValue].
	parser := (SAXHandler on: binarySource) parser.
	stream := parser tokenizer streamReader stream.
	self
		assert: stream isXMLConvertingStreamAdapter;
		assert: stream hasDefaultStreamConverter;
		assert: stream upToEnd = source.
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
					(self encodingDeclaration: 'UTF-16-BE'), self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-BE'
						andASCIIContentAsUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-BE'
						andASCIIContentAsUTF32BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-BE'
						andASCIIContentAsUTF32LE: self sourceXML))]
		raise: XMLParserException.

	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-BE'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-BE'
						andASCIIContentAsUTF16BE: self sourceXML)))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF16LE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self encodingDeclaration: 'UTF-16-LE'), self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-LE'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-LE'
						andASCIIContentAsUTF32BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-LE'
						andASCIIContentAsUTF32LE: self sourceXML))]
		raise: XMLParserException.

	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-LE'
						andASCIIContentAsUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-16-LE'
						andASCIIContentAsUTF16LE: self sourceXML)))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF32BE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self encodingDeclaration: 'UTF-32-BE'), self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-BE'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-BE'
						andASCIIContentAsUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-BE'
						andASCIIContentAsUTF32LE: self sourceXML))]
		raise: XMLParserException.

	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-BE'
						andASCIIContentAsUTF32BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-BE'
						andASCIIContentAsUTF32BE: self sourceXML)))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF32LE [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self encodingDeclaration: 'UTF-32-LE'), self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-LE'
						andASCIIContentAsUTF16BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-LE'
						andASCIIContentAsUTF16LE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-LE'
						andASCIIContentAsUTF32BE: self sourceXML))]
		raise: XMLParserException.

	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-LE'
						andASCIIContentAsUTF32LE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-32-LE'
						andASCIIContentAsUTF32LE: self sourceXML)))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclarationUTF8 [
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-8'
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
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-8'
						andASCIIContentAsUTF32BE: self sourceXML))]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self
						sourceXMLWithEncoding: 'UTF-8'
						andASCIIContentAsUTF32LE: self sourceXML))]
		raise: XMLParserException.

	self
		shouldnt: [
			SAXHandler parse:
				(self convertableStreamOn:
					(self encodingDeclaration: 'UTF-8'), self sourceXML)]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testExternalEntityByteOrderMarkDetection [
	| document entity |

	document := '
		<!DOCTYPE test [
			<!ENTITY % external SYSTEM "extern.ent">
			 %external;
		]>
		<test/>'.
	entity := '<!ELEMENT test EMPTY>'.
	(Array
		with: self utf8BOM, entity
		with: self utf16BigEndianBOM, (self asciiToUTF16BE: entity)
		with: self utf16LittleEndianBOM, (self asciiToUTF16LE: entity)
		with: self utf32BigEndianBOM, (self asciiToUTF32BE: entity)
		with: self utf32LittleEndianBOM, (self asciiToUTF32LE: entity))
		do: [:each |
			self
				shouldnt: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.ent' -> each));
						resolvesExternalEntities: true;
						parseDocument]
				raise: XMLParserException.
			self
				should: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.ent' -> each));
						resolvesExternalEntities: true;
						decodesCharacters: false;
						parseDocument]
				raise: XMLParserException].
]

{ #category : #tests }
XMLEncodingTest >> testExternalEntityImplicitEncodingDetection [
	| document entity |

	document := '
		<!DOCTYPE test [
			<!ENTITY % external SYSTEM "extern.ent">
			 %external;
		]>
		<test/>'.
	entity := '<!ELEMENT test EMPTY>'.
	(Array
		with: (self asciiToUTF16BE: entity)
		with: (self asciiToUTF16LE: entity)
		with: (self asciiToUTF32BE: entity)
		with: (self asciiToUTF32LE: entity))
		do: [:each |
			self
				shouldnt: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.ent' -> each));
						resolvesExternalEntities: true;
						parseDocument]
				raise: XMLParserException.
			self
				should: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.ent' -> each));
						resolvesExternalEntities: true;
						decodesCharacters: false;
						parseDocument]
				raise: XMLParserException].
]

{ #category : #tests }
XMLEncodingTest >> testExternalEntityTextDeclaration [
	| document entity |

	document := '
		<!DOCTYPE test [
			<!ENTITY % external SYSTEM "extern.ent">
			 %external;
		]>
		<test/>'.
	entity := '<!ELEMENT test EMPTY>'.
	(Array
		with:
			(self
				sourceXMLWithEncoding: 'UTF-16-BE'
				andASCIIContentAsUTF16BE: entity)
		with:
			(self
				sourceXMLWithEncoding: 'UTF-16-LE'
				andASCIIContentAsUTF16LE: entity)
		with:
			(self
				sourceXMLWithEncoding: 'UTF-32-BE'
				andASCIIContentAsUTF32BE: entity)
		with:
			(self
				sourceXMLWithEncoding: 'UTF-32-LE'
				andASCIIContentAsUTF32LE: entity))
		do: [:each |
			self
				shouldnt: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.ent' -> each));
						resolvesExternalEntities: true;
						parseDocument]
				raise: XMLParserException.
			self
				should: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.ent' -> each));
						resolvesExternalEntities: true;
						decodesCharacters: false;
						parseDocument]
				raise: XMLParserException].
]

{ #category : #tests }
XMLEncodingTest >> testExternalSubsetByteOrderMarkDetection [
	| document dtd |

	document := '<!DOCTYPE test SYSTEM "extern.dtd"><test/>'.
	dtd := '<!ELEMENT test EMPTY>'.
	(Array
		with: self utf8BOM, dtd
		with: self utf16BigEndianBOM, (self asciiToUTF16BE: dtd)
		with: self utf16LittleEndianBOM, (self asciiToUTF16LE: dtd)
		with: self utf32BigEndianBOM, (self asciiToUTF32BE: dtd)
		with: self utf32LittleEndianBOM, (self asciiToUTF32LE: dtd))
		do: [:each |
			self
				shouldnt: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.dtd' -> each));
						resolvesExternalEntities: true;
						parseDocument]
				raise: XMLParserException.
			self
				should: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.dtd' -> each));
						resolvesExternalEntities: true;
						decodesCharacters: false;
						parseDocument]
				raise: XMLParserException].
]

{ #category : #tests }
XMLEncodingTest >> testExternalSubsetImplicitEncodingDetection [
	| document dtd |

	document := '<!DOCTYPE test SYSTEM "extern.dtd"><test/>'.
	dtd := '<!ELEMENT test EMPTY>'.
	(Array
		with: (self asciiToUTF16BE: dtd)
		with: (self asciiToUTF16LE: dtd)
		with: (self asciiToUTF32BE: dtd)
		with: (self asciiToUTF32LE: dtd))
		do: [:each |
			self
				shouldnt: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.dtd' -> each));
						resolvesExternalEntities: true;
						parseDocument]
				raise: XMLParserException.
			self
				should: [
					(SAXHandler on: document)
						externalEntityResolver:
							(DTDStaticExternalEntityResolver externalEntities:
								(Array with: 'extern.dtd' -> each));
						resolvesExternalEntities: true;
						decodesCharacters: false;
						parseDocument]
				raise: XMLParserException].
]

{ #category : #tests }
XMLEncodingTest >> testExternalSubsetTextDeclaration [
	| document dtd |

	document := '<!DOCTYPE test SYSTEM "extern.dtd"><test/>'.
	dtd := '<!ELEMENT test EMPTY>'.
	(Array
		with:
			(self
				sourceXMLWithEncoding: 'UTF-16-BE'
				andASCIIContentAsUTF16BE: dtd)
		with:
			(self
				sourceXMLWithEncoding: 'UTF-16-LE'
				andASCIIContentAsUTF16LE: dtd)
		with:
			(self
				sourceXMLWithEncoding: 'UTF-32-BE'
				andASCIIContentAsUTF32BE: dtd)
		with:
			(self
				sourceXMLWithEncoding: 'UTF-32-LE'
				andASCIIContentAsUTF32LE: dtd))
			do: [:each |
				self
					shouldnt: [
						(SAXHandler on: document)
							externalEntityResolver:
								(DTDStaticExternalEntityResolver externalEntities:
									(Array with: 'extern.dtd' -> each));
							resolvesExternalEntities: true;
							parseDocument]
					raise: XMLParserException.
				self
					should: [
						(SAXHandler on: document)
							externalEntityResolver:
								(DTDStaticExternalEntityResolver externalEntities:
									(Array with: 'extern.dtd' -> each));
							resolvesExternalEntities: true;
							decodesCharacters: false;
							parseDocument]
					raise: XMLParserException].
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF16BigEndianEncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self asciiToUTF16BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self asciiToUTF16BE: self sourceXML))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF16LittleEndianEncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self asciiToUTF16LE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self asciiToUTF16LE: self sourceXML))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF32BigEndianEncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self asciiToUTF32BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self asciiToUTF32BE: self sourceXML))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testImplicitUTF32LittleEndianEncodingDetection [
	self
		shouldnt: [
			SAXHandler parse:
				(self asciiToUTF32LE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				(self asciiToUTF32LE: self sourceXML))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF16BigEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				self utf16BigEndianBOM, self sourceXML]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf16BigEndianBOM, (self asciiToUTF16LE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf16BigEndianBOM, (self asciiToUTF32BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf16BigEndianBOM, (self asciiToUTF32LE: self sourceXML)]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				self utf16BigEndianBOM, (self asciiToUTF16BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				self utf16BigEndianBOM, (self asciiToUTF16BE: self sourceXML))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF16LittleEndianByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				self utf16LittleEndianBOM, self sourceXML]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf16LittleEndianBOM, (self asciiToUTF16BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf16LittleEndianBOM, (self asciiToUTF32BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf16LittleEndianBOM, (self asciiToUTF32LE: self sourceXML)]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				self utf16LittleEndianBOM, (self asciiToUTF16LE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				self utf16LittleEndianBOM, (self asciiToUTF16LE: self sourceXML))
					decodesCharacters: false;
					parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLEncodingTest >> testUTF8ByteOrderMarkDetection [
	self
		should: [
			SAXHandler parse:
				self utf8BOM, (self asciiToUTF16BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf8BOM, (self asciiToUTF16LE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf8BOM, (self asciiToUTF32BE: self sourceXML)]
		raise: XMLParserException.
	self
		should: [
			SAXHandler parse:
				self utf8BOM, (self asciiToUTF32LE: self sourceXML)]
		raise: XMLParserException.
	self
		shouldnt: [
			SAXHandler parse:
				self utf8BOM, self sourceXML]
		raise: XMLParserException.
	self
		should: [
			(SAXHandler on:
				self utf8BOM, self sourceXML)
					decodesCharacters: false;
					parseDocument]
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

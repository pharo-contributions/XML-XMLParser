Class {
	#name : #XMLStreamConverterTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #tests }
XMLStreamConverterTest >> testByteStreamConverterNames [
	#('ASCII' 'CP819' 'CSISOLATIN1' 'IBM819' 'ISO-8859-1' 'ISO-IR-100'
		'L1' 'LATIN-1' 'LATIN1' 'Latin-1' 'Latin1'
		'ascii' 'cp819' 'csISOLatin1' 'csisolatin1' 'ibm819'
		'iso-8859-1' 'iso-ir-100' 'l1' 'latin-1' 'latin1'
	) do: [:each |
		self assert:
			(XMLStreamConverter newForEncoding: each) class ==
				XMLByteStreamConverter]
]

{ #category : #tests }
XMLStreamConverterTest >> testUTF16BigEndianStreamConverterNames [
	#('UTF-16' 'UTF-16-BE' 'UTF-16BE' 'UTF16' 'UTF16-BE' 'UTF16BE'
		'utf-16' 'utf-16-be' 'utf-16be' 'utf16' 'utf16-be' 'utf16be'
	) do: [:each |
		self assert:
			(XMLStreamConverter newForEncoding: each) class ==
				XMLUTF16BigEndianStreamConverter]
]

{ #category : #tests }
XMLStreamConverterTest >> testUTF16LittleEndianStreamConverterNames [
	#('UTF-16-LE' 'UTF-16LE' 'UTF16-LE' 'UTF16LE'
		'utf-16-le' 'utf-16le' 'utf16-le' 'utf16le'
	) do: [:each |
		self assert:
			(XMLStreamConverter newForEncoding: each) class ==
				XMLUTF16LittleEndianStreamConverter]
]

{ #category : #tests }
XMLStreamConverterTest >> testUTF32BigEndianStreamConverterNames [
	#('UTF-32' 'UTF-32-BE' 'UTF-32BE' 'UTF32' 'UTF32-BE' 'UTF32BE'
		'utf-32' 'utf-32-be' 'utf-32be' 'utf32' 'utf32-be' 'utf32be'
	) do: [:each |
		self assert:
			(XMLStreamConverter newForEncoding: each) class ==
				XMLUTF32BigEndianStreamConverter]
]

{ #category : #tests }
XMLStreamConverterTest >> testUTF32LittleEndianStreamConverterNames [
	#('UTF-32-LE' 'UTF-32LE' 'UTF32-LE' 'UTF32LE'
		'utf-32-le' 'utf-32le' 'utf32-le' 'utf32le'
	) do: [:each |
		self assert:
			(XMLStreamConverter newForEncoding: each) class ==
				XMLUTF32LittleEndianStreamConverter]
]

{ #category : #tests }
XMLStreamConverterTest >> testUTF8StreamConverterNames [
	#('UTF-8' 'UTF8' 'utf-8' 'utf8') do: [:each |
		self assert:
			(XMLStreamConverter newForEncoding: each) class ==
				XMLUTF8StreamConverter]
]

"
This is a class for automatic encoding detection of streams that infers encodings from byte order marks (BOM).
"
Class {
	#name : #XMLEncodingDetector,
	#superclass : #Object,
	#instVars : [
		'stream',
		'startPosition'
	],
	#classVars : [
		'NullCharacter',
		'UTF16BigEndianBOM',
		'UTF32BigEndianBOM',
		'UTF32LittleEndianBOM',
		'UTF8BOM'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'class initialization' }
XMLEncodingDetector class >> initialize [
	"self initialize"

	self
		initializeByteOrderMarks;
		initializeNullCharacter
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initializeByteOrderMarks [
	"stored in class vars for faster access"
	UTF8BOM := XMLUTF8StreamConverter byteOrderMark.
	UTF16BigEndianBOM := XMLUTF16BigEndianStreamConverter byteOrderMark.
	UTF32BigEndianBOM := XMLUTF32BigEndianStreamConverter byteOrderMark.
	UTF32LittleEndianBOM := XMLUTF32LittleEndianStreamConverter byteOrderMark.
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initializeNullCharacter [
	"stored in a class var for faster access"
	NullCharacter := Character value: 0
]

{ #category : #'instance creation' }
XMLEncodingDetector class >> on: aStream [
	^ self new on: aStream
]

{ #category : #private }
XMLEncodingDetector >> atEnd [
	^ stream atEnd
]

{ #category : #testing }
XMLEncodingDetector >> detectsImplicitEncodings [
	^ false
]

{ #category : #private }
XMLEncodingDetector >> handleImplicitLittleEndianEncoding [
	| implicitConverterClass |

	self detectsImplicitEncodings
		ifTrue: [
			implicitConverterClass :=
				self peekForNull
					ifTrue: [		
						(self peekForNull
							and: [self peekForNull])
							ifTrue: [
								"a leading ASCII char followed by three nulls;
								implicit little endian UTF-32"
								XMLImplicitUTF32LittleEndianStreamConverter]
							ifFalse: [
								"a leading ASCII char followed by just one null;
								implicit little endian UTF-16"
								XMLImplicitUTF16LittleEndianStreamConverter]]
					ifFalse: [
						"an ASCII char; assume it's UTF-8"
						XMLImplicitUTF8StreamConverter]].

	self resetStreamToStartPosition.
	^ implicitConverterClass
		ifNotNil: [implicitConverterClass new].
]

{ #category : #private }
XMLEncodingDetector >> handleUTF16BigEndianBOM [
	2 to: UTF16BigEndianBOM size do: [:i |
		self next == (UTF16BigEndianBOM at: i)
			ifFalse: [
				self resetStreamToStartPosition.
				"no legal UTF-8 byte sequence begins with 16rFE, and:
					16rFE = UTF16BigEndianBOM first asciiValue
				so it can't be implicit UTF-8"
				^ nil]].
	^ XMLUTF16BigEndianStreamConverter new.
]

{ #category : #private }
XMLEncodingDetector >> handleUTF32BigEndianBOMOrImplicitEncoding [
	2 to: UTF32BigEndianBOM size do: [:i |
		self peek == (UTF32BigEndianBOM at: i)
			ifTrue: [self next]
			ifFalse: [| implicitConverterClass |
				self detectsImplicitEncodings
					ifTrue: [
						i = 2
							ifTrue: [
								"(UTF32BigEndianBOM at: 1) == NullCharacter"
								self peekForASCII
									ifTrue: [
										"null char followed by an ASCII char;
										implicit UTF-16 BE"
										implicitConverterClass :=
											XMLImplicitUTF16BigEndianStreamConverter]]
							ifFalse: [
								i = 3
									ifTrue: [
										"(UTF32BigEndianBOM at: 2) == NullCharacter"
										(self peekForNull
											and: [self peekForASCII]) 
											ifTrue: [
												"three null chars followed by an ASCII char;
												implicit UTF-32 BE"
												implicitConverterClass :=
													XMLImplicitUTF32BigEndianStreamConverter]]].
						(implicitConverterClass isNil
							and: [self peekForUTF8LeadingByteChar])
							ifTrue: [
								"any number of null chars followed by a leading UTF-8
								byte char; implicit UTF-8"
								implicitConverterClass :=
									XMLImplicitUTF8StreamConverter]].
				self resetStreamToStartPosition.
				^ implicitConverterClass
					ifNotNil: [implicitConverterClass new]]].
	^ XMLUTF32BigEndianStreamConverter new.
]

{ #category : #private }
XMLEncodingDetector >> handleUTF32OrUTF16LittleEndianBOM [
	2 to: UTF32LittleEndianBOM size do: [:i |
		self peek == (UTF32LittleEndianBOM at: i)
			ifTrue: [self next]
			ifFalse: [
				i > 2
					ifTrue: [
						"the 2 byte UTF-16 BOM begins the 4 byte UTF-32 BOM:
							UTF32LittleEndianBOM beginsWith:
								XMLUTF16LittleEndianStreamConverter byteOrderMark"
						stream position: startPosition + 2.
						^ XMLUTF16LittleEndianStreamConverter new]
					ifFalse: [
						self resetStreamToStartPosition.
						"no legal UTF-8 byte sequence begins with 16rFF, and:
							16rFF = UTF32LittleEndianBOM first asciiValue
						so it can't be implicit UTF-8"
						^ nil]]].
	^ XMLUTF32LittleEndianStreamConverter new.
]

{ #category : #private }
XMLEncodingDetector >> handleUTF8BOM [
	2 to: UTF8BOM size do: [:i |
		self peek == (UTF8BOM at: i)
			ifTrue: [self next]
			ifFalse: [| implicitConverter |
				(self detectsImplicitEncodings
					and: [self peekForUTF8NonLeadingByteChar])
					ifTrue: [implicitConverter := XMLImplicitUTF8StreamConverter new].
				self resetStreamToStartPosition.
				^ implicitConverter]].
	^ XMLUTF8StreamConverter new.
]

{ #category : #private }
XMLEncodingDetector >> isUTF8LeadingByteChar: aCharacter [
	| asciiValue |

	^ (asciiValue := aCharacter asciiValue) < 16r80
		or: [asciiValue < 16rF8
			and: [(asciiValue bitAnd: 16rE0) = 16rC0
				or: [(asciiValue bitAnd: 16rF0) = 16rE0
					or: [(asciiValue bitAnd: 16rF8) = 16rF0]]]]
]

{ #category : #private }
XMLEncodingDetector >> next [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next]
]

{ #category : #initialization }
XMLEncodingDetector >> on: aStream [
	stream :=
		(XMLBinaryReadStreamAdapter onIfBinary: aStream)
			ifNil: [aStream].
	startPosition := aStream position.
]

{ #category : #private }
XMLEncodingDetector >> peek [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream peek]
]

{ #category : #private }
XMLEncodingDetector >> peekForASCII [
	| nextChar |

	((nextChar := self peek) notNil
		and: [nextChar asciiValue < 128])
		ifTrue: [
			self next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #private }
XMLEncodingDetector >> peekForNull [
	self peek == NullCharacter
		ifTrue: [
			self next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #private }
XMLEncodingDetector >> peekForUTF8LeadingByteChar [
	| nextChar |

	((nextChar := self peek) notNil
		and: [self isUTF8LeadingByteChar: nextChar])
		ifTrue: [
			self next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #private }
XMLEncodingDetector >> peekForUTF8NonLeadingByteChar [
	| nextChar asciiValue |

	((nextChar := self peek) notNil
		and: [(asciiValue := nextChar asciiValue) < 16rC0
			and: [asciiValue > 16r80]])
		ifTrue: [
			self next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #private }
XMLEncodingDetector >> resetStreamToStartPosition [
	stream position: startPosition
]

{ #category : #detecting }
XMLEncodingDetector >> streamConverterForEncoding [
	| nextChar |

	stream atEnd
		ifTrue: [^ nil].

	(nextChar := stream next) == NullCharacter
		ifTrue: [^ self handleUTF32BigEndianBOMOrImplicitEncoding].

	nextChar asciiValue < 128
		ifTrue: [^ self handleImplicitLittleEndianEncoding].

	"(UTF8BOM at: 1) asciiValue >= 128"
	nextChar == (UTF8BOM at: 1)
		ifTrue: [^ self handleUTF8BOM].

	"(UTF16BigEndianBOM at: 1) asciiValue >= 128"
	nextChar == (UTF16BigEndianBOM at: 1)
		ifTrue: [^ self handleUTF16BigEndianBOM].

	"(UTF32LittleEndianBOM at: 1) asciiValue >= 128"
	nextChar == (UTF32LittleEndianBOM at: 1)
		ifTrue: [^ self handleUTF32OrUTF16LittleEndianBOM].

	self resetStreamToStartPosition.
	^ (self detectsImplicitEncodings
		and: [self isUTF8LeadingByteChar: nextChar])
		ifTrue: [XMLImplicitUTF8StreamConverter new]
		ifFalse: [nil].
]

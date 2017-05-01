"
This is a class for automatic encoding detectors for streams that infers encodings from byte order marks (BOM) or implicit UTF-16/32 encodings from null bytes before or after the first ASCII character.
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

{ #category : #private }
XMLEncodingDetector >> handleImplicitLittleEndianEncoding [
	self peekForNull
		ifTrue: [| converter |
			converter :=
				(self peekForNull
					and: [self peekForNull])
					ifTrue: [XMLUTF32LittleEndianStreamConverter new]
					ifFalse: [XMLUTF16LittleEndianStreamConverter new].
			self resetStreamToStartPosition.
			^ converter]
		ifFalse: [
			self resetStreamToStartPosition.
			^ nil]
]

{ #category : #private }
XMLEncodingDetector >> handleUTF16BigEndianBOM [
	2 to: UTF16BigEndianBOM size do: [:i |
		self next == (UTF16BigEndianBOM at: i)
			ifFalse: [
				self resetStreamToStartPosition.
				^ nil]].
	^ XMLUTF16BigEndianStreamConverter new.
]

{ #category : #private }
XMLEncodingDetector >> handleUTF32BigEndianBOMOrImplicitEncoding [
	2 to: UTF32BigEndianBOM size do: [:i |
		self peek == (UTF32BigEndianBOM at: i)
			ifTrue: [self next]
			ifFalse: [
				(i = 2 "(UTF32BigEndianBOM at: 1) == NullCharacter"
					and: [self peekForASCII])
					ifTrue: [
						"null char followed by an ASCII char; implicit UTF-16 BE"
						self resetStreamToStartPosition.
						^ XMLUTF16BigEndianStreamConverter new]
					ifFalse: [
						(i = 3  "(UTF32BigEndianBOM at: 2) == NullCharacter"
							and: [self peekForNull
								and: [self peekForASCII]]) 
							ifTrue: [
								"three null chars followed by an ASCII char;
								implicit UTF-32 BE"
								self resetStreamToStartPosition.
								^ XMLUTF32BigEndianStreamConverter new]]]].
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
						^ XMLUTF16LittleEndianStreamConverter new].
				self resetStreamToStartPosition.
				^ nil]].
	^ XMLUTF32LittleEndianStreamConverter new.
]

{ #category : #private }
XMLEncodingDetector >> handleUTF8BOM [
	2 to: UTF8BOM size do: [:i |
		self next == (UTF8BOM at: i)
			ifFalse: [
				self resetStreamToStartPosition.
				^ nil]].
	^ XMLUTF8StreamConverter new.
]

{ #category : #private }
XMLEncodingDetector >> next [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next]
]

{ #category : #initialization }
XMLEncodingDetector >> on: aStream [
	stream := aStream.
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
	nextChar == (UTF8BOM at: 1)	"(UTF8BOM at: 1) asciiValue >= 128"
		ifTrue: [^ self handleUTF8BOM].
	nextChar == (UTF16BigEndianBOM at: 1) "(UTF16BigEndianBOM at: 1) asciiValue >= 128"
		ifTrue: [^ self handleUTF16BigEndianBOM].
	nextChar == (UTF32LittleEndianBOM at: 1) "(UTF32LittleEndianBOM at: 1) asciiValue >= 128"
		ifTrue: [^ self handleUTF32OrUTF16LittleEndianBOM].

	self resetStreamToStartPosition.
	^ nil.
]

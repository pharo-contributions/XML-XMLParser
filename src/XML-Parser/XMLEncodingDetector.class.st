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
		'EncodingHandlerTable',
		'NullCharacter',
		'UTF16BigEndianBOM',
		'UTF32BigEndianBOM',
		'UTF32LittleEndianBOM',
		'UTF8BOM'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLEncodingDetector class >> handlerForByteValue: aByteValue [
	aByteValue = 0
		ifTrue: [^ #handleBigEndianUTF32BOMOrImplicitEncoding].
	aByteValue = XMLUTF16BigEndianStreamConverter byteOrderMarkBytes first
		ifTrue: [^ #handleBigEndianUTF16BOM].
	aByteValue = XMLUTF8StreamConverter byteOrderMarkBytes first
		ifTrue: [^ #handleUTF8BOM].
	aByteValue = XMLUTF16LittleEndianStreamConverter byteOrderMarkBytes first
		ifTrue: [^ #handleLittleEndianUTF16BOMOrUTF32BOM].
	aByteValue < 128
		ifTrue: [^ #handleLittleEndianImplicitEncoding].
	^ nil.
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initialize [
	"self initialize"

	self
		initializeByteOrderMarks;
		initializeNullCharacter;
		initializeEncodingHandlerTable
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initializeByteOrderMarks [
	"cached in class vars for faster access"
	UTF8BOM := XMLUTF8StreamConverter byteOrderMark.
	UTF16BigEndianBOM := XMLUTF16BigEndianStreamConverter byteOrderMark.
	UTF32BigEndianBOM := XMLUTF32BigEndianStreamConverter byteOrderMark.
	UTF32LittleEndianBOM := XMLUTF32LittleEndianStreamConverter byteOrderMark.
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initializeEncodingHandlerTable [
	| temp |

	"use an array instead of a dictionary for speed, and use a temp
	to fully initialize it before assignment to avoid possible race
	conditions during class reinitialization"
	temp := Array new: 256.
	0 to: 255 do: [:each |
		temp
			at: each + 1
			put: (self handlerForByteValue: each)].
	EncodingHandlerTable := temp.
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
XMLEncodingDetector >> handleBOM: aByteOrderMark forConverterClass: aConverterClass [
	^ self
		handleBOM: aByteOrderMark
		forConverterClass: aConverterClass
		ifUnmatched: [:totalMatched |
			self resetStreamToStartPosition.
			nil]
]

{ #category : #private }
XMLEncodingDetector >> handleBOM: aByteOrderMark forConverterClass: aConverterClass ifUnmatched: aBlock [
	"to:do: for speed"
	1 to: aByteOrderMark size do: [:i |
		self peek = (aByteOrderMark at: i)
			ifFalse: [^ aBlock value: i - 1].
		self next].

	^ aConverterClass new.
]

{ #category : #private }
XMLEncodingDetector >> handleBigEndianUTF16BOM [
	^ self
		handleBOM: UTF16BigEndianBOM
		forConverterClass: XMLUTF16BigEndianStreamConverter
]

{ #category : #private }
XMLEncodingDetector >> handleBigEndianUTF32BOMOrImplicitEncoding [
	^ self
		handleBOM: UTF32BigEndianBOM
		forConverterClass: XMLUTF32BigEndianStreamConverter
		ifUnmatched: [:totalMatched | | converter |
			(totalMatched = 1 "(UTF32BigEndianBOM at: 1) == NullCharacter"
				and: [self peekForASCII])
				ifTrue: [
					"null char followed by an ASCII char; implicit UTF-16 BE"
					converter := XMLUTF16BigEndianStreamConverter new]
				ifFalse: [
					(totalMatched = 2  "(UTF32BigEndianBOM at: 2) == NullCharacter"
						and: [self peekForNull
							and: [self peekForASCII]]) 
						ifTrue: [
							"three null chars followed by an ASCII char;
							implicit UTF-32 BE"
							converter := XMLUTF32BigEndianStreamConverter new]].
			self resetStreamToStartPosition.
			converter]
]

{ #category : #private }
XMLEncodingDetector >> handleLittleEndianImplicitEncoding [
	| converter |

	(self peekForASCII
		and: [self peekForNull])
		ifTrue: [
			converter :=
				(self peekForNull
					and: [self peekForNull])
					ifTrue: [XMLUTF32LittleEndianStreamConverter new]
					ifFalse: [XMLUTF16LittleEndianStreamConverter new]].
	self resetStreamToStartPosition.
	^ converter.
]

{ #category : #private }
XMLEncodingDetector >> handleLittleEndianUTF16BOMOrUTF32BOM [
	^ self
		handleBOM: UTF32LittleEndianBOM
		forConverterClass: XMLUTF32LittleEndianStreamConverter
		ifUnmatched: [:totalMatched | | converter |
			totalMatched >= 2
				ifTrue: [
					"the 2 byte UTF-16 BOM starts the 4 byte UTF-32 BOM:
						UTF32LittleEndianBOM beginsWith:
							XMLUTF16LittleEndianStreamConverter byteOrderMark"
					converter := XMLUTF16LittleEndianStreamConverter new.
					stream position: startPosition + 2]
				ifFalse: [self resetStreamToStartPosition].
			converter]
]

{ #category : #private }
XMLEncodingDetector >> handleUTF8BOM [
	^ self
		handleBOM: UTF8BOM
		forConverterClass: XMLUTF8StreamConverter
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
	| handlerTableIndex handlerSelector |

	"the index is asciiValue + 1 for null"
	(stream atEnd not
		and: [(handlerTableIndex := self peek asciiValue + 1) <= EncodingHandlerTable size
			and: [(handlerSelector := EncodingHandlerTable at: handlerTableIndex) notNil]])
		ifTrue: [^ self perform: handlerSelector]
		ifFalse: [^ nil]
]

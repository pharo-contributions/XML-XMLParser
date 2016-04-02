"
An abstract class for automatic encoding detectors for streams that infers encodings from byte order marks (BOM) or implicitly from null bytes before or after the first ASCII character.
"
Class {
	#name : #XMLEncodingDetector,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#classVars : [
		'EncodingHandlerTable',
		'NullCharacter',
		'UTF16BigEndianBOM',
		'UTF16LittleEndianBOM',
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
	UTF8BOM := XMLUTF8StreamConverter byteOrderMark.
	UTF16BigEndianBOM := XMLUTF16BigEndianStreamConverter byteOrderMark.
	UTF16LittleEndianBOM := XMLUTF16LittleEndianStreamConverter byteOrderMark.
	UTF32BigEndianBOM := XMLUTF32BigEndianStreamConverter byteOrderMark.
	UTF32LittleEndianBOM := XMLUTF32LittleEndianStreamConverter byteOrderMark.
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initializeEncodingHandlerTable [
	EncodingHandlerTable := Array new: 256.

	0 to: 255 do: [:each |
		EncodingHandlerTable
			at: each + 1
			put: (self handlerForByteValue: each)].
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initializeNullCharacter [
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
XMLEncodingDetector >> canSkipDetection [
	^ self atEnd
]

{ #category : #private }
XMLEncodingDetector >> decodeStreamWithConverter: aStreamConverter [
	self subclassResponsibility
]

{ #category : #detecting }
XMLEncodingDetector >> detectCurrentEncoding [
	| handlerTableIndex handlerSelector |

	self canSkipDetection
		ifTrue: [^ self].

	"the index is asciiValue + 1 for null"
	((handlerTableIndex := self peek asciiValue + 1) <= EncodingHandlerTable size
		and: [(handlerSelector := EncodingHandlerTable at: handlerTableIndex) notNil])
		ifTrue: [self perform: handlerSelector].
]

{ #category : #private }
XMLEncodingDetector >> handleBOM: aByteOrderMark forConverterClass: aConverterClass [
	self
		handleBOM: aByteOrderMark
		forConverterClass: aConverterClass
		ifUnmatched: [:matchedPortion | self pushBack: matchedPortion]
]

{ #category : #private }
XMLEncodingDetector >> handleBOM: aByteOrderMark forConverterClass: aConverterClass ifUnmatched: aBlock [
	"to:do: for speed"
	1 to: aByteOrderMark size do: [:i |
		self peek == (aByteOrderMark at: i)
			ifFalse: [
				aBlock value: (aByteOrderMark copyFrom: 1 to: i - 1).
				^ self].
		self next].

	self decodeStreamWithConverter: aConverterClass new.
]

{ #category : #private }
XMLEncodingDetector >> handleBigEndianUTF16BOM [
	self
		handleBOM: UTF16BigEndianBOM
		forConverterClass: XMLUTF16BigEndianStreamConverter
]

{ #category : #private }
XMLEncodingDetector >> handleBigEndianUTF32BOMOrImplicitEncoding [
	self
		handleBOM: UTF32BigEndianBOM
		forConverterClass: XMLUTF32BigEndianStreamConverter
		ifUnmatched: [:matchedPortion | | nextChar |
			(matchedPortion size = 1 "one null char"
				and: [(nextChar := self nextASCII) notNil])
				ifTrue: [
					self
						decodeStreamWithConverter: XMLUTF16BigEndianStreamConverter new;
						pushBackCharacter: nextChar]
				ifFalse: [
					(matchedPortion size = 2  "two null chars"
						and: [self peekForNull])
						ifTrue: [
							(nextChar := self nextASCII) notNil
								ifTrue: [	
									self
										decodeStreamWithConverter: XMLUTF32BigEndianStreamConverter new;
										pushBackCharacter: nextChar]
								ifFalse: [self pushBack: (matchedPortion copyWith: NullCharacter)]]
						ifFalse: [self pushBack: matchedPortion]]]
]

{ #category : #private }
XMLEncodingDetector >> handleLittleEndianImplicitEncoding [
	| nextChar |

	nextChar := self nextASCII.
	self peekForNull
		ifTrue: [
			self peekForNull
				ifTrue: [
					self next.
					self decodeStreamWithConverter:
						XMLUTF32LittleEndianStreamConverter new]
				ifFalse: [
					self decodeStreamWithConverter:
						XMLUTF16LittleEndianStreamConverter new]].
	self pushBackCharacter: nextChar.
]

{ #category : #private }
XMLEncodingDetector >> handleLittleEndianUTF16BOMOrUTF32BOM [
	self
		handleBOM: UTF32LittleEndianBOM
		forConverterClass: XMLUTF32LittleEndianStreamConverter
		ifUnmatched: [:matchedPortion |
			matchedPortion = UTF16LittleEndianBOM
				ifTrue: [
					self decodeStreamWithConverter:
						XMLUTF16LittleEndianStreamConverter new]
				ifFalse: [self pushBack: matchedPortion]]
]

{ #category : #private }
XMLEncodingDetector >> handleUTF8BOM [
	self
		handleBOM: UTF8BOM
		forConverterClass: XMLUTF8StreamConverter
]

{ #category : #private }
XMLEncodingDetector >> next [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next]
]

{ #category : #private }
XMLEncodingDetector >> nextASCII [
	| nextChar |

	((nextChar := self peek) notNil
		and: [nextChar asciiValue < 128])
		ifTrue: [
			self next.
			^ nextChar]
		ifFalse: [^ nil]
]

{ #category : #initialization }
XMLEncodingDetector >> on: aStream [
	stream :=
		aStream isXMLConvertingStreamAdapter
			ifTrue: [aStream stream]
			ifFalse: [aStream]
]

{ #category : #private }
XMLEncodingDetector >> peek [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream peek]
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
XMLEncodingDetector >> pushBack: aString [
	self subclassResponsibility
]

{ #category : #private }
XMLEncodingDetector >> pushBackCharacter: aCharacter [
	self subclassResponsibility
]

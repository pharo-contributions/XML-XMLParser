"
An automatic encoding detector for stream reader streams that infers encodings from byte order marks (BOM) or implicitly from null bytes before or after the first non-null byte.
"
Class {
	#name : #XMLStreamEncodingDetector,
	#superclass : #Object,
	#instVars : [
		'stream',
		'streamReader'
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

{ #category : #'instance creation' }
XMLStreamEncodingDetector class >> for: aStreamReader [
	^ self new streamReader: aStreamReader
]

{ #category : #private }
XMLStreamEncodingDetector class >> handlerForByteValue: aByteValue [
	aByteValue = 0
		ifTrue: [^ #handleBigEndianUTF32BOMOrImplicitEncoding].
	aByteValue = XMLUTF16BigEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #handleBigEndianUTF16BOM].
	aByteValue = XMLUTF8StreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #handleUTF8BOM].
	aByteValue = XMLUTF16LittleEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #handleLittleEndianUTF16BOMOrUTF32BOM].
	aByteValue = $< asciiValue
		ifTrue: [^ #handleLittleEndianImplicitEncoding].
	^ nil.
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initialize [
	"self initialize"

	self
		initializeByteOrderMarks;
		initializeNullCharacter;
		initializeEncodingHandlerTable
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initializeByteOrderMarks [
	UTF8BOM := XMLUTF8StreamDecoder byteOrderMark.
	UTF16BigEndianBOM := XMLUTF16BigEndianStreamDecoder byteOrderMark.
	UTF16LittleEndianBOM := XMLUTF16LittleEndianStreamDecoder byteOrderMark.
	UTF32BigEndianBOM := XMLUTF32BigEndianStreamDecoder byteOrderMark.
	UTF32LittleEndianBOM := XMLUTF32LittleEndianStreamDecoder byteOrderMark.
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initializeEncodingHandlerTable [
	EncodingHandlerTable := Array new: 256.

	0 to: 255 do: [:each |
		EncodingHandlerTable
			at: each + 1
			put: (self handlerForByteValue: each)].
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initializeNullCharacter [
	NullCharacter := Character value: 0
]

{ #category : #detecting }
XMLStreamEncodingDetector >> detectCurrentEncoding [
	| handlerTableIndex handlerSelector |

	((stream := streamReader stream) atEnd
		or: [stream isDecodingReadStreamAdapter
			and: [stream streamDecoder isDefaultStreamDecoder not]])
		ifTrue: [^ self].

	stream isDecodingReadStreamAdapter
		ifTrue: [stream := stream stream].

	"the index is asciiValue + 1 for null"
	((handlerTableIndex := stream peek asciiValue + 1) <= EncodingHandlerTable size
		and: [(handlerSelector := EncodingHandlerTable at: handlerTableIndex) notNil])
		ifTrue: [self perform: handlerSelector].
]

{ #category : #private }
XMLStreamEncodingDetector >> handleBOM: aByteOrderMark forDecoderClass: aDecoderClass [
	self
		handleBOM: aByteOrderMark
		forDecoderClass: aDecoderClass
		ifUnmatched: [:matchedPortion | streamReader pushBack: matchedPortion]
]

{ #category : #private }
XMLStreamEncodingDetector >> handleBOM: aByteOrderMark forDecoderClass: aDecoderClass ifUnmatched: aBlock [
	"to:do: for speed"
	1 to: aByteOrderMark size do: [:i |
		(stream atEnd not
			and: [stream peek == (aByteOrderMark at: i)])
			ifFalse: [
				aBlock value: (aByteOrderMark copyFrom: 1 to: i - 1).
				^ self].
		stream next].

	streamReader decodeStreamWithDecoder: aDecoderClass new.
]

{ #category : #private }
XMLStreamEncodingDetector >> handleBigEndianUTF16BOM [
	self
		handleBOM: UTF16BigEndianBOM
		forDecoderClass: XMLUTF16BigEndianStreamDecoder
]

{ #category : #private }
XMLStreamEncodingDetector >> handleBigEndianUTF32BOMOrImplicitEncoding [
	self
		handleBOM: UTF32BigEndianBOM
		forDecoderClass: XMLUTF32BigEndianStreamDecoder
		ifUnmatched: [:matchedPortion |
			(matchedPortion size = 1 "one null char"
				and: [stream atEnd not
					and: [stream peek == $<]])
				ifTrue: [
					stream next.
					streamReader
						decodeStreamWithDecoder: XMLUTF16BigEndianStreamDecoder new;
						pushBackCharacter: $<]
				ifFalse: [
					(matchedPortion size = 2  "two null chars"
						and: [stream atEnd not
							and: [stream peek == NullCharacter]])
						ifTrue: [
							stream next.
							(stream atEnd not
								and: [stream peek == $<])
								ifTrue: [	
									stream next.
									streamReader
										decodeStreamWithDecoder: XMLUTF32BigEndianStreamDecoder new;
										pushBackCharacter: $<]
								ifFalse: [streamReader pushBack: (matchedPortion copyWith: NullCharacter)]]
						ifFalse: [streamReader pushBack: matchedPortion]]]
]

{ #category : #private }
XMLStreamEncodingDetector >> handleLittleEndianImplicitEncoding [
	"skip <"
	stream next.
	(stream atEnd not
		and: [stream peek == NullCharacter])
		ifTrue: [
			stream next.
			(stream atEnd not
				and: [stream peek == NullCharacter])
				ifTrue: [
					stream next.
					stream atEnd
						ifFalse: [stream next].
					streamReader decodeStreamWithDecoder:
						XMLUTF32LittleEndianStreamDecoder new]
				ifFalse: [
					streamReader decodeStreamWithDecoder:
						XMLUTF16LittleEndianStreamDecoder new]].
	streamReader pushBackCharacter: $<.
]

{ #category : #private }
XMLStreamEncodingDetector >> handleLittleEndianUTF16BOMOrUTF32BOM [
	self
		handleBOM: UTF32LittleEndianBOM
		forDecoderClass: XMLUTF32LittleEndianStreamDecoder
		ifUnmatched: [:matchedPortion |
			matchedPortion = UTF16LittleEndianBOM
				ifTrue: [
					streamReader decodeStreamWithDecoder:
						XMLUTF16LittleEndianStreamDecoder new]
				ifFalse: [streamReader pushBack: matchedPortion]]
]

{ #category : #private }
XMLStreamEncodingDetector >> handleUTF8BOM [
	self
		handleBOM: UTF8BOM
		forDecoderClass: XMLUTF8StreamDecoder
]

{ #category : #accessing }
XMLStreamEncodingDetector >> streamReader: aStreamReader [
	streamReader := aStreamReader
]

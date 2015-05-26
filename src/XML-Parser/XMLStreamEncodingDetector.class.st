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
XMLStreamEncodingDetector class >> handlerForLeadByte: aByte [
	aByte = 0
		ifTrue: [^ #detectBigEndianUTF32BOMOrImplicitEncoding].
	aByte = XMLUTF16BigEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectBigEndianUTF16BOM].
	aByte = XMLUTF8StreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectUTF8BOM].
	aByte = XMLUTF16LittleEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectLittleEndianUTF16BOMOrUTF32BOM].
	aByte = $< asciiValue
		ifTrue: [^ #detectLittleEndianImplicitEncoding].
	^ nil.
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initialize [
	"self initialize"
	self
		initializeNullCharacter;
		initializeByteOrderMarks;
		initializeEncodingHandlerTable.
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
			put: (self handlerForLeadByte: each)].
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initializeNullCharacter [
	NullCharacter := Character value: 0
]

{ #category : #private }
XMLStreamEncodingDetector >> detectBOM: aByteOrderMark forDecoderClass: aClass [
	stream next.
	2 to: aByteOrderMark size do: [:i |
		(stream atEnd not
			and: [stream peek == (aByteOrderMark at: i)])
			ifFalse: [^ aByteOrderMark copyFrom: 1 to: i - 1].
		stream next].
	streamReader decodeStreamWithDecoder: aClass new.
	^ nil.
]

{ #category : #private }
XMLStreamEncodingDetector >> detectBigEndianUTF16BOM [
	(self
		detectBOM: UTF16BigEndianBOM
		forDecoderClass: XMLUTF16BigEndianStreamDecoder)
		ifNotNil: [:remainder | streamReader pushBack: remainder]
]

{ #category : #private }
XMLStreamEncodingDetector >> detectBigEndianUTF32BOMOrImplicitEncoding [
	| remainder |

	(remainder :=
		self
			detectBOM: UTF32BigEndianBOM
			forDecoderClass: XMLUTF32BigEndianStreamDecoder)
		ifNil: [^ self].
	(remainder allSatisfy: [:each | each == NullCharacter])
		ifFalse: [
			streamReader pushBack: remainder.
			^ self].

	(remainder size = 1
		and: [stream atEnd not
			and: [stream peek == $<]])
		ifTrue: [
			stream next.
			streamReader
				decodeStreamWithDecoder: XMLUTF16BigEndianStreamDecoder new;
				pushBackCharacter: $<.
			^ self].
	(remainder size = 2
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
						pushBackCharacter: $<.
					^ self].
			remainder := remainder copyWith: NullCharacter].

	streamReader pushBack: remainder.
]

{ #category : #detecting }
XMLStreamEncodingDetector >> detectCurrentEncoding [
	| characterCode handlerSelector |

	(stream := streamReader stream) atEnd
		ifTrue: [^ self].

	stream isDecodingReadStreamAdapter
		ifTrue: [
			stream streamDecoder isDefaultStreamDecoder
				ifFalse: [^ self].
			stream := stream stream].

	((characterCode := stream peek asciiValue) < 256
		and: [(handlerSelector := EncodingHandlerTable at: characterCode + 1) notNil])
		ifTrue: [self perform: handlerSelector].
]

{ #category : #private }
XMLStreamEncodingDetector >> detectLittleEndianImplicitEncoding [
	"skip <"
	stream next.
	(stream atEnd
		or: [stream peek asciiValue > 0])
		ifTrue: [
			streamReader pushBackCharacter: $<.
			^ self].
	stream next.
	(stream atEnd not
		and: [stream peek == NullCharacter])
		ifTrue: [
			stream next.
			stream atEnd
				ifFalse: [stream next].
			streamReader decodeStreamWithDecoder: XMLUTF32LittleEndianStreamDecoder new]
		ifFalse: [streamReader decodeStreamWithDecoder: XMLUTF16LittleEndianStreamDecoder new].
	
	streamReader pushBackCharacter: $<.
]

{ #category : #private }
XMLStreamEncodingDetector >> detectLittleEndianUTF16BOMOrUTF32BOM [
	(self
		detectBOM: UTF32LittleEndianBOM
		forDecoderClass: XMLUTF32LittleEndianStreamDecoder)
		ifNotNil: [:remainder |
			remainder = UTF16LittleEndianBOM
				ifTrue: [
					streamReader decodeStreamWithDecoder:
						XMLUTF16LittleEndianStreamDecoder new]
				ifFalse: [streamReader pushBack: remainder]]
]

{ #category : #private }
XMLStreamEncodingDetector >> detectUTF8BOM [
	(self
		detectBOM: UTF8BOM
		forDecoderClass: XMLUTF8StreamDecoder)
		ifNotNil: [:remainder | streamReader pushBack: remainder]
]

{ #category : #accessing }
XMLStreamEncodingDetector >> streamReader: aStreamReader [
	streamReader := aStreamReader
]

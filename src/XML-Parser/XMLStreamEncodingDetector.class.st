"
An automatic encoding detector for stream reader streams that infers encodings from byte order marks or implicitly from null bytes before or after the first non-null byte.
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
		'UTF16BigEndianByteOrderMark',
		'UTF16LittleEndianByteOrderMark',
		'UTF32BigEndianByteOrderMark',
		'UTF32LittleEndianByteOrderMark',
		'UTF8ByteOrderMark'
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
		ifTrue: [^ #detectBigEndianUTF32OrImplicitEncdoing].
	aByte = XMLUTF16BigEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectBigEndianUTF16ByteOrderMark].
	aByte = XMLUTF8StreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectUTF8ByteOrderMark].
	aByte = XMLUTF16LittleEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectLittleEndianUTF16OrUTF32ByteOrderMark].
	aByte = $< asciiValue
		ifTrue: [^ #detectLittleEndianImplicitEncoding].
	^ nil.
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initialize [
	"self initialize"

	NullCharacter := Character value: 0.
	self
		initializeByteOrderMarks;
		initializeEncodingHandlerTable.
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initializeByteOrderMarks [
	UTF8ByteOrderMark := XMLUTF8StreamDecoder byteOrderMark.
	UTF16BigEndianByteOrderMark := XMLUTF16BigEndianStreamDecoder byteOrderMark.
	UTF16LittleEndianByteOrderMark := XMLUTF16LittleEndianStreamDecoder byteOrderMark.
	UTF32BigEndianByteOrderMark := XMLUTF32BigEndianStreamDecoder byteOrderMark.
	UTF32LittleEndianByteOrderMark := XMLUTF32LittleEndianStreamDecoder byteOrderMark.
]

{ #category : #'class initialization' }
XMLStreamEncodingDetector class >> initializeEncodingHandlerTable [
	EncodingHandlerTable := Array new: 256.

	0 to: 255 do: [:each |
		EncodingHandlerTable
			at: each + 1
			put: (self handlerForLeadByte: each)].
]

{ #category : #private }
XMLStreamEncodingDetector >> detectBigEndianUTF16ByteOrderMark [
	(self
		detectByteOrderMark: UTF16BigEndianByteOrderMark
		forDecoderClass: XMLUTF16BigEndianStreamDecoder)
		ifNotNil: [:remainder | streamReader pushBack: remainder]
]

{ #category : #private }
XMLStreamEncodingDetector >> detectBigEndianUTF32OrImplicitEncdoing [
	| remainder |

	(remainder :=
		self
			detectByteOrderMark: UTF32BigEndianByteOrderMark
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

{ #category : #private }
XMLStreamEncodingDetector >> detectByteOrderMark: aByteOrderMark forDecoderClass: aClass [
	stream next.
	2 to: aByteOrderMark size do: [:i |
		(stream atEnd not
			and: [stream peek == (aByteOrderMark at: i)])
			ifFalse: [^ aByteOrderMark copyFrom: 1 to: i - 1].
		stream next].
	streamReader decodeStreamWithDecoder: aClass new.
	^ nil.
]

{ #category : #detecting }
XMLStreamEncodingDetector >> detectCurrentEncoding [
	| characterCode handlerSelector |

	(stream := streamReader stream) atEnd
		ifTrue: [^ self].
	((characterCode := stream peek asciiValue) < 256
		and: [(handlerSelector := EncodingHandlerTable at: characterCode + 1) notNil])
		ifTrue: [self perform: handlerSelector].
]

{ #category : #private }
XMLStreamEncodingDetector >> detectLittleEndianImplicitEncoding [
	stream peek == $<
		ifFalse: [^ self].
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
XMLStreamEncodingDetector >> detectLittleEndianUTF16OrUTF32ByteOrderMark [
	(self
		detectByteOrderMark: UTF32LittleEndianByteOrderMark
		forDecoderClass: XMLUTF32LittleEndianStreamDecoder) = UTF16LittleEndianByteOrderMark
		ifTrue: [streamReader decodeStreamWithDecoder: XMLUTF16LittleEndianStreamDecoder new]
]

{ #category : #private }
XMLStreamEncodingDetector >> detectUTF8ByteOrderMark [
	(self
		detectByteOrderMark: UTF8ByteOrderMark
		forDecoderClass: XMLUTF8StreamDecoder)
		ifNotNil: [:remainder | streamReader pushBack: remainder]
]

{ #category : #accessing }
XMLStreamEncodingDetector >> streamReader: aStreamReader [
	streamReader := aStreamReader
]

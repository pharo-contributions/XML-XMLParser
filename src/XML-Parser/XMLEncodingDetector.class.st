"
An encoding auto-detector for streams.
"
Class {
	#name : #XMLEncodingDetector,
	#superclass : #Object,
	#instVars : [
		'stream',
		'remainder',
		'streamDecoder'
	],
	#classVars : [
		'NullCharacter',
		'UTF16BigEndianByteOrderMark',
		'UTF16LittleEndianByteOrderMark',
		'UTF32BigEndianByteOrderMark',
		'UTF32LittleEndianByteOrderMark',
		'UTF8ByteOrderMark'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingDetector class >> handlerForLeadByte: aByte [
	aByte = 0
		ifTrue: [^ #detectBigEndianUTF32OrImplicitEncdoing].
	aByte = XMLUTF16BigEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectBigEndianUTF16ByteOrderMark].
	aByte = XMLUTF8StreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectUTF8ByteOrderMark].
	aByte = XMLUTF16LittleEndianStreamDecoder byteOrderMarkBytes first
		ifTrue: [^ #detectLittleEndianUTF16OrUTF32ByteOrderMark].
	^ nil.
]

{ #category : #'class initialization' }
XMLEncodingDetector class >> initialize [
	"self initialize"

	NullCharacter := Character value: 0.

	UTF8ByteOrderMark := XMLUTF8StreamDecoder byteOrderMark.
	UTF16BigEndianByteOrderMark := XMLUTF16BigEndianStreamDecoder byteOrderMark.
	UTF16LittleEndianByteOrderMark := XMLUTF16LittleEndianStreamDecoder byteOrderMark.
	UTF32BigEndianByteOrderMark := XMLUTF32BigEndianStreamDecoder byteOrderMark.
	UTF32LittleEndianByteOrderMark := XMLUTF32LittleEndianStreamDecoder byteOrderMark.
]

{ #category : #'instance creation' }
XMLEncodingDetector class >> on: aStream [
	^ self new on: aStream
]

{ #category : #encodings }
XMLEncodingDetector >> detectBigEndianUTF16ByteOrderMark [
	self
		detectByteOrderMark: UTF16BigEndianByteOrderMark
		forDecoderClass: XMLUTF16BigEndianStreamDecoder
]

{ #category : #encodings }
XMLEncodingDetector >> detectBigEndianUTF32OrImplicitEncdoing [
	self
		detectByteOrderMark: UTF32BigEndianByteOrderMark
		forDecoderClass: XMLUTF32BigEndianStreamDecoder.
	(remainder ifNil: [^ self]) do: [:each |
		each == NullCharacter
			ifFalse: [^ self]].

	(remainder size = 1
		and: [stream atEnd not
			and: [stream peek == $<]])
		ifTrue: [
			stream next.
			streamDecoder := XMLUTF16BigEndianStreamDecoder new.
			remainder := '<'.
			^ self].
	(remainder size = 2
		and: [stream atEnd not
			and: [stream peek == NullCharacter]])
		ifTrue: [
			stream next.
			stream atEnd
				ifFalse: [ 
					remainder := stream next asString.
					streamDecoder := XMLUTF32BigEndianStreamDecoder new]].
]

{ #category : #private }
XMLEncodingDetector >> detectByteOrderMark: aByteOrderMark forDecoderClass: aClass [
	stream next.
	2 to: aByteOrderMark size do: [:i |
		(stream atEnd not
			and: [stream peek == (aByteOrderMark at: i)])
			ifFalse: [
				remainder := aByteOrderMark copyFrom: 1 to: i - 1.
				^ self].
		stream next].
	streamDecoder := aClass new.
]

{ #category : #encodings }
XMLEncodingDetector >> detectLittleEndianImplicitEncoding [
	stream next.
	(stream atEnd not
		and: [stream peek == NullCharacter])
		ifTrue: [
			stream next.
			stream atEnd
				ifFalse: [stream next].
			streamDecoder := XMLUTF32LittleEndianStreamDecoder new]
		ifFalse: [streamDecoder := XMLUTF16LittleEndianStreamDecoder new]
]

{ #category : #encodings }
XMLEncodingDetector >> detectLittleEndianUTF16OrUTF32ByteOrderMark [
	self
		detectByteOrderMark: UTF32LittleEndianByteOrderMark
		forDecoderClass: XMLUTF32LittleEndianStreamDecoder.

	remainder = UTF16LittleEndianByteOrderMark
		ifTrue: [
			remainder := nil.
			streamDecoder := XMLUTF16LittleEndianStreamDecoder new].
]

{ #category : #encodings }
XMLEncodingDetector >> detectUTF8ByteOrderMark [
	self
		detectByteOrderMark: UTF8ByteOrderMark
		forDecoderClass: XMLUTF8StreamDecoder
]

{ #category : #initialization }
XMLEncodingDetector >> on: aStream [
	stream := aStream
]

{ #category : #accessing }
XMLEncodingDetector >> remainder [
	^ remainder
]

{ #category : #accessing }
XMLEncodingDetector >> streamDecoder [
	^ streamDecoder
]

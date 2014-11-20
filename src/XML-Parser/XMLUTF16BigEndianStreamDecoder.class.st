"
A stream decoder for big endian UTF-16 streams.
"
Class {
	#name : #XMLUTF16BigEndianStreamDecoder,
	#superclass : #XMLUTF16StreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF16BigEndianStreamDecoder class >> basicEncodingNames [
	^ #('utf16' 'utf-16' 'utf16be' 'utf-16be' 'utf-16-be' 'utf16-be')
]

{ #category : #private }
XMLUTF16BigEndianStreamDecoder class >> byteOrderMarkBytes [
	^ #(16rFE 16rFF)
]

{ #category : #private }
XMLUTF16BigEndianStreamDecoder >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte [
	^ (aFirstByte bitShift: 8) + aSecondByte
]

{ #category : #testing }
XMLUTF16BigEndianStreamDecoder >> isBigEndian [
	^ true
]

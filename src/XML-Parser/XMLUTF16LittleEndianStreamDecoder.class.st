"
A stream decoder for little endian UTF-16 streams.
"
Class {
	#name : #XMLUTF16LittleEndianStreamDecoder,
	#superclass : #XMLUTF16StreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF16LittleEndianStreamDecoder class >> basicEncodingNames [
	^ #('utf16le' 'utf-16le' 'utf-16-le' 'utf16-le')
]

{ #category : #private }
XMLUTF16LittleEndianStreamDecoder class >> byteOrderMarkBytes [
	^ #(16rFF 16rFE)
]

{ #category : #private }
XMLUTF16LittleEndianStreamDecoder >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte [
	^ (aSecondByte bitShift: 8) + aFirstByte
]

{ #category : #testing }
XMLUTF16LittleEndianStreamDecoder >> isBigEndian [
	^ false
]

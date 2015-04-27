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
	^ #('UTF-16LE' 'UTF-16-LE' 'UTF16-LE' 'UTF16LE')
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

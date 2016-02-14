"
A stream converter for little endian UTF-16 streams.
"
Class {
	#name : #XMLUTF16LittleEndianStreamConverter,
	#superclass : #XMLUTF16StreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF16LittleEndianStreamConverter class >> basicEncodingNames [
	^ #('UTF-16LE' 'UTF-16-LE' 'UTF16-LE' 'UTF16LE')
]

{ #category : #private }
XMLUTF16LittleEndianStreamConverter class >> byteOrderMarkBytes [
	^ #(16rFF 16rFE)
]

{ #category : #private }
XMLUTF16LittleEndianStreamConverter >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte [
	^ (aSecondByte bitShift: 8) + aFirstByte
]

{ #category : #testing }
XMLUTF16LittleEndianStreamConverter >> isBigEndian [
	^ false
]

{ #category : #private }
XMLUTF16LittleEndianStreamConverter >> nextPutFirstByte: aFirstByte secondByte: aSecondByte toStream: aStream [
	aStream
		basicNextPutByte: aSecondByte;
		basicNextPutByte: aFirstByte
]

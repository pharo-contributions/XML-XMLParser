"
A stream converter for big endian UTF-16 streams, and the default converter class used when a UTF-16 stream converter is created with newForEncoding: or asXMLStreamConverter and no endian is specified by the encoding name.
"
Class {
	#name : #XMLUTF16BigEndianStreamConverter,
	#superclass : #XMLUTF16StreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF16BigEndianStreamConverter class >> basicEncodingNames [
	^ #('UTF-16' 'UTF-16BE' 'UTF-16-BE' 'UTF16' 'UTF16-BE' 'UTF16BE')
]

{ #category : #private }
XMLUTF16BigEndianStreamConverter class >> byteOrderMarkBytes [
	^ #(16rFE 16rFF)
]

{ #category : #private }
XMLUTF16BigEndianStreamConverter >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte [
	^ (aFirstByte bitShift: 8) + aSecondByte
]

{ #category : #testing }
XMLUTF16BigEndianStreamConverter >> isBigEndian [
	^ true
]

{ #category : #private }
XMLUTF16BigEndianStreamConverter >> nextPutFirstByte: aFirstByte secondByte: aSecondByte toStream: aStream [
	aStream
		basicNextPutByte: aFirstByte;
		basicNextPutByte: aSecondByte
]

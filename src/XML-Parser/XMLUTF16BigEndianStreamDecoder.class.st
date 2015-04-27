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
	^ #('UTF-16' 'UTF-16BE' 'UTF-16-BE' 'UTF16' 'UTF16-BE' 'UTF16BE')
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

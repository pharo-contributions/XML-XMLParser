"
A stream decoder for big endian UTF-32 streams.
"
Class {
	#name : #XMLUTF32BigEndianStreamDecoder,
	#superclass : #XMLUTF32StreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF32BigEndianStreamDecoder class >> basicEncodingNames [
	^ #('UTF-32' 'UTF-32BE' 'UTF-32-BE' 'UTF32' 'UTF32-BE' 'UTF32BE')
]

{ #category : #private }
XMLUTF32BigEndianStreamDecoder class >> byteOrderMarkBytes [
	^ #(16r00 16r00 16rFE 16rFF)
]

{ #category : #private }
XMLUTF32BigEndianStreamDecoder >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte [
	^ self characterWithValue:
		(aFirstByte bitShift: 24) +
		(aSecondByte bitShift: 16) +
		(aThirdByte bitShift: 8) +
		aFourthByte
]

{ #category : #testing }
XMLUTF32BigEndianStreamDecoder >> isBigEndian [
	^ true
]

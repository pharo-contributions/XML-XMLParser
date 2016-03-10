"
A stream converter for big endian UTF-32 streams.
"
Class {
	#name : #XMLUTF32BigEndianStreamConverter,
	#superclass : #XMLUTF32StreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF32BigEndianStreamConverter class >> basicEncodingNames [
	^ #('UTF-32' 'UTF-32BE' 'UTF-32-BE' 'UTF32' 'UTF32-BE' 'UTF32BE')
]

{ #category : #private }
XMLUTF32BigEndianStreamConverter class >> byteOrderMarkBytes [
	^ #(16r00 16r00 16rFE 16rFF)
]

{ #category : #private }
XMLUTF32BigEndianStreamConverter >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte [
	^ self characterFromCodePoint:
		(aFirstByte bitShift: 24) +
		(aSecondByte bitShift: 16) +
		(aThirdByte bitShift: 8) +
		aFourthByte
]

{ #category : #testing }
XMLUTF32BigEndianStreamConverter >> isBigEndian [
	^ true
]

{ #category : #private }
XMLUTF32BigEndianStreamConverter >> nextPutFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte toStream: aStream [
	aStream
		basicNextPutByte: aFirstByte;
		basicNextPutByte: aSecondByte;
		basicNextPutByte: aThirdByte;
		basicNextPutByte: aFourthByte
]

"
A stream converter for little endian UTF-32 streams.
"
Class {
	#name : #XMLUTF32LittleEndianStreamConverter,
	#superclass : #XMLUTF32StreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF32LittleEndianStreamConverter class >> basicEncodingNames [
	^ #('UTF-32LE' 'UTF-32-LE' 'UTF32-LE' 'UTF32LE')
]

{ #category : #private }
XMLUTF32LittleEndianStreamConverter class >> byteOrderMarkBytes [
	^ #(16rFF 16rFE 16r00 16r00)
]

{ #category : #private }
XMLUTF32LittleEndianStreamConverter >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte [
	^ self characterWithValue:
		(aFourthByte bitShift: 24) +
		(aThirdByte bitShift: 16) +
		(aSecondByte bitShift: 8) +
		aFirstByte
]

{ #category : #testing }
XMLUTF32LittleEndianStreamConverter >> isBigEndian [
	^ false
]

{ #category : #private }
XMLUTF32LittleEndianStreamConverter >> nextPutFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte toStream: aStream [
	aStream
		basicNextPutByte: aFourthByte;
		basicNextPutByte: aThirdByte;
		basicNextPutByte: aSecondByte;
		basicNextPutByte: aFirstByte
]

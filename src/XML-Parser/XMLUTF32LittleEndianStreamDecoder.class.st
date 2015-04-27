"
A stream decoder for little endian UTF-32 streams.
"
Class {
	#name : #XMLUTF32LittleEndianStreamDecoder,
	#superclass : #XMLUTF32StreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF32LittleEndianStreamDecoder class >> basicEncodingNames [
	^ #('UTF-32LE' 'UTF-32-LE' 'UTF32-LE' 'UTF32LE')
]

{ #category : #accessing }
XMLUTF32LittleEndianStreamDecoder class >> byteOrderMarkBytes [
	^ #(16rFF 16rFE 16r00 16r00)
]

{ #category : #private }
XMLUTF32LittleEndianStreamDecoder >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte [
	^ self characterWithValue:
		(aFourthByte bitShift: 24) +
		(aThirdByte bitShift: 16) +
		(aSecondByte bitShift: 8) +
		aFirstByte
]

{ #category : #testing }
XMLUTF32LittleEndianStreamDecoder >> isBigEndian [
	^ false
]

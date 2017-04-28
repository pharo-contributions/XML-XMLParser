"
A stream converter for big endian UTF-32 streams, and the default converter class used when a UTF-32 stream converter is created with newForEncoding: or asXMLStreamConverter and no endian is specified by the encoding name.
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

{ #category : #testing }
XMLUTF32BigEndianStreamConverter >> isBigEndian [
	^ true
]

{ #category : #private }
XMLUTF32BigEndianStreamConverter >> nextFourBytesFromStream: aStream [
	^ ((aStream basicNext
			ifNil: [^ nil]) asciiValue bitShift: 24) +
		((aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue bitShift: 16) +
		((aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue bitShift: 8) +
		(aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue
]

{ #category : #private }
XMLUTF32BigEndianStreamConverter >> nextPutFourBytes: anInteger toStream: aStream [
	aStream
		basicNextPutByte: ((anInteger bitShift: -24) bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -16) bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -8) bitAnd: 16rFF);
		basicNextPutByte: (anInteger bitAnd: 16rFF)
]

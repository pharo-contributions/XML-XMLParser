"
A stream converter for big endian UTF-32 streams, and the default converter class used when a UTF-32 stream converter is created with newForEncoding: or asXMLStreamConverter and no endian is specified by the encoding name.
"
Class {
	#name : #XMLUTF32BigEndianStreamConverter,
	#superclass : #XMLUTF32StreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #basic }
XMLUTF32BigEndianStreamConverter class >> basicByteOrderMarkBytes [
	^ #(16r00 16r00 16rFE 16rFF)
]

{ #category : #basic }
XMLUTF32BigEndianStreamConverter class >> basicEncodingNames [
	^ #('UTF-32' 'UTF32'
			'UTF-32-BE' 'UTF32-BE' 'UTF-32BE' 'UTF32BE')
]

{ #category : #testing }
XMLUTF32BigEndianStreamConverter >> isBigEndian [
	^ true
]

{ #category : #basic }
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

{ #category : #basic }
XMLUTF32BigEndianStreamConverter >> nextPutFourBytes: anInteger toStream: aStream [
	aStream
		basicNextPutByte: ((anInteger bitShift: -24) bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -16) bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -8) bitAnd: 16rFF);
		basicNextPutByte: (anInteger bitAnd: 16rFF)
]

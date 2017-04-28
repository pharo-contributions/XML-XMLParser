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

{ #category : #testing }
XMLUTF16BigEndianStreamConverter >> isBigEndian [
	^ true
]

{ #category : #private }
XMLUTF16BigEndianStreamConverter >> nextPutTwoBytes: anInteger toStream: aStream [
	aStream
		basicNextPutByte: ((anInteger bitShift: -8) bitAnd: 16rFF);
		basicNextPutByte: (anInteger bitAnd: 16rFF)
]

{ #category : #private }
XMLUTF16BigEndianStreamConverter >> nextTwoBytesFromStream: aStream [
	^ ((aStream basicNext
			ifNil: [^ nil]) asciiValue bitShift: 8) +
		(aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue
]

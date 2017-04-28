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

{ #category : #testing }
XMLUTF16LittleEndianStreamConverter >> isBigEndian [
	^ false
]

{ #category : #private }
XMLUTF16LittleEndianStreamConverter >> nextPutTwoBytes: anInteger toStream: aStream [
	aStream
		basicNextPutByte: (anInteger bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -8) bitAnd: 16rFF)
]

{ #category : #private }
XMLUTF16LittleEndianStreamConverter >> nextTwoBytesFromStream: aStream [
	^ ((aStream basicNext
			ifNil: [^ nil]) asciiValue) +
		((aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue bitShift: 8)
]

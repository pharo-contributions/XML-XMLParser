"
A stream converter for little endian UTF-32 streams.
"
Class {
	#name : #XMLUTF32LittleEndianStreamConverter,
	#superclass : #XMLUTF32StreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #basic }
XMLUTF32LittleEndianStreamConverter class >> basicByteOrderMarkBytes [
	^ #(16rFF 16rFE 16r00 16r00)
]

{ #category : #basic }
XMLUTF32LittleEndianStreamConverter class >> basicEncodingNames [
	^ #('UTF-32-LE' 'UTF32-LE' 'UTF-32LE' 'UTF32LE')
]

{ #category : #testing }
XMLUTF32LittleEndianStreamConverter >> isBigEndian [
	^ false
]

{ #category : #basic }
XMLUTF32LittleEndianStreamConverter >> nextFourBytesFromStream: aStream [
	^ (aStream basicNext
			ifNil: [^ nil]) asciiValue +
		((aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue bitShift: 8) +
		((aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue bitShift: 16) +
		((aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue bitShift: 24)
]

{ #category : #basic }
XMLUTF32LittleEndianStreamConverter >> nextPutFourBytes: anInteger toStream: aStream [
	aStream
		basicNextPutByte: (anInteger bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -8) bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -16) bitAnd: 16rFF);
		basicNextPutByte: ((anInteger bitShift: -24) bitAnd: 16rFF)
]

"
An abstract class for UTF-32 stream decoders.
"
Class {
	#name : #XMLUTF32StreamDecoder,
	#superclass : #XMLUTFStreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF32StreamDecoder >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte [
	self subclassResponsibility
]

{ #category : #private }
XMLUTF32StreamDecoder >> errorInvalidCodePoint [
	XMLEncodingException signal: 'Invalid UTF-32 code point'
]

{ #category : #testing }
XMLUTF32StreamDecoder >> isBigEndian [
	self subclassResponsibility
]

{ #category : #decoding }
XMLUTF32StreamDecoder >> nextFromStream: aStream [
	^ self
		codePointFromFirstByte:
			(aStream basicNext ifNil: [^ nil]) asciiValue
		secondByte:
			(aStream basicNext ifNil: [self errorInvalidCodePoint]) asciiValue
		thirdByte:
			(aStream basicNext ifNil: [self errorInvalidCodePoint]) asciiValue
		fourthByte: 
			(aStream basicNext ifNil: [self errorInvalidCodePoint]) asciiValue
]

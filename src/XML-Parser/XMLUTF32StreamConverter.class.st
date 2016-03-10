"
An abstract class for UTF-32 stream converters.
"
Class {
	#name : #XMLUTF32StreamConverter,
	#superclass : #XMLUTFStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF32StreamConverter >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte [
	self subclassResponsibility
]

{ #category : #testing }
XMLUTF32StreamConverter >> isBigEndian [
	self subclassResponsibility
]

{ #category : #decoding }
XMLUTF32StreamConverter >> nextFromStream: aStream [
	^ self
		codePointFromFirstByte:
			(aStream basicNext
				ifNil: [^ nil]) asciiValue
		secondByte:
			(aStream basicNext
				ifNil: [self errorBadCharacterEncoding]) asciiValue
		thirdByte:
			(aStream basicNext
				ifNil: [self errorBadCharacterEncoding]) asciiValue
		fourthByte:
			(aStream basicNext
				ifNil: [self errorBadCharacterEncoding]) asciiValue
]

{ #category : #encoding }
XMLUTF32StreamConverter >> nextPut: aCharacter toStream: aStream [
	| codePoint |

	codePoint := self codePointFromCharacter: aCharacter.
	self
		nextPutFirstByte: ((codePoint bitShift: -24) bitAnd: 16rFF)
		secondByte: ((codePoint bitShift: -16) bitAnd: 16rFF)
		thirdByte: ((codePoint bitShift: -8) bitAnd: 16rFF)
		fourthByte: (codePoint bitAnd: 16rFF)
		toStream: aStream.
]

{ #category : #private }
XMLUTF32StreamConverter >> nextPutFirstByte: aFirstByte secondByte: aSecondByte thirdByte: aThirdByte fourthByte: aFourthByte toStream: aStream [
	self subclassResponsibility
]

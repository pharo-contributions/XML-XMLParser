"
An abstract class for UTF-16 stream converters.
"
Class {
	#name : #XMLUTF16StreamConverter,
	#superclass : #XMLUTFStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF16StreamConverter >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte [
	self subclassResponsibility
]

{ #category : #testing }
XMLUTF16StreamConverter >> isBigEndian [
	self subclassResponsibility
]

{ #category : #decoding }
XMLUTF16StreamConverter >> nextFromStream: aStream [
	| codePoint |

	codePoint :=
		self
			codePointFromFirstByte:
				(aStream basicNext ifNil: [^ nil]) asciiValue
			secondByte:
				(aStream basicNext ifNil: [self errorInvalidCharacter]) asciiValue.

	(codePoint < 16rD800 or: [codePoint > 16rDBFF])
		ifTrue: [^ self characterWithValue: codePoint]
		ifFalse: [
			^ self
				surrogatePairFromStream: aStream
				withHighSurrogate: codePoint]
]

{ #category : #encoding }
XMLUTF16StreamConverter >> nextPut: aCharacter toStream: aStream [
	| codePoint |

	(codePoint := self valueFromCharacter: aCharacter) < 16r10000
		ifTrue: [
			self
				nextPutFirstByte: ((codePoint bitShift: -8) bitAnd: 16rFF)
				secondByte: (codePoint bitAnd: 16rFF)
				toStream: aStream]
		ifFalse: [| difference |
			difference := codePoint - 16r10000.
			"the 10 high-order bits (2 + 16rD8 then the next 8 high-order bits)"
			self
				nextPutFirstByte: 16rD8 + ((difference bitShift: -18) bitAnd: 16r03)
				secondByte: ((difference bitShift: -10) bitAnd: 16rFF)
				toStream: aStream.
			"the 10 low-order bits (2 + 16rDC then the next 8 low-order bits)"
			self
				nextPutFirstByte: 16rDC + ((difference bitShift: -8) bitAnd: 16r03)
				secondByte: (difference bitAnd: 16rFF)
				toStream: aStream]
]

{ #category : #private }
XMLUTF16StreamConverter >> nextPutFirstByte: aFirstByte secondByte: aSecondByte toStream: aStream [
	self subclassResponsibility
]

{ #category : #private }
XMLUTF16StreamConverter >> surrogatePairFromStream: aStream withHighSurrogate: aHighSurrogate [
	| lowSurrogate |

	lowSurrogate :=
		self
			codePointFromFirstByte:
				(aStream basicNext ifNil: [self errorInvalidCharacter]) asciiValue
			secondByte:
				(aStream basicNext ifNil: [self errorInvalidCharacter]) asciiValue.

	^ self characterWithValue:
		((aHighSurrogate bitAnd: 16r3FF) bitShift: 10) +
		(lowSurrogate bitAnd: 16r3FF) +
		16r10000.
]

"
An abstract class for UTF-16 stream decoders.
"
Class {
	#name : #XMLUTF16StreamDecoder,
	#superclass : #XMLUTFStreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF16StreamDecoder >> codePointFromFirstByte: aFirstByte secondByte: aSecondByte [
	self subclassResponsibility
]

{ #category : #private }
XMLUTF16StreamDecoder >> errorInvalidCodePoint [
	XMLEncodingException signal: 'Invalid UTF-16 code point'
]

{ #category : #testing }
XMLUTF16StreamDecoder >> isBigEndian [
	self subclassResponsibility
]

{ #category : #decoding }
XMLUTF16StreamDecoder >> nextFromStream: aStream [
	| codePoint |

	codePoint :=
		self
			codePointFromFirstByte:
				(aStream basicNext ifNil: [^ nil]) asciiValue
			secondByte:
				(aStream basicNext ifNil: [self errorInvalidCodePoint]) asciiValue.

	(codePoint < 16rD800 or: [codePoint > 16rDBFF])
		ifTrue: [^ self characterWithValue: codePoint]
		ifFalse: [
			^ self
				surrogatePairFromStream: aStream
				withHighSurrogate: codePoint]
]

{ #category : #private }
XMLUTF16StreamDecoder >> surrogatePairFromStream: aStream withHighSurrogate: aHighSurrogate [
	| lowSurrogate |

	lowSurrogate :=
		self
			codePointFromFirstByte:
				(aStream basicNext ifNil: [self errorInvalidCodePoint]) asciiValue
			secondByte:
				(aStream basicNext ifNil: [self errorInvalidCodePoint]) asciiValue.

	^ self characterWithValue:
		((aHighSurrogate bitAnd: 16r3FF) bitShift: 10) +
		(lowSurrogate bitAnd: 16r3FF) +
		16r10000.
]

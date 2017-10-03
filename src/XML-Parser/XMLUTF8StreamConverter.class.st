"
A stream converter for UTF-8 streams. (Rejects overlong encodings.)
"
Class {
	#name : #XMLUTF8StreamConverter,
	#superclass : #XMLUTFStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #basic }
XMLUTF8StreamConverter class >> basicByteOrderMarkBytes [
	^ #(16rEF 16rBB 16rBF)
]

{ #category : #basic }
XMLUTF8StreamConverter class >> basicEncodingNames [
	^ #('UTF-8' 'UTF8')
]

{ #category : #private }
XMLUTF8StreamConverter >> errorOverlongCodePoint: aCodePoint [
	XMLEncodingException
		formatSignal: 'Illegal overlong UTF-8 encoding for U+{1} code point'
		with: aCodePoint printStringHex
]

{ #category : #basic }
XMLUTF8StreamConverter >> nextCodePointFromStream: aStream [
	self shouldNotImplement
]

{ #category : #decoding }
XMLUTF8StreamConverter >> nextFromStream: aStream [
	"an attempt was made at porting Bjoern Hoehrmann's DFA-based decoder
	(with transitions pre-multiplied by 16), but it was slightly slower
	than this implementation and needed significant modification to report
	errors the same way, so it was scrapped"

	| firstByte codePoint |

	aStream basicNext
		ifNil: [^ nil]
		ifNotNil: [:firstChar |
			(firstByte := firstChar asciiValue) < 16r80 "single byte character"
				ifTrue: [^ firstChar]].

	codePoint :=
		self
			nextMultiByteCodePointStartingWith: firstByte
			fromStream: aStream.
	[codePoint == 16rFEFF] "the BOM code point"
		whileTrue: [
			aStream basicNext
				ifNil: [^ nil]
				ifNotNil: [:firstChar |
					(firstByte := firstChar asciiValue) < 16r80 "single byte character"
						ifTrue: [^ firstChar]].
			codePoint :=
				self
					nextMultiByteCodePointStartingWith: firstByte
					fromStream: aStream].

	^ Character value: codePoint.
]

{ #category : #basic }
XMLUTF8StreamConverter >> nextMultiByteCodePointStartingWith: aFirstByte fromStream: aStream [
	| secondByte thirdByte codePoint |

	secondByte :=
		(aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue.
	(secondByte bitAnd: 16rC0) == 16r80
		ifFalse: [self errorBadCharacterEncoding].
	(aFirstByte bitAnd: 16rE0) == 16rC0 "two bytes"
		ifTrue: [
			codePoint :=
				((aFirstByte bitAnd: 16r1F) bitShift: 6) +
				(secondByte bitAnd: 16r3F).
			codePoint >= 16r80
				ifFalse: [self errorOverlongCodePoint: codePoint].
			^ codePoint].

	thirdByte :=
		(aStream basicNext
			ifNil: [self errorBadCharacterEncoding]) asciiValue.
	(thirdByte bitAnd: 16rC0) == 16r80
		ifFalse: [self errorBadCharacterEncoding].
	(aFirstByte bitAnd: 16rF0) == 16rE0 "three bytes"
		ifTrue: [
			codePoint :=
				((aFirstByte bitAnd: 16r0F) bitShift: 12) +
				((secondByte bitAnd: 16r3F) bitShift: 6) +
				(thirdByte bitAnd: 16r3F).
			"check for the reserved surrogate pair code points"
			codePoint >= 16rD800
				ifTrue: [
					codePoint <= 16rDFFF
						ifTrue: [self errorBadCharacterValue: codePoint]]
				ifFalse: [
					codePoint >= 16r800
						ifFalse: [self errorOverlongCodePoint: codePoint]].
			^ codePoint].

	(aFirstByte bitAnd: 16rF8) == 16rF0
		ifTrue: [| fourthByte |
			fourthByte :=
				(aStream basicNext
					ifNil: [self errorBadCharacterEncoding]) asciiValue.
			(fourthByte bitAnd: 16rC0) == 16r80
				ifFalse: [self errorBadCharacterEncoding].
			codePoint :=
				((aFirstByte bitAnd: 16r07) bitShift: 18) +
				((secondByte bitAnd: 16r3F) bitShift: 12) +
				((thirdByte bitAnd: 16r3F) bitShift: 6) +
				(fourthByte bitAnd: 16r3F).
			codePoint > 16r10FFFF "max code point"
				ifTrue: [self errorBadCharacterValue: codePoint].
			codePoint >= 16r10000
				ifFalse: [self errorOverlongCodePoint: codePoint].
			^ codePoint].

	"the first byte is malformed"
	self errorBadCharacterEncoding.
]

{ #category : #encoding }
XMLUTF8StreamConverter >> nextPut: aCharacter toStream: aStream [
	| codePoint |

	(codePoint := aCharacter asciiValue) < 16r80
		ifTrue: [
			aStream basicNextPut: aCharacter.
			^ self].

	codePoint < 16r800
		ifTrue: [
			aStream
				basicNextPutByte: 16rC0 + (codePoint bitShift: -6);
				basicNextPutByte: 16r80 + (codePoint bitAnd: 16r003F).
			^ self].

	codePoint < 16r10000
		ifTrue: [
			"check for the reserved surrogate pair code points"
			(codePoint >= 16rD800
				and: [codePoint <= 16rDFFF])
				ifTrue: [self errorBadCharacterValue: codePoint].
			aStream
				basicNextPutByte: 16rE0 + (codePoint bitShift: -12);
				basicNextPutByte: 16r80 + ((codePoint bitShift: -6) bitAnd: 16r3F);
				basicNextPutByte: 16r80 + (codePoint bitAnd: 16r3F).
			^ self].

	codePoint <= 16r10FFFF  "max code point"
		ifTrue: [
			aStream
				basicNextPutByte: 16rF0 + (codePoint bitShift: -18);
				basicNextPutByte: 16r80 + ((codePoint bitShift: -12) bitAnd: 16r3F);
				basicNextPutByte: 16r80 + ((codePoint bitShift: -6) bitAnd: 16r3F);
				basicNextPutByte: 16r80 + (codePoint bitAnd: 16r3F).
			^ self].

	self errorBadCharacterValue: codePoint.
]

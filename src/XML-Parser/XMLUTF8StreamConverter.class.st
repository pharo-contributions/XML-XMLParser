"
A stream converter for UTF-8 streams. (accepts overlong encodings)
"
Class {
	#name : #XMLUTF8StreamConverter,
	#superclass : #XMLUTFStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTF8StreamConverter class >> basicEncodingNames [
	^ #('UTF-8' 'UTF8')
]

{ #category : #private }
XMLUTF8StreamConverter class >> byteOrderMarkBytes [
	^ #(16rEF 16rBB 16rBF)
]

{ #category : #decoding }
XMLUTF8StreamConverter >> nextFromStream: aStream [
	| firstChar firstByte secondByte thirdByte |

	((firstChar := aStream basicNext) == nil
		or: [(firstByte := firstChar asciiValue) < 16r80]) "single byte character"
		ifTrue: [^ firstChar].

	firstByte < 16rC0 "second bit must be set"
		ifTrue: [self errorInvalidCharacter].

	secondByte := (aStream basicNext ifNil: [self errorInvalidCharacter]) asciiValue.
	(firstByte bitAnd: 16rF0) < 16rE0 "two bytes"
		ifTrue: [
			^ self characterWithValue: 
				((firstByte bitAnd: 16r1F) bitShift: 6) +
				(secondByte bitAnd: 16r3F)].

	thirdByte := (aStream basicNext ifNil: [self errorInvalidCharacter]) asciiValue.
	(firstByte bitAnd: 16rF0) = 16rE0 "three bytes"
		ifTrue: [
			^ self characterWithValue: 
				((firstByte bitAnd: 16r0F) bitShift: 12) +
				((secondByte bitAnd: 16r3F) bitShift: 6) +
				(thirdByte bitAnd: 16r3F)].

	^ self characterWithValue: "four"
		((firstByte bitAnd: 16r07) bitShift: 18) +
		((secondByte bitAnd: 16r3F) bitShift: 12) +
		((thirdByte bitAnd: 16r3F) bitShift: 6) +
		((aStream basicNext ifNil: [self errorInvalidCharacter]) asciiValue bitAnd: 16r3F).
]

{ #category : #encoding }
XMLUTF8StreamConverter >> nextPut: aCharacter toStream: aStream [
	| codePoint |

	(codePoint := self valueFromCharacter: aCharacter) < 16r80
		ifTrue: [^ aStream basicNextPut: aCharacter].

	codePoint < 16r0800
		ifTrue: [
			^ aStream
				basicNextPutByte: 16rC0 + (codePoint bitShift: -6);
				basicNextPutByte: 16r80 + (codePoint bitAnd: 16r003F)].

	codePoint < 16r010000
		ifTrue: [
			^ aStream
				basicNextPutByte: 16rE0 + (codePoint bitShift: -12);
				basicNextPutByte: 16r80 + ((codePoint bitShift: -6) bitAnd: 16r3F);
				basicNextPutByte: 16r80 + (codePoint bitAnd: 16r3F)].

	aStream
		basicNextPutByte: 16rF0 + (codePoint bitShift: -18);
		basicNextPutByte: 16r80 + ((codePoint bitShift: -12) bitAnd: 16r3F);
		basicNextPutByte: 16r80 + ((codePoint bitShift: -6) bitAnd: 16r3F);
		basicNextPutByte: 16r80 + (codePoint bitAnd: 16r3F).
]

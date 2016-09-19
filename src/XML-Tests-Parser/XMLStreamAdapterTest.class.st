"
Abstract, do not run.
"
Class {
	#name : #XMLStreamAdapterTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF16BE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: 0 asCharacter;
				nextPut: each]]
]

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF16LE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: each;
				nextPut: 0 asCharacter]]
]

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF32BE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter;
				nextPut: each]]
]

{ #category : #converting }
XMLStreamAdapterTest class >> asciiToUTF32LE: anASCIIString [
	^ String streamContents: [:stream |
		anASCIIString do: [:each |
			stream
				nextPut: each;
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter;
				nextPut: 0 asCharacter]]
]

{ #category : #accessing }
XMLStreamAdapterTest class >> decodedByteString [
	"avoid ASCII null for GS compatibility"
	^ self stringFrom: #(16r01 16r0F 16r10 16rFF)
]

{ #category : #accessing }
XMLStreamAdapterTest class >> decodedUTF16String [
	^ self stringFrom:
		#(16rFF 16r0100 16rD7FF 16rE000 16rFFFF 16r10000 16r10437 16r24B62 16r10FFFF)
]

{ #category : #accessing }
XMLStreamAdapterTest class >> decodedUTF32String [
	^ self stringFrom: #(16rFE 16rD7FE 16r10FFFF)
]

{ #category : #accessing }
XMLStreamAdapterTest class >> decodedUTF8String [
	^ self stringFrom:
		#(16r7F 16r80 16r7FF 16r800 16rFFFF 16r10000 16r10FFFF)
]

{ #category : #accessing }
XMLStreamAdapterTest class >> encodedByteString [
	^ self decodedByteString
]

{ #category : #accessing }
XMLStreamAdapterTest class >> encodedUTF16BEString [
	^ self stringFrom:
		#(16r00 16rFF
			16r01 16r00
			16rD7 16rFF
			16rE0 16r00
			16rFF 16rFF
			16rD8 16r00 16rDC 16r00 "first surrogate pair"
			16rD8 16r01 16rDC 16r37
			16rD8 16r52 16rDF 16r62
			16rDB 16rFF 16rDF 16rFF) "last surrogate pair"
]

{ #category : #accessing }
XMLStreamAdapterTest class >> encodedUTF16LEString [
	^ self stringFrom:
		#(16rFF 16r00
			16r00 16r01
			16rFF 16rD7
			16r00 16rE0
			16rFF 16rFF
			16r00 16rD8 16r00 16rDC "first surrogate pair"
			16r01 16rD8 16r37 16rDC
			16r52 16rD8 16r62 16rDF
			16rFF 16rDB 16rFF 16rDF) "last surrogate pair"
]

{ #category : #accessing }
XMLStreamAdapterTest class >> encodedUTF32BEString [
	^ self stringFrom:
		#(16r00 16r00 16r00 16rFE
			16r00 16r00 16rD7 16rFE
			16r00 16r10 16rFF 16rFF)
]

{ #category : #accessing }
XMLStreamAdapterTest class >> encodedUTF32LEString [
	^ self stringFrom:
		#(16rFE 16r00 16r00 16r00
			16rFE 16rD7 16r00 16r00
			16rFF 16rFF 16r10 16r00)
]

{ #category : #accessing }
XMLStreamAdapterTest class >> encodedUTF8String [
	^ self stringFrom:
		#(16r7F
			16rC2 16r80
			16rDF 16rBF
			16rE0 16rA0 16r80
			16rEF 16rBF 16rBF
			16rF0 16r90 16r80 16r80
			16rF4 16r8F 16rBF 16rBF)
]

{ #category : #testing }
XMLStreamAdapterTest class >> isAbstract [
	^ true
]

{ #category : #converting }
XMLStreamAdapterTest class >> percentEncodeCharacter: aCharacter [
	| hexString |

	(hexString := aCharacter asciiValue printStringHex asUppercase) size > 1
		ifTrue: [^ '%', hexString]
		ifFalse: [^ '%0', hexString]
]

{ #category : #accessing }
XMLStreamAdapterTest class >> percentEncodedUTF8String [
	^ String streamContents: [:stream |
		self encodedUTF8String do: [:each |
			stream nextPutAll: (self percentEncodeCharacter: each)]]
]

{ #category : #testing }
XMLStreamAdapterTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #converting }
XMLStreamAdapterTest class >> stringFrom: aCollection [
	"avoid asString for portability"
	^ String withAll: (aCollection collect: [:each | each asCharacter])
]

{ #category : #accessing }
XMLStreamAdapterTest >> decodedByteString [
	^ self class decodedByteString
]

{ #category : #accessing }
XMLStreamAdapterTest >> decodedUTF16String [
	^ self class decodedUTF16String
]

{ #category : #accessing }
XMLStreamAdapterTest >> decodedUTF32String [
	^ self class decodedUTF32String
]

{ #category : #accessing }
XMLStreamAdapterTest >> decodedUTF8String [
	^ self class decodedUTF8String
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedByteString [
	^ self class encodedByteString
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF16BEString [
	^ self class encodedUTF16BEString
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF16LEString [
	^ self class encodedUTF16LEString
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF32BEString [
	^ self class encodedUTF32BEString
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF32LEString [
	^ self class encodedUTF32LEString
]

{ #category : #accessing }
XMLStreamAdapterTest >> encodedUTF8String [
	^ self class encodedUTF8String
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newStream [
	^ self newStreamOn: self streamCollection
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newStreamAdapter [
	^ self newStreamAdapterOn: self newStream
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newStreamAdapterOn: aStream [
	^ self streamAdapterClass on: aStream
]

{ #category : #'instance creation' }
XMLStreamAdapterTest >> newStreamOn: aCollection [
	^ self streamClass on: aCollection
]

{ #category : #accessing }
XMLStreamAdapterTest >> percentEncodedUTF8String [
	^ self class percentEncodedUTF8String
]

{ #category : #accessing }
XMLStreamAdapterTest >> streamAdapterClass [
	^ XMLStreamAdapter
]

{ #category : #accessing }
XMLStreamAdapterTest >> streamClass [
	^ ReadStream
]

{ #category : #accessing }
XMLStreamAdapterTest >> streamCollection [
	^ String new
]

{ #category : #converting }
XMLStreamAdapterTest >> stringFrom: aCollection [
	^ self class stringFrom: aCollection
]

{ #category : #tests }
XMLStreamAdapterTest >> testClose [
	self
		shouldnt: [self newStreamAdapter close]
		raise: Error
]

{ #category : #tests }
XMLStreamAdapterTest >> testIsBinary [
	self deny: self newStreamAdapter isBinary
]

{ #category : #tests }
XMLStreamAdapterTest >> testIsStream [
	self assert: self newStreamAdapter isStream
]

{ #category : #tests }
XMLStreamAdapterTest >> testIsXMLConvertingStreamAdapter [
	self deny: self newStreamAdapter isXMLConvertingStreamAdapter
]

{ #category : #tests }
XMLStreamAdapterTest >> testOn [
	| stream adapter |

	stream := self newStream.
	adapter := self newStreamAdapterOn: stream.
	self
		assert: adapter class == self streamAdapterClass;
		assert: adapter stream == stream.
]

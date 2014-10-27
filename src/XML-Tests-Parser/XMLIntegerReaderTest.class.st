Class {
	#name : #XMLIntegerReaderTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #private }
XMLIntegerReaderTest >> maxBase [
	^ XMLIntegerReader maxBase
]

{ #category : #tests }
XMLIntegerReaderTest >> testBaseMarker [
	2 to: self maxBase do: [:base | | stream defaultBase |
		defaultBase := (base - 1) max: 2.
		stream := ((base printStringBase: base) copyWithFirst: $#) readStream.
		self
			assert:
				(XMLIntegerReader
					readFrom: stream
					withBase: base
					startingWithAny: '@#$'
					orBase: defaultBase) = base;
			assert: stream atEnd.

		stream := (base printStringBase: defaultBase) readStream.
		self
			assert:
				(XMLIntegerReader
					readFrom: stream
					withBase: base
					startingWithAny: '@#$'
					orBase: defaultBase) = base;
			assert: stream atEnd].
]

{ #category : #tests }
XMLIntegerReaderTest >> testBases [
	2 to: self maxBase do: [:base | | stream |
		(0 to: base), (base + 1 to: base * 10 by: base) do: [:i |
			stream := (i printStringBase: base) readStream.
			self
				assert: (XMLIntegerReader readFrom: stream withBase: base) = i;
				assert: stream atEnd]].
	self
		should: [XMLIntegerReader readFrom: '1' readStream withBase: 1]
		raise: Error.
	self
		should: [XMLIntegerReader readFrom: '1' readStream withBase: self maxBase + 1]
		raise: Error.
]

{ #category : #tests }
XMLIntegerReaderTest >> testMaxValue [
	| maxValue |

	maxValue := XMLIntegerReader maxIntegerValue.
	2 to: self maxBase do: [:base |
		self assert:
			(XMLIntegerReader
				readFrom: (maxValue printStringBase: base) readStream
				withBase: base) = maxValue.
		1 to: base do: [:i |
			self  assert:
				(XMLIntegerReader
					readFrom: ((maxValue + i) printStringBase: base) readStream
					withBase: base) = maxValue]].
]

{ #category : #tests }
XMLIntegerReaderTest >> testNonDigit [

	2 to: self maxBase do: [:base | | baseCharacter stream |
		baseCharacter :=
			base >= 10
				ifTrue: [Character value: $A asciiValue + (base - 10)]
				ifFalse: [Character value: $0 asciiValue + base].
		stream := ((base printStringBase: base) copyWith: baseCharacter) readStream.
		self
			assert: (XMLIntegerReader readFrom: stream withBase: base) = base;
			deny: stream atEnd;
			assert: stream next = baseCharacter.

		baseCharacter := Character value: $0 asciiValue - 1.
		stream := baseCharacter asString readStream.
		self
			assert: (XMLIntegerReader readFrom: stream withBase: base) isNil;
			deny: stream atEnd;
			assert: stream next = baseCharacter].
]

{ #category : #tests }
XMLIntegerReaderTest >> testPositioning [
	| reader string |

	string := 'test'.
	reader := XMLIntegerReader on: string readStream.
	string do: [:each |
		self
			deny: reader atEnd;
			assert: reader peek = each;
			assert: reader next = each].
	self assert: reader atEnd.
]

{ #category : #tests }
XMLIntegerReaderTest >> testReadLimit [
	2 to: self maxBase do: [:base | | stream |
		"101 regardless of base"
		stream := (base * base + 1 printStringBase: base) readStream.
		self
			assert: (XMLIntegerReader readFrom: stream withBase: base upTo: 2) = base;
			deny: stream atEnd;
			assert: stream next == $1]
]

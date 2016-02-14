Class {
	#name : #XMLIntegerReaderTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Util'
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
XMLIntegerReaderTest >> testMaxIntegerValue [
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
	2 to: self maxBase do: [:base | | digitInterval letterInterval uppercaseLetterInterval |
		base > 10
			ifTrue: [
				digitInterval := $0 asciiValue to: $9 asciiValue.
				letterInterval := $a asciiValue to: $a asciiValue + (base - 11).
				uppercaseLetterInterval := $A asciiValue to: $A asciiValue + (base - 11)]
			ifFalse: [
				digitInterval := $0 asciiValue to: $0 asciiValue + base - 1.
				letterInterval := #().
				uppercaseLetterInterval := #()].
		0 to: 256 do: [:each | | char reader |
			char := each asCharacter.
			reader := XMLIntegerReader on: char asString readStream.
			((digitInterval includes: each)
				or: [(letterInterval includes: each)
					or: [uppercaseLetterInterval includes: each]])
				ifTrue: [
					self
						assert: (reader nextIntegerWithBase: base) notNil;
						assert: reader atEnd]
				ifFalse: [
					self
						assert: (reader nextIntegerWithBase: base) isNil;
						deny: reader atEnd;
						assert: reader next = char;
						assert: reader atEnd]]]
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
XMLIntegerReaderTest >> testPrintStream [
	| printStream reader |

	printStream := String new writeStream.
	(reader := XMLIntegerReader on: '123xABChdefO11' readStream)
		printStream: printStream.
	self
		assert: (reader nextIntegerWithBase: 10) = 123;
		assert: printStream contents = '123';
		assert: (reader nextIntegerWithBase: 16 startingWithAny: 'x' orBase: 10) = 2748;
		assert: printStream contents = '123xABC';
		assert: (reader nextIntegerWithBase: 16 startingWithAny: 'h' orBase: 10) = 3567;
		assert: printStream contents = '123xABChdef'.

	reader printStream: nil.
	self
		assert: (reader nextIntegerWithBase: 8 startingWithAny: 'oO' orBase: 10) = 9;
		assert: printStream contents = '123xABChdef';
		assert: reader atEnd.
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

{ #category : #tests }
XMLIntegerReaderTest >> testStreamReadingPortability [
	| stream integerReader integer atEnd |

	stream := XMLExceptionRaisingReadStream on: '123abc'.
	integerReader := XMLIntegerReader on: stream.
	self
		assert: (integerReader nextIntegerWithBase: 16) = 16r123ABC;
		assert: integerReader atEnd.
	self
		shouldnt: [
			integerReader
				nextInteger;
				nextIntegerWithBase: 16;
				nextIntegerWithBase: 16 upTo: 1;
				nextIntegerWithBase: 16 startingWithAny: 'x' orBase: 10;
				peek;
				next]
		raise: Error.

	self assert: stream atEnd.
	self should: [stream peek] raise: Error.
	self should: [stream next] raise: Error.
]

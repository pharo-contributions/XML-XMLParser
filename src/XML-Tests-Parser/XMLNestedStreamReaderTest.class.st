Class {
	#name : #XMLNestedStreamReaderTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLNestedStreamReaderTest >> absentChar [
	^ $!
]

{ #category : #accessing }
XMLNestedStreamReaderTest >> cr [
	^ Character cr
]

{ #category : #accessing }
XMLNestedStreamReaderTest >> lf [
	^ Character lf
]

{ #category : #'instance creation' }
XMLNestedStreamReaderTest >> newStreamReaderOn: aStream [
	^ XMLNestedStreamReader on: aStream
]

{ #category : #'instance creation' }
XMLNestedStreamReaderTest >> newStreamReaderOnSourceXML [
	^ self newStreamReaderOn: self sourceXML readStream
]

{ #category : #accessing }
XMLNestedStreamReaderTest >> normalizedLineEnding [
	^ self lf
]

{ #category : #source }
XMLNestedStreamReaderTest >> normalizedSourceXML [
	^ self sourceXMLNormalizedWith: self normalizedLineEnding
]

{ #category : #source }
XMLNestedStreamReaderTest >> sourceXML [
	^ self sourceXMLTemplate format:
		(Array
			with: self lf
			with: (String with: self cr with: self lf)
			with: self cr)
]

{ #category : #source }
XMLNestedStreamReaderTest >> sourceXMLNormalizedWith: aCharacter [
	^ self sourceXMLTemplate format:
		(Array
			with: aCharacter
			with: aCharacter
			with: aCharacter)
]

{ #category : #source }
XMLNestedStreamReaderTest >> sourceXMLTemplate [
	^ '{1}	<test>{2}	   test{3}	</test>'
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testAtEnd [
	| streamReader |

	streamReader := self newStreamReaderOnSourceXML.
	self normalizedSourceXML size timesRepeat: [
		self deny: streamReader atEnd.
		streamReader next].
	self assert: streamReader atEnd.

	streamReader pushBack: self sourceXML.
	self normalizedSourceXML size timesRepeat: [
		self deny: streamReader atEnd.
		streamReader next].

	self assert: streamReader atEnd.
	streamReader pushBack: ''.
	self assert: streamReader atEnd.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testIsBinary [
	self deny: self newStreamReaderOnSourceXML isBinary
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testIsStream [
	self assert: self newStreamReaderOnSourceXML isStream
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testLineEndingNormalizationAcrossStreams [
	| streamReader |

	streamReader := self newStreamReaderOn: (String with: self lf) readStream.
	streamReader pushBackCharacter: self cr.
	self
		assert: streamReader next == self normalizedLineEnding;
		assert: streamReader atEnd.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testNext [
	| streamReader currentLineNumber currentColumnNumber currentPosition |

	streamReader := self newStreamReaderOnSourceXML.
	currentLineNumber := 1.
	currentColumnNumber := currentPosition := 0.
	self normalizedSourceXML do: [:each |
		streamReader next == self normalizedLineEnding
			ifTrue: [
				currentLineNumber := currentLineNumber + 1.
				currentColumnNumber := 0]
			ifFalse: [currentColumnNumber := currentColumnNumber + 1].
		currentPosition := currentPosition + 1.
		self
			assert: streamReader currentLineNumber = currentLineNumber;
			assert: streamReader currentColumnNumber = currentColumnNumber;
			assert: streamReader currentPosition = currentPosition].
	self assert: streamReader next isNil.

	streamReader := self newStreamReaderOnSourceXML.
	self
		assert: (streamReader next: self normalizedSourceXML size) = self normalizedSourceXML;
		assert: streamReader currentLineNumber = currentLineNumber;
		assert: streamReader currentColumnNumber = currentColumnNumber;
		assert: streamReader currentPosition = currentPosition;
		assert: (streamReader next: self normalizedSourceXML size) = ''.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testNextMatchAll [
	| streamReader readStream currentLineNumber currentColumnNumber currentPosition searchLength |

	streamReader := self newStreamReaderOnSourceXML.
	readStream := self normalizedSourceXML readStream.
	currentLineNumber := 1.
	currentColumnNumber := currentPosition := 0.
	searchLength := 0.
	[readStream atEnd]
		whileFalse: [| searchStream search |
			searchStream := String new writeStream.
			searchLength timesRepeat: [
				readStream atEnd
					ifFalse: [searchStream nextPut: readStream next]].
			search := searchStream contents.
			self
				deny: (streamReader nextMatchAll: (search copyWithFirst: self absentChar));
				deny: (streamReader nextMatchAll: (search copyWith: self absentChar));
				assert: streamReader currentLineNumber = currentLineNumber;
				assert: streamReader currentColumnNumber = currentColumnNumber;
				assert: streamReader currentPosition = currentPosition.

			(search includes: self normalizedLineEnding)
				ifTrue: [
					currentLineNumber :=
						currentLineNumber + (search occurrencesOf: self normalizedLineEnding).
					currentColumnNumber :=
						(search copyAfterLast: self normalizedLineEnding) size]
				ifFalse: [currentColumnNumber := currentColumnNumber + search size].
			currentPosition := currentPosition + search size.
			self
				assert: (streamReader nextMatchAll: search);
				assert: streamReader currentLineNumber = currentLineNumber;
				assert: streamReader currentColumnNumber = currentColumnNumber;
				assert: streamReader currentPosition = currentPosition.

			searchLength := searchLength + 1].
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testNormalizedLineEndingChar [
	| streamReader |

	streamReader := self newStreamReaderOnSourceXML.
	self
		assert: (streamReader normalizedLineEndingChar: $N) == streamReader;
		assert: (streamReader normalizedLineEndingChar) == $N;
		assert: streamReader upToEnd = (self sourceXMLNormalizedWith: $N).
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testPushBackStreamOnClose [
	| streamReader closed |

	streamReader := XMLNestedStreamReader on: '' readStream.
	closed := false.
	streamReader
		pushBackStream: self sourceXML readStream
		onClose: [closed := true].
	self normalizedSourceXML do: [:each |
		self
			assert: streamReader peek == each;
			assert: streamReader next == each;
			deny: closed].
	self
		assert: streamReader next isNil;
		assert: closed.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testSkipSeparators [
	| streamReader readStream currentLineNumber currentColumnNumber currentPosition |

	streamReader := self newStreamReaderOnSourceXML.
	readStream := self normalizedSourceXML readStream.
	currentLineNumber := 1.
	currentColumnNumber := currentPosition := 0.
	[readStream atEnd]
		whileFalse: [| totalSeparatorsSkipped |
			totalSeparatorsSkipped := 0.
			[readStream peek isXMLSeparator]
				whileTrue: [
					readStream next == self normalizedLineEnding
						ifTrue: [
							currentLineNumber := currentLineNumber + 1.
							currentColumnNumber := 0]
						ifFalse: [currentColumnNumber := currentColumnNumber + 1].
					currentPosition := currentPosition + 1.
					totalSeparatorsSkipped := totalSeparatorsSkipped + 1].
			streamReader skipSeparators.
			self
				assert: streamReader currentLineNumber = currentLineNumber;
				assert: streamReader currentColumnNumber = currentColumnNumber;
				assert: streamReader currentPosition = currentPosition.
			totalSeparatorsSkipped > 0
				ifFalse: [
					readStream next.
					streamReader next.
					currentColumnNumber := currentColumnNumber + 1.
					currentPosition := currentPosition + 1]].
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testStreamReadingPortability [
	| streamReader stream lastPeek lastNext |

	stream := XMLExceptionRaisingReadStream on: self sourceXML.
	streamReader := self newStreamReaderOn: stream.
	self
		shouldnt: [
			self normalizedSourceXML size timesRepeat: [
				streamReader
					peek;
					next].
			lastPeek := streamReader peek.
			lastNext := streamReader next]
		raise: Error.
	self
		assert: lastPeek isNil;
		assert: lastNext isNil;
		assert: streamReader atEnd.

	self assert: stream atEnd.
	self should: [stream peek] raise: Error.
	self should: [stream next] raise: Error.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testUpTo [
	self normalizedSourceXML do: [:each | | streamReader |
		streamReader := self newStreamReaderOnSourceXML.
		self assert:
			(streamReader upTo: each) =
				(self normalizedSourceXML copyUpTo: each).
		self assert:
			streamReader upToEnd =
				(self normalizedSourceXML copyAfter: each)].
	self assert:
		(self newStreamReaderOnSourceXML upTo: self absentChar) = self normalizedSourceXML.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testUpToEnd [
	| streamReader |

	self normalizedSourceXML withIndexDo: [:each :i |
		streamReader := self newStreamReaderOnSourceXML.
		streamReader next: i.
		self
			assert: streamReader upToEnd = (self normalizedSourceXML allButFirst: i);
			assert: streamReader upToEnd = ''].
	streamReader := self newStreamReaderOnSourceXML.
	self
		assert: streamReader upToEnd = self normalizedSourceXML;
		assert: streamReader upToEnd = ''.
]

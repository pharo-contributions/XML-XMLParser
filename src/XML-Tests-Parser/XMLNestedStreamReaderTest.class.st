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
	self
		assert: streamReader atEnd;
		assert: streamReader stream atEnd.

	streamReader pushBack: self normalizedSourceXML.
	self normalizedSourceXML size timesRepeat: [
		self deny: streamReader atEnd.
		streamReader next].
	self
		assert: streamReader atEnd;
		assert: streamReader stream atEnd.

	streamReader pushBack: ''.
	self
		assert: streamReader atEnd;
		assert: streamReader stream atEnd.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testCloseStreams [
	| stream streamReader pushedBackStream evaluated |

	stream := XMLExceptionRaisingReadStream on: self sourceXML.
	streamReader := self newStreamReaderOn: stream.

	pushedBackStream := XMLExceptionRaisingReadStream on: self sourceXML.	
	evaluated := false.
	streamReader
		pushBackStream: pushedBackStream
		whenPoppedDo: [evaluated := true]
		isExternal: true.
	self
		assert: streamReader stream == pushedBackStream;
		assert: streamReader hasPushedBackStreams;
		deny: stream wasClosed;
		deny: pushedBackStream wasClosed.

	self
		assert: streamReader closeStreams == streamReader;
		assert: streamReader atEnd;
		deny: streamReader stream == stream;
		deny: streamReader stream == pushedBackStream;
		deny: streamReader hasPushedBackStreams;
		assert: stream wasClosed;
		assert: pushedBackStream wasClosed;
		deny: evaluated.

	self
		shouldnt: [streamReader closeStreams]
		raise: Error.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testHasPushedBackStreams [
	| streamReader |

	streamReader := self newStreamReaderOnSourceXML.
	self deny: streamReader hasPushedBackStreams.

	streamReader pushBackStream: '' readStream.
	self assert: streamReader hasPushedBackStreams.

	streamReader next.
	self deny: streamReader hasPushedBackStreams.		
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
	streamReader
		pushBackStream: (String with: self cr with: self lf) readStream
		whenPoppedDo: nil
		isExternal: true.
	self
		assert: streamReader next = self normalizedLineEnding;
		deny: streamReader atEnd;
		assert: streamReader next = self cr;
		deny: streamReader atEnd;
		assert: streamReader next = self normalizedLineEnding;
		assert: streamReader atEnd.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testNext [
	| streamReader currentLineNumber currentColumnNumber currentPosition |

	streamReader := self newStreamReaderOnSourceXML.
	currentLineNumber := 1.
	currentColumnNumber := currentPosition := 0.
	self normalizedSourceXML do: [:each |
		self assert: streamReader next = each.
		each = self normalizedLineEnding
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
XMLNestedStreamReaderTest >> testNormalizedLineEndingChar [
	| streamReader |

	streamReader := self newStreamReaderOnSourceXML.
	self
		assert: (streamReader normalizedLineEndingChar: $N) == streamReader;
		assert: (streamReader normalizedLineEndingChar) == $N;
		assert: streamReader upToEnd = (self sourceXMLNormalizedWith: $N).
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testPushBackStreamWhenPoppedDoIsExternal [
	| streamReader evaluated |

	streamReader := XMLNestedStreamReader on: '' readStream.
	evaluated := false.
	self assert:
		(streamReader
			pushBackStream: self sourceXML readStream
			whenPoppedDo: [evaluated := true]
			isExternal: true) == streamReader.
	self normalizedSourceXML do: [:each |
		self
			assert: streamReader peek = each;
			assert: streamReader next = each;
			deny: evaluated].
	self
		assert: streamReader next isNil;
		assert: evaluated.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testPushBackStreamWhenPoppedDoIsExternalException [
	"ensure that throwing an exception from the callback doesn't stop
	the stream from being closed or getting popped"

	| stream streamReader evaluated |

	stream := XMLExceptionRaisingReadStream on: self sourceXML.
	streamReader := self newStreamReaderOnSourceXML.
	evaluated := false.
	streamReader
		pushBackStream: stream
		whenPoppedDo: [
			evaluated := true.
			Error signal]
		isExternal: true.
	self
		assert: streamReader stream == stream;
		deny: evaluated;
		deny: stream wasClosed.

	self
		should: [streamReader upToEnd]
		raise: Error.
	self
		deny: streamReader stream == stream;
		assert: evaluated;
		assert: stream wasClosed.
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
					readStream next = self normalizedLineEnding
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
XMLNestedStreamReaderTest >> testStreamPushbackPortability [
	| streamReader output lastPeek lastNext |

	streamReader := self newStreamReaderOn: '' readStream.
	streamReader
		pushBackStream:
			(XMLExceptionRaisingReadStream on: self sourceXML)
		whenPoppedDo: nil
		isExternal: true.
	output := String new writeStream.
	self
		shouldnt: [
			self normalizedSourceXML size timesRepeat: [
				output nextPut:
					(streamReader
						peek;
						next)].
			lastPeek := streamReader peek.
			lastNext := streamReader next]
		raise: Error.
	self
		assert: output contents = self normalizedSourceXML;
		assert: lastPeek isNil;
		assert: lastNext isNil;
		assert: streamReader atEnd.
]

{ #category : #tests }
XMLNestedStreamReaderTest >> testStreamReadingPortability [
	| streamReader stream output lastPeek lastNext |

	stream := XMLExceptionRaisingReadStream on: self sourceXML.
	streamReader := self newStreamReaderOn: stream.
	output := String new writeStream.
	self
		shouldnt: [
			self normalizedSourceXML size timesRepeat: [
				output nextPut:
					(streamReader
						peek;
						next)].
			lastPeek := streamReader peek.
			lastNext := streamReader next]
		raise: Error.
	self
		assert: output contents = self normalizedSourceXML;
		assert: lastPeek isNil;
		assert: lastNext isNil;
		assert: streamReader atEnd.

	self assert: stream wasClosed.
	self should: [stream atEnd] raise: Error.
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

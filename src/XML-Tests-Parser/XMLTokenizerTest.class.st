Class {
	#name : #XMLTokenizerTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #accessing }
XMLTokenizerTest class >> badNCNames [
	"all NC (non-qualified) names are names, but not all names are NC names"
	^ self badNames, self nonNCNameNames
]

{ #category : #accessing }
XMLTokenizerTest class >> badNames [
	"all names are Nmtokens, but not all Nmtokesn are names"
	^ self badNmtokens, self nonNameNmtokens
]

{ #category : #accessing }
XMLTokenizerTest class >> badNmtokenChars [
	^ #(16r00 16r01 16r0F 16r10
			16r2C 16r2F 16r40 16r5B
			16r5E 16r60 16r7B 16r80
			16rBF 16rD7 16rF7 16r37E
			16r2000 16r200B 16r200E 16r206F
			16r2190 16r2BFF 16r2FFF 16r3000
			16rD800 16rF8FF 16rFDD0 16rFDEF
			16rFFFE 16r0FFFF 16rF0000 16r10FFFF)
			collect: [:each | each asCharacter]
]

{ #category : #accessing }
XMLTokenizerTest class >> badNmtokens [
	^ #('' ' ' '	'), (self badNmtokenChars collect: [:each | 'test' copyWith: each])
]

{ #category : #accessing }
XMLTokenizerTest class >> nonNCNameNames [
	^ #(':' 'test:test' 'test:' ':test')
]

{ #category : #accessing }
XMLTokenizerTest class >> nonNameNmtokens [
	^ self nonNameStartCharNameChars collect: [:each | 'test' copyWithFirst: each]
]

{ #category : #accessing }
XMLTokenizerTest class >> nonNameStartCharNameChars [
	"NameChars that aren't NameStartChars"
	^ #($- $.
			$0 $1 $2 $3 $4 $5 $6 $7 $8 $9
			16rB7 16r0300 16r036F 16r203F 16r2040)
			collect: [:each | each asCharacter]
]

{ #category : #source }
XMLTokenizerTest >> addressBookXML [
	^ XMLParserTest addressBookXML
]

{ #category : #source }
XMLTokenizerTest >> addressBookXMLWithDTD [
	^ XMLParserTest addressBookXMLWithDTD
]

{ #category : #accessing }
XMLTokenizerTest >> badNCNames [
	^ self class badNCNames
]

{ #category : #accessing }
XMLTokenizerTest >> badNames [
	^ self class badNames
]

{ #category : #accessing }
XMLTokenizerTest >> badNmtokens [
	^ self class badNmtokens
]

{ #category : #accessing }
XMLTokenizerTest >> nonNCNameNames [
	^ self class nonNCNameNames
]

{ #category : #accessing }
XMLTokenizerTest >> nonNameNmtokens [
	^ self class nonNameNmtokens
]

{ #category : #tests }
XMLTokenizerTest >> testChangingNormalizedLineEnding [
	| xml domParser parser tokenizer |

	xml :=
		'<root>{1}one{2}two{3}three{1}</root>'
			format: (Array with: String lf with: String cr with: String crlf).
	domParser := XMLDOMParser on: xml.

	parser := domParser parser.
	tokenizer := parser tokenizer.
	self assert: tokenizer normalizedLineEndingChar == Character lf.
	
	tokenizer normalizedLineEndingChar: $N.
	self assert: tokenizer normalizedLineEndingChar == $N.

	parser parseDocument.
	self assert: domParser document root contentString = 'NoneNtwoNthreeN'.
]

{ #category : #tests }
XMLTokenizerTest >> testIsNCName [
	self badNCNames do: [:each |
		self deny: (self tokenizerClass isNCName: each)].
]

{ #category : #tests }
XMLTokenizerTest >> testIsName [
	self nonNCNameNames do: [:each |
		self assert: (self tokenizerClass isName: each)].
	self badNames do: [:each |
		self deny: (self tokenizerClass isName: each)].
]

{ #category : #tests }
XMLTokenizerTest >> testIsNmtoken [
	self nonNCNameNames do: [:each |
		self assert: (self tokenizerClass isNmtoken: each)].
	self nonNameNmtokens do: [:each |
		self assert: (self tokenizerClass isNmtoken: each)].
	self badNmtokens do: [:each |
		self deny: (self tokenizerClass isNmtoken: each)].
]

{ #category : #tests }
XMLTokenizerTest >> testNextMatchAll [
	| xml tokenizer streamReader readLimit |

	xml := '<test>
test
</test>'.
	readLimit := xml size.
	tokenizer :=
		self tokenizerClass
			driver: nil
			on: xml readStream
			readLimit: readLimit.
	streamReader := tokenizer streamReader.
	self
		deny: (streamReader nextMatchAll: '!<test>');
		assert: streamReader currentLineNumber = 1;
		assert: streamReader readLimit = readLimit.
	self
		deny: (streamReader nextMatchAll: '<test>!');
		assert: streamReader currentLineNumber = 1;
		assert: streamReader readLimit = readLimit.
	self
		assert: (streamReader nextMatchAll: '<test>');
		assert: streamReader currentLineNumber = 1;
		assert: streamReader readLimit = (readLimit - '<test>' size).

	tokenizer :=
		self tokenizerClass
			driver: nil
			on: xml readStream
			readLimit: nil.
	streamReader := tokenizer streamReader.
	self
		deny: (streamReader nextMatchAll: '!<test>');
		assert: streamReader currentLineNumber = 1;
		assert: streamReader readLimit isNil.
	self
		assert: (streamReader nextMatchAll: '<test>');
		assert: streamReader currentLineNumber = 1;
		assert: streamReader readLimit isNil.
]

{ #category : #tests }
XMLTokenizerTest >> testNextNCNameFrom [
	| readStream writeStream |

	self badNCNames do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		(self tokenizerClass
			nextNCNameFrom: readStream
			on: writeStream)
			ifTrue: [self deny: writeStream contents = each]].
]

{ #category : #tests }
XMLTokenizerTest >> testNextNameFromOn [
	| readStream writeStream |

	self nonNCNameNames do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		self assert:
			(self tokenizerClass
				nextNameFrom: readStream
				on: writeStream).
		self assert: writeStream contents = each].

	self badNames do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		(self tokenizerClass
			nextNameFrom: readStream
			on: writeStream)
			ifTrue: [self deny: writeStream contents = each]].
]

{ #category : #tests }
XMLTokenizerTest >> testNextNmtokenFromOn [
	| readStream writeStream |

	self nonNCNameNames, self nonNameNmtokens do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		self assert:
			(self tokenizerClass
				nextNmtokenFrom: readStream
				on: writeStream).
		self assert: writeStream contents = each].

	self badNmtokens do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		(self tokenizerClass
			nextNmtokenFrom: readStream
			on: writeStream)
			ifTrue: [self deny: writeStream contents = each]].
]

{ #category : #tests }
XMLTokenizerTest >> testSkipSeparators [
	| xml tokenizer streamReader readLimit |

	xml := '
	<test/>'.
	readLimit := xml size.
	tokenizer :=
		self tokenizerClass
			driver: nil
			on: xml readStream
			readLimit: readLimit.
	streamReader := tokenizer streamReader.
	2 timesRepeat: [
		streamReader skipSeparators.
		self
			assert: streamReader currentLineNumber = 2;
			assert: streamReader readLimit = (readLimit - ((xml copyUpTo: $<) size))].

	tokenizer :=
		self tokenizerClass
			driver: nil
			on: xml readStream
			readLimit: nil.
	streamReader := tokenizer streamReader.
	2 timesRepeat: [
		streamReader skipSeparators.
		self
			assert: streamReader currentLineNumber = 2;
			assert: streamReader readLimit isNil].
]

{ #category : #tests }
XMLTokenizerTest >> testStreamReadingPortability [
	| tokenizer stream |

	tokenizer :=
		self tokenizerClass
			driver: nil
			on: (stream := XMLExceptionRaisingReadStream on: self addressBookXML).
	self
		shouldnt: [
			[tokenizer streamReader
				peek;
				next] doWhileFalse: [tokenizer streamReader atEnd]]
		raise: Error.

	self assert: stream atEnd.
	self should: [stream peek] raise: Error.
	self should: [stream next] raise: Error.
]

{ #category : #tests }
XMLTokenizerTest >> testTokenizerAddressBook [
	| tokenizer |

	tokenizer :=
		self tokenizerClass
			driver: nil
			on: self addressBookXML readStream.
	self
		shouldnt: [[tokenizer streamReader next notNil] whileTrue]
		raise: XMLParserException.
]

{ #category : #tests }
XMLTokenizerTest >> testTokenizerAddressBookWithDTD [
	| tokenizer |

	tokenizer :=
		self tokenizerClass
			driver: nil
			on: self addressBookXMLWithDTD readStream.
	self
		shouldnt: [[tokenizer streamReader next notNil] whileTrue]
		raise: XMLParserException.
]

{ #category : #tests }
XMLTokenizerTest >> testTokenizerCharacters [
	| tokenizer |
	"This test is actually not that useful. This is not the proper way of using the parser.
	This test is here just for specification purpose"
	"self debug: #testParsingCharacters"

	tokenizer :=
		self tokenizerClass
			driver: nil
			on: self addressBookXML readStream.

	self
		assert: tokenizer streamReader next == $<;
		assert: ('address' allSatisfy: [:each | tokenizer streamReader next == each]);
		assert: tokenizer streamReader peek == $b.

	tokenizer streamReader pushBack: 'test'.
	self
		assert: ('test' allSatisfy: [:each | tokenizer streamReader next == each]);
		assert: tokenizer streamReader peek == $b;
		assert: ('book' allSatisfy: [:each | tokenizer streamReader next == each]).

	tokenizer streamReader
		pushBack: 'book';
		pushBack: 'test'.
	self
		assert: ('test' allSatisfy: [:each | tokenizer streamReader next == each]);
		assert: ('book' allSatisfy: [:each | tokenizer streamReader next == each]).
]

{ #category : #accessing }
XMLTokenizerTest >> tokenizerClass [
	^ XMLWellFormedParserTokenizer
]

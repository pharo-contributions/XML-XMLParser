Class {
	#name : #XMLTokenizerTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
XMLTokenizerTest >> addressBookXML [
	^ XMLParserTest addressBookXML
]

{ #category : #source }
XMLTokenizerTest >> addressBookXMLWithDTD [
	^ XMLParserTest addressBookXMLWithDTD
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
XMLTokenizerTest >> testConditionalSection [
	| tokenizer |

	tokenizer :=
		XMLWellFormedParserTokenizer
			driver: nil
			on:
				'<![INCLUDE [included',
				'<![ IGNORE [ignored; <![INCLUDE[ignored;]]> ignored.]]>',
				', included]]>, included.'.
	tokenizer tokenContext: XMLExternalSubsetContext new.
	tokenizer nextToken.
	self assert: tokenizer streamReader upToEnd = 'included, included, included.'.

	self
		should: [SAXHandler parse: '<!DOCTYPE root [ <![IGNORE[<!--ignored-->]]> ]><root/>']
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLTokenizerTest >> testStreamReadingPortability [
	| tokenizer stream |

	tokenizer :=
		XMLWellFormedParserTokenizer
			driver: nil
			on: (stream := XMLExceptionRaisingReadStream on: self addressBookXML).
	self
		shouldnt: [
			[tokenizer streamReader
				peek;
				next]
				doWhileFalse: [tokenizer streamReader atEnd]]
		raise: Error.
	self should: [stream peek] raise: Error.
	self should: [stream next] raise: Error.
]

{ #category : #tests }
XMLTokenizerTest >> testTokenizerAddressBook [
	| tokenizer |

	tokenizer :=
		XMLWellFormedParserTokenizer
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
		XMLWellFormedParserTokenizer
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

	tokenizer := XMLWellFormedParserTokenizer driver: nil on: self addressBookXML readStream.

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

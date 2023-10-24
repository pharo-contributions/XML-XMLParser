Class {
	#name : #SAX2ParserTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-Base'
}

{ #category : #source }
SAX2ParserTest >> addressBookXML [
	^ XMLParserTest addressBookXML
]

{ #category : #accessing }
SAX2ParserTest >> contentHandlerClass [
	^ SAX2ContentHandler
]

{ #category : #accessing }
SAX2ParserTest >> declarationHandlerClass [
	^ SAX2DeclarationHandler
]

{ #category : #accessing }
SAX2ParserTest >> lexicalHandlerClass [
	^ SAX2LexicalHandler
]

{ #category : #tests }
SAX2ParserTest >> testContentHandler [

	| parser oldContentHandler newContentHandler |
	parser := SAX2Parser on: self addressBookXML.
	oldContentHandler := parser contentHandler.
	self
		assert: oldContentHandler class
		identicalTo: self contentHandlerClass;
		assert: oldContentHandler parser identicalTo: parser.

	newContentHandler := self contentHandlerClass new.
	self
		assert: (parser contentHandler: newContentHandler)
		identicalTo: parser;
		assert: parser contentHandler identicalTo: newContentHandler;
		assert: newContentHandler parser identicalTo: parser;
		assert: (parser contentHandler: nil) identicalTo: parser;
		assert: parser contentHandler class
		identicalTo: self contentHandlerClass;
		assert: parser contentHandler parser identicalTo: parser
]

{ #category : #tests }
SAX2ParserTest >> testDeclarationHandler [

	| parser oldDeclarationHandler newDeclarationHandler |
	parser := SAX2Parser on: self addressBookXML.
	oldDeclarationHandler := parser declarationHandler.
	self
		assert: oldDeclarationHandler class
		identicalTo: self declarationHandlerClass;
		assert: oldDeclarationHandler parser identicalTo: parser.

	newDeclarationHandler := self declarationHandlerClass new.
	self
		assert: (parser declarationHandler: newDeclarationHandler)
		identicalTo: parser;
		assert: parser declarationHandler
		identicalTo: newDeclarationHandler;
		assert: newDeclarationHandler parser identicalTo: parser;
		assert: (parser declarationHandler: nil) identicalTo: parser;
		assert: parser declarationHandler class
		identicalTo: self declarationHandlerClass;
		assert: parser declarationHandler parser identicalTo: parser
]

{ #category : #tests }
SAX2ParserTest >> testLexicalHandler [

	| parser oldLexicalHandler newLexicalHandler |
	parser := SAX2Parser on: self addressBookXML.
	oldLexicalHandler := parser lexicalHandler.
	self
		assert: oldLexicalHandler class
		identicalTo: self lexicalHandlerClass;
		assert: oldLexicalHandler parser identicalTo: parser.

	newLexicalHandler := self lexicalHandlerClass new.
	self
		assert: (parser lexicalHandler: newLexicalHandler)
		identicalTo: parser;
		assert: parser lexicalHandler identicalTo: newLexicalHandler;
		assert: newLexicalHandler parser identicalTo: parser;
		assert: (parser lexicalHandler: nil) identicalTo: parser;
		assert: parser lexicalHandler class
		identicalTo: self lexicalHandlerClass;
		assert: parser lexicalHandler parser identicalTo: parser
]

{ #category : #tests }
SAX2ParserTest >> testParseDocument [
	self
		shouldnt: [
			(SAX2Parser on: self addressBookXML)
				parseDocument]
		raise: XMLParserException
]

{ #category : #tests }
SAX2ParserTest >> testParsingResult [

	| parser |
	parser := SAX2Parser on: self addressBookXML.
	self assert: parser parsingResult identicalTo: parser.

	parser parsingResult: #result.
	self
		assert: parser parsingResult identicalTo: #result;
		assert: parser parseDocument identicalTo: #result
]

Class {
	#name : #SAX2ParserTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
SAX2ParserTest >> addressBookXML [
	^ XMLParserTest addressBookXML
]

{ #category : #tests }
SAX2ParserTest >> testContentHandler [
	| parser oldContentHandler newContentHandler |

	parser := SAX2Parser on: self addressBookXML.
	oldContentHandler := parser contentHandler.
	self assert: (oldContentHandler isKindOf: SAX2ContentHandler).

	newContentHandler := SAX2ContentHandler new.
	self
		assert: (parser contentHandler: newContentHandler) == parser;
		assert: parser contentHandler == newContentHandler;
		assert: (parser contentHandler: nil) == parser;
		assert: (parser contentHandler isKindOf: SAX2ContentHandler).
]

{ #category : #tests }
SAX2ParserTest >> testDeclarationHandler [
	| parser oldDeclarationHandler newDeclarationHandler |

	parser := SAX2Parser on: self addressBookXML.
	oldDeclarationHandler := parser declarationHandler.
	self assert: (oldDeclarationHandler isKindOf: SAX2DeclarationHandler).

	newDeclarationHandler := SAX2DeclarationHandler new.
	self
		assert: (parser declarationHandler: newDeclarationHandler) == parser;
		assert: parser declarationHandler == newDeclarationHandler;
		assert: (parser declarationHandler: nil) == parser;
		assert: (parser declarationHandler isKindOf: SAX2DeclarationHandler).
]

{ #category : #tests }
SAX2ParserTest >> testLexicalHandler [
	| parser oldLexicalHandler newLexicalHandler |

	parser := SAX2Parser on: self addressBookXML.
	oldLexicalHandler := parser lexicalHandler.
	self assert: (oldLexicalHandler isKindOf: SAX2LexicalHandler).

	newLexicalHandler := SAX2LexicalHandler new.
	self
		assert: (parser lexicalHandler: newLexicalHandler) == parser;
		assert: parser lexicalHandler == newLexicalHandler;
		assert: (parser lexicalHandler: nil) == parser;
		assert: (parser lexicalHandler isKindOf: SAX2LexicalHandler).
]

{ #category : #tests }
SAX2ParserTest >> testParseDocument [
	self
		shouldnt: [
			(SAX2Parser on: self addressBookXML)
				parseDocument]
		raise: XMLParserException
]

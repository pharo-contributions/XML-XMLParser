"
A SAXHandler is an XML parser that parses XML using event handling. The acronym ""SAX"" refers to Java's ""Simple API for XML,"" on which SAXHandler's API is based. To use this class, create a subclass and override handlers in ""content"" and ""lexical"" as needed.
"
Class {
	#name : #SAXHandler,
	#superclass : #Object,
	#instVars : [
		'document',
		'driver',
		'eod'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #'instance creation' }
SAXHandler class >> on: aStream [
	| driver parser |
	driver := SAXDriver on: aStream.
	driver validating: true.
	parser := self new driver: driver.
	^parser
]

{ #category : #'instance creation' }
SAXHandler class >> parseDTDFrom: aStream [
	| driver parser |
	driver := SAXDriver on: aStream.
	driver validating: true.
	driver startParsingMarkup.
	parser := self new driver: driver.
	parser startDocument.
	parser parseDocument.
	^parser
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFrom: aStream [
	^self parseDocumentFrom: aStream useNamespaces: false
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFrom: aStream useNamespaces: aBoolean [
	|  parser |
	parser := self on: aStream.
	parser useNamespaces: aBoolean.
	parser startDocument.
	parser parseDocument.
	^parser
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFromFileNamed: fileName [
	^self parseDocumentFromFileNamed: fileName readIntoMemory: false
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFromFileNamed: fileName readIntoMemory: readIntoMemory [
	| stream xmlDoc |
	stream := FileDirectory default readOnlyFileNamed: fileName.
	readIntoMemory
		ifTrue: [stream := stream contentsOfEntireFile readStream].
	[xmlDoc := self parseDocumentFrom: stream]
		ensure: [stream close].
	^xmlDoc
]

{ #category : #'instance creation' }
SAXHandler class >> parserOnFileNamed: fileName [
	^self parserOnFileNamed: fileName readIntoMemory: false
]

{ #category : #'instance creation' }
SAXHandler class >> parserOnFileNamed: fileName readIntoMemory: readIntoMemory [
	| stream  |
	stream := FileDirectory default readOnlyFileNamed: fileName.
	readIntoMemory
		ifTrue: [stream := stream contentsOfEntireFile readStream].
	^self on: stream
]

{ #category : #content }
SAXHandler >> characters: aString [
	"This call corresponds to the Java SAX call
	characters(char[] ch, int start, int length)."
]

{ #category : #content }
SAXHandler >> checkEOD [
	"Check if the document shouldn't be ended already"
	self eod
		ifTrue: [self driver errorExpected: 'No more data expected,']
]

{ #category : #lexical }
SAXHandler >> comment: commentString [
	"This call corresponds to the Java SAX ext call
	comment(char[] ch, int start, int length)."
]

{ #category : #accessing }
SAXHandler >> document [
	^document
]

{ #category : #accessing }
SAXHandler >> document: aDocument [
	document := aDocument
]

{ #category : #content }
SAXHandler >> documentAttributes: attributeList [
]

{ #category : #accessing }
SAXHandler >> driver [
	^driver
]

{ #category : #accessing }
SAXHandler >> driver: aDriver [
	driver := aDriver.
	driver saxHandler: self
]

{ #category : #lexical }
SAXHandler >> endCData [
	"This call corresponds to the Java SAX ext call
	endCData()."
]

{ #category : #content }
SAXHandler >> endDocument [
	"This call corresponds to the Java SAX call
	endDocument()."
	eod := true
]

{ #category : #content }
SAXHandler >> endElement: elementName [

]

{ #category : #content }
SAXHandler >> endElement: elementName namespace: namespace namespaceURI: namespaceURI qualifiedName: qualifiedName [
	"This call corresponds to the Java SAX call
	endElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName).
	By default this call is mapped to the following more convenient call:"

	self endElement: elementName
]

{ #category : #lexical }
SAXHandler >> endEntity: entityName [
	"This call corresponds to the Java SAX ext call
	endEntity(java.lang.String name)."
]

{ #category : #content }
SAXHandler >> endPrefixMapping: prefix [
	"This call corresonds to the Java SAX call
	endPrefixMapping(java.lang.String prefix)."
]

{ #category : #accessing }
SAXHandler >> eod [
	^eod
]

{ #category : #content }
SAXHandler >> ignorableWhitespace: aString [
	"This call corresonds to the Java SAX call
	ignorableWhitespace(char[] ch, int start, int length)."
]

{ #category : #initialize }
SAXHandler >> initialize [
	eod := false
]

{ #category : #parsing }
SAXHandler >> parseDocument [
	[self driver nextEntity isNil or: [self eod]] whileFalse
]

{ #category : #content }
SAXHandler >> processingInstruction: piName data: dataString [
	"This call corresonds to the Java SAX call
	processingInstruction(java.lang.String target, java.lang.String data)."
]

{ #category : #entity }
SAXHandler >> resolveEntity: publicID systemID: systemID [
	"This call corresonds to the Java SAX call
	resolveEntity(java.lang.String publicId, java.lang.String systemId)."
]

{ #category : #content }
SAXHandler >> skippedEntity: aString [
	"This call corresonds to the Java SAX call
	skippedEntity(java.lang.String name)."
]

{ #category : #lexical }
SAXHandler >> startCData [
	"This call corresponds to the Java SAX ext call
	startCData()."
]

{ #category : #lexical }
SAXHandler >> startDTD: declName publicID: publicID systemID: systemID [
	"This call corresponds to the Java SAX ext call
	startDTD(java.lang.String name, java.lang.String publicId, java.lang.String systemId)."
]

{ #category : #content }
SAXHandler >> startDocument [
	"This call corresonds to the Java SAX call
	startDocument()."
]

{ #category : #content }
SAXHandler >> startElement: elementName attributeList: attributeList [

]

{ #category : #content }
SAXHandler >> startElement: localName namespaceURI: namespaceUri namespace: namespace attributeList: attributeList [
	"This call corresonds to the Java SAX call
	startElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName, Attributes atts).
	By default this call is mapped to the following more convenient call:"

	self startElement: localName attributeList: attributeList
]

{ #category : #lexical }
SAXHandler >> startEntity: entityName [
	"This call corresponds to the Java SAX ext call
	startEntity(java.lang.String name)."
]

{ #category : #content }
SAXHandler >> startPrefixMapping: prefix uri: uri [
	"This call corresonds to the Java SAX call
	startPrefixMapping(java.lang.String prefix, java.lang.String uri)."
]

{ #category : #accessing }
SAXHandler >> useNamespaces: aBoolean [
	self driver useNamespaces: aBoolean
]

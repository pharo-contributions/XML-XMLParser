"
A SAXHandler is an XML parser that uses event handling. The acronym ""SAX"" refers to Java's ""Simple API for XML,"" on which SAXHandler's API is based. To use this class, create a subclass and override handlers in ""content"" and ""lexical"" as needed. To instantiate it you can send either #on: or one of the class-side #parse- messages. The former creates a new parser on the given input stream and returns it; the instance can then be sent #parseDocument to parse the input. The #parse- messages take some input source and parse it, returning the result of #parseDocument.

By default namespace support is enabled.
"
Class {
	#name : #SAXHandler,
	#superclass : #Object,
	#instVars : [
		'driver',
		'eod'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #'instance creation' }
SAXHandler class >> on: aStream [
	| driver |
	driver := SAXDriver on:
		(aStream isStream
			ifTrue: [aStream]
			ifFalse: [aStream readStream]).
	^ self new
		driver: driver;
		validating: true.
]

{ #category : #'instance creation' }
SAXHandler class >> parse: aStream [
	^ self parseDocumentFrom: aStream
]

{ #category : #'instance creation' }
SAXHandler class >> parseDTDFrom: aStream [
	| driver parser |
	driver := SAXDriver on: aStream.
	driver validating: true.
	driver startParsingMarkup.
	parser := self new driver: driver.
	^ parser parseDocument.
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFrom: aStream [
	^ self parseDocumentFrom: aStream useNamespaces: true
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFrom: aStream useNamespaces: aBoolean [
	|  parser |
	parser := self on: aStream.
	parser useNamespaces: aBoolean.
	^ parser parseDocument.
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

{ #category : #lexical }
SAXHandler >> comment: commentString [
	"This call corresponds to the Java SAX ext call
	comment(char[] ch, int start, int length)."
]

{ #category : #accessing }
SAXHandler >> currentScope [
	^ self driver currentScope
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
SAXHandler >> endElement: localName prefix: prefix uri: namespaceURI [
	"This call corresponds to the Java SAX call
	endElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName).
	By default this call is mapped to the following more convenient call:"

	self endElement: localName
]

{ #category : #content }
SAXHandler >> endElement: localName qualifiedName: qualifiedName prefix: prefix uri: namespaceURI [
	"This call corresponds to the Java SAX call
	endElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName).
	By default this call is mapped to the following more convenient call:"

	self
		forwardToDeprecatedHandler: #endElement:namespace:namespaceURI:qualifiedName:
		withArgumentOrder: #(1 3 4 2)
		orTo: #endElement:prefix:uri:
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

{ #category : #'error handling' }
SAXHandler >> forwardToDeprecatedHandler: aDeprecatedSelector withArgumentOrder: aPositionArray orTo: aNewSelector [
	| parentContext |

	parentContext := thisContext sender.
	(self class includesSelector: aDeprecatedSelector)
		ifFalse: [
			aNewSelector ifNil: [^ self].
			^ self
				perform: aNewSelector
				withEnoughArguments: parentContext arguments].

	(Deprecation
		method: (self class lookupSelector: aDeprecatedSelector)
		explanation: 'use ', parentContext selector, ' instead'
		on: nil
		in: nil) signal.

	self
		perform: aDeprecatedSelector
		withArguments: (aPositionArray collect: [:pos | parentContext arguments at: pos]).
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
	self startDocument.
	[self driver nextToken isNil or: [self eod]] whileFalse.

	"Result of parsing"
	^ self.
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
SAXHandler >> startElement: elementName attributes: attributes [
	self
		forwardToDeprecatedHandler: #startElement:attributeList:
		withArgumentOrder: #(1 2)
		orTo: nil
]

{ #category : #content }
SAXHandler >> startElement: localName prefix: prefix uri: namespaceUri attributes: attributes [
	"This call corresonds to the Java SAX call
	startElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName, Attributes atts).
	By default this call is mapped to the following more convenient call:"

	self
		forwardToDeprecatedHandler: #startElement:namespaceURI:namespace:attributeList:
		withArgumentOrder: #(1 3 2 4)
		orTo: #startElement:attributes:
]

{ #category : #content }
SAXHandler >> startElement: localName qualifiedName: qualifiedName prefix: prefix uri: namespaceUri attributes: attributes [
	"This call corresonds to the Java SAX call
	startElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName, Attributes atts).
	By default this call is mapped to the following more convenient call:"

	self
		startElement: localName
		prefix: prefix
		uri: namespaceUri
		attributes: attributes
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

{ #category : #testing }
SAXHandler >> usesNamespaces [
	^ self driver usesNamespaces
]

{ #category : #testing }
SAXHandler >> validating [
	self driver validating
]

{ #category : #accessing }
SAXHandler >> validating: aBoolean [
	self driver validating: aBoolean
]

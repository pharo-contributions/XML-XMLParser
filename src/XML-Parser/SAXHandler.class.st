"
A SAXHandler is an XML parser that uses event handling. The acronym ""SAX"" refers to Java's ""Simple API for XML,"" on which SAXHandler's API is based. To use this class, create a subclass and override handlers in ""content"" and ""lexical"" as needed. To instantiate it you can send #on: or any of the #parse- messages. The former creates a new parser on the given input stream and returns it; the instance can then be sent #parseDocument to parse the input. The #parse- messages take some input source and parse it, returning the result of #parseDocument.

By default, namespace support is enabled.
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
		isValidating: true.
]

{ #category : #'instance creation' }
SAXHandler class >> parse: aStream [
	^ self parseDocumentFrom: aStream
]

{ #category : #'instance creation' }
SAXHandler class >> parseDTDFrom: aStream [
	| parser |

	parser := self on: aStream.
	parser driver startParsingMarkup.
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
	| stream |
	stream := FileDirectory default readOnlyFileNamed: fileName.
	readIntoMemory
		ifTrue: [stream := stream contentsOfEntireFile readStream].
	^ [self parseDocumentFrom: stream] ensure: [stream close].
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
SAXHandler >> documentAttributes: aDictionary [
]

{ #category : #accessing }
SAXHandler >> driver [
	^ driver
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
SAXHandler >> endElement: aQualifiedName prefix: aPrefix uri: aUri [
	"This call corresponds to the Java SAX call
	endElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName).
	By default this call is mapped to the following more convenient call:"

	self endElement: aQualifiedName
]

{ #category : #content }
SAXHandler >> endElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName [
	"This call corresponds to the Java SAX call
	endElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName).
	By default this call is mapped to the following more convenient call:"

	self
		invokeDeprecated: #endElement:namespace:namespaceURI:qualifiedName:
		withArguments: (Array with: aLocalName with: aPrefix with: aUri with: aQualifiedName)
		orForwardTo: #endElement:prefix:uri:
		withArguments: (Array with: aQualifiedName with: aPrefix with: aUri)
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
	^ eod ifNil: [eod := false]
]

{ #category : #content }
SAXHandler >> ignorableWhitespace: aString [
	"This call corresonds to the Java SAX call
	ignorableWhitespace(char[] ch, int start, int length)."
]

{ #category : #'error handling' }
SAXHandler >> invokeDeprecated: aDeprecatedSelector withArguments: anOldArgumentArray orForwardTo: aNewSelector withArguments: aNewArgumentArray [
	| parentContext |

	parentContext := thisContext sender.
	(self class includesSelector: aDeprecatedSelector)
		ifFalse: [
			aNewSelector ifNil: [^ self].
			^ self
				perform: aNewSelector
				withArguments: aNewArgumentArray].

	(Deprecation
		method: (self class lookupSelector: aDeprecatedSelector)
		explanation: 'use ', parentContext selector, ' instead'
		on: nil
		in: nil) signal.
	self
		perform: aDeprecatedSelector
		withArguments: anOldArgumentArray.
]

{ #category : #testing }
SAXHandler >> isValidating [
	self driver isValidating
]

{ #category : #accessing }
SAXHandler >> isValidating: aBoolean [
	self driver isValidating: aBoolean
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
SAXHandler >> startElement: aQualifiedName attributes: aDictionary [
	self
		invokeDeprecated: #startElement:attributeList:
		withArguments: (Array with: aQualifiedName with: aDictionary)
		orForwardTo: nil
		withArguments: nil.
]

{ #category : #content }
SAXHandler >> startElement: aQualifiedName prefix: aPrefix uri: aUri attributes: aDictionary [
	self startElement: aQualifiedName attributes: aDictionary
]

{ #category : #content }
SAXHandler >> startElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName attributes: aDictionary [
	"This call corresonds to the Java SAX call
	startElement(java.lang.String namespaceURI, java.lang.String localName,
		java.lang.String qName, Attributes atts)."

	self
		invokeDeprecated: #startElement:namespaceURI:namespace:attributeList:
		withArguments: (Array with: aLocalName with: aUri with: aPrefix with: aDictionary)
		orForwardTo: #startElement:prefix:uri:attributes:
		withArguments: (Array with: aQualifiedName with: aPrefix with: aUri with: aDictionary).
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

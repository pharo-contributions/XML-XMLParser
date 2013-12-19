"
This class is an XML parser that uses event handling. The acronym ""SAX"" refers to Java's ""Simple API for XML,"" on which SAXHandler's API is based. To use this class, create a subclass and override handlers under the ""content"" and ""lexical"" categories as needed. By default, namespace support, validation, and external entity resolution are enabled.

To instantiate a SAXHandler, send any of the #on: or #parse- messages to the class.

The class-side #parse- messages take some input source and parse it immediately, returning the result of #parseDocument:
	SAXHandlerSubclass parse: xml.
	SAXHandlerSubclass parseURL: aUrl. 
	SAXHandlerSubclass parse: xml usingNamespaces: false

The #on: messages create new parsers on the given input string, stream, URL, or file and return it; the instance can then be further configured and ultimately sent #parseDocument to parse the given input:
	(SAXHandlerSubclass on: xml)
		isValidating: false;
		resolvesExternalEntities: false;
		parseDocument.

There is also #parseDocumentWhile: to stop parsing before the end.
	(SAXHandlerSubclass on: xml)
		parseDocumentWhile: [self shouldStopParsing not].

To parse incrementally, send #parser to an instance to get the underlying XMLParser object and send it #parseToken repeatedly:
	(handler := SAXHandlerSubclass on: xml)
		isValidating: false; 
		preservesUndeclaredEntityReferences: true.
	parser := handler parser.

	""Only parse the first 10 tokens:""
	10 timesRepeat: [parser parseToken].
"
Class {
	#name : #SAXHandler,
	#superclass : #Object,
	#instVars : [
		'input',
		'documentUri',
		'configuration',
		'elementNester',
		'scopeAllocator'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
SAXHandler class >> on: aStringOrStream [
	^ self new input: aStringOrStream
]

{ #category : #'instance creation' }
SAXHandler class >> on: aStringOrStream documentURI: aUri [
	^ self new
		input: aStringOrStream
		documentURI: aUri
]

{ #category : #'instance creation' }
SAXHandler class >> onFileNamed: aFileName [
	^ self
		on: (XMLFileClient defaultImplementation get: aFileName)
		documentURI: aFileName
]

{ #category : #'instance creation' }
SAXHandler class >> onURL: aUrlString [
	^ self
		on: (XMLHTTPClient defaultImplementation get: aUrlString)
		documentURI: aUrlString
]

{ #category : #parsing }
SAXHandler class >> parse: aStringOrStream [
	^ (self on: aStringOrStream) parseDocument
]

{ #category : #parsing }
SAXHandler class >> parse: aStringOrStream usingNamespaces: aBoolean [
	^ (self on: aStringOrStream)
		usesNamespaces: aBoolean;
		parseDocument
]

{ #category : #parsing }
SAXHandler class >> parse: aStringOrStream usingNamespaces: aNamespaceBoolean validation: aValidationBoolean [
	^ (self on: aStringOrStream)
		usesNamespaces: aNamespaceBoolean;
		isValidating: aValidationBoolean;
		parseDocument
]

{ #category : #parsing }
SAXHandler class >> parse: aStringOrStream usingNamespaces: aNamespaceBoolean validation: aValidationBoolean externalEntities: anEntityBoolean [
	^ (self on: aStringOrStream)
		usesNamespaces: aNamespaceBoolean;
		isValidating: aValidationBoolean;
		resolvesExternalEntities: anEntityBoolean;
		parseDocument
]

{ #category : #parsing }
SAXHandler class >> parseDocumentFrom: aStringOrStream [
	self deprecated: 'use #parse: instead'.

	^ self parse: aStringOrStream.
]

{ #category : #parsing }
SAXHandler class >> parseDocumentFrom: aStringOrStream useNamespaces: aBoolean [
	self deprecated: 'use #parse:usingNamespaces: instead'.

	^ self parse: aStringOrStream usingNamespaces: aBoolean.
]

{ #category : #parsing }
SAXHandler class >> parseFileNamed: aFileName [
	^ (self onFileNamed: aFileName) parseDocument
]

{ #category : #parsing }
SAXHandler class >> parseURL: aUrl [
	^ (self onURL: aUrl) parseDocument
]

{ #category : #declaration }
SAXHandler >> attributeDeclaration: anElement name: aName type: aType defaultDeclaration: aDefaultDeclaration [
]

{ #category : #content }
SAXHandler >> characters: aString [
	"This call corresponds to the Java SAX call
	characters(char[] ch, int start, int length)."
]

{ #category : #lexical }
SAXHandler >> comment: aCommentString [
	"This call corresponds to the Java SAX ext call
	comment(char[] ch, int start, int length)."
]

{ #category : #accessing }
SAXHandler >> configuration [
	^ configuration ifNil: [configuration := self configurationClass new]
]

{ #category : #accessing }
SAXHandler >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #private }
SAXHandler >> configurationClass [
	^ XMLConfiguration
]

{ #category : #accessing }
SAXHandler >> currentElement [
	^ self elementNester currentElement
]

{ #category : #accessing }
SAXHandler >> currentScope [
	^ self scopeAllocator currentScope
]

{ #category : #accessing }
SAXHandler >> currentScope: aScope [
	self scopeAllocator currentScope: aScope
]

{ #category : #private }
SAXHandler >> defaultDocumentURI [
	^ (input respondsTo: #path)
		ifTrue: [input path]
		ifFalse: [self externalEntityResolver defaultDocumentURI].
]

{ #category : #accessing }
SAXHandler >> documentURI [
	^ documentUri ifNil: [documentUri := self defaultDocumentURI]
]

{ #category : #private }
SAXHandler >> driverClass [
	^ SAXDriver
]

{ #category : #declaration }
SAXHandler >> elementDeclaration: aName contentModel: aContentModel [

]

{ #category : #private }
SAXHandler >> elementNester [
	^ elementNester ifNil: [elementNester := self elementNesterClass new]
]

{ #category : #private }
SAXHandler >> elementNesterClass [
	^ XMLWellFormedElementNester
]

{ #category : #lexical }
SAXHandler >> endCData [
	"This call corresponds to the Java SAX ext call
	endCData()."
]

{ #category : #declaration }
SAXHandler >> endDTD [

]

{ #category : #content }
SAXHandler >> endDocument [
	"This call corresponds to the Java SAX call
	endDocument()."
]

{ #category : #content }
SAXHandler >> endElement: aQualifiedName [

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

	self endElement: aQualifiedName prefix: aPrefix uri:  aUri
]

{ #category : #lexical }
SAXHandler >> endEntity: anEntityName [
	"This call corresponds to the Java SAX ext call
	endEntity(java.lang.String name)."
]

{ #category : #content }
SAXHandler >> endPrefixMapping: aPrefix [
	"This call corresonds to the Java SAX call
	endPrefixMapping(java.lang.String prefix)."
]

{ #category : #accessing }
SAXHandler >> externalEntityResolver [
	^ self configuration externalEntityResolver
]

{ #category : #accessing }
SAXHandler >> externalEntityResolver: anExternalEntityResolver [
	self configuration externalEntityResolver: anExternalEntityResolver
]

{ #category : #declaration }
SAXHandler >> generalEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
]

{ #category : #declaration }
SAXHandler >> generalEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #content }
SAXHandler >> ignorableWhitespace: aString [
	"This call corresonds to the Java SAX call
	ignorableWhitespace(char[] ch, int start, int length)."
]

{ #category : #private }
SAXHandler >> input [
	^ input
]

{ #category : #private }
SAXHandler >> input: aStringOrStream [
	input := aStringOrStream.
]

{ #category : #private }
SAXHandler >> input: aStringOrStream documentURI: aUri [
	input := aStringOrStream.
	documentUri := aUri.
]

{ #category : #testing }
SAXHandler >> isValidating [
	^ self configuration isValidating
]

{ #category : #accessing }
SAXHandler >> isValidating: aBoolean [
	"If true and a DTD is present, the document will
	be validated against it (default).
	Disabling also disables requiresDTDDeclarations."

	self configuration isValidating: aBoolean
]

{ #category : #declaration }
SAXHandler >> notationDeclaration: aName publicID: aPublicId systemID: aSytemId [

]

{ #category : #declaration }
SAXHandler >> parameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
]

{ #category : #declaration }
SAXHandler >> parameterEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #parsing }
SAXHandler >> parseDocument [
	self parser parseDocument.

	^ self parsingResult.
]

{ #category : #parsing }
SAXHandler >> parseDocumentWhile: aBlock [
	self parser parseDocumentWhile: aBlock.

	^ self parsingResult.
]

{ #category : #parsing }
SAXHandler >> parser [
	self configuration parserHandlerClass: self class.

	^ XMLParser
		driver: (self driverClass saxHandler: self)
		on: input.
]

{ #category : #parsing }
SAXHandler >> parsingResult [
	^ self
]

{ #category : #testing }
SAXHandler >> preservesUndeclaredEntityReferences [
	^ self configuration preservesUndeclaredEntityReferences
]

{ #category : #accessing }
SAXHandler >> preservesUndeclaredEntityReferences: aBoolean [
	self configuration preservesUndeclaredEntityReferences: aBoolean
]

{ #category : #content }
SAXHandler >> processingInstruction: aTarget data: aDataString [
	"This call corresonds to the Java SAX call
	processingInstruction(java.lang.String target, java.lang.String data)."
]

{ #category : #testing }
SAXHandler >> requiresDTDDeclarations [
	^ self configuration requiresDTDDeclarations
]

{ #category : #accessing }
SAXHandler >> requiresDTDDeclarations: aBoolean [
	"If true, a DTD with element and attribute declarations will be
	required (not default).
	Enabling also enables isValidating."

	self configuration requiresDTDDeclarations: aBoolean
]

{ #category : #testing }
SAXHandler >> resolvesExternalEntities [
	^ self configuration resolvesExternalEntities
]

{ #category : #accessing }
SAXHandler >> resolvesExternalEntities: aBoolean [
	self configuration resolvesExternalEntities: aBoolean
]

{ #category : #accessing }
SAXHandler >> rootElement [
	^ self elementNester rootElement
]

{ #category : #private }
SAXHandler >> scopeAllocator [
	^ scopeAllocator ifNil: [scopeAllocator := XMLNamespaceScopeAllocator new]
]

{ #category : #content }
SAXHandler >> skippedEntity: anEntityName [
	"This call corresonds to the Java SAX call
	skippedEntity(java.lang.String name)."
]

{ #category : #lexical }
SAXHandler >> startCData [
	"This call corresponds to the Java SAX ext call
	startCData()."
]

{ #category : #declaration }
SAXHandler >> startDTD: aRootElementName publicID: aPublicId systemID: aSystemId [
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
		startElement: aQualifiedName
		prefix: aPrefix
		uri: aUri
		attributes: aDictionary
]

{ #category : #lexical }
SAXHandler >> startEntity: anEntityName [
	"This call corresponds to the Java SAX ext call
	startEntity(java.lang.String name)."
]

{ #category : #content }
SAXHandler >> startPrefixMapping: aPrefix uri: aUri [
	"This call corresonds to the Java SAX call
	startPrefixMapping(java.lang.String prefix, java.lang.String uri)."
]

{ #category : #testing }
SAXHandler >> usesNamespaces [
	^ self configuration usesNamespaces
]

{ #category : #accessing }
SAXHandler >> usesNamespaces: aBoolean [
	self configuration usesNamespaces: aBoolean
]

{ #category : #content }
SAXHandler >> xmlVersion: aVersionFloat encoding: anEncoding standalone: aBoolean [

]

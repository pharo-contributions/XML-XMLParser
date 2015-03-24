"
This class is an XML parser that uses event handling. The acronym ""SAX"" refers to Java's ""Simple API for XML,"" on which SAXHandler's API is based. To use this class, create a subclass and override handlers under the handling ""content"" and ""lexical"" categories as needed. By default, namespace support and validation are enabled (but not external entity resolution).

To instantiate a SAXHandler, send any of the #on: or #parse- messages to a subclass.

The class-side #parse- messages take some input source and parse it immediately, returning the result of #parseDocument:
	SAXHandlerSubclass parse: xml.
	SAXHandlerSubclass parseURL: aUrl. 
	SAXHandlerSubclass parse: xml usingNamespaces: false

The #on: messages create new parsers on the given input string, stream, URL, or file and return it; the instance can then be further configured and ultimately sent #parseDocument to parse the given input:
	(SAXHandlerSubclass on: xml)
		isValidating: true;
		resolvesExternalEntities: true;
		parseDocument.

There is also #parseDocumentWhile: to stop parsing before the end.
	(SAXHandlerSubclass on: xml)
		parseDocumentWhile: [self shouldKeepParsing].

To parse incrementally, send #parser to an instance to get the underlying XMLParser object and send it #parseToken repeatedly:
	(handler := SAXHandlerSubclass on: xml)
		isValidating: false; 
		preservesUndeclaredEntityReferences: true.
	parser := handler parser.

	""Only parse the first 10 tokens:""
	10 timesRepeat: [parser parseToken].

There are security limits on input you can remove with #removeLimits or change with messages like #documentReadLimit:
	(SAXHandlerSubclass on: xml)
		removeLimits;
		documentReadLimit: newReadLimit;
		maxEntityReplacementDepth: newMaxEntityDepth;
		parseDocument.
"
Class {
	#name : #SAXHandler,
	#superclass : #Object,
	#instVars : [
		'input',
		'documentURI',
		'configuration',
		'isInContent',
		'isInCDataSection'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
SAXHandler class >> on: aStringOrStream [
	^ self new on: aStringOrStream
]

{ #category : #'instance creation' }
SAXHandler class >> on: aStringOrStream documentURI: aURIString [
	"Returns a new instance with associated base URI"

	^ self new
		on: aStringOrStream
		documentURI: aURIString
]

{ #category : #'instance creation' }
SAXHandler class >> onFileNamed: aFileName [
	^ self
		on: (XMLFileHandle path: aFileName) readStream
		documentURI: aFileName
]

{ #category : #'instance creation' }
SAXHandler class >> onURL: aURLString [
	"Fetches the URL and returns a new instance on the response"

	^ self
		onURL: aURLString
		upToLimit: XMLParserLimits defaultDocumentReadLimit
]

{ #category : #'instance creation' }
SAXHandler class >> onURL: aURLString upToLimit: aLimit [
	"Fetches the URL and returns a new instance on the response up
	to the input limit (use nil to disable)."

	^ (self
		on: (aURLString asXMLURI getUpToLimit: aLimit)
		documentURI: aURLString)
		documentReadLimit: aLimit
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

{ #category : #deprecated }
SAXHandler class >> parseDocumentFrom: aStringOrStream [
	self deprecated: 'use #parse: instead'.

	^ self parse: aStringOrStream.
]

{ #category : #parsing }
SAXHandler class >> parseFileNamed: aFileName [
	^ (self onFileNamed: aFileName) parseDocument
]

{ #category : #parsing }
SAXHandler class >> parseURL: aURLString [
	^ (self onURL: aURLString) parseDocument
]

{ #category : #'handling - declarations' }
SAXHandler >> attributeDeclaration: anElement name: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
]

{ #category : #'handling - content' }
SAXHandler >> characters: aString [
	"This call corresponds to the Java SAX call
	characters(char[] ch, int start, int length)."
]

{ #category : #'handling - lexical' }
SAXHandler >> comment: aCommentString [
	"This call corresponds to the Java SAX ext call
	comment(char[] ch, int start, int length)."
]

{ #category : #accessing }
SAXHandler >> configuration [
	^ configuration
]

{ #category : #accessing }
SAXHandler >> configuration: aConfiguration [
	(configuration := aConfiguration) parserHandlerClass: self class
]

{ #category : #private }
SAXHandler >> configurationClass [
	^ XMLConfiguration
]

{ #category : #private }
SAXHandler >> currentScope: aNamespaceScope [
]

{ #category : #private }
SAXHandler >> defaultDocumentURI [
	^ self externalEntityResolver defaultDocumentURI
]

{ #category : #private }
SAXHandler >> doctypeDefinition: aDoctypeDefinition [
]

{ #category : #configuring }
SAXHandler >> documentReadLimit [
	^ self configuration documentReadLimit
]

{ #category : #configuring }
SAXHandler >> documentReadLimit: aLimit [
	"change the document read limit or nil to disable"

	self configuration documentReadLimit: aLimit
]

{ #category : #accessing }
SAXHandler >> documentURI [
	^ documentURI ifNil: [documentURI := self defaultDocumentURI]
]

{ #category : #private }
SAXHandler >> driverClass [
	^ SAXParserDriver
]

{ #category : #'handling - declarations' }
SAXHandler >> elementDeclaration: aName contentModel: aContentModel [

]

{ #category : #'handling - lexical' }
SAXHandler >> endCData [
	"This call corresponds to the Java SAX ext call
	endCData()."
]

{ #category : #private }
SAXHandler >> endCDataSection [
	isInCDataSection := false
]

{ #category : #'handling - lexical' }
SAXHandler >> endDTD [

]

{ #category : #'handling - content' }
SAXHandler >> endDocument [
	"This call corresponds to the Java SAX call
	endDocument()."
]

{ #category : #'handling - content' }
SAXHandler >> endElement: aQualifiedName [

]

{ #category : #'handling - content' }
SAXHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI [
	"This call corresponds to the Java SAX call
	endElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName).
	By default this call is mapped to the following more convenient call:"

	self endElement: aQualifiedName
]

{ #category : #'handling - content' }
SAXHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName [
	"This call corresponds to the Java SAX call
	endElement(java.lang.String namespaceURI, java.lang.String localName, java.lang.String qName).
	By default this call is mapped to the following more convenient call:"

	self endElement: aQualifiedName prefix: aPrefix uri:  aURI
]

{ #category : #'handling - lexical' }
SAXHandler >> endEntity: anEntityName [
	"This call corresponds to the Java SAX ext call
	endEntity(java.lang.String name)."
]

{ #category : #'handling - content' }
SAXHandler >> endPrefixMapping: aPrefix [
	"This call corresonds to the Java SAX call
	endPrefixMapping(java.lang.String prefix)."
]

{ #category : #configuring }
SAXHandler >> externalEntityResolver [
	^ self configuration externalEntityResolver
]

{ #category : #configuring }
SAXHandler >> externalEntityResolver: anExternalEntityResolver [
	"This can be used to set a different DTDExternalEntityResolver"

	self configuration externalEntityResolver: anExternalEntityResolver
]

{ #category : #'handling - declarations' }
SAXHandler >> generalEntityDeclaration: aName publicID: aPublicID systemID: aSystemID ndata: aNotation [
]

{ #category : #'handling - declarations' }
SAXHandler >> generalEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #'handling - content' }
SAXHandler >> ignorableWhitespace: aString [
	"This call corresonds to the Java SAX call
	ignorableWhitespace(char[] ch, int start, int length)."
]

{ #category : #private }
SAXHandler >> input [
	^ input
]

{ #category : #parsing }
SAXHandler >> interruptParsing [
	"Can be sent within a handler to stop parsing;
	will be silently caught within parseDocument or other parsing methods"

	XMLParsingInterruptException signal
]

{ #category : #testing }
SAXHandler >> isInCDataSection [
	^ isInCDataSection
]

{ #category : #testing }
SAXHandler >> isInContent [
	^ isInContent
]

{ #category : #configuring }
SAXHandler >> isValidating [
	^ self configuration isValidating
]

{ #category : #configuring }
SAXHandler >> isValidating: aBoolean [
	"If true and document contstraints are present (in a DTD),
	the document will be checked against them (default).

	Enabling disables preservesUndeclaredEntityReferences.
	Disabling disables requiresDocumentConstraints."

	self configuration isValidating: aBoolean
]

{ #category : #configuring }
SAXHandler >> maxEntityReplacementDepth [
	^ self configuration maxEntityReplacementDepth
]

{ #category : #configuring }
SAXHandler >> maxEntityReplacementDepth: aLimit [
	"change the max replacement depth or nil to disable"

	self configuration maxEntityReplacementDepth: aLimit
]

{ #category : #'handling - declarations' }
SAXHandler >> notationDeclaration: aName publicID: aPublicID systemID: aSystemID [

]

{ #category : #initialization }
SAXHandler >> on: aStringOrStream [
	self
		on: aStringOrStream
		documentURI: nil
]

{ #category : #initialization }
SAXHandler >> on: aStringOrStream documentURI: aURI [
	input := aStringOrStream.
	documentURI := aURI.
	configuration
		ifNil: [self configuration: self configurationClass new].
	isInContent := false.
	isInCDataSection := false.
]

{ #category : #configuring }
SAXHandler >> optimizeForLargeDocuments [
	"faster parsing and less memory use for large documents"
	self
		isValidating: false;
		usesNamespaces: false;
		documentReadLimit: nil.
]

{ #category : #'handling - declarations' }
SAXHandler >> parameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
]

{ #category : #'handling - declarations' }
SAXHandler >> parameterEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #parsing }
SAXHandler >> parseDocument [
	"parser the entire input document"

	self parser parseDocument.

	^ self parsingResult.
]

{ #category : #parsing }
SAXHandler >> parseDocumentUntil: aBlock [
	"parse the input document until aBlock is true"

	self parser parseDocumentUntil: aBlock.

	^ self parsingResult.
]

{ #category : #parsing }
SAXHandler >> parseDocumentWhile: aBlock [
	"parse the input document while aBlock is true"

	self parser parseDocumentWhile: aBlock.

	^ self parsingResult.
]

{ #category : #parsing }
SAXHandler >> parser [
	"returns a new XMLParser object for this handler"

	^ self parserClass
		driver: (self driverClass saxHandler: self)
		on: self input
]

{ #category : #private }
SAXHandler >> parserClass [
	^ XMLParser
]

{ #category : #parsing }
SAXHandler >> parsingResult [
	"value returned by parseDocument and other parsing methods"

	^ self
]

{ #category : #configuring }
SAXHandler >> preservesUndeclaredEntityReferences [
	^ self configuration preservesUndeclaredEntityReferences
]

{ #category : #configuring }
SAXHandler >> preservesUndeclaredEntityReferences: aBoolean [
	"If true, references to undeclared entities in content are
	preserved (not default).
	Disables validation"

	self configuration preservesUndeclaredEntityReferences: aBoolean
]

{ #category : #'handling - content' }
SAXHandler >> processingInstruction: aTargetString data: aDataString [
	"This call corresonds to the Java SAX call
	processingInstruction(java.lang.String target, java.lang.String data)."
]

{ #category : #configuring }
SAXHandler >> removeLimits [
	"remove all input security limits (unsafe)"

	self configuration removeLimits
]

{ #category : #configuring }
SAXHandler >> replacesContentEntityReferences [
	^ self configuration replacesContentEntityReferences
]

{ #category : #configuring }
SAXHandler >> replacesContentEntityReferences: aBoolean [
	"Replace general parsed entity and character references
	in content (default)"

	self configuration replacesContentEntityReferences: aBoolean
]

{ #category : #configuring }
SAXHandler >> requiresDocumentConstraints [
	^ self configuration requiresDocumentConstraints
]

{ #category : #configuring }
SAXHandler >> requiresDocumentConstraints: aBoolean [
	"If true, constraints on elements and attributes (in a DTD)
	will be required (not default).
	Enables validation."

	self configuration requiresDocumentConstraints: aBoolean
]

{ #category : #configuring }
SAXHandler >> resolvesExternalEntities [
	^ self configuration resolvesExternalEntities
]

{ #category : #configuring }
SAXHandler >> resolvesExternalEntities: aBoolean [
	"When true, external DTDs and parsed entities will be
	fetched (not default)."

	self configuration resolvesExternalEntities: aBoolean
]

{ #category : #'handling - content' }
SAXHandler >> skippedEntity: anEntityName [
	"This call corresonds to the Java SAX call
	skippedEntity(java.lang.String name)."
]

{ #category : #'handling - lexical' }
SAXHandler >> startCData [
	"This call corresponds to the Java SAX ext call
	startCData()."
]

{ #category : #private }
SAXHandler >> startCDataSection [
	isInCDataSection := true
]

{ #category : #private }
SAXHandler >> startContent [
	isInContent := true
]

{ #category : #'handling - lexical' }
SAXHandler >> startDTD: aRootElementName publicID: aPublicID systemID: aSystemID [
	"This call corresponds to the Java SAX ext call
	startDTD(java.lang.String name, java.lang.String publicId, java.lang.String systemId)."
]

{ #category : #'handling - content' }
SAXHandler >> startDocument [
	"This call corresonds to the Java SAX call
	startDocument()."
]

{ #category : #'handling - content' }
SAXHandler >> startElement: aQualifiedName attributes: aDictionary [

]

{ #category : #'handling - content' }
SAXHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI attributes: aDictionary [
	self startElement: aQualifiedName attributes: aDictionary
]

{ #category : #'handling - content' }
SAXHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: aDictionary [
	"This call corresonds to the Java SAX call
	startElement(java.lang.String namespaceURI, java.lang.String localName,
		java.lang.String qName, Attributes atts)."

	self
		startElement: aQualifiedName
		prefix: aPrefix
		uri: aURI
		attributes: aDictionary
]

{ #category : #'handling - lexical' }
SAXHandler >> startEntity: anEntityName [
	"This call corresponds to the Java SAX ext call
	startEntity(java.lang.String name)."
]

{ #category : #'handling - content' }
SAXHandler >> startPrefixMapping: aPrefix uri: aURI [
	"This call corresonds to the Java SAX call
	startPrefixMapping(java.lang.String prefix, java.lang.String uri)."
]

{ #category : #configuring }
SAXHandler >> usesNamespaces [
	^ self configuration usesNamespaces
]

{ #category : #configuring }
SAXHandler >> usesNamespaces: aBoolean [
	"Namespace checking when true (default)"

	self configuration usesNamespaces: aBoolean
]

{ #category : #'handling - content' }
SAXHandler >> xmlVersion: aVersionFloat encoding: anEncoding standalone: aBoolean [

]

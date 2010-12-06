"
A SAXHandler is an XML parser that uses event handling. The acronym ""SAX"" refers to Java's ""Simple API for XML,"" on which SAXHandler's API is based. To use this class, create a subclass and override handlers in ""content"" and ""lexical"" as needed. To instantiate it you can send #on: or any of the #parse- messages. The former creates a new parser on the given input string or stream and returns it; the instance can then be further configured and sent #parseDocument to parse the input. The class-side #parse- messages take some input source and parse it immediately, returning the result of #parseDocument.

By default, namespace support is enabled.
"
Class {
	#name : #SAXHandler,
	#superclass : #Object,
	#instVars : [
		'input',
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
SAXHandler class >> onFileNamed: aFileName [
	^ self on: (FileStream readOnlyFileNamed: aFileName)
]

{ #category : #'instance creation' }
SAXHandler class >> parse: aStringOrStream [
	^ (self on: aStringOrStream) parseDocument
]

{ #category : #'instance creation' }
SAXHandler class >> parse: aStringOrStream usingNamespaces: aBoolean [
	^ (self on: aStringOrStream)
		usesNamespaces: aBoolean;
		parseDocument
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFrom: aStringOrStream [
	^ self parse: aStringOrStream.
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFrom: aStringOrStream useNamespaces: aBoolean [
	^ self parse: aStringOrStream usingNamespaces: aBoolean.
]

{ #category : #'instance creation' }
SAXHandler class >> parseDocumentFromFileNamed: aFileName [
	self deprecated: 'use #parseFileNamed: instead'.

	^ self parseFileNamed: aFileName.
]

{ #category : #'instance creation' }
SAXHandler class >> parseFileNamed: aFileName [
	^ (self onFileNamed: aFileName) parseDocument
]

{ #category : #'instance creation' }
SAXHandler class >> parserOnFileNamed: aFileName [
	self deprecated: 'use #onFileNamed: instead'.

	^ self onFileNamed: aFileName.
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

{ #category : #accessing }
SAXHandler >> elementNester [
	^ elementNester ifNil: [elementNester := XMLElementNester new]
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

	self
		invokeDeprecated: #endElement:namespace:namespaceURI:qualifiedName:
		withArguments: (Array with: aLocalName with: aPrefix with: aUri with: aQualifiedName)
		orForwardTo: #endElement:prefix:uri:
		withArguments: (Array with: aQualifiedName with: aPrefix with: aUri)
]

{ #category : #lexical }
SAXHandler >> endEntity: anEntityName [
	"This call corresponds to the Java SAX ext call
	endEntity(java.lang.String name)."
]

{ #category : #content }
SAXHandler >> endPrefixMapping: prefix [
	"This call corresonds to the Java SAX call
	endPrefixMapping(java.lang.String prefix)."
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
	^ self configuration isValidating
]

{ #category : #accessing }
SAXHandler >> isValidating: aBoolean [
	self configuration isValidating: aBoolean
]

{ #category : #parsing }
SAXHandler >> parseDocument [
	self parser parseDocument.

	"Result of parsing"
	^ self.
]

{ #category : #parsing }
SAXHandler >> parser [
	self configuration parserClass: self class.

	^ XMLParser
		driver: (SAXDriver saxHandler: self)
		on: input.
]

{ #category : #content }
SAXHandler >> processingInstruction: piName data: dataString [
	"This call corresonds to the Java SAX call
	processingInstruction(java.lang.String target, java.lang.String data)."
]

{ #category : #accessing }
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

{ #category : #lexical }
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
SAXHandler >> startEntity: anEntityName [
	"This call corresponds to the Java SAX ext call
	startEntity(java.lang.String name)."
]

{ #category : #content }
SAXHandler >> startPrefixMapping: aPrefix uri: aUri [
	"This call corresonds to the Java SAX call
	startPrefixMapping(java.lang.String prefix, java.lang.String uri)."
]

{ #category : #accessing }
SAXHandler >> useNamespaces: aBoolean [
	self deprecated: 'use #usesNamespaces: instead'.

	self usesNamespaces: aBoolean.
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
	self
		invokeDeprecated: #documentAttributes:
		withArguments:
			(Array with: (Dictionary
				with: 'version' -> aVersionFloat asString
				with: 'encoding' -> anEncoding))
		orForwardTo: nil
		withArguments: nil
]

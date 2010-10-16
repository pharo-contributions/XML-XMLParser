"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. A SAXDriver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages that handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLTokenizer,
	#instVars : [
		'saxHandler',
		'useNamespaces',
		'validateAttributes',
		'languageEnvironment',
		'scopeManager',
		'wellFormednessChecker'
	],
	#category : #'XML-Parser'
}

{ #category : #content }
SAXDriver >> activeSaxHandler [
	saxHandler eod
		ifTrue: [self errorExpected: 'No more data expected.'].
	^ saxHandler.
]

{ #category : #accessing }
SAXDriver >> currentScope [
	^ self usesNamespaces
		ifTrue: [self scopeManager currentScope]
		ifFalse: [nil]
]

{ #category : #namespaces }
SAXDriver >> declareNamespaces: aDictionary [
	aDictionary keysAndValuesDo: [:prefix :uri |
		self scopeManager declarePrefix: prefix uri: uri.
		self activeSaxHandler startPrefixMapping: prefix uri: uri]
]

{ #category : #errors }
SAXDriver >> errorBadPrefix: aPrefix inStartTag: aStartTag [
	XMLNamespaceException signal:
		'Start tag <', aStartTag, '> refers to unmapped prefix ', aPrefix
]

{ #category : #'handling tokens' }
SAXDriver >> handleCData: aString [
	self activeSaxHandler
		startCData;
		characters: aString;
		endCData
]

{ #category : #'handling tokens' }
SAXDriver >> handleComment: aString [
	self activeSaxHandler 
		comment: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndDocument [
	self wellFormednessChecker ensureNoElementsRemainOpen.
	self saxHandler endDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndTag: anElementName [
	| prefix localName namespaceURI |

	self wellFormednessChecker endedElement: anElementName.

	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart].
	self usesNamespaces
		ifTrue: [namespaceURI := self scopeManager resolvePrefix: prefix].

	self activeSaxHandler 
		endElement: anElementName
		prefix: prefix
		uri: namespaceURI
		localName: localName.

	self usesNamespaces
		ifTrue: [
			self undeclareNamespaces.
			self scopeManager exitScope].
]

{ #category : #'handling tokens' }
SAXDriver >> handlePCData: aString [
	self languageEnvironment
		ifNotNil: [aString applyLanguageInfomation: self languageEnvironment].
	self activeSaxHandler 
		characters: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handlePI: piTarget data: piData [
	self activeSaxHandler 
		processingInstruction: piTarget data: piData
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartDocument [
	self saxHandler startDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	| prefix localName namespaceURI |

	self wellFormednessChecker startedElement: anElementName.
	(anAttributeDictionary includesKey: 'xml:lang')
		ifTrue: [self languageEnvironment: (anAttributeDictionary at: 'xml:lang')].
	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart].

	self usesNamespaces ifTrue: [
		self scopeManager enterScope.
		self declareNamespaces: aNamespaceDictionary.
		namespaceURI := self scopeManager resolvePrefix: prefix.
		self
			validateStartTag: anElementName
			prefix: prefix
			attributes: anAttributeDictionary].

	self activeSaxHandler 
		startElement: anElementName
		prefix: prefix
		uri: namespaceURI
		localName: localName
		attributes: anAttributeDictionary
]

{ #category : #'handling tokens' }
SAXDriver >> handleWhitespace: aString [
	self activeSaxHandler 
		ignorableWhitespace: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleXMLDecl: attributes [
	self activeSaxHandler 
		documentAttributes: attributes
]

{ #category : #accessing }
SAXDriver >> languageEnvironment [
	^ languageEnvironment
]

{ #category : #accessing }
SAXDriver >> languageEnvironment: anIsoString [
	languageEnvironment := LanguageEnvironment localeID: (LocaleID isoString: anIsoString)
]

{ #category : #accessing }
SAXDriver >> saxHandler [
	^ saxHandler
]

{ #category : #accessing }
SAXDriver >> saxHandler: aHandler [
	saxHandler := aHandler
]

{ #category : #namespaces }
SAXDriver >> scopeManager [
	^ scopeManager ifNil: [scopeManager := XMLNamespaceScopeManager new]
]

{ #category : #namespaces }
SAXDriver >> undeclareNamespaces [
	| currentScope enclosingScope |

	currentScope := self scopeManager currentScope.
	currentScope hasNamespaces
		ifFalse: [^ self].
	enclosingScope := self scopeManager enclosingScope.

	currentScope prefixesAndURIsDo: [:prefix :uri |
		(enclosingScope includesPrefix: prefix mappedTo: uri)
			ifFalse: [self activeSaxHandler endPrefixMapping: prefix]].

	(currentScope defaultNamespace notNil
		and: [currentScope defaultNamespace ~= enclosingScope defaultNamespace])
		ifTrue: [self activeSaxHandler endPrefixMapping: 'xmlns']
]

{ #category : #accessing }
SAXDriver >> useNamespaces: aBoolean [
	useNamespaces := aBoolean
]

{ #category : #testing }
SAXDriver >> usesNamespaces [
	^ useNamespaces ifNil: [useNamespaces := false]
]

{ #category : #namespaces }
SAXDriver >> validateStartTag: aStartTag prefix: aPrefix attributes: attributeList [
	(aPrefix isEmpty or: [self scopeManager includesPrefix: aPrefix])
		ifFalse: [self errorBadPrefix: aPrefix inStartTag: aStartTag].

	self validatesAttributes
		ifTrue: [self scopeManager validatePrefixedAttributeNames: attributeList].
]

{ #category : #testing }
SAXDriver >> validatesAttributes [
	^ validateAttributes ifNil: [validateAttributes := true]
]

{ #category : #accessing }
SAXDriver >> wellFormednessChecker [
	^ wellFormednessChecker ifNil: [wellFormednessChecker := XMLWellFormednessChecker new]
]

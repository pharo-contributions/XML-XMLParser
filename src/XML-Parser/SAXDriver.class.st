"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. A SAXDriver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages that handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLTokenizer,
	#instVars : [
		'saxHandler',
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

{ #category : #accessing }
SAXDriver >> currentScope: aScope [
	self usesNamespaces
		ifTrue: [self scopeManager pushScope: aScope]
]

{ #category : #namespaces }
SAXDriver >> declareNamespaces: aDictionary [
	aDictionary keysAndValuesDo: [:prefix :uri |
		self scopeManager declarePrefix: prefix uri: uri.
		self activeSaxHandler startPrefixMapping: prefix uri: uri]
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
	| prefix localName namespaceUri |

	self wellFormednessChecker endedElement: anElementName.

	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart].
	self usesNamespaces
		ifTrue: [namespaceUri := self scopeManager resolvePrefix: prefix].

	self activeSaxHandler 
		endElement: anElementName
		prefix: prefix
		uri: namespaceUri
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
	| prefix localName namespaceUri |

	self wellFormednessChecker startedElement: anElementName.
	(anAttributeDictionary includesKey: 'xml:lang')
		ifTrue: [self languageEnvironment: (anAttributeDictionary at: 'xml:lang')].
	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart.
		namespaceUri := ''].

	self usesNamespaces ifTrue: [
		self scopeManager enterScope.
		self declareNamespaces: aNamespaceDictionary.
		namespaceUri := self scopeManager resolvePrefix: prefix.
		self
			validateStartTag: anElementName
			prefix: prefix
			attributes: anAttributeDictionary].

	self activeSaxHandler 
		startElement: anElementName
		prefix: prefix
		uri: namespaceUri
		localName: localName
		attributes: anAttributeDictionary
]

{ #category : #'handling tokens' }
SAXDriver >> handleWhitespace: aString [
	self activeSaxHandler 
		ignorableWhitespace: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	| versionNumber standaloneBoolean |

	aVersion
		ifNotEmpty: [versionNumber := aVersion asNumber].

	(#('yes' 'no') includes: aYesOrNo)
		ifTrue: [standaloneBoolean := aYesOrNo = 'yes'].

	self saxHandler
		xmlVersion: versionNumber
		encoding: anEncoding
		standalone: standaloneBoolean
]

{ #category : #testing }
SAXDriver >> isValidating [
	^ saxHandler configuration isValidating
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
		ifTrue: [self activeSaxHandler endPrefixMapping: '']
]

{ #category : #testing }
SAXDriver >> usesNamespaces [
	^ saxHandler configuration usesNamespaces
]

{ #category : #namespaces }
SAXDriver >> validateStartTag: aStartTag prefix: aPrefix attributes: anAttributeDictionary [
	aPrefix ifNotEmpty: [
		self scopeManager
			validatePrefix: aPrefix
			ofElementName: aStartTag].

	self scopeManager validatePrefixedAttributeNames: anAttributeDictionary.
]

{ #category : #accessing }
SAXDriver >> wellFormednessChecker [
	^ wellFormednessChecker ifNil: [wellFormednessChecker := XMLWellFormednessChecker new]
]

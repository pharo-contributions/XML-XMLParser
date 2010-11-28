"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. A SAXDriver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages that handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLDriver,
	#instVars : [
		'saxHandler',
		'configuration',
		'elementNester',
		'scopeAllocator',
		'languageEnvironment'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
SAXDriver class >> saxHandler: aHandler [
	^ self new
		setSaxHandler: aHandler
		configuration: aHandler configuration
		elementNester: aHandler elementNester
		scopeAllocator: aHandler scopeAllocator
]

{ #category : #accessing }
SAXDriver >> configuration [
	^ configuration
]

{ #category : #accessing }
SAXDriver >> currentScope [
	^ self usesNamespaces
		ifTrue: [self scopeAllocator currentScope]
		ifFalse: [nil]
]

{ #category : #namespaces }
SAXDriver >> declareNamespaces: aDictionary [
	aDictionary keysAndValuesDo: [:prefix :uri |
		self scopeAllocator declarePrefix: prefix uri: uri.
		self saxHandler startPrefixMapping: prefix uri: uri]
]

{ #category : #accessing }
SAXDriver >> elementNester [
	^ elementNester
]

{ #category : #'handling tokens' }
SAXDriver >> handleCData: aString [
	self saxHandler
		startCData;
		characters: aString;
		endCData
]

{ #category : #'handling tokens' }
SAXDriver >> handleComment: aString [
	self saxHandler 
		comment: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndDocument [
	self elementNester ensureNoElementsRemainOpen.
	self saxHandler endDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndTag: anElementName [
	| prefix localName namespaceUri |

	self elementNester endedElement: anElementName.

	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart].
	self usesNamespaces
		ifTrue: [namespaceUri := self scopeAllocator resolvePrefix: prefix].

	self saxHandler 
		endElement: anElementName
		prefix: prefix
		uri: namespaceUri
		localName: localName.

	self usesNamespaces
		ifTrue: [
			self undeclareNamespaces.
			self scopeAllocator exitScope].
]

{ #category : #'handling tokens' }
SAXDriver >> handlePCData: aString [
	self languageEnvironment
		ifNotNil: [aString applyLanguageInfomation: self languageEnvironment].
	self saxHandler 
		characters: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handlePI: piTarget data: piData [
	self saxHandler 
		processingInstruction: piTarget data: piData
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartDocument [
	self saxHandler startDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	| prefix localName namespaceUri |

	self elementNester startedElement: anElementName.
	(anAttributeDictionary includesKey: 'xml:lang')
		ifTrue: [self languageEnvironment: (anAttributeDictionary at: 'xml:lang')].
	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart.
		namespaceUri := ''].

	self usesNamespaces ifTrue: [
		self scopeAllocator enterScope.
		self declareNamespaces: aNamespaceDictionary.
		namespaceUri := self scopeAllocator resolvePrefix: prefix.
		self
			validateStartTag: anElementName
			prefix: prefix
			attributes: anAttributeDictionary].

	self saxHandler 
		startElement: anElementName
		prefix: prefix
		uri: namespaceUri
		localName: localName
		attributes: anAttributeDictionary
]

{ #category : #'handling tokens' }
SAXDriver >> handleWhitespace: aString [
	self saxHandler 
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
	^ self configuration isValidating
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
SAXDriver >> scopeAllocator [
	^ scopeAllocator
]

{ #category : #initialization }
SAXDriver >> setSaxHandler: aHandler configuration: aConfiguration elementNester: anElementNester scopeAllocator: aScopeAllocator [
	saxHandler := aHandler.
	configuration := aConfiguration.
	elementNester := anElementNester.
	scopeAllocator := aScopeAllocator.
]

{ #category : #namespaces }
SAXDriver >> undeclareNamespaces [
	| currentScope enclosingScope |

	currentScope := self scopeAllocator currentScope.
	currentScope hasNamespaces
		ifFalse: [^ self].
	enclosingScope := self scopeAllocator enclosingScope.

	currentScope prefixesAndURIsDo: [:prefix :uri |
		(enclosingScope includesPrefix: prefix mappedTo: uri)
			ifFalse: [self saxHandler endPrefixMapping: prefix]].

	(currentScope defaultNamespace notNil
		and: [currentScope defaultNamespace ~= enclosingScope defaultNamespace])
		ifTrue: [self saxHandler endPrefixMapping: '']
]

{ #category : #testing }
SAXDriver >> usesNamespaces [
	^ self configuration usesNamespaces
]

{ #category : #namespaces }
SAXDriver >> validateStartTag: aStartTag prefix: aPrefix attributes: anAttributeDictionary [
	aPrefix ifNotEmpty: [
		self scopeAllocator
			validatePrefix: aPrefix
			ofElementName: aStartTag].

	self scopeAllocator validatePrefixedAttributeNames: anAttributeDictionary.
]

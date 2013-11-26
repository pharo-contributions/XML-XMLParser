"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. A SAXDriver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages to handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxHandler',
		'configuration',
		'dtd',
		'validator',
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
SAXDriver >> documentURI [
	^ self saxHandler documentURI
]

{ #category : #accessing }
SAXDriver >> dtd [
	^ dtd ifNil: [dtd := DTDDoctypeDefinition new]
]

{ #category : #accessing }
SAXDriver >> elementNester [
	^ elementNester
]

{ #category : #accessing }
SAXDriver >> externalEntityResolver [
	^ self configuration externalEntityResolver
]

{ #category : #'handling tokens' }
SAXDriver >> handleAttributeDeclaration: anElement name: aName type: aType default: aDefaultDeclaration [
	self isValidating
		ifTrue: [
			self dtd
				parseAttributeDefinition: anElement
				name: aName
				type: aType
				default: aDefaultDeclaration].
	self saxHandler
		attributeDeclaration: anElement
		name: aName
		type: aType
		defaultDeclaration: aDefaultDeclaration
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
SAXDriver >> handleElementDeclaration: aName contentModel: aContentModel [
	self isValidating
		ifTrue: [
			self dtd
				parseContentModel: aContentModel
				for: aName].

	self saxHandler
		elementDeclaration: aName
		contentModel: aContentModel
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndContentEntityReplacement: aName [
	self saxHandler endEntity: aName
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndDTD [
	self saxHandler endDTD
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndDocument [
	self elementNester ensureNoElementsRemainOpen.
	self isValidating
		ifTrue: [self validator validateIDsAndReferences].

	self saxHandler endDocument.
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndTag: anElementName [
	| prefix localName namespaceUri |

	self elementNester endedElement: anElementName.

	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart].
	namespaceUri :=
		self usesNamespaces
			ifTrue: [self scopeAllocator resolvePrefix: prefix]
			ifFalse: [''].

	self saxHandler 
		endElement: anElementName
		prefix: prefix
		uri: namespaceUri
		localName: localName.

	self validateEndTag: anElementName.
]

{ #category : #'handling tokens' }
SAXDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	aNotation
		ifNotEmpty: [self dtd unparsedEntityAt: aName put: aNotation]
		ifEmpty: [
			self resolvesExternalEntities
				ifTrue: [
					self dtd
						generalEntityAt: aName
						put: (self externalEntityResolver
							resolveGeneralEntity: aName
							uri: aSystemId
							from: self documentURI)]].

	self saxHandler
		generalEntityDeclaration: aName
		publicID: aPublicId
		systemID: aSystemId
		ndata: aNotation.
]

{ #category : #'handling tokens' }
SAXDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self dtd
		generalEntityAt: aName
		put:
			(DTDGeneralEntity
				name: aName
				replacement: aReplacement).

	self saxHandler
		generalEntityDeclaration: aName
		replacement: aReplacement
]

{ #category : #'handling tokens' }
SAXDriver >> handleGeneralEntityReference: aName [
	| entity |

	(entity := self dtd generalEntityAt: aName)
		ifNil: [
			self isValidating
				ifTrue: [
					XMLValidationException signal:
						'Undeclared general entity reference &', aName, ';'].
			self saxHandler skippedEntity: aName].
	^ entity.
]

{ #category : #'handling tokens' }
SAXDriver >> handleNotationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self isValidating
		ifTrue: [self dtd addNotation: aName].

	self saxHandler
		notationDeclaration: aName
		publicID: aPublicId
		systemID: aSystemId.
]

{ #category : #'handling tokens' }
SAXDriver >> handlePCData: aString [
	self languageEnvironment
		ifNotNil: [aString applyLanguageInfomation: self languageEnvironment].
	self isValidating
		ifTrue: [self  validator validatePCData: aString].

	self saxHandler 
		characters: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handlePI: piTarget data: piData [
	self saxHandler 
		processingInstruction: piTarget data: piData
]

{ #category : #'handling tokens' }
SAXDriver >> handleParameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self resolvesExternalEntities
		ifTrue: [
			self dtd
				parameterEntityAt: aName
				put: (self externalEntityResolver
					resolveParameterEntity: aName
					uri: aSystemId
					from: self documentURI)].

	self saxHandler
		parameterEntityDeclaration: aName
		publicID: aPublicId
		systemID: aSystemId
]

{ #category : #'handling tokens' }
SAXDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self dtd
		parameterEntityAt: aName
		put:
			(DTDParameterEntity
				name: aName
				replacement:aReplacement).

	self saxHandler
		parameterEntityDeclaration: aName
		replacement: aReplacement
]

{ #category : #'handling tokens' }
SAXDriver >> handleParameterEntityReference: aName [
	| entity |

	(entity := self dtd parameterEntityAt: aName)
		ifNil: [
			self isValidating
				ifTrue: [
					XMLValidationException signal:
						'Undeclared parameter entity reference %', aName, ';'].
			self saxHandler skippedEntity: aName].
	^ entity.
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartContentEntityReplacement: aName [
	^ self saxHandler startEntity: aName
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartDTD: aRoot publicID: aPublicId systemID: aSystemId [
	self dtd rootElement: aRoot.
	(self resolvesExternalEntities
		and: [aSystemId notEmpty
			and: [self dtd isStandalone not]])
		ifTrue: [self parseExternalSubset: aSystemId].
	
	self saxHandler
		startDTD: aRoot
		publicID: aPublicId
		systemID: aSystemId
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
		localName := localPart].

	self
		validateStartTag: anElementName
		prefix: prefix
		attributes: anAttributeDictionary
		namespaces: aNamespaceDictionary.
	namespaceUri :=
		self usesNamespaces
			ifTrue: [self scopeAllocator resolvePrefix: prefix]
			ifFalse: [''].

	self saxHandler 
		startElement: anElementName
		prefix: prefix
		uri: namespaceUri
		localName: localName
		attributes: anAttributeDictionary
]

{ #category : #'handling tokens' }
SAXDriver >> handleUnparsedEntityReference: aName [
	| notationName |

	notationName := self dtd unparsedEntityAt: aName.
	self isValidating
		ifTrue: [
			notationName
				ifNil: [XMLValidationException signal: 'Undeclared unparsed entity reference &', aName, ';'].
			(self dtd includesNotation: notationName)
				ifFalse: [XMLValidationException signal: 'Undeclared notation "', notationName, '"']].
	^ notationName.

	
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

	standaloneBoolean := aYesOrNo asLowercase = 'yes'.
	self dtd isStandalone: standaloneBoolean.

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

{ #category : #'handling tokens' }
SAXDriver >> parseExternalSubset: aUri [
	| absoluteUri parser |

	absoluteUri :=
		self externalEntityResolver
			entityURIFromRelative: aUri
			andBase: self documentURI.
	parser :=
		XMLParser
			driver:
				(DTDExternalSubsetDriver
					saxDriver: self
					documentURI: absoluteUri)
			on: (self externalEntityResolver resolveEntity: absoluteUri).
	parser parseDocument.
]

{ #category : #testing }
SAXDriver >> resolvesExternalEntities [
	^ self configuration resolvesExternalEntities
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

{ #category : #validation }
SAXDriver >> validateEndTag: anEndTag [
	self usesNamespaces
		ifTrue: [
			self undeclareNamespaces.
			self scopeAllocator exitScope].
	self isValidating
		ifTrue: [self validator validateEndTag: anEndTag].
]

{ #category : #validation }
SAXDriver >> validateRootElement: aStartTag [
	(self dtd rootElement isEmpty
		or: [aStartTag = self dtd rootElement])
		ifTrue: [^ self].

	XMLValidationException signal: 'Element <', aStartTag, '> cannot be root'.
]

{ #category : #validation }
SAXDriver >> validateStartTag: aStartTag prefix: aPrefix attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	self usesNamespaces
		ifTrue: [
			self scopeAllocator enterScope.
			aNamespaceDictionary
				ifNotEmpty: [self declareNamespaces: aNamespaceDictionary].
		aPrefix ifNotEmpty: [
			self scopeAllocator
				validatePrefix: aPrefix
				ofElementName: aStartTag].
		self scopeAllocator validatePrefixedAttributeNames: anAttributeDictionary].

	self isValidating
		ifTrue: [
			self elementNester totalOpen > 1
				ifFalse: [self validateRootElement: aStartTag].
		
			self validator
				validateStartTag: aStartTag
				attributes: anAttributeDictionary].
]

{ #category : #accessing }
SAXDriver >> validator [
	^ validator ifNil: [validator := DTDDocumentValidator dtd: self dtd]
]

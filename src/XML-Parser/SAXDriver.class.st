"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. A SAXDriver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages to handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxHandler',
		'dtd',
		'validator'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
SAXDriver class >> saxHandler: aHandler [
	^ self new setSaxHandler: aHandler
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
	^ saxHandler elementNester
]

{ #category : #'element nesting' }
SAXDriver >> endNestingOfElement: anElementName [
	self elementNester endElement: anElementName
]

{ #category : #accessing }
SAXDriver >> externalEntityResolver [
	^ saxHandler externalEntityResolver
]

{ #category : #private }
SAXDriver >> externalSubsetParserOnURI: aUri [
	^ XMLParser
		driver:
			(DTDExternalSubsetDriver
				saxDriver: self
				documentURI: aUri)
		on: (self externalEntityResolver resolveEntity: aUri)
	
]

{ #category : #'handling tokens' }
SAXDriver >> handleAttributeDeclaration: anElement name: aName type: aType default: aDefaultDeclaration [
	self isValidating
		ifTrue: [
			self dtd
				addValidatorForAttributeIn: anElement
				named: aName
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
	self saxHandler comment: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleElementDeclaration: aName contentModel: aContentModel [
	self isValidating
		ifTrue: [
			self dtd
				addValidatorForElement: aName
				contentModel: aContentModel].

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
	self endNestingOfElement: anElementName.

	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		self saxHandler 
			endElement: anElementName
			prefix: prefixPart
			uri:
				(self usesNamespaces
					ifTrue: [self scopeAllocator resolvePrefix: prefixPart]
					ifFalse: [''])
			localName: localPart.

		self validateEndTag: anElementName].
]

{ #category : #'handling tokens' }
SAXDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	aNotation
		ifNotEmpty: [
			self dtd
				addUnparsedEntity: aName
				ndata: aNotation]
		ifEmpty: [
			self resolvesExternalEntities
				ifTrue: [
					self dtd
						addExternalGeneralEntity: aName
						resolver: self externalEntityResolver
						uri: aSystemId
						from: self currentURI]].

	self saxHandler
		generalEntityDeclaration: aName
		publicID: aPublicId
		systemID: aSystemId
		ndata: aNotation.
]

{ #category : #'handling tokens' }
SAXDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self dtd
		addGeneralEntity: aName
		replacement: aReplacement
		from: self currentURI.

	self saxHandler
		generalEntityDeclaration: aName
		replacement: aReplacement.
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
			self preservesUndeclaredEntityReferences
				ifTrue: [entity := DTDBypassedGeneralEntity named: aName].
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
				addExternalParameterEntity: aName
				resolver: self externalEntityResolver
				uri: aSystemId
				from: self currentURI].

	self saxHandler
		parameterEntityDeclaration: aName
		publicID: aPublicId
		systemID: aSystemId.
]

{ #category : #'handling tokens' }
SAXDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self dtd
		addParameterEntity: aName
		replacement:aReplacement
		from: self currentURI.

	self saxHandler
		parameterEntityDeclaration: aName
		replacement: aReplacement.
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
			self preservesUndeclaredEntityReferences
				ifTrue: [entity := DTDBypassedParameterEntity named: aName].
			self saxHandler skippedEntity: aName].
	^ entity.
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartContentEntityReplacement: aName [
	self saxHandler startEntity: aName
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
	self startNestingOfElement: anElementName.

	anElementName splitQualifiedNameInto: [:prefixPart :localPart |
		self
			validateStartTag: anElementName
			prefix: prefixPart
			attributes: anAttributeDictionary
			namespaces: aNamespaceDictionary.

		self saxHandler 
			startElement: anElementName
			prefix: prefixPart
			uri:
				(self usesNamespaces
					ifTrue: [self scopeAllocator resolvePrefix: prefixPart]
					ifFalse: [''])
			localName: localPart
			attributes: anAttributeDictionary].
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
	self saxHandler ignorableWhitespace: aString
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
	^ saxHandler isValidating
]

{ #category : #private }
SAXDriver >> parseExternalSubset: aUri [
	| parser |

	parser :=
		self externalSubsetParserOnURI:
			(self externalEntityResolver
				entityURIFromRelative: aUri
				andBase: self documentURI).
	parser parseDocument.
]

{ #category : #testing }
SAXDriver >> preservesUndeclaredEntityReferences [
	^ saxHandler preservesUndeclaredEntityReferences
]

{ #category : #testing }
SAXDriver >> resolvesExternalEntities [
	^ saxHandler resolvesExternalEntities
]

{ #category : #accessing }
SAXDriver >> saxHandler [
	^ saxHandler
]

{ #category : #accessing }
SAXDriver >> scopeAllocator [
	^ saxHandler scopeAllocator
]

{ #category : #initialization }
SAXDriver >> setSaxHandler: aHandler [
	saxHandler := aHandler
]

{ #category : #'element nesting' }
SAXDriver >> startNestingOfElement: anElementName [
	self elementNester startElement: anElementName
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
	^ saxHandler usesNamespaces
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
	(self saxHandler requiresDTDDeclarations
		and: [self validator hasElementValidators not])
		ifTrue: [
			XMLValidationException signal:
				'DTD with element and attribute declarations required'].

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
				ifNotNil: [self declareNamespaces: aNamespaceDictionary].

			aPrefix
				ifNotEmpty: [
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

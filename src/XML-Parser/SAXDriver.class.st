"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. The driver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages to handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxHandler',
		'elementNester',
		'scopeAllocator',
		'dtd',
		'validator'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
SAXDriver class >> saxHandler: aHandler [
	^ self new saxHandler: aHandler
]

{ #category : #accessing }
SAXDriver >> currentElement [
	^ self elementNester currentElement
]

{ #category : #accessing }
SAXDriver >> currentScope [
	^ self usesNamespaces
		ifTrue: [self scopeAllocator currentScope]
		ifFalse: [nil]
]

{ #category : #accessing }
SAXDriver >> currentScope: aNamespaceScope [
	self usesNamespaces
		ifTrue: [self scopeAllocator currentScope: aNamespaceScope]
]

{ #category : #namespaces }
SAXDriver >> declareNamespaces: aDictionary inScope: aScope [
	aDictionary keysAndValuesDo: [:prefix :uri |
		aScope mapPrefix: prefix to: uri.
		self saxHandler startPrefixMapping: prefix uri: uri]
]

{ #category : #accessing }
SAXDriver >> documentReadLimit [
	^ self saxHandler documentReadLimit
]

{ #category : #accessing }
SAXDriver >> documentURI [
	^ self saxHandler documentURI
]

{ #category : #accessing }
SAXDriver >> dtd [
	^ dtd ifNil: [dtd := DTDDoctypeDefinition new]
]

{ #category : #private }
SAXDriver >> elementNester [
	^ elementNester ifNil: [elementNester := self elementNesterClass new]
]

{ #category : #private }
SAXDriver >> elementNesterClass [
	^ XMLWellFormedElementNester
]

{ #category : #private }
SAXDriver >> endNestingOfElement: anElementName withScopedAttributes: anAttributeDictionary [
	| base |

	(base := anAttributeDictionary at: 'xml:base' ifAbsent: [nil])
		ifNotNil: [
			(self elementNester
				endElement: anElementName;
				scopedAttributeAt: 'xml:base') = base
				ifFalse: [self removeURI: base]]
		ifNil: [self elementNester endElement: anElementName]
]

{ #category : #accessing }
SAXDriver >> externalEntityResolver [
	^ self saxHandler externalEntityResolver
]

{ #category : #private }
SAXDriver >> externalSubsetParserOnURI: aUri [
	^ XMLParser
		driver:
			(DTDExternalSubsetParserDriver
				saxDriver: self
				documentURI: aUri asString)
		on: (self externalEntityResolver resolveEntityURI: aUri)
	
]

{ #category : #accessing }
SAXDriver >> externalSubsetReadLimit [
	^ self saxHandler externalSubsetReadLimit
]

{ #category : #'handling tokens' }
SAXDriver >> handleAttributeDeclaration: anElement name: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self isValidating
		ifTrue: [
			self dtd
				addValidatorForAttributeIn: anElement
				named: aName
				type: aType
				defaultPragma: aDefaultPragma
				defaultValue: aDefaultValue].
	self saxHandler
		attributeDeclaration: anElement
		name: aName
		type: aType
		defaultPragma: aDefaultPragma
		defaultValue: aDefaultValue
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
	(self saxHandler resolvesExternalEntities
		and: [self dtd hasExternalSubset])
		ifTrue: [self parseExternalSubset: self dtd externalSubsetURI].

	self saxHandler endDTD.
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndDocument [
	self elementNester endNesting.
	self isValidating
		ifTrue: [self validator validateEndDocument].

	self saxHandler endDocument.
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndTag: anElementName [
	"performance critical method"
	| prefix currentScope |

	self elementNester hasScopedAttributes
		ifTrue: [
			self
				endNestingOfElement: anElementName
				withScopedAttributes: self elementNester currentScopedAttributes]
		ifFalse: [self elementNester endElement: anElementName].

	prefix := anElementName qualifiedNamePrefix.
	self saxHandler 
		endElement: anElementName
		prefix: prefix
		uri:
			(self usesNamespaces
				ifTrue: [
					currentScope := self scopeAllocator exitScope.
					currentScope resolvePrefix: prefix]
				ifFalse: [''])
		localName: (anElementName qualifiedNameLocalPart: prefix).

	(currentScope notNil and: [currentScope hasNamespaces])
		ifTrue: [self undeclareNamespacesInScope: currentScope].
	self isValidating
		ifTrue: [self validator validateEndTag: anElementName].
]

{ #category : #'handling tokens' }
SAXDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	aNotation
		ifNotEmpty: [
			self dtd
				addUnparsedEntity: aName
				ndata: aNotation]
		ifEmpty: [
			self saxHandler resolvesExternalEntities
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
				ifTrue: [(XMLValidationException undeclaredGeneralEntity: aName) signal].
			self saxHandler preservesUndeclaredEntityReferences
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
		ifTrue: [self validator validatePCData: aString].

	self saxHandler characters: aString.
]

{ #category : #'handling tokens' }
SAXDriver >> handlePI: piTarget data: piData [
	self saxHandler 
		processingInstruction: piTarget
		data: piData
]

{ #category : #'handling tokens' }
SAXDriver >> handleParameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self saxHandler resolvesExternalEntities
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
				ifTrue: [(XMLValidationException undeclaredParameterEntity: aName) signal].
			self saxHandler preservesUndeclaredEntityReferences
				ifTrue: [entity := DTDBypassedParameterEntity named: aName]].
	^ entity.
]

{ #category : #'handling tokens' }
SAXDriver >> handleReservedAttributes: anAttributeDictionary [
	(anAttributeDictionary at: 'xml:base' ifAbsent: [nil])
		ifNotNil: [:uri | self currentURI: uri].
	self isValidating
		ifTrue: [self validator validateXMLIDAttributeIn: anAttributeDictionary].

	self elementNester
		setScopedAttributesNamed: #('xml:space' 'xml:base' 'xml:lang')
		from: anAttributeDictionary.
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartContentEntityReplacement: aName [
	self saxHandler startEntity: aName
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartDTD: aRoot publicID: aPublicId systemID: aSystemId [
	self dtd
		rootElement: aRoot
		externalSubsetURI: aSystemId.
	
	self saxHandler
		startDTD: aRoot
		publicID: aPublicId
		systemID: aSystemId.
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartDocument [
	self saxHandler startDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	"performance critical method"
	| prefix namespaceUri currentScope |

	self elementNester startElement: anElementName.

	prefix := anElementName qualifiedNamePrefix.
	self usesNamespaces
		ifTrue: [
			currentScope := self scopeAllocator enterScope.
			aNamespaceDictionary
				ifNotNil: [self declareNamespaces: aNamespaceDictionary inScope: currentScope].
			namespaceUri :=
				currentScope
					validateAndResolvePrefix: prefix
					ofName: anElementName.
			anAttributeDictionary isEmpty "avoid ifNotEmpty: closure overhead"
				ifFalse: [currentScope validateAttributePrefixes: anAttributeDictionary]].
	self isValidating
		ifTrue: [self validateStartTag: anElementName attributes: anAttributeDictionary].

	self saxHandler
		startElement: anElementName
		prefix: prefix
		uri: (namespaceUri ifNil: [''])
		localName: (anElementName qualifiedNameLocalPart: prefix)
		attributes: anAttributeDictionary.
	currentScope
		ifNotNil: [self saxHandler currentScope: currentScope].
]

{ #category : #'handling tokens' }
SAXDriver >> handleUnparsedEntityReference: aName [
	| notationName |

	notationName := self dtd unparsedEntityAt: aName.
	self isValidating
		ifTrue: [
			notationName
				ifNil: [(XMLValidationException undeclaredUnparsedEntity: aName) signal].
			(self dtd includesNotation: notationName)
				ifFalse: [XMLValidationException signal: 'Undeclared notation "', notationName, '"']].
	^ notationName.

	
]

{ #category : #'handling tokens' }
SAXDriver >> handleWhitespace: aString [
	(self elementNester hasScopedAttributes
		and: [(self elementNester scopedAttributeAt: 'xml:space') = 'preserve'])
		ifTrue: [self saxHandler characters: aString]
		ifFalse: [self saxHandler ignorableWhitespace: aString]
]

{ #category : #'handling tokens' }
SAXDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	| versionNumber standaloneBoolean |

	aVersion ifNotEmpty: [versionNumber := aVersion asNumber].
	standaloneBoolean := aYesOrNo = 'yes'.

	self dtd isStandalone: standaloneBoolean.

	self saxHandler
		xmlVersion: versionNumber
		encoding: anEncoding
		standalone: standaloneBoolean
]

{ #category : #testing }
SAXDriver >> isValidating [
	^ self saxHandler isValidating
]

{ #category : #accessing }
SAXDriver >> maxEntityReplacementDepth [
	^ self saxHandler maxEntityReplacementDepth
]

{ #category : #private }
SAXDriver >> parseExternalSubset: aUri [
	| parser |

	parser :=
		self externalSubsetParserOnURI:
			(self externalEntityResolver
				combineURI: self documentURI
				with: aUri).
	parser parseDocument.
]

{ #category : #accessing }
SAXDriver >> readLimit [
	^ self documentReadLimit
]

{ #category : #accessing }
SAXDriver >> rootElement [
	^ self elementNester rootElement
]

{ #category : #accessing }
SAXDriver >> rootElement: anElementName [
	self elementNester rootElement: anElementName
]

{ #category : #accessing }
SAXDriver >> saxHandler [
	^ saxHandler
]

{ #category : #accessing }
SAXDriver >> saxHandler: aHandler [
	saxHandler := aHandler
]

{ #category : #private }
SAXDriver >> scopeAllocator [
	^ scopeAllocator ifNil: [scopeAllocator := XMLNamespaceScopeAllocator new]
]

{ #category : #namespaces }
SAXDriver >> undeclareNamespacesInScope: aScope [
	| currentScope |

	currentScope := self scopeAllocator currentScope.
	aScope prefixesAndURIsDo: [:prefix :uri |
		(currentScope includesPrefix: prefix mappedTo: uri)
			ifFalse: [self saxHandler endPrefixMapping: prefix]].

	(aScope defaultNamespace ~= currentScope defaultNamespace)
		ifTrue: [self saxHandler endPrefixMapping: ''].
]

{ #category : #testing }
SAXDriver >> usesNamespaces [
	^ self saxHandler usesNamespaces
]

{ #category : #private }
SAXDriver >> validateRootElement: aStartTag [
	(self saxHandler requiresDocumentConstraints
		and: [self validator hasElementValidators not])
		ifTrue: [XMLValidationException signal: 'Document validation constraints required'].

	self validator validateRootElement: aStartTag.
]

{ #category : #private }
SAXDriver >> validateStartTag: aStartTag attributes: anAttributeDictionary [
	self elementNester totalOpen > 1
		ifFalse: [self validateRootElement: aStartTag].

	self validator
		validateStartTag: aStartTag
		attributes: anAttributeDictionary.
]

{ #category : #accessing }
SAXDriver >> validator [
	^ validator ifNil: [validator := DTDDocumentValidator dtd: self dtd]
]

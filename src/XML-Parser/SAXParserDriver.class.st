"
SAXParserDriver together with SAXHandler provides a SAX-like API for XML parsing. The driver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages to handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXParserDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxHandler',
		'elementNester',
		'scopeAllocator',
		'dtd',
		'validator',
		'hasUnhandledReservedAttributes'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
SAXParserDriver class >> saxHandler: aHandler [
	^ self new setSAXHandler: aHandler
]

{ #category : #private }
SAXParserDriver >> checkForReservedAttributesIn: anAttributeDictionary after: anIndex [
	"validation may add attributes"
	self hasUnhandledReservedAttributes
		ifFalse: [
			anIndex + 1
				to: anAttributeDictionary size
				do: [:i |
					(anAttributeDictionary keyAtIndex: i) isReservedAttributeName
						ifTrue: [^ self haveUnhandledReservedAttributes]]]
]

{ #category : #accessing }
SAXParserDriver >> currentElement [
	^ self elementNester currentElement
]

{ #category : #private }
SAXParserDriver >> declareNamespaces: aDictionary inScope: aScope [
	aDictionary keysAndValuesDo: [:prefix :uri |
		aScope mapPrefix: prefix to: uri.
		self saxHandler startPrefixMapping: prefix uri: uri]
]

{ #category : #accessing }
SAXParserDriver >> documentReadLimit [
	^ self saxHandler documentReadLimit
]

{ #category : #accessing }
SAXParserDriver >> documentURI [
	^ self saxHandler documentURI
]

{ #category : #accessing }
SAXParserDriver >> dtd [
	^ dtd ifNil: [dtd := DTDDoctypeDefinition new]
]

{ #category : #accessing }
SAXParserDriver >> elementNester [
	^ elementNester
]

{ #category : #private }
SAXParserDriver >> elementNesterClass [
	^ XMLWellFormedElementNester
]

{ #category : #private }
SAXParserDriver >> endNestingOfElement: anElementName withScopedAttributes: anAttributeDictionary [
	| base |

	base :=
		anAttributeDictionary
			at: 'xml:base'
			ifAbsent: [
				self elementNester endElement: anElementName.
				^ self].
	(self elementNester
		endElement: anElementName;
		scopedAttributeAt: 'xml:base') = base
			ifFalse: [self removeURI: base].
]

{ #category : #private }
SAXParserDriver >> errorCharacterDataOutsideElement [
	XMLWellFormednessException signal: 'Character data outside of element'
]

{ #category : #private }
SAXParserDriver >> errorDocumentConstraintsRequired [
	XMLValidationException signal: 'Document validation constraints required'
]

{ #category : #private }
SAXParserDriver >> errorUndeclaredGeneralEntity: aName [
	XMLValidationException
		formatSignal: 'Undeclared general entity reference &{1};'
		with: aName
]

{ #category : #private }
SAXParserDriver >> errorUndeclaredNotation: aNotation referencedBy: anEntity [
	XMLValidationException
		formatSignal: 'Undeclared notation "{1}" referenced by &{2}; entity'
		with: aNotation
		with: anEntity
]

{ #category : #private }
SAXParserDriver >> errorUndeclaredParameterEntity: aName [
	XMLValidationException
		formatSignal: 'Undeclared parameter entity reference %{1};'
		with: aName
]

{ #category : #private }
SAXParserDriver >> errorUndeclaredUnparsedEntity: aName [
	XMLValidationException
		formatSignal: 'Undeclared unparsed entity reference &{1}; as attribute value'
		with: aName
]

{ #category : #accessing }
SAXParserDriver >> externalEntityResolver [
	^ self saxHandler externalEntityResolver
]

{ #category : #private }
SAXParserDriver >> externalSubsetParserOnURI: aUri [
	^ self saxHandler parserClass
		driver:
			(DTDExternalSubsetParserDriver
				saxDriver: self
				documentURI: aUri asString)
		on: (self externalEntityResolver resolveEntityURI: aUri)
	
]

{ #category : #accessing }
SAXParserDriver >> externalSubsetReadLimit [
	^ self saxHandler externalSubsetReadLimit
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleAttributeDeclaration: anElement name: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
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
SAXParserDriver >> handleCData: aString [
	self elementNester isInElement
		ifFalse: [self errorCharacterDataOutsideElement].
	self isValidating
		ifTrue: [self validator validatePCData: aString].

	self saxHandler
		startCData;
		startCDataSection;
		characters: aString;
		endCDataSection;
		endCData.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleComment: aString [
	self saxHandler comment: aString
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleElementDeclaration: aName contentModel: aContentModel [
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
SAXParserDriver >> handleEndContentEntityReplacement: aName [
	self saxHandler endEntity: aName
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleEndDTD [
	(self resolvesExternalEntities
		and: [self dtd hasExternalSubset])
		ifTrue: [self parseExternalSubset: self dtd externalSubsetURI].

	self saxHandler
		endInternalSubset;
		endDTD.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleEndDocument [
	self elementNester endNesting.
	self isValidating
		ifTrue: [self validator validateEndDocument].

	self saxHandler endDocument.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleEndTag: anElementName [
	"performance critical method"
	| prefix currentScope |

	self elementNester hasScopedAttributes
		ifTrue: [
			self
				endNestingOfElement: anElementName
				withScopedAttributes: self elementNester currentScopedAttributes]
		ifFalse: [self elementNester endElement: anElementName].

	prefix := anElementName prefixBeforeLocalName.
	self saxHandler 
		endElement: anElementName
		prefix: prefix
		uri:
			(self usesNamespaces
				ifTrue: [
					currentScope := self scopeAllocator exitScope.
					currentScope resolvePrefix: prefix]
				ifFalse: [''])
		localName: (anElementName localNameAfterPrefix: prefix).

	currentScope ifNotNil: [
		currentScope hasNamespaces
			ifTrue: [self undeclareNamespacesInScope: currentScope]].
	self isValidating
		ifTrue: [self validator validateEndTag: anElementName].
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
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
SAXParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self dtd
		addGeneralEntity: aName
		replacement: aReplacement
		from: self currentURI.

	self saxHandler
		generalEntityDeclaration: aName
		replacement: aReplacement.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleGeneralEntityReference: aName [
	| entity |

	(entity := self dtd generalEntityAt: aName)
		ifNil: [
			self isValidating
				ifTrue: [self errorUndeclaredGeneralEntity: aName].
			self preservesUndeclaredEntityReferences
				ifTrue: [entity := DTDBypassedGeneralEntity named: aName].
			self saxHandler skippedEntity: aName].
	^ entity.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleNotationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self isValidating
		ifTrue: [self dtd addNotation: aName].

	self saxHandler
		notationDeclaration: aName
		publicID: aPublicId
		systemID: aSystemId.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handlePCData: aString [
	self elementNester isInElement
		ifFalse: [self errorCharacterDataOutsideElement].
	self isValidating
		ifTrue: [self validator validatePCData: aString].

	self saxHandler characters: aString.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handlePI: piTarget data: piData [
	self saxHandler 
		processingInstruction: piTarget
		data: piData
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
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
SAXParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self dtd
		addParameterEntity: aName
		replacement:aReplacement
		from: self currentURI.

	self saxHandler
		parameterEntityDeclaration: aName
		replacement: aReplacement.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleParameterEntityReference: aName [
	| entity |

	(entity := self dtd parameterEntityAt: aName)
		ifNil: [
			self isValidating
				ifTrue: [self errorUndeclaredParameterEntity: aName].
			self preservesUndeclaredEntityReferences
				ifTrue: [entity := DTDBypassedParameterEntity named: aName]].
	^ entity.
]

{ #category : #private }
SAXParserDriver >> handleReservedAttributes: anAttributeDictionary [
	anAttributeDictionary
		at: 'xml:base'
		ifPresent: [:uri | self currentURI: uri].
	self isValidating
		ifTrue: [self validator validateXMLIDAttributeIn: anAttributeDictionary].

	self elementNester
		setScopedAttributesNamed: self scopedAttributeNames
		from: anAttributeDictionary.

	hasUnhandledReservedAttributes := false.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleStartContentEntityReplacement: aName [
	self saxHandler startEntity: aName
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleStartDTD: aRoot publicID: aPublicId systemID: aSystemId [
	self dtd
		rootElement: aRoot
		externalSubsetURI: aSystemId.
	
	self saxHandler
		startDTD: aRoot
		publicID: aPublicId
		systemID: aSystemId;
		startInternalSubset.
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleStartDocument [
	self saxHandler startDocument
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	"performance critical method"
	| prefix totalAttributes namespaceUri currentScope |

	self elementNester startElement: anElementName.

	prefix := anElementName prefixBeforeLocalName.
	totalAttributes := anAttributeDictionary size.
	self usesNamespaces
		ifTrue: [
			currentScope := self scopeAllocator enterScope.
			aNamespaceDictionary
				ifNotNil: [self declareNamespaces: aNamespaceDictionary inScope: currentScope].
			namespaceUri := currentScope validateAndResolvePrefix: prefix ofElement: anElementName.
			totalAttributes > 0
				ifTrue: [currentScope validateAttributePrefixes: anAttributeDictionary]].
	self isValidating
		ifTrue: [
			self elementNester isCurrentElementRoot
				ifTrue: [self validateRootElement: anElementName].
			self validator
				validateStartTag: anElementName
				attributes: anAttributeDictionary.
			anAttributeDictionary size > totalAttributes
				ifTrue: [self checkForReservedAttributesIn: anAttributeDictionary after: totalAttributes]].
	self hasUnhandledReservedAttributes
		ifTrue: [self handleReservedAttributes: anAttributeDictionary].

	self saxHandler
		startElement: anElementName
		prefix: prefix
		uri: (namespaceUri ifNil: [''])
		localName: (anElementName localNameAfterPrefix: prefix)
		attributes: anAttributeDictionary.
	currentScope
		ifNotNil: [self saxHandler currentScope: currentScope].
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleWhitespace: aString [
	(self elementNester hasScopedAttributes
		and: [(self elementNester scopedAttributeAt: 'xml:space') = 'preserve'])
		ifTrue: [self handlePCData: aString]
		ifFalse: [self saxHandler ignorableWhitespace: aString]
]

{ #category : #'handling tokens' }
SAXParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	| versionNumber isStandalone |

	versionNumber := Float readFrom: aVersion readStream.
	isStandalone := aYesOrNo = 'yes'.

	self dtd isStandalone: isStandalone.

	self saxHandler
		xmlVersion: versionNumber
		encoding: anEncoding
		standalone: isStandalone.
]

{ #category : #private }
SAXParserDriver >> hasUnhandledReservedAttributes [
	^ hasUnhandledReservedAttributes
]

{ #category : #private }
SAXParserDriver >> haveUnhandledReservedAttributes [
	hasUnhandledReservedAttributes := true
]

{ #category : #testing }
SAXParserDriver >> isValidating [
	^ self saxHandler isValidating
]

{ #category : #accessing }
SAXParserDriver >> maxEntityReplacementDepth [
	^ self saxHandler maxEntityReplacementDepth
]

{ #category : #private }
SAXParserDriver >> parseExternalSubset: aUri [
	| parser |

	parser :=
		self externalSubsetParserOnURI:
			(self externalEntityResolver
				combineURI: self documentURI
				with: aUri).
	parser parseDocument.
]

{ #category : #testing }
SAXParserDriver >> preservesUndeclaredEntityReferences [
	^ self saxHandler preservesUndeclaredEntityReferences
]

{ #category : #accessing }
SAXParserDriver >> readLimit [
	^ self documentReadLimit
]

{ #category : #testing }
SAXParserDriver >> resolvesExternalEntities [
	^ self saxHandler resolvesExternalEntities
]

{ #category : #accessing }
SAXParserDriver >> saxHandler [
	^ saxHandler
]

{ #category : #accessing }
SAXParserDriver >> scopeAllocator [
	^ scopeAllocator ifNil: [scopeAllocator := XMLNamespaceScopeAllocator new]
]

{ #category : #private }
SAXParserDriver >> scopedAttributeNames [
	^ #('xml:space' 'xml:base' 'xml:lang')
]

{ #category : #accessing }
SAXParserDriver >> setRootElement: anElementName currentScope: aNamespaceScope [
	self elementNester setExternalRootElement: anElementName.
	self usesNamespaces
		ifTrue: [self scopeAllocator currentScope: aNamespaceScope].
]

{ #category : #initialization }
SAXParserDriver >> setSAXHandler: aHandler [
	saxHandler := aHandler.
	elementNester := self elementNesterClass new.
	hasUnhandledReservedAttributes := false.
]

{ #category : #private }
SAXParserDriver >> undeclareNamespacesInScope: aScope [
	| currentScope |

	currentScope := self scopeAllocator currentScope.
	aScope prefixesAndURIsDo: [:prefix :uri |
		(currentScope includesPrefix: prefix mappedTo: uri)
			ifFalse: [self saxHandler endPrefixMapping: prefix]].
]

{ #category : #testing }
SAXParserDriver >> usesNamespaces [
	^ self saxHandler usesNamespaces
]

{ #category : #private }
SAXParserDriver >> validateRootElement: aStartTag [
	(self saxHandler requiresDocumentConstraints
		and: [self validator hasElementValidators not])
		ifTrue: [self errorDocumentConstraintsRequired].

	self validator validateRootElement: aStartTag.
]

{ #category : #accessing }
SAXParserDriver >> validator [
	^ validator ifNil: [validator := DTDDocumentValidator dtd: self dtd]
]

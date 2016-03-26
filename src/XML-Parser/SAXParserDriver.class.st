"
SAXParserDriver together with SAXHandler provides a SAX-like API for XML parsing. The driver processes XML tokens and signals SAX events to a SAXHandler. See SAXHandler for more info.
"
Class {
	#name : #SAXParserDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxHandler',
		'elementNester',
		'scopeAllocator',
		'doctypeDefinition',
		'validator',
		'externalSubsetURI',
		'isStandalone',
		'hasUnhandledReservedAttributes'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
SAXParserDriver class >> saxHandler: aHandler [
	^ self new setSAXHandler: aHandler
]

{ #category : #private }
SAXParserDriver >> checkForReservedAttributesIn: anAttributeDictionary afterIndex: anIndex [
	"validation may add attributes"
	self hasUnhandledReservedAttributes
		ifFalse: [
			anIndex + 1
				to: anAttributeDictionary size
				do: [:i |
					(anAttributeDictionary keyAtIndex: i) isXMLReservedAttributeName
						ifTrue: [^ self haveUnhandledReservedAttributes]]]
]

{ #category : #accessing }
SAXParserDriver >> currentElement [
	^ self elementNester currentElement
]

{ #category : #private }
SAXParserDriver >> declareNamespaces: aDictionary inScope: aScope [
	aDictionary keysAndValuesDo: [:prefix :uri |
		(aScope resolvePrefix: prefix) = uri
			ifFalse: [
				self saxHandler
					startPrefixMapping: prefix
					uri: uri]].
	aScope mapPrefixesAndURIs: aDictionary.
]

{ #category : #testing }
SAXParserDriver >> decodesCharacters [
	^ self saxHandler decodesCharacters
]

{ #category : #accessing }
SAXParserDriver >> doctypeDefinition [
	^ doctypeDefinition
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
SAXParserDriver >> errorUndeclaredParameterEntity: aName [
	XMLValidationException
		formatSignal: 'Undeclared parameter entity reference %{1};'
		with: aName
]

{ #category : #accessing }
SAXParserDriver >> externalEntityResolver [
	^ self saxHandler externalEntityResolver
]

{ #category : #private }
SAXParserDriver >> externalSubsetParserOn: aStringOrStream documentURI: aURIString [
	^ self saxHandler parserClass
		driver:
			(DTDExternalSubsetParserDriver
				saxDriver: self
				documentURI: aURIString)
		on: aStringOrStream
]

{ #category : #private }
SAXParserDriver >> externalSubsetParserOnURI: aURIString [
	| combinedURI |

	combinedURI :=
		self externalEntityResolver
			combineSourceURI: self documentURI
			withEntityURI: aURIString.

	^ self
		externalSubsetParserOn:
			(XMLDecodingReadStreamAdapter on:
				(self externalEntityResolver streamResolveEntityURI: combinedURI))
		documentURI: combinedURI asString.
]

{ #category : #accessing }
SAXParserDriver >> externalSubsetURI [
	^ externalSubsetURI
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleAttributeDeclaration: anElement name: anAttribute type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self isValidating
		ifTrue: [
			self doctypeDefinition
				addValidatorForAttributeIn: anElement
				named: anAttribute
				type: aType
				defaultPragma: aDefaultPragma
				defaultValue: aDefaultValue].
	self saxHandler
		attributeDeclaration: anElement
		name: anAttribute
		type: aType
		defaultPragma: aDefaultPragma
		defaultValue: aDefaultValue
]

{ #category : #handling }
SAXParserDriver >> handleCData: aString [
	self elementNester isInElement
		ifFalse: [self errorCharacterDataOutsideElement].
	self isValidating
		ifTrue: [self validator validatePCData: aString].

	self saxHandler
		isInCDataSection: true;
		startCData;
		characters: aString;
		endCData;
		isInCDataSection: false.
]

{ #category : #handling }
SAXParserDriver >> handleComment: aString [
	self saxHandler comment: aString
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleElementDeclaration: aName contentModel: aContentModel [
	self isValidating
		ifTrue: [
			self doctypeDefinition
				addValidatorForElement: aName
				contentModel: aContentModel].

	self saxHandler
		elementDeclaration: aName
		contentModel: aContentModel
]

{ #category : #handling }
SAXParserDriver >> handleEndContentEntityReplacement: aName [
	self saxHandler endEntity: aName
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleEndDTD [
	(self resolvesExternalEntities
		and: [self externalSubsetURI notEmpty
			and: [self isValidating or: [self isStandalone not]]])
		ifTrue: [self parseExternalSubset].

	self saxHandler
		doctypeDefinition: self doctypeDefinition;
		endDTD.
]

{ #category : #handling }
SAXParserDriver >> handleEndDocument [
	self elementNester endNesting.
	self isValidating
		ifTrue: [self validator validateEndDocument].

	self saxHandler endDocument.
]

{ #category : #handling }
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
					(currentScope := self scopeAllocator exitScope)
						resolvePrefix: prefix]
				ifFalse: [''])
		localName: (anElementName localNameAfterPrefix: prefix).

	currentScope ifNotNil: [
		currentScope hasNamespaces
			ifTrue: [self undeclareNamespacesInScope: currentScope]].
	self isValidating
		ifTrue: [self validator validateEndTag: anElementName].
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicID systemID: aSystemID ndata: aNotation [
	aNotation isEmpty
		ifTrue: [
			self resolvesExternalEntities
				ifTrue: [
					self doctypeDefinition
						addExternalGeneralEntity: aName
						resolver: self externalEntityResolver
						publicID: aPublicID
						systemID: aSystemID
						from: self currentURI]]
		ifFalse: [
			self doctypeDefinition
				addUnparsedEntity: aName
				ndata: aNotation].

	self saxHandler
		generalEntityDeclaration: aName
		publicID: aPublicID
		systemID: aSystemID
		ndata: aNotation.
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addGeneralEntity: aName
		replacement: aReplacement
		from: self currentURI.

	self saxHandler
		generalEntityDeclaration: aName
		replacement: aReplacement.
]

{ #category : #handling }
SAXParserDriver >> handleGeneralEntityReference: aName [
	^ self doctypeDefinition
		generalEntityAt: aName
		ifAbsent: [
			self isValidating
				ifTrue: [self errorUndeclaredGeneralEntity: aName].
			nil]
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleNotationDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self isValidating
		ifTrue: [self doctypeDefinition addNotation: aName].

	self saxHandler
		notationDeclaration: aName
		publicID: aPublicID
		systemID: aSystemID.
]

{ #category : #handling }
SAXParserDriver >> handlePCData: aString [
	self elementNester isInElement
		ifFalse: [self errorCharacterDataOutsideElement].
	self isValidating
		ifTrue: [self validator validatePCData: aString].

	self saxHandler characters: aString.
]

{ #category : #handling }
SAXParserDriver >> handlePI: aTargetString data: aDataString [
	self saxHandler 
		processingInstruction: aTargetString
		data: aDataString
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self resolvesExternalEntities
		ifTrue: [
			self doctypeDefinition
				addExternalParameterEntity: aName
				resolver: self externalEntityResolver
				publicID: aPublicID
				systemID: aSystemID
				from: self currentURI].

	self saxHandler
		parameterEntityDeclaration: aName
		publicID: aPublicID
		systemID: aSystemID.
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addParameterEntity: aName
		replacement:aReplacement
		from: self currentURI.

	self saxHandler
		parameterEntityDeclaration: aName
		replacement: aReplacement.
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleParameterEntityReference: aName [
	^ self doctypeDefinition
		parameterEntityAt: aName
		ifAbsent: [
			self isValidating
				ifTrue: [self errorUndeclaredParameterEntity: aName].
			nil]
]

{ #category : #handling }
SAXParserDriver >> handleParseError: aString [
	XMLWellFormednessException signal: aString
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

{ #category : #handling }
SAXParserDriver >> handleStartContent [
	self saxHandler startContent
]

{ #category : #handling }
SAXParserDriver >> handleStartContentEntityReplacement: aName [
	self saxHandler startEntity: aName
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleStartDTD: aRoot publicID: aPublicID systemID: aSystemID [
	externalSubsetURI := aSystemID.

	self doctypeDefinition root: aRoot.
	self saxHandler
		startDTD: aRoot
		publicID: aPublicID
		systemID: aSystemID.
]

{ #category : #handling }
SAXParserDriver >> handleStartDocument [
	self saxHandler startDocument
]

{ #category : #handling }
SAXParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	"performance critical method"
	| prefix totalAttributes namespaceURI currentScope |

	self elementNester startElement: anElementName.

	prefix := anElementName prefixBeforeLocalName.
	totalAttributes := anAttributeDictionary size.
	self usesNamespaces
		ifTrue: [
			currentScope := self scopeAllocator enterScope.
			aNamespaceDictionary
				ifNotNil: [
					self
						declareNamespaces: aNamespaceDictionary
						inScope: currentScope].
			namespaceURI :=
				currentScope
					validateAndResolvePrefix: prefix
					ofElement: anElementName.
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
				ifTrue: [
					self
						checkForReservedAttributesIn: anAttributeDictionary
						afterIndex: totalAttributes]].
	self hasUnhandledReservedAttributes
		ifTrue: [self handleReservedAttributes: anAttributeDictionary].

	self saxHandler
		startElement: anElementName
		prefix: prefix
		uri: (namespaceURI ifNil: [''])
		localName: (anElementName localNameAfterPrefix: prefix)
		attributes: anAttributeDictionary.

	currentScope
		ifNotNil: [self saxHandler currentScope: currentScope].
]

{ #category : #handling }
SAXParserDriver >> handleUnreplacedGeneralEntityReference: aName [
	self saxHandler skippedEntity: aName
]

{ #category : #handling }
SAXParserDriver >> handleWhitespace: aString [
	(self elementNester hasScopedAttributes
		and: [(self elementNester scopedAttributeAt: 'xml:space') = 'preserve'])
		ifTrue: [self handlePCData: aString]
		ifFalse: [self saxHandler ignorableWhitespace: aString]
]

{ #category : #handling }
SAXParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	isStandalone := aYesOrNo = 'yes'.

	self saxHandler
		xmlVersion: (Float readFrom: aVersion readStream)
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

{ #category : #initialization }
SAXParserDriver >> initialContext [
	^ XMLXMLDeclarationContext new
]

{ #category : #testing }
SAXParserDriver >> isStandalone [
	^ isStandalone
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
SAXParserDriver >> parseExternalSubset [
	(self externalSubsetParserOnURI: self externalSubsetURI) parseDocument
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
SAXParserDriver >> replacesContentEntityReferences [
	^ self saxHandler replacesContentEntityReferences
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
	doctypeDefinition := DTDDoctypeDefinition new.
	validator := (aHandler schema ifNil: [doctypeDefinition]) newValidator.
	externalSubsetURI := ''.
	isStandalone := false.
	hasUnhandledReservedAttributes := false.
]

{ #category : #private }
SAXParserDriver >> undeclareNamespacesInScope: anExitedScope [
	| currentScope |

	currentScope := self scopeAllocator currentScope.
	anExitedScope prefixesAndURIsDo: [:prefix :uri |
		(currentScope resolvePrefix: prefix) = uri
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
	^ validator
]

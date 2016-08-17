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
		'isStandalone',
		'hasUnhandledReservedAttributes',
		'externalSubsetSystemID',
		'externalSubsetPublicID'
	],
	#category : #'XML-Parser-Drivers'
}

{ #category : #'instance creation' }
SAXParserDriver class >> saxHandler: aHandler [
	^ self new setSAXHandler: aHandler
]

{ #category : #accessing }
SAXParserDriver >> baseURI [
	"returns a string with the current base URI at this stage of parsing"
	self elementNester hasScopedAttributes
		ifTrue: [
			^ self elementNester
				scopedAttributeAt: 'xml:base'
				ifAbsent: [super baseURI]].
	^ super baseURI.
]

{ #category : #private }
SAXParserDriver >> checkForReservedAttributesIn: anOrderPreservingDictionary afterIndex: anIndex [
	"validation may add attributes, so this is used to check if reserved
	attributes were added that need handling when there weren't any before"

	self hasUnhandledReservedAttributes
		ifTrue: [^ self].
	anIndex + 1
		to: anOrderPreservingDictionary size
		do: [:i |
			(anOrderPreservingDictionary keyAtIndex: i) isXMLReservedAttributeName
				ifTrue: [^ self haveUnhandledReservedAttributes]].
]

{ #category : #accessing }
SAXParserDriver >> currentElement [
	^ self elementNester currentElement
]

{ #category : #private }
SAXParserDriver >> declareNamespaces: aSequenceableCollection inScope: aScope [
	1 to: aSequenceableCollection size do: [:i | | association |
		association := aSequenceableCollection at: i.
		(aScope resolvePrefix: association key) = association value
			ifFalse: [
				self saxHandler
					startPrefixMapping: association key
					uri: association value]].
	aScope mapPrefixesAndURIs: aSequenceableCollection.
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
SAXParserDriver >> errorCharacterDataOutsideElement [
	XMLWellFormednessException signal: 'Character data outside of element'
]

{ #category : #private }
SAXParserDriver >> errorDocumentConstraintsRequired [
	XMLValidationException signal: 'Document validation constraints required'
]

{ #category : #private }
SAXParserDriver >> errorImproperParameterEntityNesting [
	XMLValidationException signal:
		'Improper nesting of parameter entity replacement within DTD subset'
]

{ #category : #private }
SAXParserDriver >> errorStandaloneUndeclaredGeneralEntity: aName [
	XMLWellFormednessException
		formatSignal:
			'Undeclared general entity reference &{1}; in standalone document'
		with: aName
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

{ #category : #private }
SAXParserDriver >> errorUnparsedGeneralEntityReference: aName [
	XMLWellFormednessException
		formatSignal: 'Illegal unparsed general entity reference &{1};'
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

{ #category : #accessing }
SAXParserDriver >> externalSubsetPublicID [
	^ externalSubsetPublicID
]

{ #category : #accessing }
SAXParserDriver >> externalSubsetSystemID [
	^ externalSubsetSystemID
]

{ #category : #private }
SAXParserDriver >> extractNamespacesFromAttributes: anOrderPreservingDictionary [
	"returns an ordered collection of namespace prefix/uri associations
	removed from the attribute dictionary or nil if there aren't any"
	| namespaces keysToRemove |

	self haveNoUnhandledReservedAttributes.
	anOrderPreservingDictionary keysDo: [:name |
		"optimized comparison ordering"
		(name at: 1) == $x
			ifTrue: [
				name isXMLNSAttributeName
					ifTrue: [
						"only initialize when needed"
						(namespaces ifNil: [namespaces := OrderedCollection new: 5])
							addLast:
								(name size > 6 "'xmlns:' size"
									ifTrue: [name copyFrom: 7 to: name size]
									ifFalse: ['']) ->
										(anOrderPreservingDictionary at: name).
						"only initialize when needed"
						(keysToRemove ifNil: [keysToRemove := OrderedCollection new: 5])
							addLast: name]
					ifFalse: [
						name isXMLReservedAttributeName
							ifTrue: [
								"at least one xml attr is not an xmlns attr, so there
								will still be reserved attrs to handle after extracting
								the namespaces"
								self haveUnhandledReservedAttributes]]]].

	keysToRemove
		ifNotNil: [
			"use removeKeys: for speed"
			anOrderPreservingDictionary removeKeys: keysToRemove].

	^ namespaces.
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
	(self elementNester isInElement
		and: [self isValidating])
		ifTrue: [self validator validateComment: aString].

	self saxHandler comment: aString.
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
	self hasExternalSubsetToParse
		ifTrue: [self parseExternalSubset].

	self isValidating
		ifTrue: [self doctypeDefinition validateCompletedDefinition].

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
SAXParserDriver >> handleEndTag: anElement [
	"performance critical method"
	| prefix currentScope |

	self elementNester endElement: anElement.

	prefix := anElement xmlPrefixBeforeLocalName.
	self saxHandler 
		endElement: anElement
		prefix: prefix
		uri:
			(self usesNamespaces
				ifTrue: [
					(currentScope := self scopeAllocator exitScope)
						resolvePrefix: prefix]
				ifFalse: [''])
		localName: (anElement xmlLocalNameAfterPrefix: prefix).

	currentScope ifNotNil: [
		currentScope hasNamespaces
			ifTrue: [self undeclareNamespacesInScope: currentScope]].
	self isValidating
		ifTrue: [self validator validateEndTag: anElement].
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
						baseURI: self baseURI]
				ifFalse: [
					(self isValidating
						or: [self isStandalone])
						ifTrue: [
							self doctypeDefinition
								addUnresolvableExternalGeneralEntity: aName]]]
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
		addInternalGeneralEntity: aName
		replacement: aReplacement
		baseURI: self baseURI.

	self saxHandler
		generalEntityDeclaration: aName
		replacement: aReplacement.
]

{ #category : #handling }
SAXParserDriver >> handleGeneralEntityReference: aName [
	| entity |

	entity :=
		self doctypeDefinition
			generalEntityAt: aName
			ifAbsent: [
				self isValidating
					ifTrue: [self errorUndeclaredGeneralEntity: aName].
				self isStandalone
					ifTrue: [self errorStandaloneUndeclaredGeneralEntity: aName].
				^ nil].

	entity isUnparsed
		ifTrue: [self errorUnparsedGeneralEntityReference: aName].

	^ entity.
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleImproperParameterEntityNesting [
	"this is a validity constraint and is only checked when validating"
	self isValidating
		ifTrue: [self errorImproperParameterEntityNesting]
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleNotationDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self isValidating
		ifTrue: [
			self doctypeDefinition unparsedEntityValidator
				validateNotation: aName].
	self doctypeDefinition addNotation: aName.

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
	(self elementNester isInElement
		and: [self isValidating])
		ifTrue: [
			self validator
				validatePI: aTargetString
				data: aDataString].

	self saxHandler 
		processingInstruction: aTargetString
		data: aDataString.
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
				baseURI: self baseURI]
		ifFalse: [
			(self isValidating
				or: [self isStandalone])
				ifTrue: [
					self doctypeDefinition
						addUnresolvableExternalParameterEntity: aName]].

	self saxHandler
		parameterEntityDeclaration: aName
		publicID: aPublicID
		systemID: aSystemID.
]

{ #category : #'handling - dtd' }
SAXParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addInternalParameterEntity: aName
		replacement:aReplacement
		baseURI: self baseURI.

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
SAXParserDriver >> handleReservedAttributes: aDictionary [
	aDictionary
		at: 'xml:base'
		ifPresent: [:uri |
			"expand the new base URI using the current"
			aDictionary
				at: 'xml:base'
				put: (self baseURI asXMLURI / uri) asString].
	self isValidating
		ifTrue: [self validator validateXMLIDAttributeIn: aDictionary].

	self elementNester
		setScopedAttributesNamed: self scopedAttributeNames
		from: aDictionary.

	self haveNoUnhandledReservedAttributes.
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
	externalSubsetPublicID := aPublicID.
	externalSubsetSystemID := aSystemID.

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
SAXParserDriver >> handleStartTag: anElement attributes: aDictionary [
	"performance critical method"
	| prefix totalAttributes namespaceURI currentScope |

	self elementNester startElement: anElement.

	prefix := anElement xmlPrefixBeforeLocalName.
	totalAttributes := aDictionary size.
	self isValidating
		ifTrue: [
			self elementNester isCurrentElementRoot
				ifTrue: [self validateRootElement: anElement].
			self validator
				validateStartTag: anElement
				attributes: aDictionary.
			aDictionary size > totalAttributes
				ifTrue: [
					self
						checkForReservedAttributesIn: aDictionary
						afterIndex: totalAttributes]].
	self usesNamespaces
		ifTrue: [
			currentScope := self scopeAllocator enterScope.
			self hasUnhandledReservedAttributes
				ifTrue: [
					(self extractNamespacesFromAttributes: aDictionary)
						ifNotNil: [:namespaces |
							self
								declareNamespaces: namespaces
								inScope: currentScope]].
			namespaceURI :=
				currentScope
					validateAndResolvePrefix: prefix
					ofElement: anElement.
			totalAttributes > 0
				ifTrue: [currentScope validateAttributePrefixes: aDictionary]].
	self hasUnhandledReservedAttributes
		ifTrue: [self handleReservedAttributes: aDictionary].

	self saxHandler
		startElement: anElement
		prefix: prefix
		uri: (namespaceURI ifNil: [''])
		localName: (anElement xmlLocalNameAfterPrefix: prefix)
		attributes: aDictionary.

	currentScope
		ifNotNil: [self saxHandler currentScope: currentScope].
]

{ #category : #handling }
SAXParserDriver >> handleUnreplacedGeneralEntityReference: aName [
	self saxHandler skippedEntity: aName
]

{ #category : #handling }
SAXParserDriver >> handleWhitespace: aString [
	self elementNester isInElement
		ifFalse: [^ self].

	self isValidating
		ifTrue: [
			self validator hasElementContent
				ifTrue: [
					(self elementNester hasScopedAttributes
						and: [(self elementNester scopedAttributeAt: 'xml:space') = 'preserve'])
						ifTrue: [self saxHandler characters: aString]
						ifFalse: [self saxHandler ignorableWhitespace: aString].
					^ self].
			self validator validatePCData: aString].
	self saxHandler characters: aString.
]

{ #category : #handling }
SAXParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	isStandalone := aYesOrNo = 'yes'.

	self saxHandler
		xmlVersion: (Float readFrom: aVersion readStream)
		encoding: anEncoding
		standalone: isStandalone.
]

{ #category : #testing }
SAXParserDriver >> hasExternalSubsetToParse [
	self resolvesExternalEntities
		ifFalse: [^ false].

	(self externalSubsetPublicID notEmpty
		or: [self externalSubsetSystemID notEmpty])
		ifFalse: [^ false].
	
	^ self isValidating
		or: [self isStandalone not].
]

{ #category : #private }
SAXParserDriver >> hasUnhandledReservedAttributes [
	^ hasUnhandledReservedAttributes
]

{ #category : #private }
SAXParserDriver >> haveNoUnhandledReservedAttributes [
	hasUnhandledReservedAttributes := false
]

{ #category : #private }
SAXParserDriver >> haveUnhandledReservedAttributes [
	hasUnhandledReservedAttributes := true
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
	| externalSubsetURI externalSubsetStream |

	externalSubsetURI :=
		self externalEntityResolver
			externalEntityURIFromPublicID: self externalSubsetPublicID
			systemID: self externalSubsetSystemID
			baseURI: self baseURI.

	"External subsets are stream-resolved so if they are local (stored on disk),
	they aren't kept entirely in memory during parsing. HTTP entities will be
	kept in memory regardless and this will just return a read stream on them."
	externalSubsetStream :=
		self externalEntityResolver streamResolveExternalEntityURI:
			externalSubsetURI.

	(self
		externalSubsetParserOn:
			(XMLDecodingReadStreamAdapter on: externalSubsetStream)
		documentURI: externalSubsetURI asString)
		parseDocument.
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
	"the scoped attributes tracked by this driver"
	^ #('xml:space' 'xml:base')
]

{ #category : #accessing }
SAXParserDriver >> setRootElement: anElement currentScope: aNamespaceScope [
	self elementNester setExternalRootElement: anElement.
	self usesNamespaces
		ifTrue: [self scopeAllocator currentScope: aNamespaceScope].
]

{ #category : #initialization }
SAXParserDriver >> setSAXHandler: aHandler [
	saxHandler := aHandler.
	elementNester := self elementNesterClass new.
	doctypeDefinition := DTDDoctypeDefinition new.
	validator := (aHandler schema ifNil: [doctypeDefinition]) newValidator.
	externalSubsetPublicID := ''.
	externalSubsetSystemID := ''.
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
SAXParserDriver >> validateRootElement: anElement [
	(self saxHandler requiresDocumentConstraints
		and: [self validator hasElementValidators not])
		ifTrue: [self errorDocumentConstraintsRequired].

	self validator validateRootElement: anElement.
]

{ #category : #accessing }
SAXParserDriver >> validator [
	^ validator
]

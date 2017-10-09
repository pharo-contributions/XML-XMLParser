"
This is a tokenizer for well-formed XML documents that supports DTD subsets and entity replacement.
"
Class {
	#name : #XMLWellFormedParserTokenizer,
	#superclass : #XMLParserTokenizer,
	#instVars : [
		'pushedBackEntities',
		'totalOpenIncludeSections',
		'isInLiteralValue',
		'isIgnoringLiteralValueTerminator'
	],
	#classVars : [
		'EncodingNameChars',
		'EncodingNameStartChars',
		'NormalizedSpace',
		'PublicIDChars',
		'VersionDigitChars'
	],
	#category : #'XML-Parser-Drivers'
}

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initialize [
	"self initialize"

	self
		initializeNormalizedSpace;
		initializePublicIDChars;
		initializeEncodingNameStartChars;
		initializeEncodingNameChars;
		initializeVersionDigitChars
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeEncodingNameChars [
	"EncName ::= [A-Za-z] ([A-Za-z0-9._] | '-')*"

	"assign the fully initialized object with #yourself to avoid
	possible race conditions when reinitialization the class"
	EncodingNameChars :=
		BitmapCharacterSet new
			addRangeFrom: $a to: $z;
			addRangeFrom: $A to: $Z;
			addRangeFrom: $0 to: $9;
			addAll: '-_.';
			yourself
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeEncodingNameStartChars [
	"Character>>isLetter is not used because it may return true for non-ASCII
	letters depending on the locale.
	
	EncName ::= [A-Za-z] ([A-Za-z0-9._] | '-')*"

	"assign the fully initialized object with #yourself to avoid
	possible race conditions when reinitialization the class"
	EncodingNameStartChars :=
		BitmapCharacterSet new
			addRangeFrom: $a to: $z;
			addRangeFrom: $A to: $Z;
			yourself
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeNormalizedSpace [
	"stored in a class var for faster access"
	NormalizedSpace := Character space
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializePublicIDChars [
	"PubidChar ::= #x20 | #xD | #xA | [a-zA-Z0-9] | [-'()+,./:=?;!*#@$_%]"

	"assign the fully initialized object with #yourself to avoid
	possible race conditions when reinitialization the class"
	PublicIDChars :=
		BitmapCharacterSet new
			add: 16r20 asCharacter;
			add: 16rD asCharacter;
			add: 16rA asCharacter;
			addRangeFrom: $a to: $z;
			addRangeFrom: $A to: $Z;
			addRangeFrom: $0 to: $9;
			addAll: '-''()+,./:=?;!*#@$_%';
			yourself
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeVersionDigitChars [
	"Character>>#isDigit is not used because it may return true for non-ASCII
	digits depending on the locale.
	
	VersionNum ::= '1.' [0-9]+"

	"assign the fully initialized object with #yourself to avoid
	possible race conditions when reinitialization the class"
	VersionDigitChars :=
		BitmapCharacterSet new
			addRangeFrom: $0 to: $9;
			yourself
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> addPushedBackEntity: aPushedBackEntity [
	(self hasPushedBackEntity: aPushedBackEntity)
		ifTrue: [self errorSelfReferentialEntity: aPushedBackEntity].

	self maxEntityReplacementDepth
		ifNotNil: [:maxDepth |
			self pushedBackEntities size >= maxDepth
				ifTrue: [self errorEntityDepthLimitExceeded]].
	
	self pushedBackEntities addLast: aPushedBackEntity.
	driver currentEntity: aPushedBackEntity entity.
	aPushedBackEntity isExternal
		ifTrue: [driver baseURI: aPushedBackEntity uri].

	^ aPushedBackEntity.
]

{ #category : #decoding }
XMLWellFormedParserTokenizer >> characterFromCodePoint: aCodePoint [
	| character |

	"nil understands isXMLChar so it does not need to be tested for"
	(character := super characterFromCodePoint: aCodePoint) isXMLChar
		ifTrue: [^ character]
		ifFalse: [^ nil].
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> constructLiteralReplacementForEntity: anEntity [
	| wasIgnoringLiteralValueTerminator |

	wasIgnoringLiteralValueTerminator := isIgnoringLiteralValueTerminator.
	isIgnoringLiteralValueTerminator := true.
	self
		pushBackEntity: anEntity
		whenPoppedDo: [
			isIgnoringLiteralValueTerminator := wasIgnoringLiteralValueTerminator].
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> constructReplacementForGeneralEntity: anEntity [
	isInLiteralValue
		ifTrue: [
			anEntity isExternal
				ifTrue: [self errorLiteralReferenceToExternalGeneralEntity: anEntity].
			self constructLiteralReplacementForEntity: anEntity]
		ifFalse: [
			driver handleStartContentEntityReplacement: anEntity name.
			self
				pushBackEntity: anEntity
				whenPoppedDo: [driver handleEndContentEntityReplacement: anEntity name]]
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> constructReplacementForParameterEntity: anEntity [
	isInLiteralValue
		ifTrue: [self constructLiteralReplacementForEntity: anEntity]
		ifFalse: [
			"the trailing space"
			streamReader pushBackCharacter: NormalizedSpace.
			self
				pushBackEntity: anEntity
				whenPoppedDo: nil.
			"the leading space"
			streamReader pushBackCharacter: NormalizedSpace]
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorDuplicateAttribute: anAttribute [
	self
		formatParseError: 'Duplicate attribute "{1}" in start tag'
		with: anAttribute
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorEntityDepthLimitExceeded [
	XMLLimitException signal: 
		'Cannot further nest entity replacements; ',
		'use #maxEntityReplacementDepth: to change or disable'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeName [
	self errorExpected: 'attribute name'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeNameValueSeparatorButGot: aCharacter [
	self
		errorExpected: 'attribute name-value "=" separator'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeValueEnd: aQuote butGot: aCharacter [
	aCharacter == $<
		ifTrue: [self parseError: 'Attribute value contains illegal "<" character']
		ifFalse: [
			self
				errorExpectedQuote: aQuote
				ending: 'attribute value'
				butGot: aCharacter]
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeValueStartButGot: aCharacter [
	self
		errorExpectedQuoteStarting: 'attribute value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedCDataSectionTerminator [
	self errorExpected: 'end of CDATA section "]]>" terminator'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedElementName [
	self errorExpected: 'element name'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedEncodingName [
	self errorExpected: 'encoding name in <?xml ...?> encoding attribute'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedEndTag: anExpectedEndTag butGot: aCharacter at: aCharacterPosition [
	| receivedEndTag |

	"try to get the entire unexpected name"
	nameStream reset.
	1 to: aCharacterPosition - 1 do: [:i |
		nameStream nextPut: (anExpectedEndTag at: i)].
	"nil understands isXMLNameChar so it is not tested for"
	aCharacter isXMLNameChar
		ifTrue: [
			nameStream nextPut: aCharacter.
			[streamReader peek isXMLNameChar]
				whileTrue: [nameStream nextPut: streamReader next]].

	(receivedEndTag := nameStream contents) size > 0
		ifTrue: [
			(elementNester hasOpenElement: receivedEndTag)
				ifTrue: [self errorUnterminatedElementsInElement: receivedEndTag]
				ifFalse: [self errorTerminatingUnstartedElement: receivedEndTag]]
		ifFalse: [self errorExpectedElementName].
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedEntityName [
	self errorExpected: 'entity name'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedEntityValueEnd: aQuote butGot: aCharacter [
	self
		errorExpectedQuote: aQuote
		ending: 'entity value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedIntegerCharacterReference [
	self errorExpected:
		'decimal or hex integer after "&#" character reference start'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: aString butGot: aCharacter at: aStringPosition [
	| receivedString |

	receivedString :=
		(aString
			copyReplaceFrom: aStringPosition
			to: aString size
			with:
				(aCharacter ifNil: ['']) asString,
				(streamReader next: aString size - aStringPosition)).

	self
		errorExpectedLiteral: aString
		butGot: receivedString.
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedName [
	self errorExpected: 'an XML name'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedNmtoken [
	self errorExpected: 'an XML Nmtoken name'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedNotationName [
	self errorExpected: 'notation name'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedPITarget [
	self errorExpected:
		(state isXMLDeclarationState
			ifTrue: ['xml declaration name or processing instruction target']
			ifFalse: ['processing instruction target'])
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedPublicIDLiteralEnd: aQuote butGot: aCharacter [
	self
		errorExpectedQuote: aQuote
		ending: 'public ID literal'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedPublicIDLiteralStartButGot: aCharacter [
	self
		errorExpectedQuoteStarting: 'public ID literal'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedQuote: aQuote ending: aDescription butGot: aCharacter [
	self
		formatParseError: 'Expected end of {1} ({2}) quoted {3} but got "{4}"'
		with:
			(aQuote == $"
				ifTrue: ['double']
				ifFalse: ['single'])
		with: aQuote
		with: aDescription
		with: (aCharacter ifNil: [''])
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedQuoteStarting: aDescription butGot: aCharacter [
	self
		formatParseError:
			'Expected start of double (") or single ('') quoted {1} but got "{2}"'
		with: aDescription
		with: (aCharacter ifNil: [''])
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedSeparators [
	self errorExpected: 'one or more whitespace characters'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedSubsetDeclaration [
	self errorExpected:
		'DTD subset ELEMENT, ATTLIST, ENTITY, or NOTATION declaration'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedSystemIDLiteralEnd: aQuote butGot: aCharacter [
	self
		errorExpectedQuote: aQuote
		ending: 'system ID literal'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedSystemIDLiteralStartButGot: aCharacter [
	self
		errorExpectedQuoteStarting: 'system ID literal'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedTerminatorButGot: aCharacter [
	self
		errorExpected: '">" terminator'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedVersionDigitButGot: aCharacter [
	self
		errorExpected: 'XML version digit'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedXMLEncodingValueEnd: aQuote butGot: aCharacter [
	self
		errorExpectedQuote: aQuote
		ending: '<?xml ...?> encoding value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedXMLEncodingValueStartButGot: aCharacter [
	self
		errorExpectedQuoteStarting: '<?xml ...?> encoding value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedXMLStandaloneValueEnd: aQuote butGot: aCharacter [
	self
		errorExpectedQuote: aQuote
		ending: '<?xml ...?> standalone value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedXMLStandaloneValueStartButGot: aCharacter [
	self
		errorExpectedQuoteStarting: '<?xml ...?> standalone value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedXMLVersionValueEnd: aQuote butGot: aCharacter [
	self
		errorExpectedQuote: aQuote
		ending: '<?xml ...?> version value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedXMLVersionValueStartButGot: aCharacter [
	self
		errorExpectedQuoteStarting: '<?xml ...?> version value'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorImproperGeneralEntityNesting [
	self parseError:
		'Markup tokens must start and end in the same general entity replacement'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInputTerminatedPrematurely [
	self parseError: 'Input terminated prematurely'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInternalDeclarationParameterEntityReference [
	self parseError: 'Parameter entity reference within internal subset declaration'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInternalSubsetConditionalSection [
	self parseError:
		'Cannot have <![INCLUDE[...]> or <![IGNORE[...]> sections in internal subset'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInvalidCharacterReferenceCodePoint: aCodePoint [
	self
		formatParseError: 'Invalid character reference to U+{1} code point'
		with: aCodePoint printStringHex
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorLiteralReferenceToExternalGeneralEntity: anEntity [
	self
		formatParseError:
			'External general entity reference {1} in attribute value'
		with: anEntity asReference
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorMultipleDoctypeDeclarations [
	self parseError: 'Multiple <!DOCTYPE ...> declarations'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorMultipleDocumentRootElements [
	self parseError: 'Document cannot have multiple root elements'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonChar: aCharacter in: aDescription [
	self
		formatParseError: 'Invalid character U+{1} in {2}'
		with: aCharacter asciiValue printStringHex
		with: aDescription
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonCharInAttributeValue: aCharacter [
	self
		errorNonChar: aCharacter
		in: 'attribute value'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonCharInCDataSection: aCharacter [
	self
		errorNonChar: aCharacter
		in: '<![CDATA[...]]> section'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonCharInComment: aCharacter [
	self
		errorNonChar: aCharacter
		in: 'comment'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonCharInEntityValue: aCharacter [
	self
		errorNonChar: aCharacter
		in: 'entity value'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonCharInPCData: aCharacter [
	self
		errorNonChar: aCharacter
		in: 'PCDATA'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonCharInPIValue: aCharacter [
	self
		errorNonChar: aCharacter
		in: 'processing instruction value'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonCharInSystemID: aCharacter [
	self
		errorNonChar: aCharacter
		in: 'system ID'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonElementGeneralEntityOrCharacterReference [
	self parseError:
		'Unexpected "&" starting general entity or character reference after content'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorNonElementPCDataCharacter: aCharacter [
	aCharacter == $&
		ifTrue: [self errorNonElementGeneralEntityOrCharacterReference]
		ifFalse: [
			self
				formatParseError: 'Character data "{1}" outside of element'
				with: aCharacter]
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorParameterEntityTerminatingSubset [
	self parseError: 'Parameter entity replacement cannot terminate internal subset'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorReferenceToUnparsedGeneralEntity: anEntity [
	self
		formatParseError: 'Illegal unparsed general entity reference {1}'
		with: anEntity asReference
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorReservedPITarget: aTarget [
	self
		formatParseError: 'Processing instruction target "{1}" is reserved'
		with: aTarget
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorSelfReferentialEntity: anEntity [
	self
		formatParseError: 'Illegal self-referential {1} entity'
		with: anEntity asReference
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorTerminatingUnstartedElement: anElement [
	self
		formatParseError: 'End tag </{1}> with no corresponding <{1}> start tag'
		with: anElement
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorURIFragmentInSystemID [
	self parseError: 'Illegal "#" URI fragment in system ID'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnexpectedCDataTerminator [
	self parseError: 'Unexpected CDATA "]]>" terminator in PCDATA'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnexpectedEndConditionalSection [
	self parseError: 'Unexpected "]" end of conditional section in external entity'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnexpectedEndTag: anElement [
	self
		formatParseError: 'Unexpected end tag </{1}> before any start tag'
		with: anElement
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnexpectedMarkupDeclarationInContent [
	self parseError: 'Unexpected "<!" markup declaration in content'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnterminatedElements [
	self
		formatParseError: 'Unterminated elements: {1}'
		with: elementNester printedElements
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnterminatedElementsInElement: anElement [
	self
		formatParseError: '<{1}> element ended before enclosed element(s) {2}'
		with: anElement
		with: (elementNester printedElementsEnclosedBy: anElement)
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnterminatedIgnoreSections [
	self parseError: 'Unterminated <![IGNORE[...]]> section(s) in external entity'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnterminatedIncludeSections [
	self parseError: 'Unterminated <![INCLUDE[...]]> section(s) in external entity'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorXMLDeclarationNotAtStart [
	self parseError: 'XML declaration can only occur at the start of a document'
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectNext: aCharacter [
	| nextChar |

	"use #= for pre-SpurVM compatibility where wide chars aren't #=="
	(nextChar := streamReader next) = aCharacter
		ifFalse: [
			self
				errorExpectedLiteral: aCharacter
				butGot: nextChar].
	^ nextChar.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectNextAll: aString [
	"uses to:do: and not implemented in terms of #expectNextAll:startingAt:
	for speed"
	1 to: aString size do: [:i | | nextChar |
		"use #= for pre-SpurVM compatibility where wide chars aren't #=="
		(nextChar := streamReader next) = (aString at: i)
			ifFalse: [
				self
					errorExpectedLiteral: aString
					butGot: nextChar
					at: i]].
	^ aString.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectNextAll: aString startingAt: aPosition [
	"to:do: for speed"
	aPosition to: aString size do: [:i | | nextChar |
		"use #= for pre-SpurVM compatibility where wide chars aren't #=="
		(nextChar := streamReader next) = (aString at: i)
			ifFalse: [
				self
					errorExpectedLiteral: aString
					butGot: nextChar
					at: i]].
	^ aString.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectNextVersionDigit [
	| nextChar |

	((nextChar := streamReader next) == nil
		or: [(VersionDigitChars includes: nextChar) not])
		ifTrue: [self errorExpectedVersionDigitButGot: nextChar].
	^ nextChar.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectSeparators [
	"nil understands isXMLSeparator so no nil test is needed"
	streamReader next isXMLSeparator
		ifTrue: [streamReader skipSeparators]
		ifFalse: [self errorExpectedSeparators]
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectSeparatorsInDeclaration [
	"this can be used to replace entity references within declarations"

	[streamReader peek == $%]
		whileTrue: [
			streamReader next.
			self nextParameterEntityReferenceInDeclaration].
	self expectSeparators.
	[streamReader peek == $%]
		whileTrue: [
			streamReader next.
			self nextParameterEntityReferenceInDeclaration.
			streamReader skipSeparators].
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectTerminator [
	| nextChar |

	(nextChar := streamReader next) == $>
		ifFalse: [self errorExpectedTerminatorButGot: nextChar]
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasOpenIncludeSections [
	totalOpenIncludeSections == nil
		ifTrue: [^ false].
	^ totalOpenIncludeSections > 0.
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasPushedBackEntities [
	pushedBackEntities == nil
		ifTrue: [^ false].
	^ pushedBackEntities size > 0.
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasPushedBackEntity: aPushedBackEntity [
	self hasPushedBackEntities
		ifFalse: [^ false].
	self pushedBackEntities do: [:each |
		each entity = aPushedBackEntity entity
			ifTrue: [^ true]].
	^ false.
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> isInExternalSubsetOrExternalEntity [
	"This is used to check for conditional sections and parameter entity
	refs within declarations in the internal subset, which is disallowed.
	
	The way the spec is written and the way Xerces behaves, internal
	entities defined in external entities DO NOT count as 'external'
	for this purpose, even though they were defined externally to
	the document."

	^ state isExternalSubsetState
		or: [self topPushedBackExternalEntity notNil]
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> maxEntityReplacementDepth [
	^ driver maxEntityReplacementDepth
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttlistDeclaration [
	| element defaultPragma |

	self
		expectNextAll: 'ATTLIST';
		expectSeparatorsInDeclaration.

	element := self nextElementName.
	[streamReader peek == $>
		or: [
			self expectSeparatorsInDeclaration.
			streamReader peek == $>]]
		whileFalse: [
			driver
				handleAttributeDeclaration: element
				name: self nextAttributeName
				type: self nextAttributeType
				defaultPragma:
					(defaultPragma := self nextAttributeDefaultPragma)
				defaultValue:
					(self nextAttributeDefaultValueForPragma: defaultPragma)].

	self expectTerminator.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeDefaultPragma [
	self expectSeparatorsInDeclaration.
	streamReader peek == $#
		ifFalse: [^ ''].
	streamReader next.

	streamReader peek == $R
		ifTrue: [^ self expectNextAll: 'REQUIRED'].
	streamReader peek == $I
		ifTrue: [^ self expectNextAll: 'IMPLIED'].
	^ self expectNextAll: 'FIXED'.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeDefaultValueForPragma: aPragma [
	| previousState attributeValue |

	aPragma isEmpty
		ifFalse: [
			(aPragma first == $F) "FIXED"
				ifFalse: [^ ''].
			self expectSeparatorsInDeclaration].
	previousState := state.
	state := state contentState.
	attributeValue := self nextAttributeValue.
	state := previousState.
	^ attributeValue.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeEntityType [
	self expectNextAll: 'ENTIT'.
	streamReader peek == $Y
		ifFalse: [
			^ self
				expectNextAll: 'ENTITIES'
				startingAt: 6 "'ENTITIES' indexOfSubCollection: 'IES'"].
	streamReader next.
	^ 'ENTITY'.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeEnumerationType [
	characterStream
		reset;
		nextPut: (self expectNext: $().

	"must have at least one value in the enumeration"
	self
		skipSeparatorsInDeclaration;
		nextNmtokenOnCharacterStream.
	[self skipSeparatorsInDeclaration.
		streamReader peek == $)]
		whileFalse: [
			characterStream nextPut: (self expectNext: $|).
			self
				skipSeparatorsInDeclaration;
				nextNmtokenOnCharacterStream].

	^ characterStream
		nextPut: streamReader next;
		contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeIDOrIDRefType [
	self expectNextAll: 'ID'.
	streamReader peek == $R
		ifFalse: [^ 'ID'].	
	self
		expectNextAll: 'IDREF'
		startingAt: 3.
	streamReader peek == $S
		ifFalse: [^ 'IDREF'].
	streamReader next.
	^ 'IDREFS'.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextAttributeName [
	| nextChar |

	"nil understands #isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedAttributeName].
	nameStream
		reset;
		nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [nameStream nextPut: streamReader next].
	^ nameStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeNotationEnumerationOrNmtokenType [
	"skip the N"
	streamReader next.
	streamReader peek == $O
		ifTrue: [^ self nextAttributeNotationEnumerationType].
	self
		expectNextAll: 'NMTOKEN'
		startingAt: 2.
	streamReader peek == $S
		ifFalse: [^ 'NMTOKEN'].
	streamReader next.
	^ 'NMTOKENS'.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeNotationEnumerationType [
	characterStream
		reset;
		nextPutAll:
			(self
				expectNextAll: 'NOTATION'
				startingAt: 2). "the 'N' was already read"
	self
		expectSeparatorsInDeclaration;
		expectNext: $(.
	characterStream nextPutAll: ' ('.

	"must have at least one declaration name in the enumeration"
	self
		skipSeparatorsInDeclaration;
		nextNotationNameOnCharacterStream.
	[self skipSeparatorsInDeclaration.
		streamReader peek == $)]
		whileFalse: [
			characterStream nextPut: (self expectNext: $|).
			self
				skipSeparatorsInDeclaration;
				nextNotationNameOnCharacterStream].
	
	^ characterStream
		nextPut: streamReader next;
		contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeType [
	| nextChar |

	self expectSeparatorsInDeclaration.
	(nextChar := streamReader peek) == $C
		ifTrue: [^ self expectNextAll: 'CDATA'].
	nextChar == $I
		ifTrue: [^ self nextAttributeIDOrIDRefType].
	nextChar == $E
		ifTrue: [^ self nextAttributeEntityType].
	nextChar == $N
		ifTrue: [^ self nextAttributeNotationEnumerationOrNmtokenType].
	^ self nextAttributeEnumerationType.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextAttributeValue [
	| quote nextChar |

	((quote := streamReader next) == $"
		or: [quote == $'])
		ifFalse: [self errorExpectedAttributeValueStartButGot: quote].
	
	isInLiteralValue := true.
	characterStream reset.
	[((nextChar := streamReader next) == quote
		and: [isIgnoringLiteralValueTerminator not])
			or: [nextChar == $<
				or: [nextChar == nil]]]
		whileFalse: [
			nextChar == $&
				ifTrue: [
					"char refs should be ignored by whitespace normalization"
					self nextGeneralEntityOrCharacterReferenceOnCharacterStream]
				ifFalse: [
					nextChar isXMLSeparator
						ifTrue: [nextChar := NormalizedSpace]
						ifFalse: [
							nextChar isXMLChar
								ifFalse: [self errorNonCharInAttributeValue: nextChar]].
					characterStream nextPut: nextChar]].
	isInLiteralValue := false.

	nextChar == quote
		ifFalse: [
			self
				errorExpectedAttributeValueEnd: quote
				butGot: nextChar].

	^ characterStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextCDataSection [
	| closingBracketsRead nextChar |

	self expectNextAll: '[CDATA['.
	characterStream reset.
	closingBracketsRead := 0.
	[(nextChar := streamReader next) == nil
		or: [closingBracketsRead == 2
			and: [nextChar == $>]]]
		whileFalse: [
			nextChar == $]
				ifTrue: [
					closingBracketsRead == 2
						ifTrue: [characterStream nextPut: $]]
						ifFalse: [closingBracketsRead := closingBracketsRead + 1]]
				ifFalse: [
					closingBracketsRead == 0
						ifFalse: [
							characterStream nextPut: $].
							closingBracketsRead == 2
								ifTrue: [characterStream nextPut: $]].
							closingBracketsRead := 0].
					nextChar isXMLChar
						ifFalse: [self errorNonCharInCDataSection: nextChar].
					characterStream nextPut: nextChar]].
	nextChar
		ifNil: [self errorExpectedCDataSectionTerminator].
	driver handleCData: characterStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextCharacterReferenceOnCharacterStream [
	"returns the character written to 'characterStream' or $& if
	it wasn't replaced"
	| codePoint |

	"skip #"
	streamReader next.
	(state isContentState
		and: [driver replacesContentEntityReferences not])
		ifTrue: [
			nameStream reset.
			(codePoint := streamReader nextIntegerPrintedOn: nameStream)
				ifNil: [self errorExpectedIntegerCharacterReference].
			(self characterFromCodePoint: codePoint)
				ifNil: [self errorInvalidCharacterReferenceCodePoint: codePoint].
			self expectNext: $;.
			characterStream
				nextPutAll: '&#';
				nextPutAll: nameStream contents;
				nextPut: $;.
			^ $&]
		ifFalse: [| character |
			(codePoint := streamReader nextInteger)
				ifNil: [self errorExpectedIntegerCharacterReference].
			(character := self characterFromCodePoint: codePoint)
				ifNil: [self errorInvalidCharacterReferenceCodePoint: codePoint].
			self expectNext: $;.
			characterStream nextPut: character.
			^ character].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextComment [
	| nextChar |

	"Skip first -"
	streamReader next.
	self expectNext: $-.

	"xml comments can't have '--' in them and must be followed
	by the terminating '>'"
	characterStream reset.
	[(nextChar := streamReader next) == nil
		or: [nextChar == $-
			and: [streamReader peek == $-]]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInComment: nextChar].
			characterStream nextPut: nextChar].
	self
		expectNext: $-;
		expectTerminator.

	driver handleComment: characterStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextConditionalSectionFromEntity: aPushedBackParameterEntity [
	"skip ["
	streamReader next.
	self
		skipSeparatorsInDeclaration;
		expectNext: $I.
	streamReader peek == $N
		ifTrue: [self nextStartIncludeSectionFromEntity: aPushedBackParameterEntity]
		ifFalse: [self nextIgnoreSectionFromEntity: aPushedBackParameterEntity].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextContentMarkupToken [
	self topPushedBackEntity
		ifNil: [
			streamReader peek == $?
				ifTrue: [^ self nextPI].
			streamReader peek == $!
				ifTrue: [
					streamReader next.
					streamReader peek == $-
						ifTrue: [^ self nextComment].
					elementNester isInElement
						ifTrue: [^ self nextCDataSection].
					self errorUnexpectedMarkupDeclarationInContent].
			self nextTag]
		ifNotNil: [:pushedBackGeneralEntity |
			self nextContentMarkupTokenFromEntity: pushedBackGeneralEntity]
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextContentMarkupTokenFromEntity: aPushedBackGeneralEntity [
	streamReader peek == $?
		ifTrue: [self nextPI]
		ifFalse: [
			streamReader peek == $!
				ifTrue: [
					streamReader next.
					streamReader peek == $-
						ifTrue: [self nextComment]
						ifFalse: [
							elementNester isInElement
								ifTrue: [self nextCDataSection]
								ifFalse: [
									self errorUnexpectedMarkupDeclarationInContent]]]
				ifFalse: [| oldTotalOpenElements newTotalOpenElements |
					oldTotalOpenElements := elementNester totalOpenElements.
					self nextTag.
					newTotalOpenElements := elementNester totalOpenElements.
					newTotalOpenElements < oldTotalOpenElements
						ifTrue: [
							aPushedBackGeneralEntity endElement.
							aPushedBackGeneralEntity totalOpenElements >= 0
								ifFalse: [self errorImproperGeneralEntityNesting]]
						ifFalse: [
							newTotalOpenElements > oldTotalOpenElements
								ifTrue: [aPushedBackGeneralEntity startElement]]]].

	self topPushedBackEntity == aPushedBackGeneralEntity
		ifFalse: [self errorImproperGeneralEntityNesting].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModel [
	| pushedBackParameterEntity |

	self expectSeparatorsInDeclaration.
	streamReader peek == $A
		ifTrue: [^ self expectNextAll: 'ANY'].
	streamReader peek == $E
		ifTrue: [^ self expectNextAll: 'EMPTY'].
	
	characterStream
		reset;
		nextPut: (self expectNext: $().
	pushedBackParameterEntity := self topPushedBackEntity.
	self skipSeparatorsInDeclaration.
	streamReader peek == $#
		ifTrue: [
			self nextMixedContentListOnCharacterStreamFromEntity:
				pushedBackParameterEntity]
		ifFalse: [
			self nextContentModelChoiceOrSequenceOnCharacterStreamFromEntity:
				pushedBackParameterEntity].

	^ characterStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelChoiceOrSequenceOnCharacterStreamFromEntity: aPushedBackParameterEntity [
	self
		nextContentModelParticleOnCharacterStream;
		skipSeparatorsInDeclaration.
	streamReader peek == $|
		ifTrue: [
			characterStream nextPut: streamReader next.
			self nextContentModelParticleOnCharacterStream.
			[self skipSeparatorsInDeclaration.
				streamReader peek == $)]
				whileFalse: [
					characterStream nextPut: (self expectNext: $|).
					self nextContentModelParticleOnCharacterStream].
			characterStream nextPut: streamReader next]
		ifFalse: [
			streamReader peek == $,
				ifTrue: [
					characterStream nextPut: streamReader next.
					self nextContentModelParticleOnCharacterStream.
					[self skipSeparatorsInDeclaration.
						streamReader peek == $)]
						whileFalse: [
							characterStream nextPut: (self expectNext: $,).
							self nextContentModelParticleOnCharacterStream].
					characterStream nextPut: streamReader next]
				ifFalse: [characterStream nextPut: (self expectNext: $))]].

	self topPushedBackEntity == aPushedBackParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].
	self nextContentModelUnaryOperatorOnCharacterStream.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelParticleOnCharacterStream [
	self skipSeparatorsInDeclaration.
	streamReader peek == $(
		ifTrue: [
			characterStream nextPut: streamReader next.
			self nextContentModelChoiceOrSequenceOnCharacterStreamFromEntity:
				self topPushedBackEntity]
		ifFalse: [
			self
				nextElementNameOnCharacterStream;
				nextContentModelUnaryOperatorOnCharacterStream]
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelUnaryOperatorOnCharacterStream [
	| nextChar |

	((nextChar := streamReader peek) == $?
		or: [nextChar == $*
			or: [nextChar == $+]])
		ifTrue: [characterStream nextPut: streamReader next]
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextDoctypeDeclarationOrComment [
	"skip !"
	streamReader next.
	streamReader peek == $-
		ifTrue: [^ self nextComment].
	state isPostDoctypeDeclarationState
		ifTrue: [self errorMultipleDoctypeDeclarations].
	self nextDoctypeDeclaration.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextElementDeclaration [
	self
		expectNextAll: 'ELEMENT'
		startingAt: 2. "the 'E' was already read"

	self expectSeparatorsInDeclaration.
	driver
		handleElementDeclaration: self nextElementName
		contentModel: self nextContentModel.
	self
		skipSeparatorsInDeclaration;
		expectTerminator.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextElementName [
	| nextChar |

	"nil understands #isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedElementName].
	nameStream
		reset;
		nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [nameStream nextPut: streamReader next].
	^ nameStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextElementNameOnCharacterStream [
	| nextChar |

	"nil understands #isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedElementName].
	characterStream nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [characterStream nextPut: streamReader next].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextEndDocument [
	state canTerminateInput
		ifFalse: [self errorInputTerminatedPrematurely].
	state isContentState
		ifTrue: [
			elementNester hasOpenElements
				ifTrue: [self errorUnterminatedElements]]
		ifFalse: [
			self hasOpenIncludeSections
				ifTrue: [self errorUnterminatedIncludeSections]].
	super nextEndDocument.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEndIncludeSection [
	"skip ]"
	streamReader next.
	self
		expectNext: $];
		expectTerminator.

	totalOpenIncludeSections := self totalOpenIncludeSections - 1.
	self topPushedBackEntity
		ifNotNil: [:pushedBackParameterEntity |
			pushedBackParameterEntity endIncludeSection.
			pushedBackParameterEntity totalOpenIncludeSections >= 0
				ifFalse: [driver handleImproperParameterEntityNesting]].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEndInternalSubset [
	self hasOpenIncludeSections
		ifTrue: [^ self nextEndIncludeSection].
	"skip ]"
	streamReader next.
	self hasPushedBackEntities
		ifTrue: [self errorParameterEntityTerminatingSubset].
	streamReader skipSeparators.
	self nextEndDoctypeDeclaration.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextEndTag [
	| tagName |
	"Skip /"
	streamReader next.
	(tagName := elementNester currentElement)
		ifNil: [self errorUnexpectedEndTag: self nextElementName].
	1 to: tagName size do: [:i | | nextChar |
		"can't use #== here because wide chars aren't an immediate type
		in pre-Spur VMs"
		(nextChar := streamReader next) = (tagName at: i)
			ifFalse: [
				self
					errorExpectedEndTag: tagName
					butGot: nextChar
					at: i]].
	elementNester endCurrentElement.
	driver handleEndTag: tagName.
	streamReader skipSeparators.
	self expectTerminator.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEntityDeclaration [
	| isParameterEntity name |

	self
		expectNextAll: 'ENTITY'
		startingAt: 2. "the 'E' was already read"

	self isInExternalSubsetOrExternalEntity
		ifTrue: [
			"this is to distinguish a parameter reference from declaration"
			[isParameterEntity isNil]
				whileTrue: [
					streamReader skipSeparators.
					streamReader peek == $%
						ifTrue: [
							streamReader next.
							"nil understands isXMLSeparator so no nil test is needed"
							streamReader peek isXMLSeparator
								ifTrue: [
									isParameterEntity := true.
									self expectSeparatorsInDeclaration]
								ifFalse: [self nextParameterEntityReference]]
						ifFalse: [isParameterEntity := false]]]
		ifFalse: [
			self expectSeparators.
			(isParameterEntity := (streamReader peek == $%))
				ifTrue: [
					streamReader next.
					self expectSeparators]].

	name := self nextEntityName.
	self expectSeparatorsInDeclaration.
	streamReader atQuote
		ifTrue: [
			self
				nextInternalEntityDeclaration: name
				isParameterEntity: isParameterEntity]
		ifFalse: [
			self
				nextExternalEntityDeclaration: name
				isParameterEntity: isParameterEntity].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextEntityName [
	| nextChar |

	"nil understands #isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedEntityName].
	nameStream
		reset;
		nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [nameStream nextPut: streamReader next].
	^ nameStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEntityNameOnCharacterStream [
	| nextChar |

	"nil understands #isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedEntityName].
	characterStream nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [characterStream nextPut: streamReader next].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEntityValue [
	| quote nextChar |

	quote := streamReader next.

	isInLiteralValue := true.
	characterStream reset.
	[((nextChar := streamReader next) == quote
		and: [isIgnoringLiteralValueTerminator not])
			or: [nextChar == nil]]
		whileFalse: [
			nextChar == $&
				ifTrue: [
					streamReader peek == $#
						ifTrue: [
							"character refs are replaced in entity values"
							self nextCharacterReferenceOnCharacterStream]
						ifFalse: [
							"general entity refs aren't replaced but must be complete"
							characterStream nextPut: $&.
							self nextEntityNameOnCharacterStream.
							characterStream nextPut: (self expectNext: $;)]]
				ifFalse: [
					nextChar == $%
						ifTrue: [
							self isInExternalSubsetOrExternalEntity
								ifFalse: [
									self
										errorInternalDeclarationParameterEntityReference].
							self nextParameterEntityReferenceOnCharacterStream]
						ifFalse: [
							nextChar isXMLChar
								ifFalse: [self errorNonCharInEntityValue: nextChar].
							characterStream nextPut: nextChar]]].
	isInLiteralValue := false.

	nextChar == quote
		ifFalse: [
			self
				errorExpectedEntityValueEnd: quote
				butGot: nextChar].

	^ characterStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextExternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| publicID systemID notation |

	streamReader peek == $P
		ifTrue: [
			publicID := self nextPublicIDInDeclaration.
			self expectSeparatorsInDeclaration.
			systemID := self nextSystemIDLiteralWithoutURIFragment]
		ifFalse: [
			publicID := ''.
			systemID := self nextSystemIDInDeclarationWithoutURIFragment].
	aBoolean
		ifTrue: [
			self
				skipSeparatorsInDeclaration;
				expectTerminator.
			driver
				handleParameterEntityDeclaration: aName
				publicID: publicID
				systemID: systemID]
		ifFalse: [
			(streamReader peek == $>
				or: [
					self expectSeparatorsInDeclaration.
					streamReader peek == $>])
				ifTrue: [	
					streamReader next.
					notation := '']
				ifFalse: [
					self
						expectNextAll: 'NDATA';
						expectSeparatorsInDeclaration.
					notation := self nextNotationName.
					self
						skipSeparatorsInDeclaration;
						expectTerminator].
			driver
				handleGeneralEntityDeclaration: aName
				publicID: publicID
				systemID: systemID
				ndata: notation].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextExternalSubsetToken [
	streamReader skipSeparators.
	streamReader atEnd
		ifTrue: [^ self].
	streamReader peek == $%
		ifTrue: [
			streamReader next.
			^ self nextParameterEntityReference].
	streamReader peek == $]
		ifTrue: [
			self hasOpenIncludeSections
				ifFalse: [self errorUnexpectedEndConditionalSection].
			^ self nextEndIncludeSection].
	self nextSubsetMarkupToken.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextGeneralEntityOrCharacterReferenceOnCharacterStream [
	"returns the character written to 'characterStream' if any, nil otherwise"
	| pushedBackGeneralEntity result |

	pushedBackGeneralEntity := self topPushedBackEntity.
	result :=
		streamReader peek == $#
			ifTrue: [self nextCharacterReferenceOnCharacterStream]
			ifFalse: [self nextGeneralEntityReferenceOnCharacterStream].
	pushedBackGeneralEntity
		ifNotNil: [
			(self pushedBackEntities includes: pushedBackGeneralEntity)
				ifFalse: [self errorImproperGeneralEntityNesting]].

	^ result.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextGeneralEntityReferenceOnCharacterStream [
	"returns the (first) character written to 'characterStream' if any,
	nil otherwise"
	| name |

	name := self nextEntityName.
	self expectNext: $;.
	PredefinedEntities
		at: name
		ifPresent: [:character |
			driver replacesContentEntityReferences
				ifFalse: [^ self nextUnreplacedGeneralEntityOnCharacterStreamNamed: name].
			characterStream nextPut: character.
			^ character].

	(driver handleGeneralEntityReference: name)
		ifNil: [
			(driver replacesContentEntityReferences not
				or: [driver preservesUndeclaredEntityReferences])
				ifTrue: [^ self nextUnreplacedGeneralEntityOnCharacterStreamNamed: name].
			driver handleUnreplacedGeneralEntityReference: name]
		ifNotNil: [:entity |
			entity isUnparsed
				ifTrue: [self errorReferenceToUnparsedGeneralEntity: entity].
			driver replacesContentEntityReferences
				ifFalse: [^ self nextUnreplacedGeneralEntityOnCharacterStreamNamed: name].
			self constructReplacementForGeneralEntity: entity].
	^ nil.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextIgnoreSectionFromEntity: aPushedBackParameterEntity [
	| openSections firstChar secondChar nextChar |

	self
		expectNextAll: 'IGNORE'
		startingAt: 2. "the 'I' was already read"
	streamReader skipSeparators.
	self expectNext: $[.

	"the 'IGNORE' can be in the replacement of an entity, like
	in '<![%entity[...]]>', but after it the entity that started
	the declaration must be current"
	self topPushedBackEntity == aPushedBackParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].

	"From the spec:
	The contents of an ignored conditional section MUST be parsed by
	ignoring all characters after the '[' following the keyword, except
	conditional section starts '<![' and ends ']]>', until the matching
	conditional section end is found. Parameter entity references MUST
	NOT be recognized in this process."
	openSections := 1.
	[openSections == 0
		or: [(nextChar := streamReader next) == nil]]
		whileFalse: [
			nextChar == $>
				ifTrue: [
					(secondChar == $]
						and: [firstChar == $]])
						ifTrue: [openSections := openSections - 1]]
				ifFalse: [
					nextChar == $[
						ifTrue: [
							(secondChar == $!
								and: [firstChar == $<])
								ifTrue: [openSections := openSections + 1]]].
			firstChar := secondChar.
			secondChar := nextChar].

	openSections == 0
		ifFalse: [self errorUnterminatedIgnoreSections].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextInternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| value |

	value := self nextEntityValue.
	self
		skipSeparatorsInDeclaration;
		expectTerminator.

	aBoolean
		ifTrue: [
			driver
				handleParameterEntityDeclaration: aName
				replacement: value]
		ifFalse: [
			driver
				handleGeneralEntityDeclaration: aName
				replacement: value].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextMixedContentListOnCharacterStreamFromEntity: aPushedBackParameterEntity [
	| hasElements |

	hasElements := false.
	characterStream nextPutAll: (self expectNextAll: '#PCDATA').

	[self skipSeparatorsInDeclaration.
		streamReader peek == $)]
		whileFalse: [
			characterStream nextPut: (self expectNext: $|).
			hasElements := true.
			self
				skipSeparatorsInDeclaration;
				nextElementNameOnCharacterStream].
	characterStream nextPut: streamReader next.
	self topPushedBackEntity == aPushedBackParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].

	streamReader peek == $*
		ifTrue: [characterStream nextPut: streamReader next]
		ifFalse: [
			hasElements
				ifTrue: [self errorExpectedLiteral: $*]].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNmtokenOnCharacterStream [
	"matches the Nmtoken production"
	| nextChar |

	"nil understands #isXMLNameChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameChar
		ifFalse: [self errorExpectedNmtoken].
	characterStream nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [characterStream nextPut: streamReader next].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextNonElementWhitespace [
	| nextChar |

	"nil understands isXMLSeparator so it is not tested for first"
	[(nextChar := streamReader peek) isXMLSeparator]
		whileTrue: [streamReader next].
	(nextChar == $<
		or: [nextChar == nil])
		ifFalse: [self errorNonElementPCDataCharacter: streamReader next].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextNonPIPrologOrContentMarkupToken [
	streamReader peek == $!
		ifTrue: [^ self nextDoctypeDeclarationOrComment].
	self
		nextStartContent;
		nextTag.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNotationDeclaration [
	| name publicID systemID |

	self
		expectNextAll: 'NOTATION';
		expectSeparatorsInDeclaration.

	name := self nextNotationName.
	self expectSeparatorsInDeclaration.
	streamReader peek == $P
		ifTrue: [
			publicID := self nextPublicIDInDeclaration.
			(streamReader peek == $>
				or: [
					self expectSeparatorsInDeclaration.
					streamReader peek == $>])
				ifFalse: [systemID := self nextSystemIDLiteral]]
		ifFalse: [systemID := self nextSystemIDInDeclaration].
	self
		skipSeparatorsInDeclaration;
		expectTerminator.

	driver
		handleNotationDeclaration: name
		publicID: (publicID ifNil: [''])
		systemID: (systemID ifNil: ['']).
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNotationName [
	| nextChar |

	"nil understands #isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedNotationName].
	nameStream
		reset;
		nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [nameStream nextPut: streamReader next].
	^ nameStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNotationNameOnCharacterStream [
	| nextChar |

	"nil understands #isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedNotationName].
	characterStream nextPut: nextChar.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [characterStream nextPut: streamReader next].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPCDataToken [
	| isWhitespace nextChar closingBracketsRead |

	isWhitespace := true.
	characterStream reset.
	closingBracketsRead := 0.
	[(nextChar := streamReader peek) == $<
		or: [nextChar == nil]]
		whileFalse: [
			streamReader next == $&
				ifTrue: [
					self nextGeneralEntityOrCharacterReferenceOnCharacterStream
						ifNotNil: [:writtenChar |
							isWhitespace
								ifTrue: [isWhitespace := writtenChar isXMLSeparator]]]
				ifFalse: [
					(isWhitespace
						and: [isWhitespace := nextChar isXMLSeparator])
						ifFalse: [
							nextChar == $]
								ifTrue: [
									isWhitespace := false.
									closingBracketsRead := closingBracketsRead + 1]
								ifFalse: [
									closingBracketsRead == 0
										ifFalse: [
											(closingBracketsRead >= 2
												and: [nextChar == $>])
												ifTrue: [
													self errorUnexpectedCDataTerminator].
											closingBracketsRead := 0].
									nextChar isXMLChar
										ifFalse: [self errorNonCharInPCData: nextChar]]].
					characterStream nextPut: nextChar]].
	isWhitespace
		ifTrue: [
			characterStream position == 0
				ifFalse: [driver handleWhitespace: characterStream contents]]
		ifFalse: [driver handlePCData: characterStream contents].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPIData [
	| nextChar |

	characterStream reset.
	[(nextChar := streamReader next) == nil
		or: [nextChar == $?
			and: [streamReader peek == $>]]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInPIValue: nextChar].
			characterStream nextPut: nextChar].
	self expectTerminator.
	^ characterStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPITarget [
	"PITarget	   ::=   	Name - (('X' | 'x') ('M' | 'm') ('L' | 'l'))"
	| nextChar isReservedTarget isLowercaseReservedTarget length |

	nameStream reset.
	(nextChar := streamReader next) == $x
		ifTrue: [
			isReservedTarget := true.
			isLowercaseReservedTarget := true]
		ifFalse:[
			nextChar == $X
				ifTrue: [isReservedTarget := true]
				ifFalse: [
					"nil understands #isXMLNameStartChar so it does
					not need to be tested for"
					nextChar isXMLNameStartChar
						ifFalse: [self errorExpectedPITarget].
					isReservedTarget := false].
			isLowercaseReservedTarget := false].
	nameStream nextPut: nextChar.
	length := 1.

	"nil understands #isXMLNameChar so it does not need to be tested for"
	[streamReader peek isXMLNameChar]
		whileTrue: [
			nextChar := streamReader next.
			length := length + 1.
			isReservedTarget
				ifTrue: [
					(length <= 3
						and: [
							nextChar == ('xml' at: length)
								or: [
									isLowercaseReservedTarget := false.
									nextChar == ('XML' at: length)]])
						ifFalse: [
							isReservedTarget := false.
							isLowercaseReservedTarget := false]].
			nameStream nextPut: nextChar].
	
	(isReservedTarget
		and: [length = 3])
		ifTrue: [
			isLowercaseReservedTarget
				ifTrue: [
					state isXMLDeclarationState
						ifFalse: [self errorXMLDeclarationNotAtStart].
					"return nil to indicate it's an XML declaration, not a PI"
					^ nil].
			"a reserved target other than lowercase 'xml' for XML declarations
			is never allowed"
			self errorReservedPITarget: nameStream contents].
	^ nameStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReference [
	| pushedBackParameterEntity name |

	pushedBackParameterEntity := self topPushedBackEntity.
	name := self nextEntityName.
	self expectNext: $;.
	self topPushedBackEntity == pushedBackParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].

	(driver handleParameterEntityReference: name)
		ifNotNil: [:entity | self constructReplacementForParameterEntity: entity].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReferenceInDeclaration [
	self isInExternalSubsetOrExternalEntity
		ifFalse: [self errorInternalDeclarationParameterEntityReference].
	self nextParameterEntityReference.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReferenceOnCharacterStream [
	| pushedBackParameterEntity name |

	pushedBackParameterEntity := self topPushedBackEntity.
	name := self nextEntityName.
	self expectNext: $;.
	self topPushedBackEntity == pushedBackParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].
	
	(driver handleParameterEntityReference: name)
		ifNil: [
			driver preservesUndeclaredEntityReferences
				ifTrue: [
					characterStream
						nextPut: $%;
						nextPutAll: name;
						nextPut: $;.
					^ $%]]
		ifNotNil: [:entity |
			self constructReplacementForParameterEntity: entity].
	^ nil.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPrologToken [
	streamReader skipSeparators.
	self expectNext: $<.
	streamReader peek == $?
		ifTrue: [^ self nextPI].
	self nextNonPIPrologOrContentMarkupToken.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextPublicIDInDeclaration [
	^ self
		expectNextAll: 'PUBLIC';
		expectSeparatorsInDeclaration;
		nextPublicIDLiteral
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextPublicIDLiteral [
	"this returns the pubid with leading and trailing whitespace removed
	and all other whitespace sequences converted to single spaces"
	| quote isInWhitespace nextChar |

	((quote := streamReader next) == $"
		or: [quote == $'])
		ifFalse: [self errorExpectedPublicIDLiteralStartButGot: quote].

	characterStream reset.
	isInWhitespace := false.
	"it's not enough to test for nil and PublicIDChars inclusion because
	(PublicIDChars includes: $') = true (double quoted pubids can contain
	single quotes), so the terminating quote must be tested for first to
	handle single quoted pubids correctly"
	[(nextChar := streamReader next) == nil
		or: [nextChar == quote
			or: [(PublicIDChars includes: nextChar) not]]]
		whileFalse: [
			nextChar isXMLSeparator
				ifTrue: [
					isInWhitespace
						ifFalse: [isInWhitespace := true]]
				ifFalse: [
					isInWhitespace
						ifTrue: [
							characterStream position > 0
								ifTrue: [characterStream nextPut: NormalizedSpace].
							isInWhitespace := false].
					characterStream nextPut: nextChar]].

	nextChar == quote
		ifFalse: [
			self
				errorExpectedPublicIDLiteralEnd: quote
				butGot: nextChar].

	^ characterStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextStartExternalEntity [
	driver decodesCharacters
		ifTrue: [streamReader detectEncoding]
		ifFalse: [streamReader decodeStreamWithNullConverter].
	self nextXMLTextDeclaration.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextStartExternalSubset [
	self nextXMLTextDeclaration.
	state := state externalSubsetState.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextStartIncludeSectionFromEntity: aPushedBackParameterEntity [
	self
		expectNextAll: 'INCLUDE'
		startingAt: 2. "the 'I' was already read"
	streamReader skipSeparators.
	self expectNext: $[.

	"the 'INCLUDE' can be in the replacement of an entity, like
	in '<![%entity[...]]>', but after it the entity that started
	the declaration must be current"
	self topPushedBackEntity == aPushedBackParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].

	totalOpenIncludeSections := self totalOpenIncludeSections + 1.
	aPushedBackParameterEntity
		ifNotNil: [aPushedBackParameterEntity startIncludeSection].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSubsetDeclaration [
	streamReader peek == $E
		ifTrue: [
			streamReader next.
			streamReader peek == $N
				ifTrue: [^ self nextEntityDeclaration]
				ifFalse: [^ self nextElementDeclaration]].
	streamReader peek == $A
		ifTrue: [^ self nextAttlistDeclaration].
	streamReader peek == $N
		ifTrue: [^ self nextNotationDeclaration].

	self errorExpectedSubsetDeclaration.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSubsetMarkupToken [
	| pushedBackParameterEntity |

	self expectNext: $<.
	pushedBackParameterEntity := self topPushedBackEntity.

	streamReader peek == $?
		ifTrue: [self nextPI]
		ifFalse: [
			self expectNext: $!.
			streamReader peek == $-
				ifTrue: [self nextComment]
				ifFalse: [
					streamReader peek == $[
						ifTrue: [
							self isInExternalSubsetOrExternalEntity
								ifFalse: [self errorInternalSubsetConditionalSection].
							self nextConditionalSectionFromEntity:
								pushedBackParameterEntity]
						ifFalse: [self nextSubsetDeclaration]]].

	self topPushedBackEntity == pushedBackParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemIDInDeclaration [
	^ self
		expectNextAll: 'SYSTEM';
		expectSeparatorsInDeclaration;
		nextSystemIDLiteral
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemIDInDeclarationWithoutURIFragment [
	^ self
		expectNextAll: 'SYSTEM';
		expectSeparatorsInDeclaration;
		nextSystemIDLiteralWithoutURIFragment
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemIDLiteral [
	^ self nextSystemIDLiteralWithoutURIFragment: false
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemIDLiteralWithoutURIFragment [
	^ self nextSystemIDLiteralWithoutURIFragment: true
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemIDLiteralWithoutURIFragment: aBoolean [
	"Returns the system ID literal.
	If aBoolean is true, it disallows '#' URI fragments."

	| quote nextChar |

	((quote := streamReader next) == $"
		or: [quote == $'])
		ifFalse: [self errorExpectedSystemIDLiteralStartButGot: quote].

	characterStream reset.
	[(nextChar := streamReader next) == nil
		or: [nextChar == quote]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInSystemID: nextChar].
			aBoolean
				ifTrue: [
					nextChar == $#
						ifTrue: [self errorURIFragmentInSystemID]].
			characterStream nextPut: nextChar].

	nextChar == quote
		ifFalse: [
			self
				errorExpectedSystemIDLiteralEnd: quote
				butGot: nextChar].

	^ characterStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextTag [
	"performance critical method"
	| tagName attributes nextChar |

	(streamReader peek == $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextElementName.

	"nil understands isXMLSeparator so is not tested for"
	[(nextChar := streamReader peek) isXMLSeparator
		and: [
			streamReader
				next;
				skipSeparators.
			((nextChar := streamReader peek) == $>
				or: [nextChar == $/]) not]]
		whileTrue: [| attributeName |
			attributeName := self nextAttributeName.
			streamReader skipSeparators.
			(nextChar := streamReader next) == $=
				ifFalse: [
					self errorExpectedAttributeNameValueSeparatorButGot: nextChar].
			streamReader skipSeparators.

			"delay initializing 'attributes' until now to know for sure if it
			needs a non-zero capacity, otherwise use the lazy version"
			((attributes
				ifNil: [attributes := driver newAttributeDictionary])
				at: attributeName
				newPut: self nextAttributeValue)
				ifFalse: [self errorDuplicateAttribute: attributeName].

			"the ordering of these tests is optimized"
			(attributeName at: 1) == $x
				ifTrue: [
					driver hasUnhandledReservedAttributes
						ifFalse: [
							attributeName isXMLReservedAttributeName
								ifTrue: [driver haveUnhandledReservedAttributes]]]].

	elementNester wasRootElementEnded
		ifTrue: [self errorMultipleDocumentRootElements].
	elementNester startElement: tagName.
	driver
		handleStartTag: tagName
		attributes:
			(attributes
				ifNil: [driver newEmptyAttributeDictionary]).

	nextChar == $/
		ifTrue: [
			streamReader next.
			elementNester endCurrentElement.
			driver handleEndTag: tagName].

	self expectTerminator.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextUnreplacedGeneralEntityOnCharacterStreamNamed: aName [
	driver handleUnreplacedGeneralEntityReference: aName.
	characterStream
		nextPut: $&;
		nextPutAll: aName;
		nextPut: $;.
	^ $&.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextXMLEncodingAttributeValue [
	| quote nextChar |

	((quote := streamReader next) == $"
		or: [quote == $'])
		ifFalse: [self errorExpectedXMLEncodingValueStartButGot: quote].

	((nextChar := streamReader next) notNil
		and: [EncodingNameStartChars includes: nextChar])
		ifFalse: [self errorExpectedEncodingName].

	xmlDeclarationStream
		reset;
		nextPut: nextChar.
	[(nextChar := streamReader next) == nil
		or: [(EncodingNameChars includes: nextChar) not]]
		whileFalse: [xmlDeclarationStream nextPut: nextChar].

	nextChar == quote
		ifFalse: [
			self
				errorExpectedXMLEncodingValueEnd: quote
				butGot: nextChar].

	^ xmlDeclarationStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextXMLStandaloneAttributeValue [
	| quote yesOrNo nextChar |

	((quote := streamReader next) == $"
		or: [quote == $'])
		ifFalse: [self errorExpectedXMLStandaloneValueStartButGot: quote].

	yesOrNo := 
		streamReader peek == $y
			ifTrue: [self expectNextAll: 'yes']
			ifFalse: [self expectNextAll: 'no'].

	(nextChar := streamReader next) == quote
		ifFalse: [
			self
				errorExpectedXMLStandaloneValueEnd: quote
				butGot: nextChar].

	^ yesOrNo.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextXMLTextDeclaration [
	| encoding |
	
	1 to: 5 "'<?xml' size" do: [:i |
		streamReader peek == ('<?xml' at: i)
			ifFalse: [
				i > 1
					ifTrue: [
						streamReader pushBack:
							('<?xml'
								copyFrom: 1
								to: i - 1)].
				^ self].
		streamReader next].

	self expectSeparators.
	(self nextXMLVersionAttributeRequired: false) isEmpty
		ifFalse: [self expectSeparators].
	(encoding := self nextXMLEncodingAttributeRequired: true) isEmpty
		ifFalse: [self convertFromEncoding: encoding].

	streamReader skipSeparators.
	self
		expectNext: $?;
		expectTerminator.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextXMLVersionAttributeValue [
	| quote nextChar |

	((quote := streamReader next) == $"
		or: [quote == $'])
		ifFalse: [self errorExpectedXMLVersionValueStartButGot: quote].

	xmlDeclarationStream
		reset;
		nextPut: self expectNextVersionDigit;
		nextPut: (self expectNext: $.);
		nextPut: self expectNextVersionDigit.

	[(nextChar := streamReader next) == nil
		or: [(VersionDigitChars includes: nextChar) not]]
		whileFalse: [xmlDeclarationStream nextPut: nextChar].

	nextChar == quote
		ifFalse: [
			self
				errorExpectedXMLVersionValueEnd: quote
				butGot: nextChar].

	^ xmlDeclarationStream contents.
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> pushBackEntity: anEntity whenPoppedDo: aBlock [
	anEntity hasReplacement
		ifTrue: [| pushedBackEntity |
			pushedBackEntity :=
				self addPushedBackEntity: anEntity asPushedBackEntity.
			streamReader
				pushBackStream: pushedBackEntity replacementStream
				whenPoppedDo: [
					self removePushedBackEntity: pushedBackEntity.
					aBlock
						ifNotNil: [aBlock value]]
				isExternal: pushedBackEntity isExternal.
			pushedBackEntity isExternal
				ifTrue: [self nextStartExternalEntity]]
		ifFalse: [
			aBlock
				ifNotNil: [aBlock value]]
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> pushedBackEntities [
	^ pushedBackEntities
		ifNil: [pushedBackEntities := OrderedCollection new: 5]
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> removePushedBackEntity: aPushedBackEntity [
	self pushedBackEntities remove: aPushedBackEntity.
	driver currentEntity: self topPushedBackEntity.
	aPushedBackEntity isExternal
		ifTrue: [
			self topPushedBackExternalEntity
				ifNil: [
					driver baseURI: nil]
				ifNotNil: [:pushedBackExternalEntity |
					driver baseURI: pushedBackExternalEntity uri]].
	^ aPushedBackEntity poppedByTokenizer: self.
]

{ #category : #initialization }
XMLWellFormedParserTokenizer >> setDriver: aDriver stream: aStream readLimit: anInteger [
	super
		setDriver: aDriver
		stream: aStream
		readLimit: anInteger.

	isInLiteralValue := false.
	isIgnoringLiteralValueTerminator := false.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> skipSeparatorsInDeclaration [
	"this can be used to replace references within declarations"

	streamReader skipSeparators.
	[streamReader peek == $%]
		whileTrue: [
			streamReader next.
			self nextParameterEntityReferenceInDeclaration.
			streamReader skipSeparators].
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> topPushedBackEntity [
	"heavily optimized"
	pushedBackEntities == nil
		ifTrue: [^ nil].
	pushedBackEntities size > 0
		ifFalse: [^ nil].
	^ pushedBackEntities at: pushedBackEntities size.
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> topPushedBackExternalEntity [
	self pushedBackEntities reverseDo: [:each |
		each isExternal
			ifTrue: [^ each]].
	^ nil.
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> totalOpenIncludeSections [
	^ totalOpenIncludeSections ifNil: [totalOpenIncludeSections := 0]
]

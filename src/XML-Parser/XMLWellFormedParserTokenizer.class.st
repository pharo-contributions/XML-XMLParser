"
This is a tokenizer for well-formed XML documents that supports DTD subsets and entity replacement.
"
Class {
	#name : #XMLWellFormedParserTokenizer,
	#superclass : #XMLParserTokenizer,
	#instVars : [
		'pushedBackEntities',
		'openIncludeSections'
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

	(EncodingNameChars := BitmapCharacterSet new)
		addRangeFrom: $a to: $z;
		addRangeFrom: $A to: $Z;
		addRangeFrom: $0 to: $9;
		addAll: '-_.'
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeEncodingNameStartChars [
	"Character>>isLetter is not used because it may return true for non-ASCII
	letters depending on the locale.
	
	EncName ::= [A-Za-z] ([A-Za-z0-9._] | '-')*"

	(EncodingNameStartChars := BitmapCharacterSet new)
		addRangeFrom: $a to: $z;
		addRangeFrom: $A to: $Z
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeNormalizedSpace [
	NormalizedSpace := Character space
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializePublicIDChars [
	"PubidChar ::= #x20 | #xD | #xA | [a-zA-Z0-9] | [-'()+,./:=?;!*#@$_%]"

	(PublicIDChars := BitmapCharacterSet new)
		add: 16r20 asCharacter;
		add: 16rD asCharacter;
		add: 16rA asCharacter;
		addRangeFrom: $a to: $z;
		addRangeFrom: $A to: $Z;
		addRangeFrom: $0 to: $9;
		addAll: '-''()+,./:=?;!*#@$_%'
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeVersionDigitChars [
	"Character>>isDigit is not used because it may return true for non-ASCII
	digits depending on the locale.
	
	VersionNum ::= '1.' [0-9]+"

	(VersionDigitChars := BitmapCharacterSet new)
		addRangeFrom: $0 to: $9
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> addPushedBackEntity: aPushedBackEntity [
	(self hasPushedBackEntityNamed: aPushedBackEntity name)
		ifTrue: [self errorSelfReferentialEntity: aPushedBackEntity].

	self maxEntityReplacementDepth
		ifNotNil: [:maxDepth |
			self pushedBackEntities size >= maxDepth
				ifTrue: [self errorEntityDepthLimitExceeded]].
	
	self pushedBackEntities addLast: aPushedBackEntity.
	aPushedBackEntity isExternal
		ifTrue: [driver pushEntityURI: aPushedBackEntity uri].

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
XMLWellFormedParserTokenizer >> checkNestingOfParameterEntity: aParameterEntity [
	aParameterEntity
		ifNil: [
			self topPushedBackEntity
				ifNotNil: [driver handleImproperParameterEntityNesting]]
		ifNotNil: [
			self topPushedBackEntity == aParameterEntity
				ifFalse: [driver handleImproperParameterEntityNesting]].
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> constructReplacementForGeneralEntity: anEntity [
	context isLiteralValueContext
		ifTrue: [
			anEntity isExternal
				ifTrue: [self errorLiteralContextExternalEntity: anEntity].
			self constructReplacementForLiteralContextEntity: anEntity]
		ifFalse: [
			driver handleStartContentEntityReplacement: anEntity name.
			self
				pushBackEntity: anEntity
				onClose: [driver handleEndContentEntityReplacement: anEntity name]]
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> constructReplacementForLiteralContextEntity: anEntity [
	| wasEscapingQuotes |

	wasEscapingQuotes := streamReader isEscapingQuotes.
	self
		pushBackEntity: anEntity
		onClose: [streamReader isEscapingQuotes: wasEscapingQuotes].

	"wait till after the text declaration was read to start escaping"
	self topPushedBackEntity
		ifNotNil: [:pushedBackEntity |
			pushedBackEntity == anEntity
				ifTrue: [streamReader isEscapingQuotes: true]].
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> constructReplacementForParameterEntity: anEntity [
	context isLiteralValueContext
		ifTrue: [self constructReplacementForLiteralContextEntity: anEntity]
		ifFalse: [
			streamReader pushBackCharacter: NormalizedSpace.
			self
				pushBackEntity: anEntity
				onClose: nil.
			streamReader pushBackCharacter: NormalizedSpace]
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorDocumentTerminatedPrematurely [
	self parseError: 'Document terminated prematurely'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorDuplicateAttribute: anAttributeName [
	self
		formatParseError: 'Duplicate attribute "{1}" in start tag'
		with: anAttributeName
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorEntityDepthLimitExceeded [
	XMLLimitException signal: 
		'Cannot further nest entity replacements; ',
		'use #maxEntityReplacementDepth: to change or disable'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeNameValueSeparator [
	self errorExpected: 'attribute name-value "=" separator'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeValueEndButGot: aCharacter [
	aCharacter == $<
		ifTrue: [self parseError: 'Attribute value contains illegal "<" character']
		ifFalse: [self errorExpected: 'end of quoted attribute value']
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeValueStart [
	self errorExpected: 'start of quoted attribute value'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedCDataSectionTerminator [
	self errorExpected: 'end of CDATA section "]]>" terminator'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedEncodingName [
	self errorExpected: 'encoding name in <?xml ...?> encoding attribute'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedIntegerCharacterReference [
	self errorExpected:
		'decimal or hex integer after "&#" character reference start'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: aString butGot: aCharacter at: aStringPosition [
	| oldPosition receivedString |

	oldPosition := streamReader currentPosition.
	receivedString :=
		(aString
			copyReplaceFrom: aStringPosition
			to: aString size
			with:
				(aCharacter ifNil: ['']) asString,
				(streamReader next: aString size - aStringPosition)).

	"more accurately estimate where the error occured"
	streamReader
		currentPosition: oldPosition - aStringPosition + 1;
		currentLineNumber:
			streamReader currentLineNumber -
				(receivedString occurrencesOf: streamReader normalizedLineEndingChar).

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
XMLWellFormedParserTokenizer >> errorExpectedQuoteButGot: aCharacter [
	self
		errorExpected: 'single ('') or double (") quote character delimiter'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedSeparators [
	self errorExpected: 'one or more whitespace characters'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedSubsetDeclaration [
	self errorExpected:
		'DTD subset ELEMENT, ENTITY, ATTLIST, or NOTATION declaration'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedTerminatorButGot: aCharacter [
	self
		errorExpected: '">" terminator'
		butGot: aCharacter
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorImproperGeneralEntityNesting [
	self parseError:
		'Markup tokens must start and end in the same general entity replacement'
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
XMLWellFormedParserTokenizer >> errorLiteralContextExternalEntity: anEntity [
	self
		formatParseError: 'External general entity reference {1} in literal context'
		with: anEntity asReference
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorMultipleDoctypeDeclarations [
	self parseError: 'Multiple <!DOCTYPE ...> declarations'
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
XMLWellFormedParserTokenizer >> errorParameterEntityTerminatingSubset [
	self parseError: 'Parameter entity replacement cannot terminate internal subset'
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
XMLWellFormedParserTokenizer >> errorUnexpectedCDataTerminator [
	self parseError: 'Unexpected CDATA "]]>" terminator in PCDATA'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnexpectedEndConditionalSection [
	self parseError: 'Unexpected "]" end of conditional section in external entity'
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

	(nextChar := streamReader next) = aCharacter
		ifFalse: [
			self
				errorExpectedLiteral: aCharacter
				butGot: nextChar].
	^ nextChar.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectNextAll: aString [
	"uses to:do: and not implemented in terms of expectNextAll:startingAt:
	for speed"
	1 to: aString size do: [:i | | nextChar |
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
		(nextChar := streamReader next) = (aString at: i)
			ifFalse: [
				self
					errorExpectedLiteral: aString
					butGot: nextChar
					at: i]].
	^ aString.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectQuote [
	| nextChar |

	((nextChar := streamReader next) == $"
		or: [nextChar == $'])
		ifFalse: [self errorExpectedQuoteButGot: nextChar].
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

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectVersionDigit [
	| nextChar |

	((nextChar := streamReader next) notNil
		and: [VersionDigitChars includes: nextChar])
		ifFalse: [
			self
				errorExpected: 'XML version digit'
				butGot: nextChar].
	^ nextChar.
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasOpenIncludeSections [
	openIncludeSections == nil
		ifTrue: [^ false].
	^ openIncludeSections size > 0.
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasPushedBackEntities [
	pushedBackEntities == nil
		ifTrue: [^ false].
	^ pushedBackEntities size > 0.
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasPushedBackEntityNamed: aName [
	^ self hasPushedBackEntities
		and: [self pushedBackEntities anySatisfy: [:each | each name = aName]]
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> isInExternalSubsetOrExternallyDefinedEntity [
	"this is used to check for conditional sections and
	parameter entity refs within declarations within the
	internal subset, which are disallowed"

	context isExternalSubsetContext
		ifTrue: [^ true].
	self hasPushedBackEntities
		ifTrue: [
			self pushedBackEntities do: [:each |
				(each isInternalTo: driver documentURI)
					ifFalse: [^ true]]].
	^ false.
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

	element := self nextName.
	[streamReader peek == $>
		or: [
			self expectSeparatorsInDeclaration.
			streamReader peek == $>]]
		whileFalse: [
			driver
				handleAttributeDeclaration: element
				name: self nextName
				type: self nextAttributeType
				defaultPragma: (defaultPragma := self nextAttributeDefaultPragma)
				defaultValue: (self nextAttributeDefaultValueForPragma: defaultPragma)].
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
	| previousContext attributeValue |

	aPragma isEmpty
		ifFalse: [
			(aPragma first == $F) "FIXED"
				ifFalse: [^ ''].
			self expectSeparatorsInDeclaration].
	previousContext := context.
	context := context contentContext.
	attributeValue := self nextAttributeValue.
	context := previousContext.
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
	writeStream
		reset;
		nextPut: (self expectNext: $().
	self
		skipSeparatorsInDeclaration;
		nextNmtokenOnWriteStream;
		skipSeparatorsInDeclaration.
	[streamReader peek == $)]
		whileFalse: [
			writeStream nextPut: (self expectNext: $|).
			self
				skipSeparatorsInDeclaration;
				nextNmtokenOnWriteStream;
				skipSeparatorsInDeclaration].
	writeStream nextPut: streamReader next.

	^ writeStream contents.
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
	writeStream
		reset;
		nextPutAll:
			(self
				expectNextAll: 'NOTATION'
				startingAt: 2). "the 'N' was already read"
	self
		expectSeparatorsInDeclaration;
		expectNext: $(.
	writeStream nextPutAll: ' ('.

	self
		skipSeparatorsInDeclaration;
		nextNameOnWriteStream;
		skipSeparatorsInDeclaration;
		nextNameListOnWriteStream.

	^ writeStream contents.
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
		ifFalse: [self errorExpectedAttributeValueStart].
	
	context enterLiteralValue.
	writeStream reset.
	[(nextChar := streamReader next) == quote
		or: [nextChar == $<
			or: [nextChar == nil]]]
		whileFalse: [
			nextChar == $&
				ifTrue: [
					"char refs should be ignored by whitespace normalization"
					self nextGeneralEntityOrCharacterReferenceOnWriteStream]
				ifFalse: [
					nextChar isXMLSeparator
						ifTrue: [nextChar := NormalizedSpace]
						ifFalse: [
							nextChar isXMLChar
								ifFalse: [self errorNonCharInAttributeValue: nextChar]].
					writeStream nextPut: nextChar]].
	context exitLiteralValue.

	nextChar == quote
		ifFalse: [self errorExpectedAttributeValueEndButGot: nextChar].

	^ writeStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextCDataSection [
	| wasTerminated nextChar |

	self expectNextAll: '[CDATA['.
	writeStream reset.
	wasTerminated := false.
	[streamReader atEnd
		or: [(nextChar := streamReader next) == $]
			and: [wasTerminated := streamReader nextMatch: $] followedBy: $>]]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInCDataSection: nextChar].
			writeStream nextPut: nextChar].
	wasTerminated
		ifFalse: [self errorExpectedCDataSectionTerminator].
	driver handleCData: writeStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextCharacterReferenceOnWriteStream [
	"returns the character written to the stream or $& if it wasn't replaced"
	| codePoint |

	"skip #"
	streamReader next.
	(context isContentContext
		and: [driver replacesContentEntityReferences not])
		ifTrue: [
			nameStream reset.
			(codePoint := streamReader nextIntegerPrintedOn: nameStream)
				ifNil: [self errorExpectedIntegerCharacterReference].
			(self characterFromCodePoint: codePoint)
				ifNil: [self errorInvalidCharacterReferenceCodePoint: codePoint].
			self expectNext: $;.
			writeStream
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
			writeStream nextPut: character.
			^ character].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextComment [
	| nextChar |

	"Skip first -"
	streamReader next.
	self expectNext: $-.

	"xml comments can't have '--' unless followed by the terminating '>'"
	writeStream reset.
	[(nextChar := streamReader next) == nil
		or: [nextChar == $-
			and: [streamReader peek == $-]]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInComment: nextChar].
			writeStream nextPut: nextChar].
	self
		expectNext: $-;
		expectTerminator.

	driver handleComment: writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextConditionalSectionFromEntity: aParameterEntity [
	"skip ["
	streamReader next.
	self
		skipSeparatorsInDeclaration;
		expectNext: $I.
	streamReader peek == $N
		ifTrue: [self nextStartIncludeSectionFromEntity: aParameterEntity]
		ifFalse: [self nextIgnoreSectionFromEntity: aParameterEntity].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextContentMarkupToken [
	| generalEntity |

	generalEntity := self topPushedBackEntity.
	streamReader peek == $?
		ifTrue: [self nextPI]
		ifFalse: [
			streamReader peek == $!
				ifTrue: [
					streamReader next.
					streamReader peek == $-
						ifTrue: [self nextComment]
						ifFalse: [self nextCDataSection]]
				ifFalse: [self nextTag]].
	generalEntity
		ifNotNil: [
			self topPushedBackEntity == generalEntity
				ifFalse: [self errorImproperGeneralEntityNesting]].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModel [
	| parameterEntity |

	self expectSeparatorsInDeclaration.
	streamReader peek == $A
		ifTrue: [^ self expectNextAll: 'ANY'].
	streamReader peek == $E
		ifTrue: [^ self expectNextAll: 'EMPTY'].
	
	writeStream
		reset;
		nextPut: (self expectNext: $().
	parameterEntity := self topPushedBackEntity.
	self skipSeparatorsInDeclaration.
	streamReader peek == $#
		ifTrue: [
			self nextMixedContentListOnWriteStreamFromEntity:
				parameterEntity]
		ifFalse: [
			self nextContentModelChoiceOrSequenceOnWriteStreamFromEntity:
				parameterEntity].

	^ writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelChoiceOrSequenceOnWriteStreamFromEntity: aParameterEntity [
	self
		nextContentModelParticleOnWriteStream;
		skipSeparatorsInDeclaration.
	streamReader peek == $|
		ifTrue: [self nextContentModelChoiceValuesOnWriteStream]
		ifFalse: [self nextContentModelSequenceOnWriteStream].
	self
		checkNestingOfParameterEntity: aParameterEntity;
		nextContentModelUnaryOperatorOnWriteStream.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelChoiceValuesOnWriteStream [
	[streamReader peek == $)]
		whileFalse: [
			writeStream nextPut: (self expectNext: $|).
			self
				nextContentModelParticleOnWriteStream;
				skipSeparatorsInDeclaration].
	writeStream nextPut: streamReader next.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelParticleOnWriteStream [
	self skipSeparatorsInDeclaration.
	streamReader peek == $(
		ifTrue: [
			writeStream nextPut: streamReader next.
			self nextContentModelChoiceOrSequenceOnWriteStreamFromEntity:
				self topPushedBackEntity]
		ifFalse: [
			self
				nextNameOnWriteStream;
				nextContentModelUnaryOperatorOnWriteStream]
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelSequenceOnWriteStream [
	[streamReader peek == $)]
		whileFalse: [
			writeStream nextPut: (self expectNext: $,).
			self
				nextContentModelParticleOnWriteStream;
				skipSeparatorsInDeclaration].
	writeStream nextPut: streamReader next.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelUnaryOperatorOnWriteStream [
	| nextChar |

	((nextChar := streamReader peek) == $?
		or: [nextChar == $*
			or: [nextChar == $+]])
		ifTrue: [writeStream nextPut: streamReader next]
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextDoctypeDeclarationOrComment [
	"skip !"
	streamReader next.
	streamReader peek == $-
		ifTrue: [^ self nextComment].
	context isPostDoctypeDeclarationContext
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
		handleElementDeclaration: self nextName
		contentModel: self nextContentModel.
	self
		skipSeparatorsInDeclaration;
		expectTerminator.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextEndDocument [
	context canTerminateDocument
		ifFalse: [self errorDocumentTerminatedPrematurely].
	self hasOpenIncludeSections
		ifTrue: [self errorUnterminatedIncludeSections].
	super nextEndDocument.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEndIncludeSection [
	"skip ]"
	streamReader next.
	self
		expectNext: $];
		expectTerminator;
		checkNestingOfParameterEntity: self openIncludeSections removeLast.
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
	"Skip /"
	streamReader next.
	driver handleEndTag: self nextName.
	streamReader skipSeparators.
	self expectTerminator.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEntityDeclaration [
	| isParameterEntity name |

	self
		expectNextAll: 'ENTITY'
		startingAt: 2. "the 'E' was already read"

	context isExternalSubsetContext
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

	name := self nextName.
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

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEntityValue [
	| quote nextChar |

	quote := streamReader next.
	context enterLiteralValue.
	writeStream reset.
	[(nextChar := streamReader peek) == quote
		or: [nextChar == nil]]
		whileFalse: [
			streamReader next == $&
				ifTrue: [
					streamReader peek == $#
						ifTrue: [
							"character refs are replaced in entity values"
							self nextCharacterReferenceOnWriteStream]
						ifFalse: [
							"general entity refs aren't replaced but must be complete"
							writeStream nextPut: $&.
							self nextNameOnWriteStream.
							writeStream nextPut: (self expectNext: $;)]]
				ifFalse: [
					nextChar == $%
						ifTrue: [
							self isInExternalSubsetOrExternallyDefinedEntity
								ifFalse: [
									self errorInternalDeclarationParameterEntityReference].
							self nextParameterEntityReferenceOnWriteStream]
						ifFalse: [
							nextChar isXMLChar
								ifFalse: [self errorNonCharInEntityValue: nextChar].
							writeStream nextPut: nextChar]]].
	context exitLiteralValue.
	self expectNext: quote.

	^ writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextExternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| publicID systemID notation |

	streamReader peek == $P
		ifTrue: [
			publicID := self nextPublicIDInDeclaration.
			self expectSeparatorsInDeclaration.
			systemID := self nextSystemIDLiteral]
		ifFalse: [
			publicID := ''.
			systemID := self nextSystemIDInDeclaration].
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
					notation := self nextName.
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
XMLWellFormedParserTokenizer >> nextGeneralEntityOrCharacterReferenceOnWriteStream [
	"returns the (first) character written to 'writeStream' if any, nil otherwise"
	| generalEntity result |

	generalEntity := self topPushedBackEntity.
	result :=
		streamReader peek == $#
			ifTrue: [self nextCharacterReferenceOnWriteStream]
			ifFalse: [self nextGeneralEntityReferenceOnWriteStream].
	generalEntity
		ifNotNil: [
			(self pushedBackEntities includes: generalEntity)
				ifFalse: [self errorImproperGeneralEntityNesting]].
	^ result.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextGeneralEntityReferenceOnWriteStream [
	"returns the (first) character written to 'writeStream' if any, nil otherwise"
	| name |

	name := self nextName.
	self expectNext: $;.
	PredefinedEntities
		at: name
		ifPresent: [:character |
			driver replacesContentEntityReferences
				ifFalse: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			writeStream nextPut: character.
			^ character].

	(driver handleGeneralEntityReference: name)
		ifNil: [
			(driver replacesContentEntityReferences not
				or: [driver preservesUndeclaredEntityReferences])
				ifTrue: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			driver handleUnreplacedGeneralEntityReference: name]
		ifNotNil: [:entity |
			driver replacesContentEntityReferences
				ifFalse: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			self constructReplacementForGeneralEntity: entity].
	^ nil.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextIgnoreSectionFromEntity: aParameterEntity [
	| openSections |

	self
		expectNextAll: 'IGNORE'
		startingAt: 2. "the 'I' was already read"
	streamReader skipSeparators.
	self expectNext: $[.
	self topPushedBackEntity == aParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].

	"From the spec:
	The contents of an ignored conditional section MUST be parsed by
	ignoring all characters after the '[' following the keyword, except
	conditional section starts '<![' and ends ']]>', until the matching
	conditional section end is found. Parameter entity references MUST
	NOT be recognized in this process."
	openSections := 1.
	[openSections > 0
		and: [streamReader atEnd not]]
		whileTrue: [
			(streamReader nextMatchAll: ']]>')
				ifTrue: [openSections := openSections - 1]
				ifFalse: [
					(streamReader nextMatchAll: '<![')
						ifTrue: [openSections := openSections + 1]
						ifFalse: [streamReader next]]].

	openSections > 0
		ifTrue: [self errorUnterminatedIgnoreSections].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextInternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| value |

	value := self nextEntityValue.
	self
		skipSeparatorsInDeclaration;
		expectTerminator.

	aBoolean
		ifTrue: [driver handleParameterEntityDeclaration: aName replacement: value]
		ifFalse: [driver handleGeneralEntityDeclaration: aName replacement: value].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextMixedContentListOnWriteStreamFromEntity: aParameterEntity [
	| hasElements |

	writeStream nextPutAll: (self expectNextAll: '#PCDATA').

	self skipSeparatorsInDeclaration.
	hasElements := streamReader peek == $|.

	self
		nextNameListOnWriteStream;
		checkNestingOfParameterEntity: aParameterEntity.

	streamReader peek == $*
		ifTrue: [writeStream nextPut: streamReader next]
		ifFalse: [
			hasElements
				ifTrue: [self errorExpectedLiteral: $*]].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextName [
	| nextChar |

	nameStream reset.
	"nil understands isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedName].
	nameStream nextPut: nextChar.

	"nil understands isXMLNameChar so it does not need to be tested for"
	[(nextChar := streamReader peek) isXMLNameChar]
		whileTrue: [nameStream nextPut: streamReader next].
	^ nameStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNameListOnWriteStream [
	[streamReader peek == $)]
		whileFalse: [
			writeStream nextPut: (self expectNext: $|).
			self
				skipSeparatorsInDeclaration;
				nextNameOnWriteStream;
				skipSeparatorsInDeclaration].
	writeStream nextPut: streamReader next.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNameOnWriteStream [
	| nextChar |

	"nil understands isXMLNameStartChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameStartChar
		ifFalse: [self errorExpectedName].
	writeStream nextPut: nextChar.

	"nil understands isXMLNameChar so it does not need to be tested for"
	[(nextChar := streamReader peek) isXMLNameChar]
		whileTrue: [writeStream nextPut: streamReader next].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNmtokenOnWriteStream [
	"matches the Nmtoken production"
	| nextChar |

	"nil understands isXMLNameChar so it does not need to be tested for"
	(nextChar := streamReader next) isXMLNameChar
		ifFalse: [self errorExpectedNmtoken].
	writeStream nextPut: nextChar.

	"nil understands isXMLNameChar so it does not need to be tested for"
	[(nextChar := streamReader peek) isXMLNameChar]
		whileTrue: [writeStream nextPut: streamReader next].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextNonPIPrologOrContentToken [
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

	name := self nextName.
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

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPCDataToken [
	| isWhitespace nextChar |

	isWhitespace := true.
	writeStream reset.
	[(nextChar := streamReader peek) == $<
		or: [nextChar == nil]]
		whileFalse: [
			streamReader next == $&
				ifTrue: [
					self nextGeneralEntityOrCharacterReferenceOnWriteStream
						ifNotNil: [:writtenChar |
							isWhitespace
								ifTrue: [isWhitespace := writtenChar isXMLSeparator]]]
				ifFalse: [
					nextChar == $]
						ifTrue: [
							(streamReader nextMatch: $] followedBy: $>)
								ifTrue: [self errorUnexpectedCDataTerminator].
							isWhitespace := false]
						ifFalse: [
							(isWhitespace
								and: [isWhitespace := nextChar isXMLSeparator])
								ifFalse: [
									nextChar isXMLChar
										ifFalse: [self errorNonCharInPCData: nextChar]]].
					writeStream nextPut: nextChar]].
	isWhitespace
		ifTrue: [
			writeStream position > 0
				ifTrue: [driver handleWhitespace: writeStream contents]]
		ifFalse: [driver handlePCData: writeStream contents].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPITarget [
	| target |

	(target := self nextName) size = 3
		ifTrue: [
			target = 'xml'
				ifTrue: [
					context isXMLDeclarationContext
						ifFalse: [self errorXMLDeclarationNotAtStart]]
				ifFalse: [
					target asLowercase = 'xml'
						ifTrue: [self errorReservedPITarget: target]]].
	^ target.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPIValue [
	| nextChar |

	writeStream reset.
	[(nextChar := streamReader next) == nil
		or: [nextChar == $?
			and: [streamReader peek == $>]]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInPIValue: nextChar].
			writeStream nextPut: nextChar].
	self expectTerminator.
	^ writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReference [
	| parameterEntity name |

	parameterEntity := self topPushedBackEntity.
	name := self nextName.
	self
		expectNext: $;;
		checkNestingOfParameterEntity: parameterEntity.

	(driver handleParameterEntityReference: name)
		ifNotNil: [:entity | self constructReplacementForParameterEntity: entity].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReferenceInDeclaration [
	self isInExternalSubsetOrExternallyDefinedEntity
		ifFalse: [self errorInternalDeclarationParameterEntityReference].
	self nextParameterEntityReference.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReferenceOnWriteStream [
	| parameterEntity name entity |

	parameterEntity := self topPushedBackEntity.
	name := self nextName.
	self
		expectNext: $;;
		checkNestingOfParameterEntity: parameterEntity.
	
	(entity := driver handleParameterEntityReference: name)
		ifNil: [
			driver preservesUndeclaredEntityReferences
				ifTrue: [
					writeStream
						nextPut: $%;
						nextPutAll: name;
						nextPut: $;].
			^ true].
	self constructReplacementForParameterEntity: entity.
	^ false.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPrologToken [
	streamReader skipSeparators.
	self expectNext: $<.
	streamReader peek == $?
		ifTrue: [^ self nextPI].
	self nextNonPIPrologOrContentToken.
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
	| quote nextChar |

	quote := self expectQuote.
	writeStream reset.
	[(nextChar := streamReader peek) == nil
		or: [nextChar == quote "duoble quoted pubids can contain subquotes"
			or: [(PublicIDChars includes: nextChar) not]]]
		whileFalse: [writeStream nextPut: streamReader next].
	self expectNext: quote.

	^ writeStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextStartExternalEntity [
	context := context textDeclarationContext.
	driver decodesCharacters
		ifTrue: [streamReader detectCurrentEncoding]
		ifFalse: [streamReader decodeStreamWithConverter: XMLStreamConverter null].
	context nextTokenFrom: self.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextStartIncludeSectionFromEntity: aParameterEntity [
	self
		expectNextAll: 'INCLUDE'
		startingAt: 2. "the 'I' was already read"
	streamReader skipSeparators.
	self expectNext: $[.
	self topPushedBackEntity == aParameterEntity
		ifFalse: [driver handleImproperParameterEntityNesting].
	self openIncludeSections addLast: aParameterEntity.
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
	| parameterEntity |

	self expectNext: $<.
	parameterEntity := self topPushedBackEntity.

	streamReader peek == $?
		ifTrue: [self nextPI]
		ifFalse: [
			self expectNext: $!.
			streamReader peek == $-
				ifTrue: [self nextComment]
				ifFalse: [
					streamReader peek == $[
						ifTrue: [
							self isInExternalSubsetOrExternallyDefinedEntity
								ifFalse: [self errorInternalSubsetConditionalSection].
							self nextConditionalSectionFromEntity: parameterEntity]
						ifFalse: [self nextSubsetDeclaration]]].

	self checkNestingOfParameterEntity: parameterEntity.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemIDInDeclaration [
	^ self
		expectNextAll: 'SYSTEM';
		expectSeparatorsInDeclaration;
		nextSystemIDLiteral
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemIDLiteral [
	| quote nextChar |
	
	quote := self expectQuote.
	writeStream reset.
	[(nextChar := streamReader peek) == nil
		or: [nextChar == quote]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInSystemID: nextChar].
			writeStream nextPut: streamReader next].
	self expectNext: quote.

	^ writeStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextTag [
	"performance critical method"
	| tagName attributes nextChar |

	(streamReader peek == $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName.

	"nil understands isXMLSeparator so is not tested for"
	[(nextChar := streamReader peek) isXMLSeparator
		and: [
			streamReader
				next;
				skipSeparators.
			((nextChar := streamReader peek) == $>
				or: [nextChar == $/]) not]]
		whileTrue: [| attributeName |
			attributeName := self nextName.
			streamReader skipSeparators.
			streamReader next == $=
				ifFalse: [self errorExpectedAttributeNameValueSeparator].
			streamReader skipSeparators.

			"delay initializing attributes until now to know for sure if it
			needs a non-zero capacity, otherwise default initialize to zero
			later for performance"
			((attributes
				ifNil: [attributes := OrderPreservingStringDictionary new: 10])
				xmlAt: attributeName
				newPut: self nextAttributeValue)
				ifFalse: [self errorDuplicateAttribute: attributeName].

			"the ordering of these tests is optimized"
			(attributeName at: 1) == $x
				ifTrue: [
					driver hasUnhandledReservedAttributes
						ifFalse: [
							attributeName isXMLReservedAttributeName
								ifTrue: [driver haveUnhandledReservedAttributes]]]].

	driver
		handleStartTag: tagName
		attributes:
			(attributes
				ifNil: [OrderPreservingStringDictionary new: 0]).

	nextChar == $/
		ifTrue: [
			streamReader next.
			driver handleEndTag: tagName].
	self expectTerminator.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextUnreplacedGeneralEntityOnWriteStreamNamed: aName [
	driver handleUnreplacedGeneralEntityReference: aName.
	writeStream
		nextPut: $&;
		nextPutAll: aName;
		nextPut: $;.
	^ $&.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextXMLEncodingAttributeValue [
	| quote nextChar |

	quote := self expectQuote.
	((nextChar := streamReader next) notNil
		and: [EncodingNameStartChars includes: nextChar])
		ifFalse: [self errorExpectedEncodingName].
	writeStream
		reset;
		nextPut: nextChar.

	[(nextChar := streamReader peek) == nil
		or: [(EncodingNameChars includes: nextChar) not]]
		whileFalse: [writeStream nextPut: streamReader next].
	self expectNext: quote.

	^ writeStream contents.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextXMLStandaloneAttributeValue [
	| quote yesOrNo |

	quote := self expectQuote.
	yesOrNo := 
		streamReader peek == $y
			ifTrue: [self expectNextAll: 'yes']
			ifFalse: [self expectNextAll: 'no'].
	self expectNext: quote.

	^ yesOrNo.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextXMLVersionAttributeValue [
	| quote |

	quote := self expectQuote.

	writeStream
		reset;
		nextPut: self expectVersionDigit;
		nextPut: (self expectNext: $.);
		nextPut: self expectVersionDigit.

	[streamReader atEnd
		or: [streamReader peek == quote]]
		whileFalse: [writeStream nextPut: self expectVersionDigit].

	self expectNext: quote.
	^ writeStream contents.
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> openIncludeSections [
	^ openIncludeSections
		ifNil: [openIncludeSections := OrderedCollection new: 5]
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> pushBackEntity: anEntity onClose: aBlock [
	anEntity hasReplacement
		ifTrue: [
			self addPushedBackEntity: anEntity.
			streamReader
				pushBackStream: anEntity replacementStream
				onClose: [
					self removePushedBackEntity: anEntity.
					aBlock
						ifNotNil: [aBlock value]].
			anEntity isExternal
				ifTrue: [self nextStartExternalEntity]]
		ifFalse: [
			aBlock
				ifNotNil: [aBlock value]]
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> pushedBackEntities [
	^ pushedBackEntities ifNil: [pushedBackEntities := OrderedCollection new]
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> removePushedBackEntity: aPushedBackEntity [
	self pushedBackEntities remove: aPushedBackEntity.
	aPushedBackEntity isExternal
		ifTrue: [driver popEntityURI: aPushedBackEntity uri].
	^ aPushedBackEntity.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> skipSeparatorsInDeclaration [
	"this can be used to replace references within declarations"

	streamReader skipSeparators.
	[streamReader peek == $%]
		whileTrue: [
			streamReader next.
			self nextParameterEntityReferenceInDeclaration.
			streamReader skipSeparators]
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

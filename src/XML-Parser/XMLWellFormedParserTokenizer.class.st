"
This is a tokenizer for well-formed XML documents that supports DTD subsets and entity replacement.
"
Class {
	#name : #XMLWellFormedParserTokenizer,
	#superclass : #XMLParserTokenizer,
	#instVars : [
		'totalOpenIncludeSections',
		'pushedBackEntities'
	],
	#classVars : [
		'EncodingNameChars',
		'EncodingNameStartChars',
		'NormalizedSpace',
		'PublicIDChars',
		'VersionDigitChars'
	],
	#category : #'XML-Parser'
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
XMLWellFormedParserTokenizer >> addPushedBackEntity: anEntity [
	(self hasPushedBackEntityNamed: anEntity name)
		ifTrue: [self errorSelfReferentialEntity: anEntity].
	self maxEntityReplacementDepth
		ifNotNil: [:maxDepth |
			self pushedBackEntities size >= maxDepth
				ifTrue: [self errorEntityDepthLimitExceeded]].
	
	self pushedBackEntities addLast: anEntity.
	anEntity isExternal
		ifTrue: [driver pushEntityURI: anEntity uri].
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
	(self currentPushedBackEntity == anEntity
		and: [wasEscapingQuotes not])
		ifTrue: [streamReader isEscapingQuotes: true].
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

{ #category : #accessing }
XMLWellFormedParserTokenizer >> currentPushedBackEntity [
	^ self pushedBackEntities xmlLastOrNil
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
XMLWellFormedParserTokenizer >> errorDuplicateNamespace: aPrefix [
	aPrefix
		ifEmpty: [
			self parseError: 'Duplicate default namespace declaration in start tag']
		ifNotEmpty: [
			self
				formatParseError:
					'Duplicate namespace declaration "xmlns:{1}" in start tag'
				with: aPrefix]
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
XMLWellFormedParserTokenizer >> errorInternalDeclarationParameterEntityReference: aName [
	self
		formatParseError:
			'Parameter entity reference %{1}; in internal subset declaration'
		with: aName
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInternalEntityValueParameterEntityReference [
	self parseError:
		'Internal entity values cannot contain parameter entity references'
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
XMLWellFormedParserTokenizer >> errorUnexpectedCDataTerminatorInPCData [
	self parseError: 'Unexpected CDATA "]]>" terminator in PCDATA'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorUnexpectedEndOfIncludeSection [
	self parseError: 'Unexpected end of section "]" in external entity'
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

	(nextChar := streamReader next) == aCharacter
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
		(nextChar := streamReader next) == (aString at: i)
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
		(nextChar := streamReader next) == (aString at: i)
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
	^ totalOpenIncludeSections notNil
		and: [totalOpenIncludeSections > 0]
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
		nextNameListValuesOnWriteStream.

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
			nextChar isXMLChar
				ifFalse: [self errorNonCharInAttributeValue: nextChar].
			nextChar == $&
				ifTrue: [
					"char refs should be ignored by whitespace normalization"
					streamReader peek == $#
						ifTrue: [self nextCharacterReferenceOnWriteStream]
						ifFalse: [self nextGeneralEntityReferenceOnWriteStream]]
				ifFalse: [
					nextChar isXMLSeparator
						ifTrue: [nextChar := NormalizedSpace].
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
	"returns true if writeStream is written to, false otherwise"
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
				nextPut: $;]
		ifFalse: [| character |
			(codePoint := streamReader nextInteger)
				ifNil: [self errorExpectedIntegerCharacterReference].
			(character := self characterFromCodePoint: codePoint)
				ifNil: [self errorInvalidCharacterReferenceCodePoint: codePoint].
			self expectNext: $;.
			writeStream nextPut: character].
	^ true.
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
XMLWellFormedParserTokenizer >> nextConditionalSection [
	"skip ["
	streamReader next.
	self
		skipSeparatorsInDeclaration;
		expectNext: $I.
	streamReader peek == $N
		ifTrue: [self nextStartIncludeSection]
		ifFalse: [self nextIgnoreSection].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextContentMarkupToken [
	streamReader peek == $?
		ifTrue: [^ self nextPI].
	streamReader peek == $!
		ifTrue: [
			streamReader next.
			streamReader peek == $-
				ifTrue: [^ self nextComment].
			^ self nextCDataSection].
	self nextTag.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModel [
	self expectSeparatorsInDeclaration.
	streamReader peek == $A
		ifTrue: [^ self expectNextAll: 'ANY'].
	streamReader peek == $E
		ifTrue: [^ self expectNextAll: 'EMPTY'].
	
	writeStream
		reset;
		nextPut: (self expectNext: $().
	self skipSeparatorsInDeclaration.
	streamReader peek == $#
		ifTrue: [self nextMixedContentListValuesOnWriteStream]
		ifFalse: [self nextContentModelChoiceOrSequenceValuesOnWriteStream].

	^ writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelChoiceOrSequenceValuesOnWriteStream [
	self
		nextContentModelParticleOnWriteStream;
		skipSeparatorsInDeclaration.
	streamReader peek == $|
		ifTrue: [self nextContentModelChoiceValuesOnWriteStream]
		ifFalse: [self nextContentModelSequenceValuesOnWriteStream].
	self nextContentModelUnaryOperatorOnWriteStream.
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
			self nextContentModelChoiceOrSequenceValuesOnWriteStream]
		ifFalse: [
			self
				nextNameOnWriteStream;
				nextContentModelUnaryOperatorOnWriteStream]
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextContentModelSequenceValuesOnWriteStream [
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
		expectTerminator.
	totalOpenIncludeSections := self totalOpenIncludeSections - 1.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEndInternalSubset [
	self hasOpenIncludeSections
		ifTrue: [^ self nextEndIncludeSection].
	self hasPushedBackEntities
		ifTrue: [self errorParameterEntityTerminatingSubset].
	super nextEndInternalSubset.
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
								ifFalse: [self errorInternalEntityValueParameterEntityReference].
							self nextParameterEntityReferenceOnWriteStream]
						ifFalse: [writeStream nextPut: nextChar]]].
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
				ifFalse: [self errorUnexpectedEndOfIncludeSection].
			^ self nextEndIncludeSection].
	self nextSubsetMarkupToken.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextGeneralEntityReferenceOnWriteStream [
	"returns true if writeStream is written to, false otherwise"
	| name |

	name := self nextName.
	self expectNext: $;.
	PredefinedEntities
		at: name
		ifPresent: [:character |
			driver replacesContentEntityReferences
				ifFalse: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			writeStream nextPut: character.
			^ true].

	(driver handleGeneralEntityReference: name)
		ifNil: [
			(driver replacesContentEntityReferences not
				or: [driver preservesUndeclaredEntityReferences])
				ifTrue: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			driver handleUnreplacedGeneralEntityReference: name]
		ifNotNil: [:entity |
			driver replacesContentEntityReferences
				ifFalse: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			entity constructReplacementOn: self].
	^ false.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextIgnoreSection [
	| openSections |

	self
		expectNextAll: 'IGNORE'
		startingAt: 2. "the 'I' was already read"
	streamReader skipSeparators.
	self expectNext: $[.

	openSections := 1.
	[openSections > 0 and: [streamReader atEnd not]]
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
XMLWellFormedParserTokenizer >> nextMixedContentListValuesOnWriteStream [
	| hasElements |

	writeStream nextPutAll: (self expectNextAll: '#PCDATA').

	self skipSeparatorsInDeclaration.
	hasElements := streamReader peek == $|.

	self nextNameListValuesOnWriteStream.
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
XMLWellFormedParserTokenizer >> nextNameListValuesOnWriteStream [
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
	| isIgnorableWhitespace nextChar |

	isIgnorableWhitespace := true.
	writeStream reset.
	[(nextChar := streamReader peek) == $<
		or: [nextChar == nil]]
		whileFalse: [
			streamReader next isXMLChar
				ifFalse: [self errorNonCharInPCData: nextChar].
			nextChar == $&
				ifTrue: [
					(streamReader peek == $#
						ifTrue: [self nextCharacterReferenceOnWriteStream]
						ifFalse: [self nextGeneralEntityReferenceOnWriteStream])
							ifTrue: [isIgnorableWhitespace := false]]
				ifFalse: [
					nextChar == $]
						ifTrue: [
							(streamReader nextMatch: $] followedBy: $>)
								ifTrue: [self errorUnexpectedCDataTerminatorInPCData]].
					isIgnorableWhitespace
						ifTrue: [isIgnorableWhitespace := nextChar isXMLSeparator].
					writeStream nextPut: nextChar]].
	isIgnorableWhitespace
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
	| name |

	name := self nextName.
	self expectNext: $;.
	(driver handleParameterEntityReference: name)
		ifNotNil: [:entity | entity constructReplacementOn: self].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReferenceInDeclaration [
	| name |

	name := self nextName.
	self isInExternalSubsetOrExternallyDefinedEntity
		ifFalse: [self errorInternalDeclarationParameterEntityReference: name].
	self expectNext: $;.
	(driver handleParameterEntityReference: name)
		ifNotNil: [:entity | entity constructReplacementOn: self].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReferenceOnWriteStream [
	| name entity |

	name := self nextName.
	self expectNext: $;.
	(entity := driver handleParameterEntityReference: name)
		ifNil: [
			driver preservesUndeclaredEntityReferences
				ifTrue: [
					writeStream
						nextPut: $%;
						nextPutAll: name;
						nextPut: $;].
			^ true].
	entity constructReplacementOn: self.
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

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextStartIncludeSection [
	self
		expectNextAll: 'INCLUDE'
		startingAt: 2. "the 'I' was already read"
	streamReader skipSeparators.
	self expectNext: $[.
	totalOpenIncludeSections := self totalOpenIncludeSections + 1.
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
	self expectNext: $<.
	streamReader peek == $?
		ifTrue: [^ self nextPI].

	self expectNext: $!.
	streamReader peek == $-
		ifTrue: [^ self nextComment].

	(streamReader peek == $[)
		ifTrue: [
			self isInExternalSubsetOrExternallyDefinedEntity
				ifFalse: [self errorInternalSubsetConditionalSection].
			^ self nextConditionalSection].

	self nextSubsetDeclaration.
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
	| tagName attributes nextChar namespaces |

	(streamReader peek == $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName.

	attributes := OrderPreservingStringDictionary new: 10.
	"nil understands isXMLSeparator so is not tested for"
	[(nextChar := streamReader peek) isXMLSeparator
		and: [
			streamReader
				next;
				skipSeparators.
			((nextChar := streamReader peek) == $>
				or: [nextChar == $/]) not]]
		whileTrue: [ | attributeName attributeValue |
			attributeName := self nextName.
			streamReader skipSeparators.
			streamReader next == $=
				ifFalse: [self errorExpectedAttributeNameValueSeparator].
			streamReader skipSeparators.
			attributeValue := self nextAttributeValue.
	
			(attributeName at: 1) == $x
				ifTrue: [
					(attributeName isXMLNSAttributeName
						and: [driver usesNamespaces])
						ifTrue: [
							"initialize only if needed"
							((namespaces
								ifNil: [namespaces := OrderPreservingStringDictionary new: 5])
								xmlAt:
									((attributeName size > 6)
										ifTrue: [attributeName copyFrom: 7 to: attributeName size]
										ifFalse: [''])
								newPut: attributeValue)
								ifFalse: [self errorDuplicateNamespace: attributeName]]
						ifFalse: [							
							attributeName isXMLReservedAttributeName
								ifTrue: [driver haveUnhandledReservedAttributes].
							(attributes
								xmlAt: attributeName
								newPut: attributeValue)
								ifFalse: [self errorDuplicateAttribute: attributeName]]]
				ifFalse: [
					(attributes
						xmlAt: attributeName
						newPut: attributeValue)
						ifFalse: [self errorDuplicateAttribute: attributeName]]].

	driver
		handleStartTag: tagName
		attributes: attributes
		namespaces: namespaces.

	nextChar == $/
		ifTrue: [
			streamReader next.
			driver handleEndTag: tagName].
	self expectTerminator.
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> nextUnreplacedGeneralEntityOnWriteStreamNamed: aName [
	driver handleUnreplacedGeneralEntityReference: aName.
	writeStream
		nextPut: $&;
		nextPutAll: aName;
		nextPut: $;.
	^ true.
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

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> pushBackEntity: anEntity onClose: aBlock [
	anEntity hasReplacement
		ifFalse: [
			aBlock ifNotNil: [aBlock value].
			^ self].

	self addPushedBackEntity: anEntity.
	streamReader
		pushBackStream: anEntity replacementStream
		onClose: [
			self removePushedBackEntity: anEntity.
			aBlock ifNotNil: [aBlock value]].

	anEntity isExternal
		ifTrue: [
			streamReader detectCurrentEncoding.
			(context := context textDeclarationContext)
				nextTokenFrom: self].
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> pushedBackEntities [
	^ pushedBackEntities ifNil: [pushedBackEntities := OrderedCollection new]
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> removePushedBackEntity: anEntity [
	self pushedBackEntities remove: anEntity.
	anEntity isExternal
		ifTrue: [driver popEntityURI: anEntity uri].
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
XMLWellFormedParserTokenizer >> totalOpenIncludeSections [
	^ totalOpenIncludeSections ifNil: [totalOpenIncludeSections := 0]
]

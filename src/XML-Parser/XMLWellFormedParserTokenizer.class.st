"
This is a tokenizer for well-formed XML documents that supports DTD subsets and entity replacement.
"
Class {
	#name : #XMLWellFormedParserTokenizer,
	#superclass : #XMLParserTokenizer,
	#instVars : [
		'activeEntities',
		'totalOpenIncludeSections'
	],
	#classVars : [
		'EncodingNameChars',
		'NameChars',
		'NonNameStartCharNameChars',
		'NormalizedSpace',
		'PublicIDChars'
	],
	#category : #'XML-Parser'
}

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initialize [
	"self initialize"

	self
		initializeNormalizedSpace;
		initializeNonNameStartCharNameChars;
		initializeNameChars;
		initializePublicIDChars;
		initializeEncodingNameChars
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
XMLWellFormedParserTokenizer class >> initializeNameChars [
	"This character set is built from the range below for 'NameStartChars' plus
	the characters from NonNameStartCharNameChars. 
	
	NameStartChar ::=
		':' | [A-Z] | '_' | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] |
		[#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] |
		[#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] |
		[#x10000-#xEFFFF]
	NameChar ::=
		NameStartChar | '-' | '.' | [0-9] | #xB7 | [#x0300-#x036F] |
		[#x203F-#x2040]"

	(NameChars := BitmapCharacterSet new: 16rF0000)
		add: $:;
		addRangeFrom: $A to: $Z;
		add: $_;
		addRangeFrom: $a to: $z;
		addRangeFrom: 16rC0 asCharacter to: 16rD6 asCharacter;
		addRangeFrom: 16rD8 asCharacter to: 16rF6 asCharacter;
		addRangeFrom: 16rF8 asCharacter to: 16r2FF asCharacter;
		addRangeFrom: 16r370 asCharacter to: 16r37D asCharacter;
		addRangeFrom: 16r37F asCharacter to: 16r1FFF asCharacter;
		addRangeFrom: 16r200C asCharacter to: 16r200D asCharacter;
		addRangeFrom: 16r2070 asCharacter to: 16r218F asCharacter;
		addRangeFrom: 16r2C00 asCharacter to: 16r2FEF asCharacter;
		addRangeFrom: 16r3001 asCharacter to: 16rD7FF asCharacter;
		addRangeFrom: 16rF900 asCharacter to: 16rFDCF asCharacter;
		addRangeFrom: 16rFDF0 asCharacter to: 16rFFFD asCharacter;
		addRangeFrom: 16r10000 asCharacter to: 16rEFFFF asCharacter;
		addAll: NonNameStartCharNameChars
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeNonNameStartCharNameChars [
	"This character set equals 'NameChar' except 'NameStartChar', which
	requires less memory than creating one for 'NameStartChar' but can
	still be used to test for illegal start chars in names.

	NameChar ::=
		NameStartChar | '-' | '.' | [0-9] | #xB7 | [#x0300-#x036F] |
		 [#x203F-#x2040]"

	(NonNameStartCharNameChars := BitmapCharacterSet new: 16r2041)
		add: $-;
		add: $.;
		addRangeFrom: $0 to: $9;
		add: 16rB7 asCharacter;
		addRangeFrom: 16r0300 asCharacter to: 16r036F asCharacter;
		addRangeFrom: 16r203F asCharacter to: 16r2040 asCharacter
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
		add: 16r0D asCharacter;
		add: 16r0A asCharacter;
		addRangeFrom: $a to: $z;
		addRangeFrom: $A to: $Z;
		addRangeFrom: $0 to: $9;
		addAll: '-''()+,./:=?;!*#@$_%'
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isNCName: aString [
	"optimized"
	1 to: aString size do: [:i | | nextChar |
		(nextChar := aString at: i) == $:
			ifTrue: [^ false].
		((NameChars includes: nextChar)
			and: [i > 1
				or: [(NonNameStartCharNameChars includes: nextChar) not]])
			ifFalse: [^ false]].
	^ aString size > 0.
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isName: aString [
	"optimized"
	1 to: aString size do: [:i | 
		((NameChars includes: (aString at: i))
			and: [i > 1
				or: [(NonNameStartCharNameChars includes: (aString at: i)) not]])
			ifFalse: [^ false]].
	^ aString size > 0.
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isNmtoken: aString [
	"optimized"
	1 to: aString size do: [:i |
		(NameChars includes: (aString at: i))
			ifFalse: [^ false]].
	^ aString size > 0.
]

{ #category : #streaming }
XMLWellFormedParserTokenizer class >> nextNCNameFrom: aReadStream on: aWriteStream [
	| nextChar |

	(aReadStream atEnd
		or: [(NameChars includes: (nextChar := aReadStream peek)) not
			or: [nextChar == $:
				or: [NonNameStartCharNameChars includes: nextChar]]])
		ifTrue: [^ false].
	aWriteStream nextPut: aReadStream next.

	[aReadStream atEnd
		or: [(NameChars includes: (nextChar := aReadStream peek)) not
			or: [nextChar == $:]]]
		whileFalse: [aWriteStream nextPut: aReadStream next].
	^ true.
]

{ #category : #streaming }
XMLWellFormedParserTokenizer class >> nextNameFrom: aReadStream on: aWriteStream [
	(aReadStream atEnd
		or: [(NameChars includes: aReadStream peek) not
			or: [NonNameStartCharNameChars includes: aReadStream peek]])
		ifTrue: [^ false].
	aWriteStream nextPut: aReadStream next.

	[aReadStream atEnd not
		and: [NameChars includes: aReadStream peek]]
		whileTrue: [aWriteStream nextPut: aReadStream next].
	^ true.
]

{ #category : #streaming }
XMLWellFormedParserTokenizer class >> nextNmtokenFrom: aReadStream on: aWriteStream [
	(aReadStream atEnd
		or: [(NameChars includes: aReadStream peek) not])
		ifTrue: [^ false].
	aWriteStream nextPut: aReadStream next.

	[aReadStream atEnd not
		and: [NameChars includes: aReadStream peek]]
		whileTrue: [aWriteStream nextPut: aReadStream next].
	^ true.
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> activeEntities [
	^ activeEntities ifNil: [activeEntities := OrderedCollection new]
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> addActiveEntity: anEntity [
	(self hasActiveEntityNamed: anEntity name)
		ifTrue: [self errorSelfReferentialEntity: anEntity].
	self maxEntityReplacementDepth
		ifNotNil: [:maxDepth |
			(self activeEntities size + 1 > maxDepth)
				ifTrue: [self errorEntityDepthLimitExceeded]].
	
	self activeEntities addLast: anEntity.
	anEntity isExternal
		ifTrue: [driver currentURI: anEntity uri].
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
	(self currentActiveEntity == anEntity
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
XMLWellFormedParserTokenizer >> currentActiveEntity [
	^ self activeEntities lastOrNil
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorDocumentTerminatedPrematurely [
	self parseError: 'Document terminated prematurely'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorDuplicateAttribute: anAttributeName [
	self parseError: 'Duplicate attribute "', anAttributeName, '" in start tag'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorDuplicateNamespace: aPrefix [
	self parseError:
		(aPrefix
			ifEmpty: [
				'Duplicate default namespace declaration in start tag']
			ifNotEmpty: [
				'Duplicate namespace declaration "xmlns:', aPrefix, '" in start tag'])
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorEntityDepthLimitExceeded [
	XMLLimitException signal: 
		'Cannot further nest entity replacements; ',
		'use #maxEntityReplacementDepth: to change or disable'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpected: aDescription [
	self parseError: 'Expected ', aDescription
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpected: aDescription butGot: aCharacter [
	self errorExpected:
		('{1} but got "{2}"' format:
			(Array
				with: aDescription
				with: (aCharacter ifNil: [''])))
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
XMLWellFormedParserTokenizer >> errorExpectedIntegerCharacterReference [
	self errorExpected:
		'decimal or hex integer after "&#" character reference start'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: aCharacterOrString [
	self
		errorExpectedLiteral: aCharacterOrString
		butGot: nil
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: aCharacterOrString butGot: aCharacter [
	self
		errorExpectedLiteral: aCharacterOrString
		butGot: aCharacter
		at: 1
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: aCharacterOrString butGot: aCharacter at: aPosition [
	| literal replacement |

	literal := aCharacterOrString asString.
	replacement := (aCharacter ifNil: ['']) asString.
	self errorExpected:
		('"{1}" but got "{2}"' format:
			(Array
				with: literal
				with:
					(literal
						copyReplaceFrom: aPosition
						to: literal size
						with: replacement)))
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedName [
	self errorExpected: 'a name'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedNmtoken [
	self errorExpected: 'a Nmtoken name'
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
	self parseError: 'Parameter entity reference %', aName, '; in internal subset declaration'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInternalEntityValueParameterEntityReference [
	self parseError: 'Internal entity values cannot contain parameter entity references'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInternalSubsetConditionalSection [
	self parseError:
		'Cannot have <![INCLUDE[...]> or <![IGNORE[...]> sections in internal subset'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInvalidCharacterReferenceCodePoint: aCodePoint [
	self parseError:
		'Invalid character reference to code point U+', aCodePoint printStringHex
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorLiteralContextExternalEntity: anEntity [
	self parseError:
		'External general entity reference ', anEntity asReference, ' in literal context'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorMultipleDoctypeDeclarations [
	self parseError: 'Multiple <!DOCTYPE ...> declarations'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorParameterEntityTerminatingSubset [
	self parseError: 'Parameter entity replacement cannot terminate internal subset'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorReservedPITarget: aTarget [
	self parseError: 'Processing instruction target "', aTarget, '" is reserved'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorSelfReferentialEntity: anEntity [
	self parseError: 'Illegal self-referential entity ', anEntity asReference
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
XMLWellFormedParserTokenizer >> errorXMLDeclarationNotAtBeginning [
	self parseError: 'XML declaration must only occur at beginning of document'
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectDigit [
	| nextChar |

	((nextChar := streamReader next) notNil
		and: [nextChar isDigit])
		ifFalse: [
			self
				errorExpected: 'digit'
				butGot: nextChar].
	^ nextChar.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectLetter [
	| nextChar |

	((nextChar := streamReader next) notNil
		and: [nextChar isLetter])
		ifFalse: [
			self
				errorExpected: 'letter'
				butGot: nextChar].
	^ nextChar.
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
XMLWellFormedParserTokenizer >> expectNextAll: anExpectedLiteral [
	1 to: anExpectedLiteral size do: [:i | | nextChar |
		(nextChar := streamReader next) == (anExpectedLiteral at: i)
			ifFalse: [
				self
					errorExpectedLiteral: anExpectedLiteral
					butGot: nextChar
					at: i]].
	^ anExpectedLiteral.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectQuote [
	| nextChar |

	(((nextChar := streamReader next) == $")
		or: [nextChar == $'])
		ifFalse: [
			self
				errorExpected: 'quote character delimiter'
				butGot: nextChar].
	^ nextChar.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectSeparators [
	"nil understands isXMLSeparator so no nil test is needed"
	streamReader peek isXMLSeparator
		ifTrue: [
			streamReader
				next;
				skipSeparators]
		ifFalse: [self errorExpectedSeparators]
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectSeparatorsInDeclaration [
	"this can be used to replace references within declarations"

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
XMLWellFormedParserTokenizer >> expectUpToAll: aString [
	writeStream reset.
	[streamReader atEnd]
		whileFalse: [
			(streamReader nextMatchAll: aString)
				ifTrue: [^ writeStream contents].
			writeStream nextPut: streamReader next].
	self errorExpectedLiteral: aString.
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasActiveEntities [
	^ activeEntities notNil and: [activeEntities notEmpty]
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasActiveEntityNamed: aName [
	^ self activeEntities anySatisfy: [:each | each name = aName]
]

{ #category : #testing }
XMLWellFormedParserTokenizer >> hasOpenIncludeSections [
	^ totalOpenIncludeSections notNil
		and: [totalOpenIncludeSections > 0]
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> isInExternalSubsetOrExternallyDefinedEntity [
	context isExternalSubsetContext
		ifTrue: [^ true].
	self hasActiveEntities
		ifTrue: [
			self activeEntities do: [:each |
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
	streamReader next.
	self expectNextAll: 'NTIT'.
	streamReader peek == $Y
		ifTrue: [
			streamReader next.
			^ 'ENTITY'].
	self expectNextAll: 'IES'.
	^ 'ENTITIES'.
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
	streamReader next.
	self expectNext: $D.
	streamReader peek == $R
		ifFalse: [^ 'ID'].	
	self expectNextAll: 'REF'.
	streamReader peek == $S
		ifTrue: [
			streamReader next.
			^ 'IDREFS'].
	^ 'IDREF'.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeNotationEnumerationOrNmtokenType [
	streamReader next.
	streamReader peek == $O
		ifTrue: [
			self expectNextAll: 'OTATION'.
			^ self nextAttributeNotationEnumerationType].
	self expectNextAll: 'MTOKEN'.
	streamReader peek == $S
		ifTrue: [
			streamReader next.
			^ 'NMTOKENS'].
	^ 'NMTOKEN'.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeNotationEnumerationType [
	writeStream
		reset;
		nextPutAll: 'NOTATION '.
	self expectSeparatorsInDeclaration.
	writeStream nextPut: (self expectNext: $().

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
			and: [(streamReader peek) == $-]]]
		whileFalse: [writeStream nextPut: nextChar].
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
		expectNextAll: 'LEMENT';
		expectSeparatorsInDeclaration.
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
	self hasActiveEntities
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

	self expectNextAll: 'NTITY'.

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

	self expectNextAll: 'GNORE'.
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
	((nextChar := streamReader next) notNil
		and: [(NameChars includes: nextChar)
			and: [(NonNameStartCharNameChars includes: nextChar) not]])
		ifFalse: [self errorExpectedName].
	nameStream nextPut: nextChar.

	[(nextChar := streamReader peek) notNil
		and: [NameChars includes: nextChar]]
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

	((nextChar := streamReader next) notNil
		and: [(NameChars includes: nextChar)
			and: [(NonNameStartCharNameChars includes: nextChar) not]])
		ifFalse: [self errorExpectedName].
	writeStream nextPut: nextChar.

	[(nextChar := streamReader peek) notNil
		and: [NameChars includes: nextChar]]
		whileTrue: [writeStream nextPut: streamReader next].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNmtokenOnWriteStream [
	"matches the Nmtoken production"
	| nextChar |

	((nextChar := streamReader peek) notNil
		and: [(NameChars includes: nextChar)])
		ifFalse: [self errorExpectedNmtoken].
	writeStream nextPut: streamReader next.
		
	[(nextChar := streamReader peek) notNil
		and: [NameChars includes: nextChar]]
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
			streamReader next == $&
				ifTrue: [
					(streamReader peek == $#
						ifTrue: [self nextCharacterReferenceOnWriteStream]
						ifFalse: [self nextGeneralEntityReferenceOnWriteStream])
							ifTrue: [isIgnorableWhitespace := false]]
				ifFalse: [
					(nextChar == $]
						and: [streamReader peek == $]])
						ifTrue: [
							streamReader next.
							streamReader peek == $>
								ifTrue: [self errorUnexpectedCDataTerminatorInPCData]
								ifFalse: [streamReader pushBackCharacter: $]]].
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
						ifFalse: [self errorXMLDeclarationNotAtBeginning]]
				ifFalse: [
					target asLowercase = 'xml'
						ifTrue: [self errorReservedPITarget: target]]].
	^ target.
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
	self expectNextAll: 'NCLUDE'.
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
		whileFalse: [writeStream nextPut: streamReader next].
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
	writeStream
		reset;
		nextPut: self expectLetter.
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
		nextPut: self expectDigit;
		nextPut: (self expectNext: $.);
		nextPut: self expectDigit.

	[streamReader atEnd
		or: [streamReader peek == quote]]
		whileFalse: [writeStream nextPut: self expectDigit].

	self expectNext: quote.
	^ writeStream contents.
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> parseError: aString [
	driver handleParseError: aString
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> pushBackEntity: anEntity onClose: aBlock [
	anEntity hasReplacement
		ifFalse: [
			aBlock ifNotNil: [aBlock value].
			^ self].

	self addActiveEntity: anEntity.
	streamReader
		pushBackStream: anEntity replacementStream
		onClose: [
			self removeActiveEntity: anEntity.
			aBlock ifNotNil: [aBlock value]].

	anEntity isExternal
		ifTrue: [
			streamReader detectCurrentEncoding.
			(context := context textDeclarationContext)
				nextTokenFrom: self].
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> removeActiveEntity: anEntity [
	self activeEntities remove: anEntity.
	anEntity isExternal
		ifTrue: [driver removeURI: anEntity uri].
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

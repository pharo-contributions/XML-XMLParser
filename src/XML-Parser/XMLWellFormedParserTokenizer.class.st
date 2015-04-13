"
This is tokenizer for well-formed XML documents that supports DTD subsets and entity replacement.
"
Class {
	#name : #XMLWellFormedParserTokenizer,
	#superclass : #XMLParserTokenizer,
	#instVars : [
		'activeEntities'
	],
	#classVars : [
		'AdditionalNameChars',
		'EncodingNameChars',
		'NameChars',
		'NormalizedSpace',
		'PubidChars',
		'UnaryOperatorChars'
	],
	#category : #'XML-Parser'
}

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initialize [
	"self initialize"

	self
		initializeNormalizedSpace;
		initializeAdditionalNameChars;
		initializeNameChars;
		initializePubidChars;
		initializeEncodingNameChars;
		initializeUnaryOperatorChars
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeAdditionalNameChars [
	"This creates a character set that contains all those defined in the XML spec for the
	NameChar production rule minus those also defined for NameStartChar
	(NameChar - NameStartChar)"

	(AdditionalNameChars := BitmapCharacterSet new: 16r2041)
		add: $-;
		add: $.;
		addAll: ($0 to: $9);
		add: (Character value: 16rB7).
	16r0300 to: 16r036F do: [:each | AdditionalNameChars add: (Character value: each)].
	16r203F to: 16r2040 do: [:each | AdditionalNameChars add: (Character value: each)].
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeEncodingNameChars [
	(EncodingNameChars := BitmapCharacterSet new)
		addAll: ($a to: $z);
		addAll: ($A to: $Z);
		addAll: ($0 to: $9);
		add: $-;
		add: $_;
		add: $.
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeNameChars [
	"This creates a character set that coveres the entire range of characters speicified for
	the NameChar production rule in the XML spec."

	(NameChars := BitmapCharacterSet new: 16rF0000)
		add: $:;
		addAll: ($A to: $Z);
		add: $_;
		addAll: ($a to: $z).
	16rC0 to: 16rD6 do: [:each | NameChars add: (Character value: each)].
	16rD8 to: 16rF6 do: [:each | NameChars add: (Character value: each)].
	16rF8 to: 16r2FF do: [:each | NameChars add: (Character value: each)].
	16r370 to: 16r37D do: [:each | NameChars add: (Character value: each)].
	16r37F to: 16r1FFF do: [:each | NameChars add: (Character value: each)].
	16r200C to: 16r200D do: [:each | NameChars add: (Character value: each)].
	16r2070 to: 16r218F do: [:each | NameChars add: (Character value: each)].
	16r2C00 to: 16r2FEF do: [:each | NameChars add: (Character value: each)].
	16r3001 to: 16rD7FF do: [:each | NameChars add: (Character value: each)].
	16rF900 to: 16rFDCF do: [:each | NameChars add: (Character value: each)].
	16rFDF0 to: 16rFFFD do: [:each | NameChars add: (Character value: each)].
	16r10000 to: 16rEFFFF do: [:each | NameChars add: (Character value: each)].

	AdditionalNameChars do: [:each | NameChars add: each].
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeNormalizedSpace [
	NormalizedSpace := Character space
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializePubidChars [
	(PubidChars := BitmapCharacterSet new)
		add: Character space;
		add: Character cr;
		add: Character lf;
		addAll: ($a to: $z);
		addAll: ($A to: $Z);
		addAll: ($0 to: $9);
		addAll: '-''()+,./:=?;!*#@$_%'
]

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeUnaryOperatorChars [
	UnaryOperatorChars := BitmapCharacterSet with: $? with: $* with: $+
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isNCName: aString [
	"optimized"
	1 to: aString size do: [:i | | nextChar |
		(nextChar := aString at: i) == $:
			ifTrue: [^ false].
		((NameChars includes: nextChar)
			and: [i > 1
				or: [(AdditionalNameChars includes: nextChar) not]])
			ifFalse: [^ false]].
	^ aString size > 0.
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isName: aString [
	"optimized"
	1 to: aString size do: [:i | 
		((NameChars includes: (aString at: i))
			and: [i > 1
				or: [(AdditionalNameChars includes: (aString at: i)) not]])
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
				or: [AdditionalNameChars includes: nextChar]]])
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
			or: [AdditionalNameChars includes: aReadStream peek]])
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
			(self activeEntities size + 1> maxDepth)
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
			^ self constructReplacementForLiteralContextEntity: anEntity].

	driver handleStartContentEntityReplacement: anEntity name.
	self
		pushBackEntity: anEntity
		onClose: [driver handleEndContentEntityReplacement: anEntity name].
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
		ifTrue: [^ self constructReplacementForLiteralContextEntity: anEntity].

	streamReader pushBackCharacter: NormalizedSpace.
	self
		pushBackEntity: anEntity
		onClose: nil.
	streamReader pushBackCharacter: NormalizedSpace.
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
XMLWellFormedParserTokenizer >> errorEntityDepthLimitExceeded [
	XMLLimitException signal: 
		'Cannot further nest entity replacements; ',
		'use #maxEntityReplacementDepth: to change or disable'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpected: anExpectedString [
	self parseError: 'Expected ', anExpectedString
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpected: anExpectedCharacterOrString butGot: aReceivedCharacterOrString [
	self errorExpected:
		('{1} but got "{2}"' format:
			(Array
				with: anExpectedCharacterOrString
				with: (aReceivedCharacterOrString ifNil: [''])))
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeNameValueSeparator [
	self errorExpected: 'attribute name-value "=" separator'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeValueEndButGot: aCharacter [
	aCharacter == $<
		ifTrue: [self parseError: 'Attribute value contains "<" character']
		ifFalse: [self errorExpected: 'end of quoted attribute value']
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeValueStart [
	self errorExpected: 'start of quoted attribute value'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: aCharacterOrString [
	self
		errorExpectedLiteral: aCharacterOrString
		butGot: nil
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: anExpectedLiteral butGot: aCharacter [
	self
		errorExpectedLiteral: anExpectedLiteral
		butGot: aCharacter
		at: 1
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedLiteral: anExpectedLiteral butGot: aCharacter at: aPosition [
	| literal replacement |

	literal := anExpectedLiteral asString.
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
XMLWellFormedParserTokenizer >> errorExpectedSectionTerminator [
	self errorExpectedLiteral: ']]>'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedSeparators [
	self errorExpected: 'one or more whitespace characters'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedTerminatorButGot: aReceivedCharacer [
	self
		errorExpected: '">" terminator'
		butGot: aReceivedCharacer
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInternalDeclarationParameterEntityReference: aName [
	self parseError: 'Parameter entity reference %', aName, '; in internal subset declaration'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInternalSubsetIncludeOrIgnoreSection [
	self parseError: 'Cannot have <![INCLUDE[...]> or <![IGNORE[...]> sections in internal subset'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorInvalidCodePoint: aCodePoint [
	self parseError: 'Invalid character code point ', aCodePoint printString
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorLiteralContextExternalEntity: anEntity [
	self parseError: 'External general entity ', anEntity asReference, ' in literal context'
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
XMLWellFormedParserTokenizer >> errorSelfReferentialEntity: anEntity [
	self parseError: 'Illegal self-referential entity ', anEntity asReference
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorXMLDeclarationNotAtBeginning [
	self parseError: 'XML declaration must only occur at beginning of document'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorXMLPITargetReserved [
	self parseError: 'Processing instruction target "XML" is reserved'
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
	"nil understands xmlParserIsSeparator so no nil test is needed"
	streamReader peek xmlParserIsSeparator
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
XMLWellFormedParserTokenizer >> hasActiveExternalEntity [
	^ self activeEntities anySatisfy: [:each | each isExternal]
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
					nextChar xmlParserIsSeparator
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
	| codePoint character |

	"skip #"
	streamReader next.
	codePoint :=
		(streamReader nextInteger
			ifNil: [self errorExpected: 'integer']).
	self expectNext: $;.

	character :=
		(self characterFromCodePoint: codePoint)
			ifNil: [self errorInvalidCodePoint: codePoint].
	(context isContentContext
		and: [driver replacesContentEntityReferences not])
		ifTrue: [
			writeStream
				nextPutAll: '&#';
				nextPutAll: codePoint asString;
				nextPut: $;.
			^ true].
	writeStream nextPut: character.
	^ true.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextComment [
	| nextChar |

	"Skip first -"
	streamReader next.
	self expectNext: $-.

	"xml comments cannot contain -- sequences not followed by terminating >"
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

	writeStream reset.
	self nextConditionalSectionOnWriteStream.
	streamReader pushBack: writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextConditionalSectionOnWriteStream [
	self
		skipSeparatorsInDeclaration;
		expectNext: $I.

	streamReader peek == $N
		ifTrue: [self nextIncludeSectionOnWriteStream]
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

	((nextChar := streamReader peek) notNil
		and: [UnaryOperatorChars includes: nextChar])
		ifTrue: [writeStream nextPut: streamReader next]
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextDoctypeDeclarationOrComment [
	"skip !"
	streamReader next.
	streamReader peek == $-
		ifTrue: [
			context isXMLDeclarationContext
				ifTrue: [context := context prologContext].
			^ self nextComment].
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
	super nextEndDocument.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEndInternalSubset [
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
							"nil understands xmlParserIsSeparator so no nil test is needed"
							streamReader peek xmlParserIsSeparator
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
						ifTrue: [self nextCharacterReferenceOnWriteStream]
						ifFalse: [writeStream nextPut: $&]]
				ifFalse: [
					nextChar == $%
						ifTrue: [self nextParameterEntityReferenceOnWriteStream]
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

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextGeneralEntityReferenceOnWriteStream [
	"returns true if writeStream is written to, false otherwise"
	| name entity |

	name := self nextName.
	self expectNext: $;.
	PredefinedEntities
		at: name
		ifPresent: [:character |
			driver replacesContentEntityReferences
				ifFalse: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			writeStream nextPut: character.
			^ true].

	(entity := driver handleGeneralEntityReference: name)
		ifNil: [
			(driver replacesContentEntityReferences not
				or: [driver preservesUndeclaredEntityReferences])
				ifTrue: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
			driver handleUnreplacedGeneralEntityReference: name.
			^ false].
	driver replacesContentEntityReferences
		ifFalse: [^ self nextUnreplacedGeneralEntityOnWriteStreamNamed: name].
	entity constructReplacementOn: self.
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
		ifTrue: [self errorExpectedSectionTerminator].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextIncludeSectionOnWriteStream [
	| isOpen  |

	self expectNextAll: 'NCLUDE'.
	streamReader skipSeparators.
	self expectNext: $[.

	isOpen := true.
	[isOpen and: [streamReader atEnd not]]
		whileTrue: [
			(streamReader nextMatchAll: '<![')
				ifTrue: [self nextConditionalSectionOnWriteStream]
				ifFalse: [
					(streamReader nextMatchAll: ']]>')
						ifTrue: [isOpen := false]
						ifFalse: [writeStream nextPut: streamReader next]]].
	isOpen
		ifTrue: [self errorExpectedSectionTerminator].
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
			and: [(AdditionalNameChars includes: nextChar) not]])
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
			and: [(AdditionalNameChars includes: nextChar) not]])
		ifFalse: [self errorExpectedName].
	writeStream nextPut: nextChar.

	[(nextChar := streamReader peek) notNil
		and: [NameChars includes: nextChar]]
		whileTrue: [writeStream nextPut: streamReader next].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNmtokenOnWriteStream [
	"matches the nmtoken production"
	| nextChar |

	((nextChar := streamReader peek) notNil
		and: [(NameChars includes: nextChar)])
		ifFalse: [self errorExpected: 'name token'].
	writeStream nextPut: streamReader next.
		
	[(nextChar := streamReader peek) notNil
		and: [NameChars includes: nextChar]]
		whileTrue: [writeStream nextPut: streamReader next].
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
					"we do not check for illegal ]]> CDATA terminators in PCDATA
					for performance"
					isIgnorableWhitespace
						ifTrue: [isIgnorableWhitespace := nextChar xmlParserIsSeparator].
					writeStream nextPut: nextChar]].
	isIgnorableWhitespace
		ifTrue: [
			writeStream xmlParserAtBeginning
				ifFalse: [driver handleWhitespace: writeStream contents]]
		ifFalse: [driver handlePCData: writeStream contents].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPITarget [
	| target |

	target := self nextName.
	context isXMLDeclarationContext
		ifFalse: [
			target = 'xml'
				ifTrue: [self errorXMLDeclarationNotAtBeginning]].
	target = 'XML'
		ifTrue: [self errorXMLPITargetReserved].

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
	context isInternalSubsetContext
		ifTrue: [self errorInternalDeclarationParameterEntityReference: name].
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
	streamReader atEnd
		ifTrue: [^ self].

	self expectNext: $<.
	streamReader peek == $?
		ifTrue: [^ self nextPIOrXMLDeclaration].
	streamReader peek == $!
		ifTrue: [^ self nextDoctypeDeclarationOrComment].
	self
		nextStartContent;
		nextTag.
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
		or: [nextChar == quote
			or: [(PubidChars includes: nextChar) not]]]
		whileFalse: [writeStream nextPut: streamReader next].
	self expectNext: quote.

	^ writeStream contents.
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

	self errorExpected: 'DTD subset declaration'.
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
			(context isExternalSubsetContext
				or: [self hasActiveExternalEntity])
				ifTrue: [^ self nextConditionalSection].
			self errorInternalSubsetIncludeOrIgnoreSection].

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
	"nil understands xmlParserIsSeparator so is not tested for"
	[(nextChar := streamReader peek) xmlParserIsSeparator
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
					(attributeName isNamespaceAttributeName
						and: [driver usesNamespaces])
						ifTrue: [
							"initialize only if needed"
							(namespaces
								ifNil: [namespaces := OrderPreservingStringDictionary new: 5])
								at:
									((attributeName size > 6)
										ifTrue: [attributeName copyFrom: 7 to: attributeName size]
										ifFalse: [''])
								put: attributeValue]
						ifFalse: [							
							attributeName isReservedAttributeName
								ifTrue: [driver haveUnhandledReservedAttributes].
							attributes at: attributeName put: attributeValue]]
				ifFalse: [attributes at: attributeName put: attributeValue]].

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
	| quote |

	quote := self expectQuote.

	writeStream
		reset;
		nextPut: self expectLetter.
	[streamReader atEnd not
		and: [EncodingNameChars includes: streamReader peek]]
		whileTrue: [writeStream nextPut: streamReader next].

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
XMLWellFormedParserTokenizer >> parseError: anErrorString [
	driver handleParseError: anErrorString
]

{ #category : #'entity replacing' }
XMLWellFormedParserTokenizer >> pushBackEntity: anEntity onClose: aBlock [
	anEntity hasReplacement
		ifFalse: [
			aBlock ifNotNil: [aBlock value].
			^ self].

	self addActiveEntity: anEntity.
	streamReader
		pushBackStream: anEntity replacement readStream
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

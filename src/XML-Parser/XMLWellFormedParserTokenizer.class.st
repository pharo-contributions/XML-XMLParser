"
This is tokenizer for well-formed XML that supports DTD subsets and entity replacement.
"
Class {
	#name : #XMLWellFormedParserTokenizer,
	#superclass : #XMLParserTokenizer,
	#instVars : [
		'activeEntities'
	],
	#classVars : [
		'AdditionalNameChars',
		'AttributeTypeDelimiters',
		'EncodingNameChars',
		'NameChars',
		'NormalizedSpace',
		'PubidChars',
		'UnaryOperatorChars',
		'ValueListChars'
	],
	#category : #'XML-Parser'
}

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initialize [
	"self initialize"

	self
		initializeAdditionalNameChars;
		initializeNameChars;
		initializePubidChars;
		initializeAttributeTypeDelimiters;
		initializeValueListChars;
		initializeUnaryOperatorChars;
		initializeEncodingNameChars;
		initializeNormalizedSpace
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
XMLWellFormedParserTokenizer class >> initializeAttributeTypeDelimiters [
	AttributeTypeDelimiters := BitmapCharacterSet with: $# with: $' with: $" with: $>
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

{ #category : #'class initialization' }
XMLWellFormedParserTokenizer class >> initializeValueListChars [
	ValueListChars := BitmapCharacterSet with: $( with: $| with: $)
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isName: aString [
	aString ifEmpty: [^ false].

	aString doWithIndex: [:each :i | 
		((NameChars includes: each)
			and: [i > 1 or: [(AdditionalNameChars includes: each) not]])
			ifFalse: [^ false]].
	^ true.
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isNmtoken: aString [
	^ aString notEmpty
		and: [aString allSatisfy: [:each | self isNmtokenChar: each]]
]

{ #category : #testing }
XMLWellFormedParserTokenizer class >> isNmtokenChar: aCharacter [
	^ NameChars includes: aCharacter
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> activeEntities [
	^ activeEntities ifNil: [activeEntities := OrderedCollection new]
]

{ #category : #'entity replacement' }
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

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> constructReplacementForBypassedEntity: anEntity [
	streamReader pushBack: anEntity asEscapedReference
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> constructReplacementForBypassedGeneralEntity: anEntity [
	self constructReplacementForBypassedEntity: anEntity
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> constructReplacementForBypassedParameterEntity: anEntity [
	context isLiteralValueContext
		ifTrue: [self constructReplacementForBypassedEntity: anEntity]
]

{ #category : #'entity replacement' }
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

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> constructReplacementForLiteralContextEntity: anEntity [
	| previousEscaper |

	previousEscaper := streamReader characterEscaper.
	self
		pushBackEntity: anEntity
		onClose: [streamReader characterEscaper: previousEscaper].

	"wait till after the text declaration was read to start escaping"
	(self currentActiveEntity == anEntity
		and: [previousEscaper isNil])
		ifTrue: [
			streamReader characterEscaper:
				(XMLQuoteCharacterEscaper for: streamReader)].
]

{ #category : #'entity replacement' }
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
				with: anExpectedCharacterOrString asString
				with: (aReceivedCharacterOrString ifNil: ['']) asString))
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpectedAttributeValueEnd [
	self errorExpected: 'end of quoted attribute value '
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
XMLWellFormedParserTokenizer >> errorParameterEntityTerminatingSubset [
	self parseError: 'Parameter entity replacement cannot terminate internal subset'
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorSelfReferentialEntity: anEntity [
	self parseError: 'Illegal self-referential entity ', anEntity asReference
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorXMLDeclarationInContent [
	self parseError: 'XML declaration outside of prolog or text declaration'
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
XMLWellFormedParserTokenizer >> expectTerminator: aCharacter [
	| nextChar |

	(nextChar := streamReader next) == aCharacter
		ifFalse: [
			self
				errorExpectedLiteral: aCharacter
				butGot: nextChar].
	^ nextChar.
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
		skipSeparatorsReplacingParameterEntities.

	element := self nextName.
	[self skipSeparatorsReplacingParameterEntities.
	(streamReader atEnd or: [streamReader peek == $>])]
		whileFalse: [
			driver
				handleAttributeDeclaration: element
				name: self nextName
				type: self nextAttributeType
				defaultPragma: (defaultPragma := self nextAttributeDefaultPragma)
				defaultValue: (self nextAttributeDefaultValueForPragma: defaultPragma)].

	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeDefaultPragma [
	self skipSeparatorsReplacingParameterEntities.
	streamReader peek == $#
		ifFalse: [^ ''].
	streamReader next.

	^ streamReader peek == $R
		ifTrue: [self expectNextAll: 'REQUIRED']
		ifFalse: [
			streamReader peek == $I
				ifTrue: [self expectNextAll: 'IMPLIED']
				ifFalse: [self expectNextAll: 'FIXED']].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeDefaultValueForPragma: aPragma [
	self skipSeparatorsReplacingParameterEntities.

	(aPragma isEmpty or: [aPragma first == $F]) "FIXED"
		ifTrue: [ | previousContext attributeValue |
			previousContext := context.
			context := context contentContext.
			attributeValue := self nextAttributeValue.
			context := previousContext.
			^ attributeValue]
		ifFalse: [^ ''].

]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeType [
	| nextChar |

	writeStream reset.
	[self skipSeparatorsReplacingParameterEntities.
	(nextChar := streamReader peek) == nil
		or: [AttributeTypeDelimiters includes: nextChar]]
		whileFalse: [
			(ValueListChars includes: nextChar)
				ifTrue: [
					writeStream position > 0
						ifTrue: [writeStream space].
					writeStream nextPut: streamReader next]
				ifFalse: [self nextNmtokenOn: writeStream]].
	^ writeStream contents.
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
					streamReader peek == $#
						ifTrue: [writeStream nextPut: self nextDecodedCharReference]
						ifFalse: [
							(nextChar := self nextGeneralEntityReference)
								ifNotNil: [writeStream nextPut: nextChar]]]
				ifFalse: [
					nextChar isSeparator
						ifTrue: [nextChar := NormalizedSpace].
					writeStream nextPut: nextChar]].
	context exitLiteralValue.

	nextChar == quote
		ifFalse: [self errorExpectedAttributeValueEnd].

	^ writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextConditionalSection [
	"skip ["
	streamReader next.

	writeStream reset.
	self nextConditionalSectionOn: writeStream.
	streamReader pushBack: writeStream contents.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextConditionalSectionOn: aWriteStream [
	self
		skipSeparatorsReplacingParameterEntities;
		expectNext: $I.

	streamReader peek == $N
		ifTrue: [self nextIncludeSectionOn: aWriteStream]
		ifFalse: [self nextIgnoreSection].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextContentToken [
	streamReader peek == $<
		ifTrue: [
			streamReader next.
			^ self nextContentMarkupToken].
	self nextPCDataToken.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextDecodedCharReference [
	| codePoint |

	"skip #"
	streamReader next.
	(codePoint := streamReader nextInteger)
		ifNil: [self errorExpected: 'integer'].
	self expectNext: $;.

	^ (self characterFromCodePoint: codePoint)
		ifNil: [self errorInvalidCodePoint: codePoint].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextElementDeclaration [
	| name nextChar contentModel |

	self
		expectNextAll: 'LEMENT';
		skipSeparatorsReplacingParameterEntities.

	name := self nextName.
	writeStream reset.
	[self skipSeparatorsReplacingParameterEntities.
	(streamReader atEnd or: [(nextChar := streamReader peek) == $>])]
		whileFalse: [
			nextChar == $#
				ifTrue: [writeStream nextPutAll: (self expectNextAll: '#PCDATA')]
				ifFalse: [
					(nextChar == $, or: [ValueListChars includes: nextChar])
						ifTrue: [writeStream nextPut: streamReader next]
						ifFalse: [self nextNameOn: writeStream]].
			(UnaryOperatorChars includes: streamReader peek)
				ifTrue: [writeStream nextPut: streamReader next]].
	contentModel := writeStream contents.

	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.

	driver
		handleElementDeclaration: name
		contentModel: contentModel.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextEndDocument [
	context isInternalSubsetContext
		ifTrue: [self errorExpected: 'end of internal subset'].
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
	| tagName |

	"Skip /"
	streamReader next.
	tagName := self nextName.
	streamReader skipSeparators.
	self expectTerminator: $>.

	driver handleEndTag: tagName.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEntityDeclaration [
	| isParameterEntity name  |

	self expectNextAll: 'NTITY'.

	"this is to distinguish a parameter reference from declaration"
	isParameterEntity := false.
	[streamReader skipSeparators.
	streamReader peek == $% and: [isParameterEntity not]]
		whileTrue: [
			streamReader next.
			(context isExternalSubsetContext
				and: [streamReader atEnd not
					and: [streamReader peek isSeparator not]])
				ifTrue: [self nextParameterEntityReference]
				ifFalse: [isParameterEntity := true]].

	self skipSeparatorsReplacingParameterEntities.
	name := self nextName.
	self skipSeparatorsReplacingParameterEntities.
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
	| quote value nextChar |

	quote := streamReader next.
	context enterLiteralValue.
	writeStream reset.
	[(nextChar := streamReader peek) == quote
		or: [nextChar == nil]]
		whileFalse: [
			streamReader next == $&
				ifTrue: [
					writeStream nextPut: 
						(streamReader peek == $#
							ifTrue: [self nextDecodedCharReference]
							ifFalse: [$&])]
				ifFalse: [
					nextChar == $%
						ifTrue: [self nextParameterEntityReference]
						ifFalse: [writeStream nextPut: nextChar]]].
	value := writeStream contents.
	context exitLiteralValue.
	self expectNext: quote.

	^ value.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextExternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| externalId notation |

	externalId := self nextExternalIDSystemLiteralRequired: true.
	aBoolean
		ifTrue: [
			driver
				handleParameterEntityDeclaration: aName
				publicID: externalId key
				systemID: externalId value]
		ifFalse: [
			self skipSeparatorsReplacingParameterEntities.
			streamReader peek == $>
				ifTrue: [notation := '']
				ifFalse: [
					self
						expectNextAll: 'NDATA';
						skipSeparatorsReplacingParameterEntities.
					notation := self nextName].
			driver
				handleGeneralEntityDeclaration: aName
				publicID: externalId key
				systemID: externalId value
				ndata: notation].
	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextGeneralEntityReference [
	| name |

	name := self nextName.
	self expectNext: $;.
	PredefinedEntities
		at: name
		ifPresent: [:character | ^ character].

	(driver handleGeneralEntityReference: name)
		ifNotNil: [:entity | entity constructReplacementOn: self].
	^ nil.
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
XMLWellFormedParserTokenizer >> nextIncludeSectionOn: aWriteStream [
	| isOpen  |

	self expectNextAll: 'NCLUDE'.
	streamReader skipSeparators.
	self expectNext: $[.

	isOpen := true.
	[isOpen and: [streamReader atEnd not]]
		whileTrue: [
			(streamReader nextMatchAll: '<![')
				ifTrue: [self nextConditionalSectionOn: aWriteStream]
				ifFalse: [
					(streamReader nextMatchAll: ']]>')
						ifTrue: [isOpen := false]
						ifFalse: [aWriteStream nextPut: streamReader next]]].

	isOpen
		ifTrue: [self errorExpectedSectionTerminator].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextInternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| value |

	value := self nextEntityValue.
	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.

	aBoolean
		ifTrue: [driver handleParameterEntityDeclaration: aName replacement: value]
		ifFalse: [driver handleGeneralEntityDeclaration: aName replacement: value].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextName [
	| nextChar |

	nameStream reset.
	"inlined from nextNameOn:"
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

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextNameOn: aWriteStream [
	| nextChar |

	((nextChar := streamReader next) notNil
		and: [(NameChars includes: nextChar)
			and: [(AdditionalNameChars includes: nextChar) not]])
		ifFalse: [self errorExpectedName].
	aWriteStream nextPut: nextChar.

	[(nextChar := streamReader peek) notNil
		and: [NameChars includes: nextChar]]
		whileTrue: [aWriteStream nextPut: streamReader next].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNmtokenOn: aWriteStream [
	"matches the nmtoken production"
	| nextChar |

	((nextChar := streamReader peek) notNil
		and: [(NameChars includes: nextChar)])
		ifFalse: [self errorExpected: 'name token'].
	aWriteStream nextPut: streamReader next.
		
	[(nextChar := streamReader peek) notNil
		and: [NameChars includes: nextChar]]
		whileTrue: [aWriteStream nextPut: streamReader next].
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextNotationDeclaration [
	| name externalId |

	self
		expectNextAll: 'NOTATION';
		skipSeparatorsReplacingParameterEntities.

	name := self nextName.
	self skipSeparatorsReplacingParameterEntities.

	externalId := self nextExternalIDSystemLiteralRequired: false.
	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.

	driver
		handleNotationDeclaration: name
		publicID: externalId key
		systemID: externalId value.
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
					(nextChar :=
						streamReader peek == $#
							ifTrue: [self nextDecodedCharReference]
							ifFalse: [self nextGeneralEntityReference])
						ifNotNil: [
							writeStream nextPut: nextChar.
							isIgnorableWhitespace := false]]
				ifFalse: [
					isIgnorableWhitespace
						ifTrue: [isIgnorableWhitespace := nextChar isSeparator].
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

	target := self nextName.
	(target = 'xml'
		and: [context isPrologContext not])
		ifTrue: [self errorXMLDeclarationInContent].

	^ target.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReference [
	| name |

	name := self nextName.
	self expectNext: $;.

	(driver handleParameterEntityReference: name)
		ifNotNil: [:entity | entity constructReplacementOn: self]
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
		ifTrue: [
			streamReader next.
			streamReader peek == $-
				ifTrue: [^ self nextComment].
			^ self nextDoctypeDeclaration].

	context := context contentContext.
	self nextTag.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextPubidLiteral [
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
			^ streamReader peek == $N
				ifTrue: [self nextEntityDeclaration]
				ifFalse: [self nextElementDeclaration]].
	streamReader peek == $A
		ifTrue: [^ self nextAttlistDeclaration].
	streamReader peek == $N
		ifTrue: [^ self nextNotationDeclaration].

	self errorExpected: 'declaration'.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSubsetMarkupToken [
	self expectNext: $<.
	streamReader peek == $?
		ifTrue: [^ self nextPIOrXMLDeclaration].

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
XMLWellFormedParserTokenizer >> nextSystemLiteralRequired: aBoolean [	
	| quote nextChar |

	(aBoolean or: [streamReader atQuote])
		ifFalse: [^ ''].
	
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
	| tagName attributes namespaces nextChar |

	(streamReader peek == $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName.

	attributes := OrderPreservingStringDictionary new: 10.
	[streamReader skipSeparators.
	((nextChar := streamReader peek) == $>
		or: [nextChar == $/
			or: [nextChar == nil]])]
		whileFalse: [ | attributeName attributeValue |
			attributeName := self nextName.
			streamReader skipSeparators.
			self expectNext: $=.
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

	streamReader peek == $/
		ifTrue: [
			streamReader next.
			driver handleEndTag: tagName].
	self expectTerminator: $>.
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
XMLWellFormedParserTokenizer >> nextXMLTextDeclaration [
	(streamReader nextMatchAll: '<?xml')
		ifTrue: [
			self nextXMLVersionAttributeRequired: false.
			(self nextXMLEncodingAttributeRequired: true)
				ifNotEmpty: [:encoding | streamReader convertFromEncoding: encoding].

			streamReader skipSeparators.
			self
				expectNext: $?;
				expectTerminator: $>].
	context := context previousContext.
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

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> pushBackEntity: anEntity onClose: aBlock [
	anEntity replacement
		ifEmpty: [
			aBlock ifNotNil: [aBlock value].
			^ self].

	self addActiveEntity: anEntity.
	streamReader
		pushStream: (ReadStream on: anEntity replacement)
		onClose: [
			self removeActiveEntity: anEntity.
			aBlock ifNotNil: [aBlock value]].

	anEntity isExternal
		ifTrue: [
			streamReader detectCurrentEncoding.
			(context := context textDeclarationContext)
				nextTokenFrom: self].
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> removeActiveEntity: anEntity [
	self activeEntities remove: anEntity.
	anEntity isExternal
		ifTrue: [driver removeURI: anEntity uri].
]

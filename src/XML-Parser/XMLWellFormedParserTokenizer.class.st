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

	super initialize.
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
XMLWellFormedParserTokenizer class >> initializePredefinedEntities [
	(predefinedEntities := Dictionary new)
		at: 'lt' put: $<;
		at: 'gt' put: $>;
		at: 'amp' put: $&;
		at: 'apos' put: $';
		at: 'quot' put: $"
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
	^ aString notEmpty and: [aString allSatisfy: [:each | self isNmtokenChar: each]]
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
		ifTrue: [self parseError: 'Illegal self-referential entity ', anEntity asReference].
	self maxEntityReplacementDepth
		ifNotNil: [:maxDepth |
			(self activeEntities size + 1> maxDepth)
				ifTrue: [self entityDepthError: 'Cannot further nest entity replacements']].
	
	self activeEntities addLast: anEntity.
	anEntity isExternal
		ifTrue: [driver currentURI: anEntity uri].
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> endReplacementForGeneralEntity: anEntity isInContent: aBoolean [
	self removeActiveEntity: anEntity.
	aBoolean
		ifTrue: [driver handleEndContentEntityReplacement: anEntity name].
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> endReplacementForParameterEntity: anEntity [
	self removeActiveEntity: anEntity
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> entityDepthError: anErrorString [
	XMLLimitException signal: anErrorString
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpected: anExpectedString [
	self parseError: 'Expected ', anExpectedString
]

{ #category : #errors }
XMLWellFormedParserTokenizer >> errorExpected: anExpectedCharacterOrString butGot: aReceivedCharacterOrString [
	| expectedString receivedString |

	expectedString := anExpectedCharacterOrString asString.	
	(receivedString := (aReceivedCharacterOrString ifNil: ['']) asString)
		ifEmpty: [receivedString := 'nothing'].

	self errorExpected: expectedString, ' but got ', receivedString.
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
				errorExpected: aCharacter
				butGot: nextChar].
	^ nextChar.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectNextAll: anExpectedLiteral [
	| nextChar |

	anExpectedLiteral doWithIndex: [:each :i |
		(nextChar := streamReader next) == each
			ifFalse: [
				self
					errorExpected: anExpectedLiteral
					butGot:
						(anExpectedLiteral
							copyReplaceFrom: i
							to: anExpectedLiteral size
							with: (nextChar ifNil: ['']) asString)]].
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
				errorExpected: aCharacter asString, ' terminator'
				butGot: nextChar].
	^ nextChar.
]

{ #category : #'tokenizing - expecting' }
XMLWellFormedParserTokenizer >> expectUpToAll: aString [
	| isTerminated |

	"upToAll: can't distinguish between a missing terminator or terminator at the end of a string"
	isTerminated := false.
	writeStream reset.
	[streamReader atEnd
		or: [(isTerminated := streamReader nextMatchAll: aString)]]
		whileFalse: [writeStream nextPut: streamReader next].

	isTerminated
		ifFalse: [self errorExpected: 'terminating ', aString].

	^ writeStream contents.
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

	^ (aPragma isEmpty or: [aPragma first == $F]) "FIXED"
		ifTrue: [self nextAttributeValue]
		ifFalse: [''].

]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextAttributeType [
	| nextChar |

	writeStream reset.
	[self skipSeparatorsReplacingParameterEntities.
	(nextChar := streamReader peek) isNil
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
		ifFalse: [
			quote == $&
				ifTrue: [^ self nextUnparsedEntityReference]
				ifFalse: [self errorExpected: 'start of quoted attribute value']].
	
	context
		saveCurrent;
		enterLiteralValue.
	writeStream reset.
	[(nextChar := streamReader peek) == quote
		or: [nextChar == $<
			or: [nextChar == nil]]]
		whileFalse: [
			(streamReader next) == $&
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
	context resetPrevious.

	(streamReader next == quote)
		ifFalse: [self errorExpected: 'end of quoted attribute value'].

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

	^ streamReader peek == $N
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
		ifNil: [self parseError: 'Invalid character code point ', codePoint printString].
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
	context isInInternalSubset
		ifTrue: [self errorExpected: 'end of internal subset'].
	super nextEndDocument.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEndInternalSubset [
	self hasActiveEntities
		ifTrue: [self parseError: 'Parameter entity replacement cannot terminate internal subset'].

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
			(context isInExternalSubset
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
	| quote value  |

	quote := streamReader next.
	context
		saveCurrent;
		enterLiteralValue.
	value := self nextEntityValueDelimitedBy: quote.
	context resetPrevious.
	self expectNext: quote.

	^ value.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextEntityValueDelimitedBy: aQuote [
	| nextChar |

	writeStream reset.
	[(nextChar := streamReader peek) == aQuote
		or: [nextChar == nil]]
		whileFalse: [
			(streamReader next) == $&
				ifTrue: [
					writeStream nextPut: 
						(streamReader peek == $#
							ifTrue: [self nextDecodedCharReference]
							ifFalse: [$&])]
				ifFalse: [
					nextChar == $%
						ifTrue: [self nextParameterEntityReference]
						ifFalse: [writeStream nextPut: nextChar]]].
	^ writeStream contents.
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
	| name entity replacement startedInContent |

	name := self nextName.
	self expectNext: $;.
	self class predefinedEntities
		at: name
		ifPresent: [:character | ^ character].

	entity := driver handleGeneralEntityReference: name.
	(replacement := self replacementFromGeneralEntity: entity)
		ifNotEmpty: [
			startedInContent := context isInContent.
			self
				pushBackReplacement: replacement
				forEntity: entity
				onClose: [
					self
						endReplacementForGeneralEntity: entity
						isInContent: startedInContent].
			startedInContent
				ifTrue: [driver handleStartContentEntityReplacement: name]].
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
		ifTrue: [self errorExpected: 'terminating ]]>'].

	^ ''.
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
		ifTrue: [self errorExpected: 'terminating ]]>'].
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
		ifFalse: [self errorExpected: 'name'].
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
		ifFalse: [self errorExpected: 'name'].
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
			(streamReader next) == $&
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
		and: [context isInProlog not
			and: [context isInTextDeclaration not]])
		ifTrue: [self parseError: 'XML declaration outside of prolog or text declaration'].

	^ target.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextParameterEntityReference [
	| name entity replacement |

	name := self nextName.
	self expectNext: $;.

	entity := driver handleParameterEntityReference: name.
	(replacement := self replacementFromParameterEntity: entity)
		ifNotEmpty: [
			self
				pushBackReplacement: replacement
				forEntity: entity
				onClose: [self endReplacementForParameterEntity: entity]].
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextPrologToken [
	streamReader skipSeparators.
	streamReader atEnd
		ifTrue: [^ self].

	self expectNext: $<.
	streamReader peek == $?
		ifTrue: [^ self nextPIOrXMLDecl].
	streamReader peek == $!
		ifTrue: [
			streamReader next.
			streamReader peek == $-
				ifTrue: [^ self nextComment].
			^ self nextDocTypeDecl].

	context enterContent.
	self nextTag.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextPubidLiteral [
	| quote nextChar |

	quote := self expectQuote.
	writeStream reset.
	[(nextChar := streamReader peek) notNil
		and: [(PubidChars includes: nextChar)
			and: [nextChar ~~ quote]]]
		whileTrue: [writeStream nextPut: streamReader next].
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
		ifTrue: [^ self nextPIOrXMLDecl]
		ifFalse: [
			context isInExternalSubsetTextDeclaration
				ifTrue: [context enterExternalSubset]].

	self expectNext: $!.
	streamReader peek == $-
		ifTrue: [^ self nextComment].

	(streamReader peek == $[)
		ifTrue: [
			(context isInExternalSubset
				or: [self hasActiveExternalEntity])
				ifTrue: [^ self nextConditionalSection].
			self parseError: 'Cannot have INCLUDE/IGNORE sections in internal subset'].

	self nextSubsetDeclaration.
]

{ #category : #'tokenizing - dtd' }
XMLWellFormedParserTokenizer >> nextSystemLiteralRequired: aBoolean [	
	| quote value |

	(aBoolean or: [streamReader atQuote])
		ifTrue: [
			quote := self expectQuote.
			value := streamReader upTo: quote]
		ifFalse: [value := ''].
	^ value.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextTag [
	"performance critical method"
	| tagName attributes reservedAttributes namespaces nextChar attributeName attributeValue |

	(streamReader peek == $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName.

	attributes := OrderPreservingDictionary new: 10 withDefaultValue: ''.
	[streamReader skipSeparators.
	((nextChar := streamReader peek) == $>
		or: [nextChar == $/
			or: [nextChar == nil]])]
		whileFalse: [
			attributeName := self nextName.
			streamReader skipSeparators.
			self expectNext: $=.
			streamReader skipSeparators.
			attributeValue := self nextAttributeValue.
	
			((attributeName at: 1) == $x "fast test to skip the others"
				and: [(attributeName beginsWith: 'xml')
					and: [attributeName size >= 5]])
				ifTrue: [
					(driver usesNamespaces
						and: [(attributeName at: 4) == $n
							and: [(attributeName at: 5) == $s]])
						ifTrue: [
							"initialize only if needed"
							namespaces
								ifNil: [namespaces := OrderPreservingDictionary new: 5 withDefaultValue: ''].
							attributeName size > 6
								ifTrue: [
									namespaces
										at: (attributeName copyFrom: 7 to: attributeName size)
										put: attributeValue]
								ifFalse: [namespaces at: '' put: attributeValue]]
						ifFalse: [
							(attributeName at: 4) == $:
								ifTrue: [
									"the xml: attributes require special processing so are copied
									to a separate dictionary to not be affected by changes to the
									regular dictionary and quick nil test if any are present"
									(reservedAttributes ifNil: [reservedAttributes := Dictionary new])
										at: attributeName put: attributeValue].
								attributes at: attributeName put: attributeValue]]
				ifFalse: [attributes at: attributeName put: attributeValue]].

	driver
		handleStartTag: tagName
		attributes: attributes
		namespaces: namespaces.
	reservedAttributes
		ifNotNil: [driver handleReservedAttributes: reservedAttributes].

	streamReader peek == $/
		ifTrue: [
			streamReader next.
			driver handleEndTag: tagName].
	self expectTerminator: $>.
]

{ #category : #tokenizing }
XMLWellFormedParserTokenizer >> nextTextDeclaration [
	"skip <"
	streamReader
		skipSeparators;
		next.

	context
		saveCurrent;
		enterTextDeclaration.
	self nextPIOrXMLDecl.
	context resetPrevious.	
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
		nextPut: (self expectNext: $1);
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
XMLWellFormedParserTokenizer >> pushBackReplacement: aReplacement forEntity: anEntity onClose: aBlock [
	self addActiveEntity: anEntity.

	streamReader
		pushStream: aReplacement readStream
		onClose: aBlock.

	(anEntity isExternal and: [anEntity hasTextDeclaration])
		ifTrue: [self nextTextDeclaration].
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> removeActiveEntity: anEntity [
	self activeEntities remove: anEntity.
	anEntity isExternal
		ifTrue: [driver removeURI: anEntity uri].
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> replacementFromGeneralEntity: anEntity [
	anEntity ifNil: [^ ''].

	(context isInLiteralValue and: [anEntity isExternal])
		ifTrue: [self parseError: 'External general entity ', anEntity asReference, ' in literal context'].

	^ context isInLiteralValue
		ifTrue: [anEntity replacementForLiteralContext]
		ifFalse: [anEntity replacementForContentContext].
]

{ #category : #'entity replacement' }
XMLWellFormedParserTokenizer >> replacementFromParameterEntity: anEntity [
	anEntity ifNil: [^ ''].

	^ context isInLiteralValue
		ifTrue: [anEntity replacementForLiteralContext]
		ifFalse: [anEntity replacementForDTDContext]
]

{ #category : #accessing }
XMLWellFormedParserTokenizer >> tokenContextClass [
	^ XMLTokenContext
]

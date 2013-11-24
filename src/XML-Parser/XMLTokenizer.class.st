"
This class reads XML tokens from a stream using a nested stream reader. Sending it #nextToken causes a token to be read and one or more handler messages to be dispatched to a driver.
"
Class {
	#name : #XMLTokenizer,
	#superclass : #Object,
	#instVars : [
		'driver',
		'context',
		'streamReader',
		'streamWriter'
	],
	#classVars : [
		'AdditionalNameChars',
		'NameStartChars',
		'PredefinedEntities',
		'PubidChars'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLTokenizer class >> driver: aDriver on: aStringOrStream [
	^self new
		setDriver: aDriver
		stream:
			(aStringOrStream isStream
				ifTrue: [aStringOrStream]
				ifFalse: [aStringOrStream readStream])
]

{ #category : #'class initialization' }
XMLTokenizer class >> initialize [
	"self initialize"

	self
		initializePredefinedEntities;
		initializeNameStartChars;
		initializeAdditionalNameChars;
		initializePubidChars.
]

{ #category : #'class initialization' }
XMLTokenizer class >> initializeAdditionalNameChars [
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
XMLTokenizer class >> initializeNameStartChars [
	"This creates a character set that coveres the entire range of characters speicified for
	the NameStartChar production rule in the XML spec."

	(NameStartChars := BitmapCharacterSet new: 16rF0000)
		add: $:;
		addAll: ($A to: $Z);
		add: $_;
		addAll: ($a to: $z).
	16rC0 to: 16rD6 do: [:each | NameStartChars add: (Character value: each)].
	16rD8 to: 16rF6 do: [:each | NameStartChars add: (Character value: each)].
	16rF8 to: 16r2FF do: [:each | NameStartChars add: (Character value: each)].
	16r370 to: 16r37D do: [:each | NameStartChars add: (Character value: each)].
	16r37F to: 16r1FFF do: [:each | NameStartChars add: (Character value: each)].
	16r200C to: 16r200D do: [:each | NameStartChars add: (Character value: each)].
	16r2070 to: 16r218F do: [:each | NameStartChars add: (Character value: each)].
	16r2C00 to: 16r2FEF do: [:each | NameStartChars add: (Character value: each)].
	16r3001 to: 16rD7FF do: [:each | NameStartChars add: (Character value: each)].
	16rF900 to: 16rFDCF do: [:each | NameStartChars add: (Character value: each)].
	16rFDF0 to: 16rFFFD do: [:each | NameStartChars add: (Character value: each)].
	16r10000 to: 16rEFFFF do: [:each | NameStartChars add: (Character value: each)].
]

{ #category : #'class initialization' }
XMLTokenizer class >> initializePredefinedEntities [
	(PredefinedEntities := Dictionary new)
		at: 'lt' put: $<;
		at: 'gt' put: $>;
		at: 'amp' put: $&;
		at: 'apos' put: $';
		at: 'quot' put: $"
]

{ #category : #'class initialization' }
XMLTokenizer class >> initializePubidChars [
	(PubidChars := BitmapCharacterSet new)
		add: Character space;
		add: Character cr;
		add: Character lf;
		addAll: ($a to: $z);
		addAll: ($A to: $Z);
		addAll: ($0 to: $9);
		addAll: '-''()+,./:=?;!*#@$_%'
]

{ #category : #testing }
XMLTokenizer class >> isName: aString [
	aString ifEmpty: [^ false].

	aString doWithIndex: [:each :i | 
		((NameStartChars includes: each)
			or: [i > 1 and: [AdditionalNameChars includes: each]])
			ifFalse: [^ false]].

	^ true.
]

{ #category : #testing }
XMLTokenizer class >> isNmtoken: aString [
	aString ifEmpty: [^ false].

	^ aString allSatisfy: [:each |
		(NameStartChars includes: each)
			or: [AdditionalNameChars includes: each]].
]

{ #category : #testing }
XMLTokenizer >> atEnd [
	context atEnd
		ifTrue: [^ true].
	(context isInitialized and: [streamReader atEnd])
		ifTrue: [
			context isInInternalSubset
				ifTrue: [self errorExpected: 'end of internal subset'].
			self nextEndDocument.
			^ true].
	^ false.
]

{ #category : #testing }
XMLTokenizer >> atQuote [
	^ streamReader peek == $"
		or: [streamReader peek == $']
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> checkForTextDeclarationInEntity: anEntity replacement: aReplacement [
	(anEntity isExternal and: [aReplacement notEmpty])
		ifFalse: [^ self].

	(aReplacement beginsWith: '<?xml ')
		ifTrue: [ 
			streamReader next.
			context resetAfter: [
				context enterTextDeclaration.
				self nextPIOrXMLDecl]].
]

{ #category : #accessing }
XMLTokenizer >> currentLineNumber [
	^ streamReader currentLineNumber
]

{ #category : #accessing }
XMLTokenizer >> driver [
	^ driver
]

{ #category : #errors }
XMLTokenizer >> errorExpected: expectedString [
	self parseError: 'Expected ', expectedString
]

{ #category : #errors }
XMLTokenizer >> errorExpected: anExpectedCharacterOrString butGot: aReceivedCharacterOrString [
	| expectedString receivedString |

	expectedString := anExpectedCharacterOrString asString.	
	(receivedString := (aReceivedCharacterOrString ifNil: ['']) asString)
			ifEmpty: [receivedString := 'nothing'].

	self errorExpected: expectedString, ' but got ', receivedString.
]

{ #category : #tokenizing }
XMLTokenizer >> expectNext: aCharacter [
	| nextChar |

	(nextChar := streamReader next) == aCharacter
		ifFalse: [
			self
				errorExpected: aCharacter
				butGot: nextChar].
	^ nextChar.
]

{ #category : #tokenizing }
XMLTokenizer >> expectNextAll: anExpectedLiteral [
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

{ #category : #tokenizing }
XMLTokenizer >> expectQuote [
	| nextChar |

	(((nextChar := streamReader next) == $")
		or: [nextChar == $'])
		ifFalse: [
			self
				errorExpected: 'quote character delimiter'
				butGot: nextChar].
	^ nextChar.
]

{ #category : #tokenizing }
XMLTokenizer >> expectTerminator: aCharacter [
	| nextChar |

	(nextChar := streamReader next) == aCharacter
		ifFalse: [
			self
				errorExpected: aCharacter asString, ' terminator'
				butGot: nextChar].
	^ nextChar.
]

{ #category : #tokenizing }
XMLTokenizer >> expectUpToAll: aTerminator [
	| value isTerminated |

	"upToAll: can't distinguish between a missing terminator or terminator at the end of a string"
	isTerminated := false.
	value := streamWriter writeWith: [:writeStream |
		[streamReader atEnd
			or: [(isTerminated := streamReader nextMatchAll: aTerminator)]]
			whileFalse: [writeStream nextPut: streamReader next].
		writeStream contents].
	isTerminated
		ifFalse: [self errorExpected: 'terminating ', aTerminator asString].

	^ value.

]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextAttlistDeclaration [
	| element attribute attributeType defaultDeclaration  |

	self expectNextAll: 'ATTLIST'.
	self skipSeparatorsReplacingParameterEntities.
	element := self nextName.
	[self skipSeparatorsReplacingParameterEntities.
	(streamReader atEnd or: [streamReader peek == $>])]
		whileFalse: [
			attribute := self nextName.
			attributeType := self nextAttributeType.
			defaultDeclaration := self nextDefaultDeclaration.
			driver
				handleAttributeDeclaration: element
				name: attribute
				type: attributeType
				default: defaultDeclaration].
	self skipSeparatorsReplacingParameterEntities.
	self expectTerminator: $>.
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeInto: attributes namespaces: namespaces [
	| attrName attrValue |

	attrName := self nextName.
	streamReader skipSeparators.
	self expectNext: $=.
	streamReader skipSeparators.
	attrValue := self nextAttributeValue.

	(driver usesNamespaces
		and: [attrName beginsWith: 'xmlns'])
		ifTrue: [attrName size > 6
			ifTrue: [namespaces at: (attrName copyFrom: 7 to: attrName size) put: attrValue]
			ifFalse: [namespaces at: '' put: attrValue]]
		ifFalse: [attributes at: attrName put: attrValue].
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextAttributeType [
	| nextChar type |

	type := streamWriter writeWith: [:writeStream |
		[self skipSeparatorsReplacingParameterEntities.
		(nextChar := streamReader peek) isNil
			or: [(String with: $# with: $> with: $' with:  $") includes: nextChar]]
			whileFalse: [
				(')|(' includes: nextChar)
					ifTrue: [writeStream nextPut: streamReader next]
					ifFalse: [
						writeStream
							nextPutAll: self nextNmtoken;
							nextPut: Character space]].
		writeStream contents].

	^ self removeTrailingSpacesFrom:  type.
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeValue [
	| quote value |

	streamReader peek == $&
		ifTrue: [^ self nextUnparsedEntityReference].

	quote := self expectQuote.
	context resetAfter: [
		context enterLiteralValue.
		value := self
			nextDelimitedBy: quote and: $<
			entityChar: $&
			normalizeWhitespace: true
			ignorableWhitespace: false].
	self expectNext: quote.

	^ value.
]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataSection [
	self expectNextAll: '[CDATA['.
	driver handleCData: (self expectUpToAll: ']]>').

]

{ #category : #tokenizing }
XMLTokenizer >> nextComment [
	| comment |
	"Skip first -"
	streamReader next.
	self expectNext: $-.
	comment := streamReader upToAll: '--'.
	self expectTerminator: $>.
	driver handleComment: comment.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextConditionalSection [
	self skipSeparatorsReplacingParameterEntities.
	self expectNext: $I.
	^ streamReader peek == $N
		ifTrue: [self nextIncludeSection]
		ifFalse: [self nextIgnoreSection].
]

{ #category : #tokenizing }
XMLTokenizer >> nextContentMarkupToken [
	streamReader peek == $?
		ifTrue: [^ self nextPIOrXMLDecl].
	streamReader peek == $!
		ifTrue: [
			streamReader next.
			streamReader peek == $-
				ifTrue: [^ self nextComment].
			streamReader peek == $[
				ifTrue: [^ self nextCDataSection].
			self errorExpected: 'comment or CDATA section'].

	self nextTag.
]

{ #category : #tokenizing }
XMLTokenizer >> nextContentToken [
	| pcData |

	pcData := self
		nextDelimitedBy: $< and: nil
		entityChar: $&
		normalizeWhitespace: false
		ignorableWhitespace: true.
	pcData
		ifNotEmpty: [
			driver handlePCData: pcData.
			^ self].

	streamReader peek == $<
		ifTrue: [
			streamReader next.
			self nextContentMarkupToken].
]

{ #category : #tokenizing }
XMLTokenizer >> nextDecodedCharReference [
	| charValue |

	"skip #"
	streamReader next.
	(charValue := streamReader nextInteger) > 0
		ifFalse: [self errorExpected: 'integral character value'].
	self expectNext: $;.
	^ Unicode value: charValue.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextDefaultDeclaration [
	self skipSeparatorsReplacingParameterEntities.
	^ streamWriter writeWith: [:writeStream |
		streamReader peek == $#
			ifTrue: [
				writeStream nextPut: streamReader next.
				streamReader peek == $R
					ifTrue: [writeStream nextPutAll: (self expectNextAll: 'REQUIRED')]
					ifFalse: [
						streamReader peek == $I
							ifTrue: [writeStream nextPutAll: (self expectNextAll: 'IMPLIED')]
							ifFalse: [
								writeStream
									nextPutAll: (self expectNextAll: 'FIXED');
									space.
								self skipSeparatorsReplacingParameterEntities.
								writeStream nextPutAll: self nextDefaultValue]]]
			ifFalse: [writeStream nextPutAll: self nextDefaultValue].
		self removeTrailingSpacesFrom: writeStream contents].
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextDefaultValue [
	^ $" asString, self nextAttributeValue, $" asString
]

{ #category : #tokenizing }
XMLTokenizer >> nextDelimitedBy: aDelimiter and: aSecondDelimiter entityChar: anEntityStartChar normalizeWhitespace: shouldNormalize ignorableWhitespace: shouldSkip [
	| isIgnorableWhitespace nextChar pcData |

	isIgnorableWhitespace := true.
	pcData := ''.
	streamWriter writeWith: [:writeStream |
		"separate arguments for delimiters are used instead of a collection for performance"
		[(nextChar := streamReader peek) isNil
			or: [nextChar == aDelimiter
				or: [nextChar == aSecondDelimiter]]]
			whileFalse: [
				nextChar == $&
					ifTrue: [
						streamReader next.
						streamReader peek == $#
							ifTrue: [
								writeStream nextPut: self nextDecodedCharReference.
								isIgnorableWhitespace := false]
							ifFalse: [
								anEntityStartChar == $&
									ifTrue: [
										(nextChar := self nextGeneralEntityReference)
											ifNotNil: [writeStream nextPut: nextChar]]
									ifFalse: [
										writeStream nextPut: $&.
										isIgnorableWhitespace := false]]]
					ifFalse: [
						streamReader next.
						nextChar == anEntityStartChar
							ifTrue: [self nextParameterEntityReference]
							ifFalse: [
								nextChar isSeparator
									ifTrue: [
										shouldNormalize
											ifTrue: [nextChar := Character space]]
									ifFalse: [isIgnorableWhitespace := false].
								writeStream nextPut: nextChar]]].
		isIgnorableWhitespace & shouldSkip
			ifTrue: [
				writeStream position > 0
					ifTrue: [driver handleWhitespace: writeStream contents]]
			ifFalse: [pcData :=  writeStream contents]].
	^ pcData.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextDocTypeDecl [
	|  root externalId |

	context enterDoctype.
	self expectNextAll: 'DOCTYPE'.
	streamReader skipSeparators.

	root := self nextName.
	streamReader skipSeparators.
	externalId := self nextExternalIDSystemLiteralRequired: true.
	driver
		handleStartDTD: root
		publicID: externalId key
		systemID: externalId value.

	streamReader skipSeparators.
	streamReader peek == $[
		ifTrue: [self nextInternalSubsetStart]
		ifFalse: [self nextEndDocTypeDecl].
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextElementDeclaration [
	| name nextChar contentModel |

	self expectNextAll: 'LEMENT'.
	self skipSeparatorsReplacingParameterEntities.
	name := self nextName.
	contentModel := streamWriter writeWith: [:writeStream |
		[self skipSeparatorsReplacingParameterEntities.
		(streamReader atEnd or: [(nextChar := streamReader peek) == $>])]
			whileFalse: [
				nextChar == $#
					ifTrue: [writeStream nextPutAll: (self expectNextAll: '#PCDATA')]
					ifFalse: [
						('|,)(' includes: nextChar)
							ifTrue: [writeStream nextPut: streamReader next]
							ifFalse: [writeStream nextPutAll: self nextName]].
				('?*+' includes: streamReader peek)
					ifTrue: [writeStream nextPut: streamReader next]].
		writeStream contents].
	self skipSeparatorsReplacingParameterEntities.
	self expectTerminator: $>.

	driver
		handleElementDeclaration: name
		contentModel: contentModel
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEndDocTypeDecl [
	streamReader skipSeparators.
	self expectTerminator: $>.
	context enterProlog.
	driver handleEndDTD.
]

{ #category : #tokenizing }
XMLTokenizer >> nextEndDocument [
	context enterAtEnd.
	driver handleEndDocument.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEndInternalSubset [
	self expectTerminator: $].
	context enterProlog.
	self nextEndDocTypeDecl.
]

{ #category : #tokenizing }
XMLTokenizer >> nextEndTag [
	| tagName |
	"Skip /"
	streamReader next.
	tagName := self nextName.
	streamReader skipSeparators.
	self expectTerminator: $>.
	driver handleEndTag: tagName
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEntityDeclaration [
	| isParameterEntity name  |

	self expectNextAll: 'NTITY'.
	isParameterEntity := false.
	"this is to distinguish a parameter reference from declaration"
	[streamReader skipSeparators.
	streamReader peek == $%]
		whileTrue: [
			streamReader next.
			(streamReader atEnd not and: [streamReader peek isSeparator])
				ifTrue: [
					isParameterEntity
						ifTrue: [self errorExpected: 'parameter entity reference'].
					isParameterEntity := true]
				ifFalse: [self nextParameterEntityReference]].

	name := self nextName.
	self skipSeparatorsReplacingParameterEntities.
	self atQuote
		ifTrue: [
			self
				nextInternalEntityDeclaration: name
				isParameterEntity: isParameterEntity]
		ifFalse: [
			self
				nextExternalEntityDeclaration: name
				isParameterEntity: isParameterEntity].
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEntityValue [
	| quote value  |

	quote := streamReader next.
	context resetAfter: [
		context enterLiteralValue.
		value := self
			nextDelimitedBy: quote and: nil
			entityChar: $%
			normalizeWhitespace: false
			ignorableWhitespace: false].
	self expectNext: quote.

	^ value.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextExternalEntityDeclaration: aName isParameterEntity: aBoolean [
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
					self expectNextAll: 'NDATA'.
					self skipSeparatorsReplacingParameterEntities.
					notation := self nextName].
			driver
				handleGeneralEntityDeclaration: aName
				publicID: externalId key
				systemID: externalId value
				ndata: notation].
	self skipSeparatorsReplacingParameterEntities.
	self expectTerminator: $>.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextExternalIDSystemLiteralRequired: aBoolean [
	| publicId  systemId |

	publicId := ''.
	systemId := ''.
	(streamReader atEnd not
		and: [streamReader peek == $P
			or: [streamReader peek == $S]])
		ifTrue: [
			streamReader peek == $P
				ifTrue: [
					self expectNextAll: 'PUBLIC'.
					self skipSeparatorsReplacingParameterEntities.
					publicId := self nextPubidLiteral.
					self skipSeparatorsReplacingParameterEntities.
					systemId := self nextSystemLiteralRequired: aBoolean]
				ifFalse: [
					self expectNextAll: 'SYSTEM'.
					self skipSeparatorsReplacingParameterEntities.
					systemId := self nextSystemLiteralRequired: true]].
	^ publicId -> systemId.
]

{ #category : #tokenizing }
XMLTokenizer >> nextGeneralEntityReference [
	| name entity replacement |

	name := self nextName.
	self expectNext: $;.
	(self predefinedEntities includesKey: name)
		ifTrue: [^ self predefinedEntities at: name].

	replacement := ''.
	(entity := driver handleGeneralEntityReference: name)
		ifNotNil: [
			replacement :=
				(context isInLiteralValue
					ifTrue: [entity replacementForLiteralContext]
					ifFalse: [entity replacementForContentContext])].
	replacement
		ifEmpty: [^ nil].

	context isInContent
		ifTrue: [driver handleStartContentEntityReplacement: name].
	streamReader
		pushStream: replacement readStream
		from: entity uri
		onClose:
			(context isInContent
				ifTrue: [driver handleEndContentEntityReplacement: name]
				ifFalse: [nil]).
	self checkForTextDeclarationInEntity: entity replacement: replacement.

	^ nil.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextIgnoreSection [
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

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextIncludeSection [
	| isOpen includedContents |

	self expectNextAll: 'NCLUDE'.
	streamReader skipSeparators.
	self expectNext: $[.

	isOpen := true.
	includedContents := streamWriter writeWith: [:writeStream |
		[isOpen and: [streamReader atEnd not]]
			whileTrue: [
				(streamReader nextMatchAll: '<![')
					ifTrue: [writeStream nextPutAll: self nextConditionalSection]
					ifFalse: [
						(streamReader nextMatchAll: ']]>')
							ifTrue: [isOpen := false]
							ifFalse: [writeStream nextPut: streamReader next]]].
		writeStream contents].
	isOpen
		ifTrue: [self errorExpected: 'terminating ]]>'].

	^ includedContents.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextInternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| value |

	value := self nextEntityValue.
	self skipSeparatorsReplacingParameterEntities.
	self expectTerminator: $>.

	aBoolean
		ifTrue: [driver handleParameterEntityDeclaration: aName replacement: value]
		ifFalse: [driver handleGeneralEntityDeclaration: aName replacement: value].
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextInternalSubsetStart [
	"skip ["
	streamReader next.
	context enterInternalSubset.
]

{ #category : #tokenizing }
XMLTokenizer >> nextName [
	| nextChar |

	^ streamWriter writeWith: [:writeStream |
		((nextChar := streamReader next) notNil
			and: [NameStartChars includes: nextChar])
			ifFalse: [self errorExpected: 'name'].
		writeStream nextPut: nextChar.

		[(nextChar := streamReader peek) notNil
			and: [(NameStartChars includes: nextChar)
				or: [AdditionalNameChars includes: nextChar]]]
			whileTrue: [writeStream nextPut: streamReader next].
		writeStream contents]
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextNmtoken [
	"matches the nmtoken production"
	|  nextChar |

	^ streamWriter writeWith: [:writeStream |
		[(nextChar := streamReader peek) notNil
			and: [(NameStartChars includes: nextChar)
				or: [AdditionalNameChars includes: nextChar]]]
			whileTrue: [writeStream nextPut: streamReader next].
		(writeStream position > 0)
			ifFalse: [self errorExpected: 'name token'].
		writeStream contents].
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextNotationDeclaration [
	| name externalId |

	self expectNextAll: 'NOTATION'.
	self skipSeparatorsReplacingParameterEntities.

	name := self nextName.
	self skipSeparatorsReplacingParameterEntities.
	externalId := self nextExternalIDSystemLiteralRequired: false.
	self skipSeparatorsReplacingParameterEntities.
	self expectTerminator: $>.

	driver
		handleNotationDeclaration: name
		publicID: externalId key
		systemID: externalId value.
]

{ #category : #tokenizing }
XMLTokenizer >> nextPIOrXMLDecl [
	| piTarget piData |
	"Skip ?"
	streamReader next.
	piTarget := self nextName.
	((context isInProlog or: [context isInTextDeclaration])
		and: [piTarget asUppercase = 'XML'])
		ifTrue: [^ self nextXMLDecl]
		ifFalse: [
			context isInExternalSubsetTextDeclaration
				ifTrue: [context enterExternalSubset]].
	streamReader skipSeparators.
	piData := self expectUpToAll: '?>'.

	driver handlePI: piTarget data: piData.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextParameterEntityReference [
	| name entity replacement |

	name := self nextName.
	self expectNext: $;.

	replacement := ''.
	(entity := driver handleParameterEntityReference: name)
		ifNotNil: [
			replacement :=
				(context isInLiteralValue
					ifTrue: [entity replacementForLiteralContext]
					ifFalse: [entity replacementForDTDContext])].
	replacement
		ifEmpty: [^ self].
	streamReader
		pushStream: replacement readStream
		from: entity uri
		onClose: nil.
	self checkForTextDeclarationInEntity: entity replacement: replacement.
]

{ #category : #tokenizing }
XMLTokenizer >> nextPrologToken [
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

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextPubidLiteral [
	| quote fpi nextChar |

	quote := self expectQuote.
	fpi := streamWriter writeWith: [:writeStream |
		[(nextChar := streamReader peek) notNil
			and: [(PubidChars includes: nextChar)
				and: [nextChar ~~ quote]]]
			whileTrue: [writeStream nextPut: streamReader next].
		writeStream contents].
	self expectNext: quote.

	^ fpi.
]

{ #category : #tokenizing }
XMLTokenizer >> nextStartDocument [
	context enterProlog.
	driver handleStartDocument.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextSubsetDeclaration [
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

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextSubsetMarkupToken [
	self expectNext: $<.
	streamReader peek == $?
		ifTrue: [^ self nextPIOrXMLDecl]
		ifFalse: [
			context isInExternalSubsetTextDeclaration
				ifTrue: [context enterExternalSubset]].

	self expectNext: $!.
	streamReader peek == $-
		ifTrue: [^ self nextComment].
	streamReader peek == $[
		ifTrue: [
			streamReader next.
			streamReader pushBack: self nextConditionalSection.
			^ self].

	self nextSubsetDeclaration.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextSubsetToken [
	streamReader skipSeparators.
	streamReader atEnd
		ifTrue: [^ self].

	streamReader peek == $%
		ifTrue: [^ self replaceParameterEntityReference].
	(context isInInternalSubset and: [streamReader peek == $]])
		ifTrue: [^ self nextEndInternalSubset].

	self nextSubsetMarkupToken.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextSystemLiteralRequired: aBoolean [	
	| quote value |

	(aBoolean or: [self atQuote])
		ifTrue: [
			quote := self expectQuote.
			value := streamReader upTo: quote]
		ifFalse: [value := ''].
	^ value.
]

{ #category : #tokenizing }
XMLTokenizer >> nextTag [
	| tagName attributes namespaces nextChar |

	(streamReader peek = $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName.

	attributes := OrderPreservingDictionary new: 10 withDefaultValue: ''.
	driver usesNamespaces
		ifTrue: [namespaces := OrderPreservingDictionary defaultValue: ''].
	[streamReader skipSeparators.
	((nextChar := streamReader peek) isNil
		or: [nextChar == $>
			or: [nextChar == $/]])]
		whileFalse: [self nextAttributeInto: attributes namespaces: namespaces].

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
XMLTokenizer >> nextToken [
	context notInitialized 
		ifTrue: [^ self nextStartDocument].

	self atEnd
		ifTrue: [^ self].
	context isInContent
		ifTrue: [^ self nextContentToken].
	context isInSubset
		ifTrue: [^ self nextSubsetToken].

	self nextPrologToken.
]

{ #category : #tokenizing }
XMLTokenizer >> nextUnparsedEntityReference [
	| name |

	streamReader next.
	name := self nextName.
	self expectNext: $;.

	^ (driver handleUnparsedEntityReference: name) ifNil: [''].
]

{ #category : #tokenizing }
XMLTokenizer >> nextXMLDecl [
	| version encoding standalone |

	version := self nextXMLDeclAttribute: 'version'.
	encoding := self nextXMLDeclAttribute: 'encoding'.
	context isInTextDeclaration
		ifFalse: [standalone := self nextXMLDeclAttribute: 'standalone'].
	streamReader skipSeparators.
	self expectNext: $?.
	self expectTerminator: $>.

	encoding
		ifNotEmpty: [streamReader useConverterForEncoding: encoding].

	context isInTextDeclaration
		ifTrue: [
			context isInExternalSubsetTextDeclaration
				ifTrue: [context enterExternalSubset]]
		ifFalse: [
			driver
				handleXMLVersion: version
				encoding: encoding
				standalone: standalone].
]

{ #category : #tokenizing }
XMLTokenizer >> nextXMLDeclAttribute: aName [
	| quote |

	streamReader skipSeparators.
	streamReader peek == $?
		ifTrue: [^ ''].

	self expectNextAll: aName.
	streamReader skipSeparators.
	self expectNext: $=.
	streamReader skipSeparators.

	quote := self expectQuote.
	^ streamReader upTo: quote.
]

{ #category : #errors }
XMLTokenizer >> parseError: anErrorString [
	driver handleParseError: anErrorString
]

{ #category : #accessing }
XMLTokenizer >> predefinedEntities [
	^ PredefinedEntities
]

{ #category : #tokenizing }
XMLTokenizer >> removeTrailingSpacesFrom: aString [
	| n |

	n := 0.
	aString reverseDo: [:each |
		each isSeparator
			ifTrue: [n := n + 1]
			ifFalse: [^ aString allButLast: n]].
	^ aString.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> replaceParameterEntityReference [
	streamReader next.
	self nextParameterEntityReference
]

{ #category : #initialization }
XMLTokenizer >> setDriver: aDriver stream: aStream [
	driver := aDriver.
	context := self tokenContextClass new.
	streamReader :=
		(XMLNestedStreamReader
			on: aStream
			from: (driver ifNotNil: [driver documentURI])
			onClose: nil).
	streamWriter := XMLNestedStreamWriter new.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> skipSeparatorsReplacingParameterEntities [
	"this can be used to replace references within declarations"
	[streamReader atEnd not and: [streamReader peek isSeparator]]
		whileTrue: [
			streamReader skipSeparators.
			(context isInExternalSubset and: [streamReader peek == $%])
				ifTrue: [self replaceParameterEntityReference]]
]

{ #category : #accessing }
XMLTokenizer >> streamReader [
	^ streamReader
]

{ #category : #accessing }
XMLTokenizer >> tokenContext [
	^ context
]

{ #category : #accessing }
XMLTokenizer >> tokenContextClass [
	^ XMLTokenContext
]

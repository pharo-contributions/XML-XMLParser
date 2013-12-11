"
This class reads XML tokens from a stream using a nested stream reader. Sending it #nextToken causes a token to be read and one or more handler messages to be dispatched to a driver.
"
Class {
	#name : #XMLTokenizer,
	#superclass : #XMLAbstractTokenizer,
	#instVars : [
		'activeEntities'
	],
	#classVars : [
		'AdditionalNameChars',
		'NameStartChars',
		'PubidChars'
	],
	#category : #'XML-Parser'
}

{ #category : #'class initialization' }
XMLTokenizer class >> initialize [
	"self initialize"

	super initialize.
	self
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
	(predefinedEntities := Dictionary new)
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
	^ aString notEmpty
		and: [aString allSatisfy: [:each |
			(NameStartChars includes: each)
				or: [AdditionalNameChars includes: each]]].
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

{ #category : #'entity replacement' }
XMLTokenizer >> characterFromCodePoint: aCodePoint [
	aCodePoint > 0
		ifFalse: [self errorExpected: 'postive decimal or hex integer'].

	^ [Unicode value: aCodePoint]
		on: Error
		do: [:error | self parseError: 'Invalid character code point ', aCodePoint printString]
]

{ #category : #tokenizing }
XMLTokenizer >> checkTextDeclarationInReplacement: aReplacement forEntity: anEntity [
	(aReplacement beginsWith: '<?xml ')
		ifTrue: [ 
			streamReader next.
			context resetAfter: [
				context enterTextDeclaration.
				self nextPIOrXMLDecl]].
]

{ #category : #'entity replacement' }
XMLTokenizer >> endReplacementForGeneralEntity: anEntity isInContent: aBoolean [
	activeEntities remove: anEntity.
	aBoolean
		ifTrue: [driver handleEndContentEntityReplacement: anEntity name].
]

{ #category : #'entity replacement' }
XMLTokenizer >> endReplacementForParameterEntity: anEntity [
	activeEntities remove: anEntity
]

{ #category : #errors }
XMLTokenizer >> entityDepthError: anErrorString [
	XMLEntityDepthException signal: anErrorString
]

{ #category : #errors }
XMLTokenizer >> errorExpected: anExpectedString [
	self parseError: 'Expected ', anExpectedString
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
XMLTokenizer >> expectUpToAll: aString [
	| value isTerminated |

	"upToAll: can't distinguish between a missing terminator or terminator at the end of a string"
	isTerminated := false.
	value := streamWriter writeWith: [:writeStream |
		[streamReader atEnd
			or: [(isTerminated := streamReader nextMatchAll: aString)]]
			whileFalse: [writeStream nextPut: streamReader next].

		writeStream contents].

	isTerminated
		ifFalse: [self errorExpected: 'terminating ', aString].

	^ value.

]

{ #category : #testing }
XMLTokenizer >> hasActiveEntities [
	^ activeEntities notEmpty
]

{ #category : #testing }
XMLTokenizer >> hasActiveEntityNamed: aName [
	^ activeEntities anySatisfy: [:each | each name = aName]
]

{ #category : #testing }
XMLTokenizer >> hasActiveExternalEntity [
	^ activeEntities anySatisfy: [:each | each isExternal]
]

{ #category : #accessing }
XMLTokenizer >> maxEntityReplacementDepth [
	^ 3
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextAttlistDeclaration [
	| element attribute attributeType defaultDeclaration  |

	self
		expectNextAll: 'ATTLIST';
		skipSeparatorsReplacingParameterEntities.

	element := self nextName.
	[self skipSeparatorsReplacingParameterEntities.
	(streamReader atEnd or: [streamReader peek == $>])]
		whileFalse: [
			attribute := self nextName.
			attributeType := self nextAttributeType.
			defaultDeclaration := self nextAttributeDefaultDeclaration.
			driver
				handleAttributeDeclaration: element
				name: attribute
				type: attributeType
				default: defaultDeclaration].

	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextAttributeDefaultDeclaration [
	| defaultDeclaration |

	self skipSeparatorsReplacingParameterEntities.
	streamWriter writeWith: [:writeStream |
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
								writeStream nextPutAll: self nextAttributeDefaultValue]]]
			ifFalse: [writeStream nextPutAll: self nextAttributeDefaultValue].

		defaultDeclaration := self removeTrailingSpacesFrom: writeStream contents].

	^ defaultDeclaration.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextAttributeDefaultValue [
	^ (self nextAttributeValue copyWithFirst: $") copyWith: $"
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

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextConditionalSection [
	self
		skipSeparatorsReplacingParameterEntities;
		expectNext: $I.

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

	streamReader peek == $<
		ifTrue: [
			streamReader next.
			^ self nextContentMarkupToken].
	pcData := self
		nextDelimitedBy: $< and: nil
		entityChar: $&
		normalizeWhitespace: false
		ignorableWhitespace: true.
	pcData
		ifNotEmpty: [driver handlePCData: pcData].

		
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextElementDeclaration [
	| name nextChar contentModel |

	self
		expectNextAll: 'LEMENT';
		skipSeparatorsReplacingParameterEntities.

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

	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.

	driver
		handleElementDeclaration: name
		contentModel: contentModel
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEndInternalSubset [
	self hasActiveEntities
		ifTrue: [self parseError: 'Parameter entity replacement cannot terminate internal subset'].

	super nextEndInternalSubset.
]

{ #category : #tokenizing }
XMLTokenizer >> nextEndTag [
	| tagName |

	"Skip /"
	streamReader next.
	tagName := self nextName.
	streamReader skipSeparators.
	self expectTerminator: $>.

	driver handleEndTag: tagName.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEntityDeclaration [
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
XMLTokenizer >> nextGeneralEntityReference [
	| name entity replacement startedInContent |

	name := self nextName.
	self expectNext: $;.
	(self class predefinedEntities includesKey: name)
		ifTrue: [^ self class predefinedEntities at: name].

	entity := driver handleGeneralEntityReference: name.
	replacement := self replacementFromGeneralEntity: entity.

	replacement
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
	self
		skipSeparatorsReplacingParameterEntities;
		expectTerminator: $>.

	aBoolean
		ifTrue: [driver handleParameterEntityDeclaration: aName replacement: value]
		ifFalse: [driver handleGeneralEntityDeclaration: aName replacement: value].
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

		writeStream contents]
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextNotationDeclaration [
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

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextParameterEntityReference [
	| name entity replacement |

	name := self nextName.
	self expectNext: $;.

	entity := driver handleParameterEntityReference: name.
	replacement := self replacementFromParameterEntity: entity.

	replacement
		ifNotEmpty: [
			self
				pushBackReplacement: replacement
				forEntity: entity
				onClose: [self endReplacementForParameterEntity: entity]].
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

	(streamReader peek == $[)
		ifTrue: [
			(context isInExternalSubset
				or: [self hasActiveExternalEntity])
				ifTrue: [
					streamReader next.
					streamReader pushBack: self nextConditionalSection.
					^ self]
				ifFalse: [self parseError: 'Cannot have INCLUDE/IGNORE sections in internal subset']].

	self nextSubsetDeclaration.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextSystemLiteralRequired: aBoolean [	
	| quote value |

	(aBoolean or: [streamReader atQuote])
		ifTrue: [
			quote := self expectQuote.
			value := streamReader upTo: quote]
		ifFalse: [value := ''].
	^ value.
]

{ #category : #tokenizing }
XMLTokenizer >> nextTag [
	| tagName attributes namespaces nextChar attributeName attributeValue |

	(streamReader peek = $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName.

	attributes := OrderPreservingDictionary new: 10 withDefaultValue: ''.
	[streamReader skipSeparators.
	((nextChar := streamReader peek) isNil
		or: [nextChar == $>
			or: [nextChar == $/]])]
		whileFalse: [
			attributeName := self nextName.
			streamReader skipSeparators.
			self expectNext: $=.
			streamReader skipSeparators.
			attributeValue := self nextAttributeValue.
	
			((attributeName at: 1) == $x
				and: [driver usesNamespaces
					and: [attributeName beginsWith: 'xmlns']])
				ifTrue: [
					namespaces
						ifNil: [namespaces := OrderPreservingDictionary new: 5 withDefaultValue: ''].
					attributeName size > 6
						ifTrue: [
							namespaces
								at: (attributeName copyFrom: 7 to: attributeName size)
								put: attributeValue]
						ifFalse: [namespaces at: '' put: attributeValue]]
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
XMLTokenizer >> nextXMLDeclAttributeValue [
	^ streamReader upTo: self expectQuote.
]

{ #category : #errors }
XMLTokenizer >> parseError: anErrorString [
	driver handleParseError: anErrorString
]

{ #category : #'entity replacement' }
XMLTokenizer >> pushBackReplacement: aReplacement forEntity: anEntity onClose: aBlock [
	(self hasActiveEntityNamed: anEntity name)
		ifTrue: [self entityDepthError: 'Illegal self-referential entity ', anEntity asReference].
	(activeEntities size >= self maxEntityReplacementDepth)
		ifTrue: [self entityDepthError: 'Cannot further nest entity replacements'].

	activeEntities addLast: anEntity.
	streamReader
		pushStream: aReplacement readStream
		from: anEntity uri
		onClose: aBlock.

	anEntity isExternal
		ifTrue: [
			self
				checkTextDeclarationInReplacement: aReplacement
				forEntity: anEntity].
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

{ #category : #'entity replacement' }
XMLTokenizer >> replacementFromGeneralEntity: anEntity [
	anEntity ifNil: [^ ''].

	(context isInLiteralValue and: [anEntity isExternal])
		ifTrue: [self parseError: 'External general entity ', anEntity asReference, ' in literal context'].

	^ context isInLiteralValue
		ifTrue: [anEntity replacementForLiteralContext]
		ifFalse: [anEntity replacementForContentContext].
]

{ #category : #'entity replacement' }
XMLTokenizer >> replacementFromParameterEntity: anEntity [
	anEntity ifNil: [^ ''].

	^ context isInLiteralValue
		ifTrue: [anEntity replacementForLiteralContext]
		ifFalse: [anEntity replacementForDTDContext]
]

{ #category : #'as yet unclassified' }
XMLTokenizer >> setDriver: aDriver stream: aStream [
	super setDriver: aDriver stream: aStream.

	activeEntities := OrderedCollection new: self maxEntityReplacementDepth.
]

{ #category : #accessing }
XMLTokenizer >> tokenContextClass [
	^ XMLTokenContext
]

"
This is a base class for tokenizer. Be careful changing the code in this class or its subclases. It is heavily optimized.
"
Class {
	#name : #XMLAbstractTokenizer,
	#superclass : #Object,
	#instVars : [
		'driver',
		'context',
		'streamReader',
		'streamWriter',
		'activeEntities'
	],
	#classInstVars : [
		'predefinedEntities'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLAbstractTokenizer class >> driver: aDriver on: aStringOrStream [
	^self new
		setDriver: aDriver
		stream:
			(aStringOrStream isStream
				ifTrue: [aStringOrStream]
				ifFalse: [aStringOrStream readStream])
]

{ #category : #'class initialization' }
XMLAbstractTokenizer class >> initialize [
	"self initialize"

	self initializePredefinedEntities.
]

{ #category : #'class initialization' }
XMLAbstractTokenizer class >> initializePredefinedEntities [
]

{ #category : #accessing }
XMLAbstractTokenizer class >> predefinedEntities [
	^ predefinedEntities
]

{ #category : #testing }
XMLAbstractTokenizer >> atEnd [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> checkTextDeclarationInReplacement: aReplacement forEntity: anEntity [
	(aReplacement beginsWith: '<?xml ')
		ifTrue: [ 
			streamReader next.
			context resetAfter: [
				context enterTextDeclaration.
				self nextPIOrXMLDecl]].
]

{ #category : #accessing }
XMLAbstractTokenizer >> currentLineNumber [
	^ streamReader currentLineNumber
]

{ #category : #accessing }
XMLAbstractTokenizer >> driver [
	^ driver
]

{ #category : #'entity replacement' }
XMLAbstractTokenizer >> endReplacementForGeneralEntity: anEntity isInContent: aBoolean [
	activeEntities remove: anEntity.
	aBoolean
		ifTrue: [driver handleEndContentEntityReplacement: anEntity name].
]

{ #category : #'entity replacement' }
XMLAbstractTokenizer >> endReplacementForParameterEntity: anEntity [
	activeEntities remove: anEntity
]

{ #category : #errors }
XMLAbstractTokenizer >> entityError: anErrorString [
	XMLParserException signal: anErrorString
]

{ #category : #errors }
XMLAbstractTokenizer >> errorExpected: expectedString [
	self parseError: 'Expected ', expectedString
]

{ #category : #errors }
XMLAbstractTokenizer >> errorExpected: anExpectedCharacterOrString butGot: aReceivedCharacterOrString [
	| expectedString receivedString |

	expectedString := anExpectedCharacterOrString asString.	
	(receivedString := (aReceivedCharacterOrString ifNil: ['']) asString)
			ifEmpty: [receivedString := 'nothing'].

	self errorExpected: expectedString, ' but got ', receivedString.
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> expectNext: aCharacter [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> expectNextAll: aString [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> expectQuote [
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
XMLAbstractTokenizer >> expectTerminator: aCharacter [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> expectUpToAll: aString [
	self subclassResponsibility
]

{ #category : #testing }
XMLAbstractTokenizer >> hasActiveEntities [
	^ activeEntities notEmpty
]

{ #category : #testing }
XMLAbstractTokenizer >> hasActiveEntityNamed: aName [
	^ activeEntities anySatisfy: [:each | each name = aName]
]

{ #category : #accessing }
XMLAbstractTokenizer >> maxEntityReplacementDepth [
	^ 3
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextAttlistDeclaration [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextAttributeValue [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextCDataSection [
	self expectNextAll: '[CDATA['.
	driver handleCData: (self expectUpToAll: ']]>').

]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextComment [
	| comment |

	"Skip first -"
	streamReader next.
	self expectNext: $-.
	comment := streamReader upToAll: '--'.
	self expectTerminator: $>.

	driver handleComment: comment.
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextConditionalSection [
	self skipSeparatorsReplacingParameterEntities.
	self expectNext: $I.
	^ streamReader peek == $N
		ifTrue: [self nextIncludeSection]
		ifFalse: [self nextIgnoreSection].
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextContentMarkupToken [
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
XMLAbstractTokenizer >> nextContentToken [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextDecodedCharReference [
	| charValue |

	"skip #"
	streamReader next.
	(charValue := streamReader nextInteger) > 0
		ifFalse: [self errorExpected: 'integral character value'].
	self expectNext: $;.
	^ Unicode value: charValue.
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextDelimitedBy: aDelimiter and: aSecondDelimiter entityChar: anEntityStartChar normalizeWhitespace: shouldNormalize ignorableWhitespace: shouldSkip [
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
											ifNotNil: [
												writeStream nextPut: nextChar.
												isIgnorableWhitespace := false]]
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
XMLAbstractTokenizer >> nextDocTypeDecl [
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
XMLAbstractTokenizer >> nextElementDeclaration [
	self subclassResponsibility
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextEndDocTypeDecl [
	streamReader skipSeparators.
	self expectTerminator: $>.
	context enterProlog.

	driver handleEndDTD.
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextEndDocument [
	context enterAtEnd.
	driver handleEndDocument.
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextEndInternalSubset [
	self expectTerminator: $].

	self hasActiveEntities
		ifTrue: [self parseError: 'Parameter entity replacement cannot terminate internal subset'].
	context enterProlog.
	self nextEndDocTypeDecl.
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextEndTag [
	self subclassResponsibility
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextEntityDeclaration [
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
XMLAbstractTokenizer >> nextEntityValue [
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
XMLAbstractTokenizer >> nextExternalEntityDeclaration: aName isParameterEntity: aBoolean [
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
XMLAbstractTokenizer >> nextExternalIDSystemLiteralRequired: aBoolean [
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
XMLAbstractTokenizer >> nextGeneralEntityReference [
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
XMLAbstractTokenizer >> nextIgnoreSection [
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
XMLAbstractTokenizer >> nextIncludeSection [
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
XMLAbstractTokenizer >> nextInternalEntityDeclaration: aName isParameterEntity: aBoolean [
	| value |

	value := self nextEntityValue.
	self skipSeparatorsReplacingParameterEntities.
	self expectTerminator: $>.

	aBoolean
		ifTrue: [driver handleParameterEntityDeclaration: aName replacement: value]
		ifFalse: [driver handleGeneralEntityDeclaration: aName replacement: value].
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextInternalSubsetStart [
	"skip ["
	streamReader next.
	context enterInternalSubset.
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextName [
	self subclassResponsibility
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextNotationDeclaration [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextPIOrXMLDecl [
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
XMLAbstractTokenizer >> nextParameterEntityReference [
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
XMLAbstractTokenizer >> nextPrologToken [
	self subclassResponsibility
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextPubidLiteral [
	self subclassResponsiblity
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextStartDocument [
	context enterProlog.
	driver handleStartDocument.
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> nextSubsetDeclaration [
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
XMLAbstractTokenizer >> nextSubsetMarkupToken [
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
XMLAbstractTokenizer >> nextSubsetToken [
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
XMLAbstractTokenizer >> nextSystemLiteralRequired: aBoolean [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextTag [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextToken [
	self atEnd
		ifTrue: [^ self].
	context isInContent
		ifTrue: [^ self nextContentToken].
	context isInSubset
		ifTrue: [^ self nextSubsetToken].
	context notInitialized 
		ifTrue: [^ self nextStartDocument].

	self nextPrologToken.
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextUnparsedEntityReference [
	| name |

	streamReader next.
	name := self nextName.
	self expectNext: $;.

	^ (driver handleUnparsedEntityReference: name) ifNil: [''].
]

{ #category : #tokenizing }
XMLAbstractTokenizer >> nextXMLDecl [
	| version encoding standalone |

	version := self nextXMLDeclAttribute: 'version'.
	streamReader skipSeparators.
	encoding := 
		streamReader peek == $e
			ifTrue: [self nextXMLDeclAttribute: 'encoding']
			ifFalse: [''].
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
XMLAbstractTokenizer >> nextXMLDeclAttribute: aName [
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
XMLAbstractTokenizer >> parseError: anErrorString [
	self subclassResponsibility
]

{ #category : #'entity replacement' }
XMLAbstractTokenizer >> pushBackReplacement: aReplacement forEntity: anEntity onClose: aBlock [
	(self hasActiveEntityNamed: anEntity name)
		ifTrue: [self entityError: 'Illegal self-referential entity ', anEntity asReference].
	(activeEntities size >= self maxEntityReplacementDepth)
		ifTrue: [self entityError: 'Cannot further nest entity replacements'].

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

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> replaceParameterEntityReference [
	streamReader next.
	self nextParameterEntityReference
]

{ #category : #'entity replacement' }
XMLAbstractTokenizer >> replacementFromGeneralEntity: anEntity [
	anEntity ifNil: [^ ''].

	^ context isInLiteralValue
		ifTrue: [
			anEntity isExternal
				ifTrue: [self entityError: 'External general entity ', anEntity asReference, ' in literal context'].
			anEntity replacementForLiteralContext]
		ifFalse: [anEntity replacementForContentContext].
]

{ #category : #'entity replacement' }
XMLAbstractTokenizer >> replacementFromParameterEntity: anEntity [
	anEntity ifNil: [^ ''].

	^ context isInLiteralValue
		ifTrue: [anEntity replacementForLiteralContext]
		ifFalse: [anEntity replacementForDTDContext]
]

{ #category : #initialization }
XMLAbstractTokenizer >> setDriver: aDriver stream: aStream [
	driver := aDriver.
	context := self tokenContextClass new.
	streamReader :=
		(XMLNestedStreamReader
			on: aStream
			from: (driver ifNotNil: [driver documentURI])
			onClose: nil).
	streamWriter := XMLNestedStreamWriter new: 3.
	activeEntities := OrderedCollection new: self maxEntityReplacementDepth.
]

{ #category : #'tokenizing dtd' }
XMLAbstractTokenizer >> skipSeparatorsReplacingParameterEntities [
	"this can be used to replace references within declarations"
	streamReader skipSeparators.
	[streamReader atEnd not
		and: [context isInExternalSubset
			and: [streamReader peek == $%]]]
		whileTrue: [
			self replaceParameterEntityReference.
			streamReader skipSeparators].
]

{ #category : #accessing }
XMLAbstractTokenizer >> streamReader [
	^ streamReader
]

{ #category : #accessing }
XMLAbstractTokenizer >> tokenContext [
	^ context
]

{ #category : #accessing }
XMLAbstractTokenizer >> tokenContextClass [
	self subclassResponsibility
]

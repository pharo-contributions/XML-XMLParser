"
This class reads XML tokens from a stream using a nested stream reader. Sending it #nextToken causes a token to be read and one or more handler messages to be dispatched to a driver.
"
Class {
	#name : #XMLTokenizer,
	#superclass : #XMLAbstractTokenizer,
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

{ #category : #errors }
XMLTokenizer >> entityDepthError: anErrorString [
	XMLEntityDepthException signal: anErrorString
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

	super pushBackReplacement: aReplacement forEntity: anEntity onClose: aBlock.
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

{ #category : #accessing }
XMLTokenizer >> tokenContextClass [
	^ XMLTokenContext
]

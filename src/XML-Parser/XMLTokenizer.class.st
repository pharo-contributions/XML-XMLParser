"
This class reads XML tokens from a stream using a nested stream reader. Sending it #nextToken causes a token to be read and one or more handler messages to be dispatched to a driver.
"
Class {
	#name : #XMLTokenizer,
	#superclass : #Object,
	#instVars : [
		'driver',
		'state',
		'streamReader',
		'streamWriter',
		'entities',
		'parameterEntities'
	],
	#classVars : [
		'AdditionalNameChars',
		'CharEscapes',
		'LiteralChars',
		'NameStartChars'
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

	CharEscapes := CharacterSet newFrom: #( $& $" $' $> $< ).
	(LiteralChars := CharacterSet new)
		addAll: #( $: $- $: $= $.);
		addAll: ($a to: $z);
		addAll: ($A to: $Z);
		addAll: ($0 to: $9).

	self
		initializeNameStartChars;
		initializeAdditionalNameChars.
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

{ #category : #accessing }
XMLTokenizer class >> isCharEscape: entityValue [
	^entityValue size = 1
		and: [CharEscapes includes: entityValue first]
]

{ #category : #testing }
XMLTokenizer >> atEnd [
	state == #atEnd
		ifTrue: [^ true].
	(state ~~ #atStart and: [streamReader atEnd])
		ifTrue: [
			state := #atEnd.
			driver handleEndDocument.
			^ true].
	^ false.
]

{ #category : #tokenizing }
XMLTokenizer >> checkAndExpandReference: parsingContext [
	| referenceString nextChar |
	nextChar := streamReader peek.
	driver isValidating
		ifFalse: [^ nil].

	nextChar == $&
		ifTrue: [
			streamReader next.
			streamReader peek == $#
				ifTrue: [^ streamReader pushStream: (ReadStream on: self nextCharReference asString)].
			referenceString := self nextLiteral.
			self expectNext: $;.
			self replaceEntity: referenceString in: parsingContext ]
		ifFalse: [
			((nextChar == $%
				and: [self isParsingMarkup])
				and: [parsingContext == #entityValue])
				ifTrue: [
					streamReader skipSeparators.
					referenceString := self nextLiteral.
					self replaceEntity: referenceString in: parsingContext]].

	self expectMore.
	^ nextChar.
]

{ #category : #tokenizing }
XMLTokenizer >> conditionalInclude: aKeyword [
	aKeyword = 'INCLUDE'
		ifTrue: [^ true].
	aKeyword = 'IGNORE'
		ifTrue: [^ false].
	^ self conditionalInclude: (self parameterEntity: aKeyword) value
]

{ #category : #accessing }
XMLTokenizer >> driver [
	^ driver
]

{ #category : #private }
XMLTokenizer >> endParsingMarkup [
	state := #parsing.
]

{ #category : #entities }
XMLTokenizer >> entities [
	^ entities ifNil: [entities := self initEntities]
]

{ #category : #entities }
XMLTokenizer >> entity: aReference [
	driver isValidating
		ifFalse: [^ DTDEntityDeclaration name: aReference value: ''].

	^ self entities
		at: aReference
		ifAbsentPut: [self parseError: 'Undefined entity ', aReference printString]
]

{ #category : #entities }
XMLTokenizer >> entity: aReference put: aValue [
	"Only the first declaration of an entity is valid so if there is already
	one don't register the new value."
	self entities at: aReference ifAbsentPut: [aValue]
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
XMLTokenizer >> expectLiteral: anExpectedLiteral [
	| nextLiteral |

	((nextLiteral := self nextLiteral) = anExpectedLiteral)
		ifFalse: [self errorExpected: anExpectedLiteral butGot: nextLiteral].
	^ nextLiteral.
]

{ #category : #tokenizing }
XMLTokenizer >> expectMore [
	streamReader peek ifNil: [self errorExpected: 'more characters']
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

{ #category : #entities }
XMLTokenizer >> externalEntity: aReference [
	^ self entities at: aReference ifAbsentPut: ['']
]

{ #category : #entities }
XMLTokenizer >> initEntities [
	| ents |
	ents := Dictionary new.
	ents
		at: 'amp' put: (DTDEntityDeclaration name: 'amp' value: '&');
		at: 'quot' put: (DTDEntityDeclaration name: 'quot' value: '"');
		at: 'apos' put: (DTDEntityDeclaration name: 'apos' value: '''');
		at: 'gt' put: (DTDEntityDeclaration name: 'gt' value: '>');
		at: 'lt' put: (DTDEntityDeclaration name: 'lt' value: '<').
	^ents
]

{ #category : #initialization }
XMLTokenizer >> initialize [
	streamReader := XMLNestedStreamReader new.
	streamWriter := XMLNestedStreamWriter new.
	state := #atStart.
]

{ #category : #private }
XMLTokenizer >> isParsingMarkup [
	^ state == #isParsingMarkup
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

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeValue [
	| delimiterChar |

	delimiterChar := self expectQuote.
	^ streamWriter writeWith: [:writeStream |
		self nextPCDataDelimitedBy: delimiterChar putOn: writeStream.
		self expectNext: delimiterChar.
		writeStream contents]
]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataContent [
	| cdata |

	cdata := streamReader upToAll: ']]>'.
	driver handleCData: cdata

]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataOrConditional [

	| nextChar conditionalKeyword |
	"Skip ["
	streamReader next.
	streamReader skipSeparators.
	nextChar := streamReader peek.
	nextChar == $%
		ifTrue: [
			self checkAndExpandReference: (self isParsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
			conditionalKeyword := self nextLiteral.
			streamReader skipSeparators.
			self expectNext: $[.
			streamReader skipSeparators.
			^ self nextIncludeSection: (self conditionalInclude: conditionalKeyword)].

	self
		expectLiteral: 'CDATA';
		expectNext: $[;
		nextCDataContent.
]

{ #category : #tokenizing }
XMLTokenizer >> nextCharReference [
	| base charValue |
	streamReader next == $#
		ifFalse: [self errorExpected: 'character reference'].
	streamReader peek == $x
		ifTrue: [
			streamReader next.
			base := 16]
		ifFalse: [base := 10].

	(charValue := streamReader nextIntegerWithBase: base)
		ifNil: [self errorExpected: 'number'].
	self expectNext: $;.
	^ Unicode value: charValue.
]

{ #category : #tokenizing }
XMLTokenizer >> nextComment [
	"Skip first -"
	streamReader next.
	self expectNext: $-.
	driver handleComment: (streamReader upToAll: '-->')
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextDocType [
	self expectLiteral: 'DOCTYPE'.
	self startParsingMarkup.
	^ self nextDocTypeDecl.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextDocTypeDecl [
	| nextChar |
	streamReader skipSeparators.
	self nextLiteral.
	streamReader skipSeparators.
	streamReader peek == $[
		ifFalse: [[nextChar := streamReader peek.
				nextChar == $> or: [nextChar == $[ ]] whileFalse: [streamReader next]].
	streamReader peek == $[
		ifTrue: [
			streamReader next.
			[streamReader skipSeparators.
			streamReader peek == $]] whileFalse: [
				self checkAndExpandReference: #dtd.
				self nextMarkupToken].
			self expectNext: $]].
	streamReader skipSeparators.
	self expectNext: $>.

	self endParsingMarkup
]

{ #category : #tokenizing }
XMLTokenizer >> nextEndTag [
	| tagName |
	"Skip /"
	streamReader next.
	tagName := self nextName.
	streamReader skipSeparators.
	self expectNext: $>.
	driver handleEndTag: tagName
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEntityDeclaration [
	| entityName entityDef referenceClass reference |
	streamReader skipSeparators.
	referenceClass := streamReader peek == $%
		ifTrue: [
			streamReader next.
			streamReader skipSeparators.
			DTDParameterEntityDeclaration]
		ifFalse: [DTDEntityDeclaration].
	entityName := self nextLiteral.
	streamReader skipSeparators.
	entityDef := (streamReader peek == $" or: [streamReader peek == $'])
		ifTrue: [self nextEntityValue]
		ifFalse: [self nextExternalId].
	streamReader skipUpTo: $>.
	reference := referenceClass name: entityName value: entityDef.
	reference registerIn: self.
	^reference
]

{ #category : #tokenizing }
XMLTokenizer >> nextEntityValue [
	| delimiterChar entityValueStream nextChar nextPeek referenceString entity entityValue |
	delimiterChar := self expectQuote.
	entityValueStream := WriteStream on: (String new: 32).
	[
	self expectMore.
	nextPeek := nextChar := streamReader peek.
	nextChar == $&
		ifTrue: [
			streamReader next.
			streamReader peek == $#
				ifTrue: [
					nextPeek := nil.
					nextChar := self nextCharReference]
				ifFalse: [
					referenceString := self nextLiteral.
					self expectNext: $;.
					entity := self entity: referenceString.
					entityValue := entity valueForContext: #entityValue.
					streamReader pushStream: (ReadStream on: entityValue asString).
					nextPeek := nextChar := streamReader next]]
		ifFalse: [
			nextChar == $%
				ifTrue: [
					streamReader skipSeparators.
					referenceString := self nextLiteral.
					nextChar := self replaceEntity: referenceString in: #entityValue.
					nextPeek := nextChar := streamReader next]
				ifFalse: [streamReader next]].
	nextPeek == delimiterChar]
		whileFalse: [
			nextChar ifNotNil: [entityValueStream nextPut: nextChar]].
	^ entityValueStream contents.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextExternalId [
	| extDefType systemId dir |
	extDefType := self nextLiteral.
	extDefType = 'PUBLIC'
		ifTrue: [
			streamReader skipSeparators.
			self nextPubidLiteral.
			streamReader skipSeparators.
			streamReader peek == $>
				ifFalse: [
					systemId := self nextSystemLiteral]].

	extDefType = 'SYSTEM'
		ifTrue: [
			streamReader skipSeparators.
			systemId := self nextSystemLiteral].

	systemId
		ifNil: [^nil].

	"The rest of this method only applies if we're reading aFileStream"
	(streamReader stream isKindOf: FileStream)
		ifFalse: [^''].
	dir := streamReader stream directory.
	^(dir fileExists: systemId)
		ifTrue: [(dir readOnlyFileNamed: systemId) contents]
		ifFalse: ['']
]

{ #category : #tokenizing }
XMLTokenizer >> nextIncludeSection: parseSection [
	| section |
	"Read the file up to the next include section delimiter and parse it if parseSection is true"

	section := streamReader upToAll: ']]>'.
	parseSection
		ifTrue: [streamReader pushStream: (ReadStream on: section)]
]

{ #category : #tokenizing }
XMLTokenizer >> nextLiteral [
	| nextChar |

	((nextChar := streamReader peek) isLetter
		or: [nextChar == $_])
		ifFalse: [self errorExpected: 'name literal.'].

	^ streamWriter writeWith: [:writeStream |
		[LiteralChars includes: nextChar]
			whileTrue: [
				nextChar == $&
					ifTrue: [
						nextChar := streamReader next.
						writeStream nextPut: (streamReader peek == $#
							ifTrue: [self nextCharReference]
							ifFalse: [^ writeStream contents])]
					ifFalse: [writeStream nextPut: streamReader next].
				nextChar := streamReader peek].
		writeStream position > 0
			ifFalse: [self errorExpected: 'name literal'].
		writeStream contents]
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextMarkupDeclaration [
	| declType |
	declType := self nextLiteral.
	driver isValidating
		ifFalse: [^ self skipMarkupDeclaration].
	declType = 'ENTITY'
		ifTrue: [self nextEntityDeclaration]
		ifFalse: [self skipMarkupDeclaration]
]

{ #category : #tokenizing }
XMLTokenizer >> nextMarkupToken [
	| nextChar |
	"Skip < "
	streamReader next.
	nextChar := streamReader peek.
	nextChar == $! ifTrue: [
		"Skip !"
		streamReader next.
		nextChar := streamReader peek.
		nextChar == $- ifTrue: [^ self nextComment].
		nextChar == $[ ifTrue: [^ self nextCDataOrConditional].
		^ self isParsingMarkup
			ifTrue: [self nextMarkupDeclaration]
			ifFalse: [self nextDocType]].
	nextChar == $? ifTrue: [^ self nextPI].
	self nextTag.
]

{ #category : #tokenizing }
XMLTokenizer >> nextName [
	| nextChar |

	^ streamWriter writeWith: [:writeStream |
		(NameStartChars includes: (nextChar := streamReader next))
			ifFalse: [self errorExpected: 'name'].
		writeStream nextPut: nextChar.

		[streamReader atEnd not
			and: [(NameStartChars includes: (nextChar := streamReader peek))
				or: [AdditionalNameChars includes: nextChar]]]
			whileTrue: [writeStream nextPut: streamReader next].
		writeStream contents]
]

{ #category : #tokenizing }
XMLTokenizer >> nextPCData [

	streamWriter writeWith: [:writeStream |
		driver isValidating
			ifTrue: [self nextPCDataDelimitedBy: $< putOn: writeStream]
			ifFalse: [
				[streamReader peek == $<]
					whileFalse: [writeStream nextPut: streamReader next]].

		driver handlePCData: writeStream contents]
]

{ #category : #tokenizing }
XMLTokenizer >> nextPCDataDelimitedBy: aDelimiter putOn: aStream [
	| nextChar referenceString entity entityValue |

	[(nextChar := streamReader peek) isNil or: [nextChar == aDelimiter]]
		whileFalse: [
			nextChar == $&
				ifTrue: [
					streamReader next.
					streamReader peek == $#
						ifTrue: [aStream nextPut: self nextCharReference]
						ifFalse: [
							referenceString := self nextLiteral.
							self expectNext: $;.
							entity := self entity: referenceString.
							entityValue := entity valueForContext: #content.
							(self class isCharEscape: entityValue)
								ifTrue: [aStream nextPut: entityValue first]
								ifFalse: [
									entityValue := entityValue asString.
									entityValue isEmpty
										ifFalse: [
											streamReader pushStream:
												(ReadStream on: entityValue asString)]]]]
				ifFalse: [aStream nextPut: streamReader next]].
]

{ #category : #tokenizing }
XMLTokenizer >> nextPI [
	| piTarget piData |
	"Skip ?"
	streamReader next.
	piTarget := self nextLiteral.
	piTarget asUppercase = 'XML'
		ifTrue: [^ self nextXMLDecl].
	streamReader skipSeparators.
	piData := streamReader upToAll: '?>'.
	driver handlePI: piTarget data: piData.
]

{ #category : #tokenizing }
XMLTokenizer >> nextPubidLiteral [
	^ self nextAttributeValue
]

{ #category : #tokenizing }
XMLTokenizer >> nextSystemLiteral [
	^ self nextAttributeValue
]

{ #category : #tokenizing }
XMLTokenizer >> nextTag [
	| tagName attributes nextChar namespaces |
	(streamReader peek = $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName.
	streamReader skipSeparators.
	attributes := OrderPreservingDictionary new: 10 withDefaultValue: ''.
	driver usesNamespaces
		ifTrue: [namespaces := OrderPreservingDictionary defaultValue: ''].
	[(nextChar := streamReader peek) == $> or: [nextChar == $/]] whileFalse: [
		self checkAndExpandReference: #content.
		self nextAttributeInto: attributes namespaces: namespaces.
		streamReader skipSeparators.].
	driver handleStartTag: tagName attributes: attributes namespaces: namespaces.
	streamReader next == $/
		ifTrue: [
			driver handleEndTag: tagName.
			self expectNext: $>].
]

{ #category : #tokenizing }
XMLTokenizer >> nextToken [
	| whitespace |

	state == #atStart
		ifTrue: [
			driver handleStartDocument.
			state := #started].

	whitespace := self nextWhitespace.
	self atEnd
		ifTrue: [^ self].

	self checkAndExpandReference: (self isParsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
	^ (streamReader peek = $<)
		ifTrue: [self nextMarkupToken]
		ifFalse: [
			whitespace ifNotEmpty: [streamReader pushBack: whitespace].
			self nextPCData].
]

{ #category : #tokenizing }
XMLTokenizer >> nextWhitespace [
	| whitespace |

	(whitespace := streamReader nextWhitespace)
		ifNotEmpty: [driver handleWhitespace: whitespace].
	^ whitespace.
]

{ #category : #tokenizing }
XMLTokenizer >> nextXMLDecl [
	| attributes namespaces |
	streamReader skipSeparators.
	attributes := Dictionary new.
	namespaces := Dictionary new.
	[streamReader peek == $?]
		whileFalse: [
			self nextAttributeInto: attributes namespaces: namespaces.
			streamReader skipSeparators].
	streamReader next.
	self expectNext: $>.
	(attributes includesKey: 'encoding')
		ifTrue: [streamReader useConverterForEncoding: (attributes at: 'encoding')].
	driver
		handleXMLVersion: (attributes at: 'version' ifAbsent: [''])
		encoding: (attributes at: 'encoding' ifAbsent: [''])
		standalone: (attributes at: 'standalone' ifAbsent: ['']).
]

{ #category : #entities }
XMLTokenizer >> parameterEntities [
	^ parameterEntities ifNil: [parameterEntities := Dictionary new]
]

{ #category : #entities }
XMLTokenizer >> parameterEntity: refName [
	^ self parameterEntities
		at: refName
		ifAbsent: [self parseError: 'undefined parameter entity ', refName printString]
]

{ #category : #entities }
XMLTokenizer >> parameterEntity: refName put: aReference [
	"Only the first declaration of an entity is valid so if there is already
	one don't register the new value."
	self parameterEntities at: refName ifAbsentPut: [aReference]
]

{ #category : #errors }
XMLTokenizer >> parseError: errorString [
	XMLParsingException signal: errorString
]

{ #category : #entities }
XMLTokenizer >> replaceEntity: referenceString in: parsingContext [ 

	| entity entityValue |
	entity := self entity: referenceString.
	entityValue := entity valueForContext: parsingContext.
	(self class isCharEscape: entityValue)
		ifTrue: [entityValue := entity reference].
	streamReader pushStream: (ReadStream on: entityValue asString)
]

{ #category : #private }
XMLTokenizer >> setDriver: aDriver stream: aStream [
	driver := aDriver.
	streamReader stream: aStream.
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> skipMarkupDeclaration [
	streamReader skipUpTo: $>
]

{ #category : #private }
XMLTokenizer >> startParsingMarkup [
	state := #isParsingMarkup
]

{ #category : #private }
XMLTokenizer >> stream [
	^ streamReader stream
]

{ #category : #accessing }
XMLTokenizer >> streamReader [
	^ streamReader
]

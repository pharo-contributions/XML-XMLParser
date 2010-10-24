"
This class reads XML tokens from a stream using an XMLStreamReader. To create a parser, subclass XMLTokenizer and override the #handle- messages to handle tokens as they are read. To cause a token to be read, send #nextToken to an instance.
"
Class {
	#name : #XMLTokenizer,
	#superclass : #Object,
	#instVars : [
		'streamReader',
		'streamWriter',
		'entities',
		'externalEntities',
		'parameterEntities',
		'isValidating',
		'parsingMarkup'
	],
	#classVars : [
		'CharEscapes',
		'LiteralChars',
		'NameDelimiters'
	],
	#category : #'XML-Parser'
}

{ #category : #'class initialization' }
XMLTokenizer class >> initialize [
	"XMLTokenizer initialize"

	CharEscapes := CharacterSet newFrom: #( $& $" $' $> $< ).

	LiteralChars := CharacterSet newFrom: #( $: $- $: $= $.).
	0 to: 255 do: [:i | 
		| char |
		char := i asCharacter.
		(char isDigit or: [char isLetter])
		ifTrue: [LiteralChars add: char]].

	NameDelimiters := CharacterSet new.
	#(9 10 12 13 32 61 "$= asInteger 61" 62 "$> asInteger" 47 "$/ asInteger")
		do: [:each | NameDelimiters add: each asCharacter].
]

{ #category : #accessing }
XMLTokenizer class >> isCharEscape: entityValue [
	^entityValue size = 1
		and: [CharEscapes includes: entityValue first]
]

{ #category : #'instance creation' }
XMLTokenizer class >> on: aStream [
	^self new stream: aStream
]

{ #category : #tokenizing }
XMLTokenizer >> checkAndExpandReference: parsingContext [
	| referenceString nextChar |
	nextChar := streamReader peek.
	self isValidating
		ifFalse: [^ nil].

	nextChar == $&
		ifTrue: [
			streamReader next.
			streamReader peek == $#
				ifTrue: [^ streamReader pushStream: (ReadStream on: self nextCharReference asString)].
			referenceString := self nextLiteral.
			self expectNext: $;.
			self handleEntity: referenceString in: parsingContext ]
		ifFalse: [
			((nextChar == $%
				and: [self parsingMarkup])
				and: [parsingContext == #entityValue])
				ifTrue: [
					streamReader skipSeparators.
					referenceString := self nextLiteral.
					self handleEntity: referenceString in: parsingContext]].

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

{ #category : #private }
XMLTokenizer >> endParsingMarkup [
	parsingMarkup := false
]

{ #category : #entities }
XMLTokenizer >> entities [
	^ entities ifNil: [entities := self initEntities]
]

{ #category : #entities }
XMLTokenizer >> entity: aReference [
	self isValidating
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
	| nextChar expected |

	(((nextChar := streamReader next) == $")
		or: [nextChar == $'])
			ifFalse: [
				self
					errorExpected: 'quote character delimiter'
					butGot: nextChar].
	^ nextChar.
]

{ #category : #entities }
XMLTokenizer >> externalEntities [
	^ externalEntities ifNil: [externalEntities := Dictionary new]
]

{ #category : #entities }
XMLTokenizer >> externalEntity: aReference [
	^ self entities at: aReference ifAbsentPut: ['']
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleCData: aString [
	self log: 'CData: ' , aString
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleComment: aString [
	self log: 'Comment: ' , aString
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleEndDocument [
	self log: 'End Doc '
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleEndTag: aString [
	self log: 'End tag: ' , aString
]

{ #category : #entities }
XMLTokenizer >> handleEntity: referenceString in: parsingContext [ 

	| entity entityValue |
	entity := self entity: referenceString.
	entityValue := entity valueForContext: parsingContext.
	(self class isCharEscape: entityValue)
		ifTrue: [entityValue := entity reference].
	streamReader pushStream: (ReadStream on: entityValue asString)
]

{ #category : #'handling tokens' }
XMLTokenizer >> handlePCData: aString [
	self log: 'PCData: ' , aString
]

{ #category : #'handling tokens' }
XMLTokenizer >> handlePI: piTarget data: piData [
	self log: 'PI: ' , piTarget , ' data ' , piData
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleStartDocument [
	self log: 'Start Doc'
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleStartTag: tagName attributes: attributes [
	self log: 'Start tag: ' , tagName.
	attributes keysAndValuesDo: [:key :value |
		self log: key , '->' , value]
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleStartTag: tagName attributes: attributes namespaces: namespaces [
	self handleStartTag: tagName attributes: attributes
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleWhitespace: aString [
	self log: 'Whitespace: ' , aString
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleXMLDecl: attributes [
	attributes keysAndValuesDo: [:key :value |
		self log: key , '->' , value]
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
	parsingMarkup := false.
	isValidating := false.
]

{ #category : #testing }
XMLTokenizer >> isValidating [
	^ isValidating
]

{ #category : #accessing }
XMLTokenizer >> isValidating: aBoolean [
	isValidating := aBoolean
]

{ #category : #private }
XMLTokenizer >> log: aString [
	"Transcript show: aString; cr"
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeInto: attributes namespaces: namespaces [

	| attrName attrValue |
	attrName := self nextName.
	streamReader skipSeparators.
	self expectNext: $=.
	streamReader skipSeparators.
	attrValue := self nextAttributeValue.

	(self usesNamespaces
		and: [attrName beginsWith: 'xmlns'])
		ifTrue: [attrName size > 6
			ifTrue: [namespaces at: (attrName copyFrom: 7 to: attrName size) put: attrValue]
			ifFalse: [namespaces at: attrName put: attrValue]]
		ifFalse: [attributes at: attrName put: attrValue].
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeValue [
	| delimiterChar |

	delimiterChar := self expectQuote.
	^ streamWriter writeWith: [:writeStream |
		self nextPCDataDelimitedBy: delimiterChar putOn: writeStream.
		self expectNext: delimiterChar.
		writeStream stringContents]
]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataContent [
	| cdata |

	cdata := streamReader upToAll: ']]>'.
	self handleCData: cdata

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
			self checkAndExpandReference: (self parsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
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
	self handleComment: (streamReader upToAll: '-->')
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
	self handleEndTag: tagName
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
					nextChar := self handleEntity: referenceString in: #entityValue.
					nextPeek := nextChar := streamReader next]
				ifFalse: [streamReader next]].
	nextPeek == delimiterChar]
		whileFalse: [
			nextChar ifNotNil: [entityValueStream nextPut: nextChar]].
	^ entityValueStream stringContents.
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
		ifTrue: [(dir readOnlyFileNamed: systemId) stringContents]
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
							ifFalse: [^ writeStream stringContents])]
					ifFalse: [writeStream nextPut: streamReader next].
				nextChar := streamReader peek].
		writeStream position > 0
			ifFalse: [self errorExpected: 'name literal'].
		writeStream stringContents]
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextMarkupDeclaration [
	| declType |
	declType := self nextLiteral.
	self isValidating
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
		^ self parsingMarkup
			ifTrue: [self nextMarkupDeclaration]
			ifFalse: [self nextDocType]].
	nextChar == $? ifTrue: [^ self nextPI].
	self nextTag.
]

{ #category : #tokenizing }
XMLTokenizer >> nextName [
	| nextChar |

	^ streamWriter writeWith: [:writeStream |
		[(nextChar := streamReader peek) isNil
			or: [NameDelimiters includes: nextChar]]
				whileFalse: [writeStream nextPut: streamReader next].
		writeStream position > 0
			ifFalse: [self errorExpected: 'name'].
		writeStream stringContents]
]

{ #category : #tokenizing }
XMLTokenizer >> nextPCData [

	streamWriter writeWith: [:writeStream |
		self isValidating
			ifTrue: [self nextPCDataDelimitedBy: $< putOn: writeStream]
			ifFalse: [
				[streamReader peek == $<]
					whileFalse: [writeStream nextPut: streamReader next]].

		self handlePCData: writeStream stringContents]
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
	self handlePI: piTarget data: piData.
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
	attributes := XMLOrderPreservingDictionary new: 10.
	self usesNamespaces
		ifTrue: [namespaces := XMLOrderPreservingDictionary new].
	[(nextChar := streamReader peek) == $> or: [nextChar == $/]] whileFalse: [
		self checkAndExpandReference: #content.
		self nextAttributeInto: attributes namespaces: namespaces.
		streamReader skipSeparators.].
	self handleStartTag: tagName attributes: attributes namespaces: namespaces.
	streamReader next == $/
		ifTrue: [
			self handleEndTag: tagName.
			self expectNext: $>].
]

{ #category : #tokenizing }
XMLTokenizer >> nextToken [
	"return the next XMLnode, or nil if there are no more.
	Fixed to retain leading whitespace when PCDATA is detected."

	| whitespace |
	"branch, depending on what the first character is"
	whitespace := self nextWhitespace.
	streamReader atEnd
		ifTrue: [^ self handleEndDocument].

	self checkAndExpandReference: (self parsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
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
		ifNotEmpty: [self handleWhitespace: whitespace].
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
		ifTrue: [streamReader streamEncoding: (attributes at: 'encoding')].
	self handleXMLDecl: attributes.
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
	XMLParseException signal: errorString
]

{ #category : #private }
XMLTokenizer >> parsingMarkup [
	^ parsingMarkup
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> skipMarkupDeclaration [
	streamReader skipUpTo: $>
]

{ #category : #private }
XMLTokenizer >> startParsingMarkup [
	parsingMarkup := true
]

{ #category : #private }
XMLTokenizer >> stream [
	^ streamReader stream
]

{ #category : #private }
XMLTokenizer >> stream: aStream [
	streamReader stream: aStream
]

{ #category : #accessing }
XMLTokenizer >> streamReader [
	^ streamReader
]

{ #category : #testing }
XMLTokenizer >> usesNamespaces [
	^ false
]

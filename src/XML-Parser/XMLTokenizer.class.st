"
XMLTokenizer

bolot@cc.gatech.edu

breaks the stream of characters into a stream of XMLnodes (aka token stream)
token stream is used by XMLparser to generate XMLdocument tree
"
Class {
	#name : #XMLTokenizer,
	#superclass : #Object,
	#instVars : [
		'streamReader',
		'isValidating',
		'entities',
		'externalEntities',
		'parameterEntities',
		'parsingMarkup',
		'nameBuffer',
		'attributeBuffer'
	],
	#classVars : [
		'CharEscapes',
		'LiteralChars',
		'NameDelimiters'
	],
	#category : #'XML-Parser-Parser'
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

{ #category : #'as yet unclassified' }
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
		ifFalse: [^nil].
	nextChar == $&
		ifTrue: [
			streamReader next.
			streamReader peek == $#
				ifTrue: [^ streamReader pushStream: (ReadStream on: self nextCharReference asString)].
			referenceString := self nextLiteral.
			streamReader next == $;
				ifFalse: [self errorExpected: ';'].
			self handleEntity: referenceString in: parsingContext ]
		ifFalse: [
			((nextChar == $%
				and: [self parsingMarkup])
				and: [parsingContext == #entityValue])
				ifTrue: [
					streamReader skipSeparators.
					referenceString := self nextLiteral.
					self handleEntity: referenceString in: parsingContext]].

	streamReader atEnd ifTrue: [self errorExpected: 'Character expected.'].
	^nextChar
]

{ #category : #tokenizing }
XMLTokenizer >> conditionalInclude: aKeyword [
	aKeyword = 'INCLUDE'
		ifTrue: [^ true].
	aKeyword = 'IGNORE'
		ifTrue: [^ false].
	^ self conditionalInclude: (self parameterEntity: aKeyword) value
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> endDocTypeDecl [
	"Skip ]>"
	streamReader
		next;
		next.
	^nil
]

{ #category : #private }
XMLTokenizer >> endParsingMarkup [
	parsingMarkup := false
]

{ #category : #entities }
XMLTokenizer >> entities [
	entities ifNil: [entities := self initEntities].
	^entities
]

{ #category : #entities }
XMLTokenizer >> entity: aReference [
	self isValidating
		ifFalse: [^ DTDEntityDeclaration name: aReference value: ''].

	^ self entities
		at: aReference
		ifAbsentPut: [self parseError: 'XML undefined entity ', aReference printString]
]

{ #category : #entities }
XMLTokenizer >> entity: aReference put: aValue [
	"Only the first declaration of an entity is valid so if there is already
	one don't register the new value."
	self entities at: aReference ifAbsentPut: [aValue]
]

{ #category : #errors }
XMLTokenizer >> errorExpected: expectedString [
	self parseError: 'expected ', expectedString printString
]

{ #category : #entities }
XMLTokenizer >> externalEntities [
	externalEntities ifNil: [externalEntities := Dictionary new].
	^externalEntities
]

{ #category : #entities }
XMLTokenizer >> externalEntity: aReference [
	^ self entities at: aReference ifAbsentPut: ['']
]

{ #category : #private }
XMLTokenizer >> fastStreamStringContents: writeStream [
	| newSize |
	newSize := writeStream position.
	^ (String new: newSize)
		replaceFrom: 1
		to: newSize
		with: writeStream originalContents
		startingAt: 1
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

{ #category : #initialize }
XMLTokenizer >> initialize [
	streamReader := XMLStreamReader new.
	parsingMarkup := false.
	isValidating := false.
	attributeBuffer := WriteStream on: (String new: 128).
	nameBuffer := WriteStream on: (String new: 128)
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

{ #category : #errors }
XMLTokenizer >> malformedError: errorString [
	SAXMalformedException signal: errorString
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeInto: attributes namespaces: namespaces [

	| attrName attrValue |
	attrName := self nextName.
	streamReader skipSeparators.
	streamReader next == $=
		ifFalse: [self errorExpected: '='].
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
	| delimiterChar attributeValueStream nextChar nextPeek referenceString entity entityValue |
	delimiterChar := streamReader next.
	(delimiterChar == $"
		or: [delimiterChar == $'])
		ifFalse: [self errorExpected: 'Attribute value delimiter expected.'].
	attributeValueStream := attributeBuffer reset.
	[
	nextPeek := nextChar := streamReader next.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			streamReader peek == $#
				ifTrue: [
					nextPeek := nil.
					nextChar := self nextCharReference]
				ifFalse: [
					referenceString := self nextLiteral.
					streamReader next == $;
						ifFalse: [self errorExpected: ';'].
					entity := self entity: referenceString.
					entityValue := entity valueForContext: #content.
					(self class isCharEscape: entityValue)
						ifTrue: [
							nextPeek := nil.
							nextChar := entityValue first]
						ifFalse: [
							entityValue := entityValue asString.
							entityValue isEmpty
								ifTrue: [nextPeek := nextChar := nil]
								ifFalse: [
									streamReader pushStream: (ReadStream on: entityValue asString).
									nextPeek := nextChar := streamReader next]]]].
	nextPeek == delimiterChar]
		whileFalse: [
			nextChar ifNotNil: [attributeValueStream nextPut: nextChar]].
	^self fastStreamStringContents: attributeValueStream.
]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataContent [
	| cdata |
	"Skip $[ "
	streamReader next.
	cdata := streamReader nextUpToAll: ']]>'.
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
			^streamReader next == $[
				ifTrue: [
						streamReader skipSeparators.
						self nextIncludeSection: (self conditionalInclude: conditionalKeyword)]
				ifFalse: [self errorExpected: '[' ]].

	nextChar == $C
		ifTrue: [
			^self nextLiteral = 'CDATA'
				ifTrue: [streamReader peek == $[
							ifTrue: [self nextCDataContent]
							ifFalse: [self errorExpected: '[' ]]
				ifFalse: [self errorExpected: 'CData']].
	self errorExpected: 'CData or declaration'

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

	charValue := [streamReader readNumberBase: base]
		on: Error
		do: [:ex | self errorExpected: 'Number.'].
	(streamReader next) == $;
		ifFalse: [self errorExpected: '";"'].
	^ Unicode value: charValue.
]

{ #category : #tokenizing }
XMLTokenizer >> nextComment [
	| string |
	"Skip first -"
	streamReader next.
	streamReader next == $-
		ifFalse: [self errorExpected: 'second comment $-'].
	string := streamReader nextUpToAll: '-->'.
	self handleComment: string
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextDocType [
	| declType |
	declType := self nextLiteral.
	declType = 'DOCTYPE'
		ifTrue: [
			self startParsingMarkup.
			^self nextDocTypeDecl].
	self errorExpected: 'markup declaration, not ' , declType printString
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
				self nextNode].
			streamReader next == $] 
				ifFalse: [self errorExpected: ']' ]].
	streamReader skipSeparators.
	streamReader next == $>
		ifFalse: [self errorExpected: '>' ].

	self endParsingMarkup
]

{ #category : #tokenizing }
XMLTokenizer >> nextEndTag [
	| tagName |
	"Skip /"
	streamReader next.
	tagName := self nextName.
	streamReader skipSeparators.
	(streamReader nextTrimmedBlanksUpTo: $>)
		ifNotEmpty: [self parseError: 'XML invalid end tag ' , tagName].
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
	delimiterChar := streamReader next.
	(delimiterChar == $"
		or: [delimiterChar == $'])
		ifFalse: [self errorExpected: 'Entity value delimiter expected.'].

	entityValueStream := WriteStream on: (String new).
	[
	nextPeek := nextChar := streamReader peek.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			streamReader next.
			streamReader peek == $#
				ifTrue: [
					nextPeek := nil.
					nextChar := self nextCharReference]
				ifFalse: [
					referenceString := self nextLiteral.
					streamReader next == $;
						ifFalse: [self errorExpected: ';'].
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
	^entityValueStream contents
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
	(streamReader topStream isKindOf: FileStream)
		ifFalse: [^''].
	dir := streamReader topStream directory.
	^(dir fileExists: systemId)
		ifTrue: [(dir readOnlyFileNamed: systemId) contentsOfEntireFile]
		ifFalse: ['']
]

{ #category : #tokenizing }
XMLTokenizer >> nextIncludeSection: parseSection [
	| section |
	"Read the file up to the next include section delimiter and parse it if parseSection is true"

	
	section := streamReader nextUpToAll: ']]>'.
	parseSection
		ifTrue: [streamReader pushStream: (ReadStream on: section)]
]

{ #category : #tokenizing }
XMLTokenizer >> nextLiteral [
	| resultStream nextChar resultString |
	resultStream := (String new: 10) writeStream.
	((nextChar := streamReader peek) isLetter
		or: [nextChar == $_])
		ifFalse: [self errorExpected: 'Name literal.'].
	[nextChar := streamReader peek.
	(LiteralChars includes: nextChar)
		ifTrue: [
			nextChar == $&
				ifTrue: [
					nextChar := streamReader next.
					resultStream nextPut: (streamReader peek == $#
						ifTrue: [self nextCharReference]
						ifFalse: [^ resultStream contents])]
				ifFalse: [
					resultStream nextPut: streamReader next]]
		ifFalse: [resultString := resultStream contents.
			resultString isEmpty
				ifTrue: [self errorExpected: 'Name literal']
				ifFalse: [^ resultString]]] repeat
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
XMLTokenizer >> nextName [
	| nextChar |
	nameBuffer reset.
	streamReader peek == $.
		ifTrue: [self malformedError: 'Character expected.'].
	[(nextChar := streamReader peek)
		ifNil: [self errorExpected: 'Character expected.'].
	NameDelimiters includes: nextChar] whileFalse: [
			nameBuffer nextPut: streamReader next].
	^ self fastStreamStringContents: nameBuffer.
]

{ #category : #tokenizing }
XMLTokenizer >> nextNode [
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
	self nextTag
]

{ #category : #tokenizing }
XMLTokenizer >> nextPCData [
	| resultStream nextChar referenceString entity entityValue nextPeek |
	resultStream := (String new: 10) writeStream.
	self isValidating
		ifFalse: [
			[streamReader peek == $<]
				whileFalse: [resultStream nextPut: streamReader next].
			^self handlePCData: resultStream contents].

	[
	nextPeek := nextChar := streamReader peek.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			streamReader next.
			streamReader peek == $#
				ifTrue: [
					nextPeek := nil.
					nextChar := self nextCharReference]
				ifFalse: [
					referenceString := self nextLiteral.
					streamReader next == $;
						ifFalse: [self errorExpected: ';'].
					entity := self entity: referenceString.
					entityValue := entity valueForContext: #content.
					(self class isCharEscape: entityValue)
						ifTrue: [
							nextPeek := nil.
							nextChar := entityValue first]
						ifFalse: [
							entityValue := entityValue asString.
							entityValue isEmpty
								ifTrue: [nextPeek := nextChar := nil]
								ifFalse: [
									streamReader pushStream: (ReadStream on: entityValue asString).
									nextPeek := nextChar := streamReader peek]]]]
		ifFalse: [nextPeek == $< ifFalse: [streamReader next]].
	nextPeek == $<]
		whileFalse: [
			nextChar ifNotNil: [resultStream nextPut: nextChar]].
	self handlePCData: resultStream contents
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
	piData := streamReader nextUpToAll: '?>'.
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
	namespaces := XMLOrderPreservingDictionary new: 5.
	[(nextChar := streamReader peek) == $> or: [nextChar == $/]] whileFalse: [
		self checkAndExpandReference: #content.
		self nextAttributeInto: attributes namespaces: namespaces.
		streamReader skipSeparators.].
	self handleStartTag: tagName attributes: attributes namespaces: namespaces.
	streamReader next == $/
		ifTrue: [
			self handleEndTag: tagName.
			streamReader next].
]

{ #category : #tokenizing }
XMLTokenizer >> nextToken [
	"return the next XMLnode, or nil if there are no more.
	Fixed to retain leading whitespace when PCDATA is detected."

	| whitespace |
	"branch, depending on what the first character is"
	whitespace := self nextWhitespace.
	streamReader atEnd ifTrue: [self handleEndDocument. ^ nil].
	self checkAndExpandReference: (self parsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
	^ (streamReader peek = $<)
		ifTrue: [self nextNode]
		ifFalse: [
			whitespace ifNotEmpty: [streamReader pushBack: whitespace].
			self nextPCData]
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
	| attributes nextChar namespaces |
	streamReader skipSeparators.
	attributes := Dictionary new.
	namespaces := Dictionary new.
	[(nextChar := streamReader peek) == $?] whileFalse: [
		self nextAttributeInto: attributes namespaces: namespaces.
		streamReader skipSeparators.].
	streamReader next.
	streamReader next == $>
		ifFalse: [self errorExpected: '> expected.'].
	(attributes includesKey: 'encoding')
		ifTrue: [streamReader streamEncoding: (attributes at: 'encoding')].
	self handleXMLDecl: attributes.
]

{ #category : #entities }
XMLTokenizer >> parameterEntities [
	parameterEntities ifNil: [parameterEntities := Dictionary new].
	^parameterEntities
]

{ #category : #entities }
XMLTokenizer >> parameterEntity: refName [
	^self parameterEntities
		at: refName
		ifAbsent: [self parseError: 'XML undefined parameter entity ' , refName printString]
]

{ #category : #entities }
XMLTokenizer >> parameterEntity: refName put: aReference [
	"Only the first declaration of an entity is valid so if there is already
	one don't register the new value."
	self parameterEntities at: refName ifAbsentPut: [aReference]
]

{ #category : #errors }
XMLTokenizer >> parseError: errorString [
	SAXParseException signal: errorString
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

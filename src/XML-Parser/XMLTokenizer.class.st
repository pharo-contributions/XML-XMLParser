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
		'stream',
		'nestedStreams',
		'entities',
		'externalEntities',
		'parameterEntities',
		'parsingMarkup',
		'peekChar',
		'validating',
		'nameBuffer',
		'attributeBuffer'
	],
	#classVars : [
		'CharEscapes',
		'DigitTable',
		'LiteralChars',
		'NameDelimiters',
		'SeparatorTable'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #'class initialization' }
XMLTokenizer class >> initialize [
	"XMLTokenizer initialize"

	CharEscapes := CharacterSet newFrom: #( $& $" $' $> $< ).

	SeparatorTable  := CharacterSet new.
	#(9 10 12 13 32) do: [:each | SeparatorTable add: each asCharacter].

	LiteralChars := CharacterSet newFrom: #( $: $- $: $= $.).
	0 to: 255 do: [:i | 
		| char |
		char := i asCharacter.
		(char isDigit or: [char isLetter])
		ifTrue: [LiteralChars add: char]].

	NameDelimiters := CharacterSet new.
	#(9 10 12 13 32 61 "$= asInteger 61" 62 "$> asInteger" 47 "$/ asInteger")
		do: [:each | NameDelimiters add: each asCharacter].

	DigitTable := Array new: 256.
	DigitTable atAllPut: -1.
	($0 to: $9) do: [:each | DigitTable at: each asciiValue put: each digitValue].
	($a to: $f) do: [:each | DigitTable at: each asciiValue put: each digitValue].
	($A to: $F) do: [:each | DigitTable at: each asciiValue put: each digitValue].

]

{ #category : #accessing }
XMLTokenizer class >> isCharEscape: entityValue [
	^entityValue size = 1
		and: [CharEscapes includes: entityValue first]
]

{ #category : #'instance creation' }
XMLTokenizer class >> on: aStream [
	^self new parseStream: aStream
]

{ #category : #streaming }
XMLTokenizer >> atEnd [
	nestedStreams == nil
		ifTrue: [^peekChar == nil and: [stream atEnd]].
	^stream atEnd
		ifTrue: [
			self popNestingLevel.
			self atEnd]
		ifFalse: [false]
]

{ #category : #streaming }
XMLTokenizer >> basicNext [
	"Returns next character in the stream after performing line endings normalization"
	| char nextChar |
	
	char := stream next.
	char == Character cr 
		ifTrue: [
			char := Character lf.
			nextChar := stream next.
			(nextChar = Character lf or: [nextChar == nil]) ifFalse: [self pushBack: nextChar asString]].
	^ char
]

{ #category : #tokenizing }
XMLTokenizer >> checkAndExpandReference: parsingContext [
	| referenceString nextChar |
	nextChar := self peek.
	self validating
		ifFalse: [^nil].
	nextChar == $&
		ifTrue: [
			self next.
			self peek == $#
				ifTrue: [^self pushStream: (ReadStream on: self nextCharReference asString)].
			referenceString := self nextLiteral.
			self next == $;
				ifFalse: [self errorExpected: ';'].
			self handleEntity: referenceString in: parsingContext ]
		ifFalse: [
			((nextChar == $%
				and: [self parsingMarkup])
				and: [parsingContext == #entityValue])
				ifTrue: [
					self skipSeparators.
					referenceString := self nextLiteral.
					self handleEntity: referenceString in: parsingContext]].

	self atEnd ifTrue: [self errorExpected: 'Character expected.'].
	^nextChar
]

{ #category : #streaming }
XMLTokenizer >> checkNestedStream [
	nestedStreams == nil
		ifFalse: [(peekChar == nil and: [self stream atEnd])
			ifTrue: [
				self popNestingLevel.
				self checkNestedStream]]

]

{ #category : #tokenizing }
XMLTokenizer >> conditionalInclude: conditionalKeyword [
	conditionalKeyword = 'INCLUDE'
		ifTrue: [^true].
	conditionalKeyword = 'IGNORE'
		ifTrue: [^false].
	^self conditionalInclude: (self parameterEntity: conditionalKeyword) value
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> endDocTypeDecl [
	"Skip ]>"
	self next; next.
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
XMLTokenizer >> entity: refName [
	^self validating
		ifTrue: [self entities
			at: refName
			ifAbsentPut: [self parseError: 'XML undefined entity ' , refName printString]]
		ifFalse: [DTDEntityDeclaration name: refName value: '']

]

{ #category : #entities }
XMLTokenizer >> entity: refName put: aReference [
	"Only the first declaration of an entity is valid so if there is already one don't register the new value."
	self entities at: refName ifAbsentPut: [aReference]
]

{ #category : #errors }
XMLTokenizer >> errorExpected: expectedString [
	| actualString |
	actualString := ''.
	self atEnd
		ifFalse: [
			[actualString := self next: 20]
				on: Error
				do: [:ex | ]].
	self parseError: 'XML expected ' , expectedString printString , ': ' , actualString
]

{ #category : #entities }
XMLTokenizer >> externalEntities [
	externalEntities ifNil: [externalEntities := Dictionary new].
	^externalEntities
]

{ #category : #entities }
XMLTokenizer >> externalEntity: refName [
	^self entities
		at: refName
		ifAbsentPut: ['']
]

{ #category : #private }
XMLTokenizer >> fastStreamStringContents: writeStream [
	| newSize |
	newSize := writeStream position.
	^(String new: newSize)
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
	self pushStream: (ReadStream on: entityValue asString)
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
XMLTokenizer >> handleWhitespace: aString [
	self log: 'Whitespace: ' , aString
]

{ #category : #'handling tokens' }
XMLTokenizer >> handleXMLDecl: attributes [
	attributes keysAndValuesDo: [:key :value |
		self log: key , '->' , value]
]

{ #category : #streaming }
XMLTokenizer >> hasNestedStreams [
	^nestedStreams notNil
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
	parsingMarkup := false.
	validating := false.
	attributeBuffer := WriteStream on: (String new: 128).
	nameBuffer := WriteStream on: (String new: 128)
]

{ #category : #private }
XMLTokenizer >> log: aString [
	"Transcript show: aString; cr"
]

{ #category : #errors }
XMLTokenizer >> malformedError: errorString [
	SAXMalformedException signal: errorString
]

{ #category : #streaming }
XMLTokenizer >> match: subCollection into: resultStream [
	"Set the access position of the receiver to be past the next occurrence of the subCollection. Answer whether subCollection is found.  No wildcards, and case does matter."

	| pattern startMatch |
	pattern _ ReadStream on: subCollection.
	startMatch _ nil.
	[pattern atEnd] whileFalse: 
		[self atEnd ifTrue: [^ false].
		(self next) = (pattern next) 
			ifTrue: [pattern position = 1 ifTrue: [startMatch _ self position]]
			ifFalse: [pattern position: 0.
					startMatch ifNotNil: [
						self position: startMatch.
						startMatch _ nil]]].
	^ true


]

{ #category : #private }
XMLTokenizer >> nestedStreams [
	nestedStreams ifNil: [nestedStreams := OrderedCollection new].
	^nestedStreams
]

{ #category : #streaming }
XMLTokenizer >> next [
	"Return the next character from the current input stream. If the current stream is at end pop to next nesting level if there is one.
	Due to the potential nesting of original document, included documents and replacment texts the streams are held in a stack representing the nested streams. The current stream is the top one."
	| nextChar |
	peekChar
		ifNil: [
			nestedStreams ifNotNil: [self checkNestedStream].
			^nextChar := self basicNext]
		ifNotNil: [
			nextChar := peekChar.
			peekChar := nil.
			^nextChar].
	
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeInto: attributes namespaces: namespaces [

	| attrName attrValue |
	attrName := self nextName.
	self skipSeparators.
	self next == $=
		ifFalse: [self errorExpected: '='].
	self skipSeparators.
	attrValue := self nextAttributeValue.

	(self usesNamespaces
		and: [(attrName findString: 'xmlns') = 1])
		ifTrue: [attrName size > 6
			ifTrue: [namespaces at: (attrName copyFrom: 7 to: attrName size) put: attrValue]
			ifFalse: [namespaces at: attrName put: attrValue]]
		ifFalse: [attributes at: attrName put: attrValue]
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeValue [
	| delimiterChar attributeValueStream nextChar nextPeek referenceString entity entityValue |
	delimiterChar := self next.
	(delimiterChar == $"
		or: [delimiterChar == $'])
		ifFalse: [self errorExpected: 'Attribute value delimiter expected.'].
	attributeValueStream := attributeBuffer reset.
	[
	nextPeek := nextChar := self next.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			self peek == $#
				ifTrue: [
					nextPeek := nil.
					nextChar := self nextCharReference]
				ifFalse: [
					referenceString := self nextLiteral.
					self next == $;
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
									self pushStream: (ReadStream on: entityValue asString).
									nextPeek := nextChar := self next]]]].
	nextPeek == delimiterChar]
		whileFalse: [
			nextChar ifNotNil: [attributeValueStream nextPut: nextChar]].
	^self fastStreamStringContents: attributeValueStream
"	^attributeValueStream contents"
]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataContent [
	| cdata |
	"Skip $[ "
	self next.
	cdata := self nextUpToAll: ']]>'.
	self handleCData: cdata

]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataOrConditional [

	| nextChar conditionalKeyword |
	"Skip ["
	self next.
	self skipSeparators.
	nextChar := self peek.
	nextChar == $%
		ifTrue: [
			self checkAndExpandReference: (self parsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
			conditionalKeyword := self nextLiteral.
			self skipSeparators.
			^self next == $[
				ifTrue: [
						self skipSeparators.
						self nextIncludeSection: (self conditionalInclude: conditionalKeyword)]
				ifFalse: [self errorExpected: '[' ]].

	nextChar == $C
		ifTrue: [
			^self nextLiteral = 'CDATA'
				ifTrue: [self peek == $[
							ifTrue: [self nextCDataContent]
							ifFalse: [self errorExpected: '[' ]]
				ifFalse: [self errorExpected: 'CData']].
	self errorExpected: 'CData or declaration'

]

{ #category : #tokenizing }
XMLTokenizer >> nextCharReference [
	| base charValue |
	self next == $#
		ifFalse: [self errorExpected: 'character reference'].
	base := self peek == $x
		ifTrue: [
			self next.
			16]
		ifFalse: [10].

	charValue := [self readNumberBase: base] on: Error do: [:ex | self errorExpected: 'Number.'].
	(self next) == $;
		ifFalse: [self errorExpected: '";"'].
	^Unicode value: charValue
]

{ #category : #tokenizing }
XMLTokenizer >> nextComment [
	| string |
	"Skip first -"
	self next.
	self next == $-
		ifFalse: [self errorExpected: 'second comment $-'].
	string := self nextUpToAll: '-->'.
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
	self skipSeparators.
	self nextLiteral.
	self skipSeparators.
	self peek == $[
		ifFalse: [[nextChar := self peek.
				nextChar == $> or: [nextChar == $[ ]] whileFalse: [self next]].
	self peek == $[
		ifTrue: [
			self next.
			[self skipSeparators.
			self peek == $]] whileFalse: [
				self checkAndExpandReference: #dtd.
				self nextNode].
			self next == $] 
				ifFalse: [self errorExpected: ']' ]].
	self skipSeparators.
	self next == $>
		ifFalse: [self errorExpected: '>' ].

	self endParsingMarkup
]

{ #category : #tokenizing }
XMLTokenizer >> nextEndTag [
	| tagName |
	"Skip /"
	self next.
	tagName := self nextName.
	self skipSeparators.
	(self nextTrimmedBlanksUpTo: $>)
		ifNotEmpty: [self parseError: 'XML invalid end tag ' , tagName].
	self handleEndTag: tagName
]

{ #category : #tokenizing }
XMLTokenizer >> nextEntity [
	"return the next XMLnode, or nil if there are no more.
	Fixed to retain leading whitespace when PCDATA is detected."

	|whitespace|
	"branch, depending on what the first character is"
	whitespace := self nextWhitespace.
	self atEnd ifTrue: [self handleEndDocument. ^ nil].
	self checkAndExpandReference: (self parsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
	^self peek = $<
		ifTrue: [self nextNode]
		ifFalse: [whitespace isEmpty
					ifFalse: [self pushBack: whitespace].
				self nextPCData]
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEntityDeclaration [
	| entityName entityDef referenceClass reference |
	self skipSeparators.
	referenceClass := self peek == $%
		ifTrue: [
			self next.
			self skipSeparators.
			DTDParameterEntityDeclaration]
		ifFalse: [DTDEntityDeclaration].
	entityName := self nextLiteral.
	self skipSeparators.
	entityDef := (self peek == $" or: [self peek == $'])
		ifTrue: [self nextEntityValue]
		ifFalse: [self nextExternalId].
	self skipUpTo: $>.
	reference := referenceClass name: entityName value: entityDef.
	reference registerIn: self.
	^reference
]

{ #category : #tokenizing }
XMLTokenizer >> nextEntityValue [
	| delimiterChar entityValueStream nextChar nextPeek referenceString entity entityValue |
	delimiterChar := self next.
	(delimiterChar == $"
		or: [delimiterChar == $'])
		ifFalse: [self errorExpected: 'Entity value delimiter expected.'].

	entityValueStream := WriteStream on: (String new).
	[
	nextPeek := nextChar := self peek.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			self next.
			self peek == $#
				ifTrue: [
					nextPeek := nil.
					nextChar := self nextCharReference]
				ifFalse: [
					referenceString := self nextLiteral.
					self next == $;
						ifFalse: [self errorExpected: ';'].
					entity := self entity: referenceString.
					entityValue := entity valueForContext: #entityValue.
					self pushStream: (ReadStream on: entityValue asString).
					nextPeek := nextChar := self next]]
		ifFalse: [
			nextChar == $%
				ifTrue: [
					self skipSeparators.
					referenceString := self nextLiteral.
					nextChar := self handleEntity: referenceString in: #entityValue.
					nextPeek := nextChar := self next]
				ifFalse: [self next]].
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
			self skipSeparators.
			self nextPubidLiteral.
			self skipSeparators.
			self peek == $>
				ifFalse: [
					systemId := self nextSystemLiteral]].

	extDefType = 'SYSTEM'
		ifTrue: [
			self skipSeparators.
			systemId := self nextSystemLiteral].

	systemId
		ifNil: [^nil].

	"The rest of this method only applies if we're reading aFileStream"
	(self topStream isKindOf: FileStream)
		ifFalse: [^''].
	dir := self topStream directory.
	^(dir fileExists: systemId)
		ifTrue: [(dir readOnlyFileNamed: systemId) contentsOfEntireFile]
		ifFalse: ['']
]

{ #category : #tokenizing }
XMLTokenizer >> nextIncludeSection: parseSection [
	| section |
	"Read the file up to the next include section delimiter and parse it if parseSection is true"

	
	section := self nextUpToAll: ']]>'.
	parseSection
		ifTrue: [
			self pushStream: (ReadStream on: section)]
]

{ #category : #tokenizing }
XMLTokenizer >> nextLiteral [
	| resultStream nextChar resultString |
	resultStream := (String new: 10) writeStream.
	((nextChar := self peek) isLetter
		or: [nextChar == $_])
		ifFalse: [self errorExpected: 'Name literal.'].
	[nextChar := self peek.
	(LiteralChars includes: nextChar)
		ifTrue: [
			nextChar == $&
				ifTrue: [
					nextChar := self next.
					resultStream nextPut: (self peek == $#
						ifTrue: [self nextCharReference]
						ifFalse: [^resultStream contents])]
				ifFalse: [
					resultStream nextPut: self next]]
		ifFalse: [resultString := resultStream contents.
			resultString isEmpty
				ifTrue: [self errorExpected: 'Name literal']
				ifFalse: [^resultString]]] repeat
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextMarkupDeclaration [
	| declType |
	declType := self nextLiteral.
	self validating
		ifFalse: [^self skipMarkupDeclaration].
	declType = 'ENTITY'
		ifTrue: [self nextEntityDeclaration]
		ifFalse: [self skipMarkupDeclaration]
]

{ #category : #tokenizing }
XMLTokenizer >> nextName [
	| nextChar |
	nameBuffer reset.
	self peek == $.
		ifTrue: [self malformedError: 'Character expected.'].
	[(nextChar := self peek)
		ifNil: [self errorExpected: 'Character expected.'].
	NameDelimiters includes: nextChar] whileFalse: [
			nameBuffer nextPut: self next].
	^ (self fastStreamStringContents: nameBuffer) 
]

{ #category : #tokenizing }
XMLTokenizer >> nextNode [
	| nextChar |
	"Skip < "
	self next.
	nextChar := self peek.
	nextChar == $! ifTrue: [
		"Skip !"
		self next.
		nextChar := self peek.
		nextChar == $- ifTrue: [^self nextComment].
		nextChar == $[ ifTrue: [^self nextCDataOrConditional].
		^self parsingMarkup
			ifTrue: [self nextMarkupDeclaration]
			ifFalse: [self nextDocType]].
	nextChar == $? ifTrue: [^self nextPI].
	^self nextTag
]

{ #category : #tokenizing }
XMLTokenizer >> nextPCData [
	| resultStream nextChar referenceString entity entityValue nextPeek |
	resultStream := (String new: 10) writeStream.
	self validating
		ifFalse: [
			[self peek == $<]
				whileFalse: [resultStream nextPut: self next].
			^self handlePCData: resultStream contents].

	[
	nextPeek := nextChar := self peek.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			self next.
			self peek == $#
				ifTrue: [
					nextPeek := nil.
					nextChar := self nextCharReference]
				ifFalse: [
					referenceString := self nextLiteral.
					self next == $;
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
									self pushStream: (ReadStream on: entityValue asString).
									nextPeek := nextChar := self peek]]]]
		ifFalse: [nextPeek == $< ifFalse: [self next]].
	nextPeek == $<]
		whileFalse: [
			nextChar ifNotNil: [resultStream nextPut: nextChar]].
	self handlePCData: resultStream contents
]

{ #category : #tokenizing }
XMLTokenizer >> nextPI [
	| piTarget piData |
	"Skip ?"
	self next.
	piTarget := self nextLiteral.
	piTarget asUppercase = 'XML'
		ifTrue: [^self nextXMLDecl].
	self skipSeparators.
	piData := self nextUpToAll: '?>'.
	self handlePI: piTarget data: piData
]

{ #category : #tokenizing }
XMLTokenizer >> nextPubidLiteral [
	^self nextAttributeValue
]

{ #category : #tokenizing }
XMLTokenizer >> nextSystemLiteral [
	^self nextAttributeValue
]

{ #category : #tokenizing }
XMLTokenizer >> nextTag [
	| tagName attributes nextChar namespaces |
	(self peek = $/)
		ifTrue: [^self nextEndTag].
	tagName := self nextName.
	self skipSeparators.
	attributes := Dictionary new: 33.
	namespaces := Dictionary new: 5.
	[(nextChar := self peek) == $> or: [nextChar == $/]] whileFalse: [
		self checkAndExpandReference: #content.
		self nextAttributeInto: attributes namespaces: namespaces.
		self skipSeparators.].
	self handleStartTag: tagName attributes: attributes namespaces: namespaces.
	self next == $/
		ifTrue: [
			self handleEndTag: tagName.
			self next].
	
]

{ #category : #streaming }
XMLTokenizer >> nextTrimmedBlanksUpTo: delimiter [
	| resultStream nextChar |
	resultStream := WriteStream on: (String new: 10).
	nextChar := nil.
	[(nextChar := self next) == delimiter]
		whileFalse: [
			nextChar == $  ifFalse: [
				resultStream nextPut: nextChar]].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found'].
	^resultStream contents

]

{ #category : #streaming }
XMLTokenizer >> nextUpTo: delimiter [
	| resultStream nextChar |
	resultStream := WriteStream on: (String new: 10).
	[self atEnd or: [(nextChar := self next) == delimiter]]
		whileFalse: [resultStream nextPut: nextChar].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found'].
	^resultStream contents

]

{ #category : #streaming }
XMLTokenizer >> nextUpToAll: delimitingString [
	| string |
	self unpeek.
	string := self upToAll: delimitingString.
	string
		ifNil: [self parseError: 'XML no delimiting ' , delimitingString printString , ' found'].
	^string
]

{ #category : #tokenizing }
XMLTokenizer >> nextWhitespace [
	| nextChar resultStream resultString|
	resultStream := (String new: 10) writeStream.
	[((nextChar := self peek) ~~ nil)
		and: [SeparatorTable includes: nextChar]]
		whileTrue: [resultStream nextPut: nextChar. self next].
	(nestedStreams == nil or: [self atEnd not])
		ifFalse: [self checkNestedStream.
				self nextWhitespace].
	resultString := resultStream contents.
	resultString isEmpty ifFalse: [self handleWhitespace: resultString].
	^resultString
]

{ #category : #tokenizing }
XMLTokenizer >> nextXMLDecl [
	| attributes nextChar namespaces |
	self skipSeparators.
	attributes := Dictionary new.
	namespaces := Dictionary new.
	[(nextChar := self peek) == $?] whileFalse: [
		self nextAttributeInto: attributes namespaces: namespaces.
		self skipSeparators.].
	self next.
	self next == $>
		ifFalse: [self errorExpected: '> expected.'].
	(attributes includesKey: 'encoding') ifTrue: [self streamEncoding: (attributes at: 'encoding')].
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
	"Only the first declaration of an entity is valid so if there is already one don't register the new value."
	self parameterEntities at: refName ifAbsentPut: [aReference]
]

{ #category : #errors }
XMLTokenizer >> parseError: errorString [
	SAXParseException signal: errorString
]

{ #category : #accessing }
XMLTokenizer >> parseStream: aStream [
	self stream: aStream
]

{ #category : #private }
XMLTokenizer >> parsingMarkup [
	^parsingMarkup
]

{ #category : #streaming }
XMLTokenizer >> peek [
	"Return the next character from the current input stream. If the current stream poop to next nesting level if there is one.
	Due to the potential nesting of original document, included documents and replacment texts the streams are held in a stack representing the nested streams. The current stream is the top one."
	peekChar
		ifNil: [
			nestedStreams ifNotNil: [self checkNestedStream].
			^peekChar := self basicNext]
		ifNotNil: [^peekChar]
]

{ #category : #streaming }
XMLTokenizer >> popNestingLevel [
	self hasNestedStreams
		ifTrue: [
			self stream close.
			self stream: self nestedStreams removeLast.
			self nestedStreams size > 0
				ifFalse: [nestedStreams := nil]]
]

{ #category : #streaming }
XMLTokenizer >> pushBack: aString [
	"Fixed to push the string before the peek char (if any)."
	
	| pushBackString |
	pushBackString := peekChar
		ifNil: [aString]
		ifNotNil: [aString, peekChar asString].
	peekChar := nil.
	self pushStream: (ReadStream on: pushBackString)
]

{ #category : #streaming }
XMLTokenizer >> pushStream: newStream [
	"Continue parsing from the new nested stream."
	self unpeek.
	self nestedStreams addLast: self stream.
	self stream: newStream
]

{ #category : #private }
XMLTokenizer >> readNumberBase: base [
	"Read a hex number from stream until encountering $; "

	| value digit |

	base = 10 ifFalse: [	| numberString | 
		numberString := self nextUpTo: $;.
		self stream skip: -1.
		^Integer readFrom: numberString asUppercase readStream base: base. 
	].

	value := 0.
	digit := DigitTable at: self peek asciiValue.
	digit < 0
		ifTrue: [self error: 'At least one digit expected here'].
	self next.
	value := digit.
	[digit := DigitTable at: self peek asciiValue.
	digit < 0
		ifTrue: [^value]
		ifFalse: [
			self next.
			value := value * base + digit]
		] repeat.
	^ value
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> skipMarkupDeclaration [
	self skipUpTo: $>
]

{ #category : #streaming }
XMLTokenizer >> skipSeparators [
	| nextChar |
	[((nextChar := self peek) ~~ nil)
		and: [SeparatorTable includes: nextChar]]
		whileTrue: [self next].
	(nestedStreams == nil or: [self atEnd not])
		ifFalse: [
			self checkNestedStream.
			self skipSeparators]
]

{ #category : #streaming }
XMLTokenizer >> skipUpTo: delimiter [
	| nextChar |
	self unpeek.
	[self atEnd or: [(nextChar := self next) == delimiter]]
		whileFalse: [].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found']

]

{ #category : #private }
XMLTokenizer >> startParsingMarkup [
	parsingMarkup := true
]

{ #category : #private }
XMLTokenizer >> stream [
	^stream
]

{ #category : #private }
XMLTokenizer >> stream: newStream [
	"Continue parsing from the new nested stream."
	stream := newStream
]

{ #category : #streaming }
XMLTokenizer >> stream: aStream upToAll: aCollection [
	"Answer a subcollection from the current access position to the occurrence (not inclusive) of aCollection. If aCollection is not in the stream, answer nil."

	| startPos endMatch result |
	startPos := aStream position.
	(aStream  match: aCollection) 
		ifTrue: [endMatch := aStream position.
			aStream position: startPos.
			result := aStream next: endMatch - startPos - aCollection size.
			aStream position: endMatch.
			^ result]
		ifFalse: [
			aStream position: startPos.
			^nil]
]

{ #category : #streaming }
XMLTokenizer >> streamEncoding: encodingString [

	| converterClass |
	Smalltalk at: #TextConverter ifPresent: [:tc | 
		(stream respondsTo: #converter:) ifTrue: [
			converterClass := tc defaultConverterClassForEncoding: encodingString asLowercase.
			converterClass ifNotNil: [stream converter: converterClass new]]]
]

{ #category : #streaming }
XMLTokenizer >> topStream [
	^self hasNestedStreams
		ifTrue: [self nestedStreams first]
		ifFalse: [self stream]
]

{ #category : #streaming }
XMLTokenizer >> unpeek [
	"Fixed to use nested stream since multi-byte streams
	do not properly override pushBack: to deal with multi-byte
	characters."
	
	peekChar ifNotNil: [self pushBack: '']
]

{ #category : #streaming }
XMLTokenizer >> upToAll: delimitingString [
	"Answer a subcollection from the current access position to the occurrence (if any, but not inclusive) of delimitingString. If delimitingString is not in the stream, answer the entire rest of the stream."

	| result |

	self hasNestedStreams
		ifFalse: [
			result := self stream: self stream upToAll: delimitingString.
			result
				ifNil: [self parseError: 'XML no delimiting ' , delimitingString printString , ' found'].
			^result].

	result := self stream: self stream upToAll: delimitingString.
	result
		ifNotNil: [^result].
	result := String streamContents: [:resultStream |
		resultStream nextPutAll: self stream upToEnd.
		self atEnd
			ifTrue: [self parseError: 'XML no delimiting ' , delimitingString printString , ' found'].
		self stream position timesRepeat: [
			self atEnd
				ifFalse: [
					resultStream nextPut: self next]]].
	self pushBack: result.
	^self upToAll: delimitingString
]

{ #category : #testing }
XMLTokenizer >> usesNamespaces [
	^false
]

{ #category : #testing }
XMLTokenizer >> validating [
	^validating
]

{ #category : #accessing }
XMLTokenizer >> validating: aBoolean [
	validating := aBoolean
]

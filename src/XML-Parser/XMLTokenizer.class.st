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
		'markedPosition',
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
	#category : #'XML-Parser'
}

{ #category : #examples }
XMLTokenizer class >> addressBookXML [
	^'<addressbook>
  <person employee-number="A0000" family-name="Gates" first-name="Bob">
    <contact-info><!--Confidential--></contact-info>
    <address city="Los Angeles" number="1239" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Manager"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7000" family-name="Brown"
    first-name="Robert" middle-initial="L.">
    <contact-info>
      <email address="robb@iro.ibm.com"/>
      <home-phone number="03-3987873"/>
    </contact-info>
    <address city="New York" number="344" state="NY" street="118 St."/>
    <job-info employee-type="Full-Time" is-manager="yes" job-description="Group Leader"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7890" family-name="DePaiva"
    first-name="Kassie" middle-initial="W.">
    <contact-info><!-- Kassie''s agent phone: 03-987654 --></contact-info>
    <address city="Los Angeles" number="1234" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Actor"/>
    <manager employee-number="A0000"/>
    <misc-info>One of the most talented actresses on Daytime. Kassie
      plays the devious and beautiful Blair Cramer on ABC&apos;s
      &quot;One Life To Live.&quot;</misc-info>
  </person>
  <person employee-number="A7987" family-name="Smith" first-name="Joe">
    <contact-info>
      <email address="joes@iro.ibm.com"/>
      <mobile-phone number="888-7657765"/>
      <home-phone number="03-8767898"/>
      <home-phone number="03-8767871"/>
    </contact-info>
    <address city="New York" number="12789" state="NY" street="W. 15th Ave."/>
    <job-info employee-type="Part-Time" is-manager="no" job-description="Hacker"/>
    <manager employee-number="A7000"/>
  </person>
</addressbook>
'
]

{ #category : #examples }
XMLTokenizer class >> addressBookXMLWithDTD [
	^'<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE addressbook SYSTEM "addressbook.dtd">
<?xml:stylesheet type="text/xsl" href="demo.xsl"?>
<addressbook>
  <person employee-number="A0000" family-name="Gates" first-name="Bob">
    <contact-info><!--Confidential--></contact-info>
    <address city="Los Angeles" number="1239" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Manager"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7000" family-name="Brown"
    first-name="Robert" middle-initial="L.">
    <contact-info>
      <email address="robb@iro.ibm.com"/>
      <home-phone number="03-3987873"/>
    </contact-info>
    <address city="New York" number="344" state="NY" street="118 St."/>
    <job-info employee-type="Full-Time" is-manager="yes" job-description="Group Leader"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7890" family-name="DePaiva"
    first-name="Kassie" middle-initial="W.">
    <contact-info><!-- Kassie''s agent phone: 03-987654 --></contact-info>
    <address city="Los Angeles" number="1234" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Actor"/>
    <manager employee-number="A0000"/>
    <misc-info>One of the most talented actresses on Daytime. Kassie
      plays the devious and beautiful Blair Cramer on ABC&apos;s
      &quot;One Life To Live.&quot;</misc-info>
  </person>
  <person employee-number="A7987" family-name="Smith" first-name="Joe">
    <contact-info>
      <email address="joes@iro.ibm.com"/>
      <mobile-phone number="888-7657765"/>
      <home-phone number="03-8767898"/>
      <home-phone number="03-8767871"/>
    </contact-info>
    <address city="New York" number="12789" state="NY" street="W. 15th Ave."/>
    <job-info employee-type="Part-Time" is-manager="no" job-description="Hacker"/>
    <manager employee-number="A7000"/>
  </person>
</addressbook>
'
]

{ #category : #examples }
XMLTokenizer class >> exampleAddressBook [
	| tokenizer |
	"XMLTokenizer exampleAddressBook"

	tokenizer _ XMLTokenizer on: self addressBookXML readStream.
	[tokenizer next notNil]
		whileTrue: []
]

{ #category : #examples }
XMLTokenizer class >> exampleAddressBookWithDTD [
	| tokenizer |
	"XMLTokenizer exampleAddressBookWithDTD"

	tokenizer _ XMLTokenizer on: self addressBookXMLWithDTD readStream.
	[tokenizer next notNil]
		whileTrue: []
]

{ #category : #'class initialization' }
XMLTokenizer class >> initialize [
	"XMLTokenizer initialize"

	| nameDelimiters |

	CharEscapes _ #( $& $" $' $> $< ) asSet.

	SeparatorTable  _ Array new: 256.
	SeparatorTable atAllPut: true.
	#(9 10 12 13 32) do: [:each | SeparatorTable at: each+1 put: false].

	LiteralChars _ Array new: 256.
	LiteralChars atAllPut: false.
	':-_.' do: [:each | LiteralChars at: each asciiValue put: true].
	1 to: 256 do: [:i | ((i-1) asCharacter isDigit or: [(i-1) asCharacter isLetter])
		ifTrue: [LiteralChars at: i put: true]].

	nameDelimiters _ #(9 10 12 13 32 61 "$= asInteger 61" 62 "$> asInteger" 47 "$/ asInteger").
	NameDelimiters _ Array new: 256.
	NameDelimiters atAllPut: false.
	nameDelimiters do: [:each | NameDelimiters at: each put: true].

	DigitTable _ Array new: 256.
	DigitTable atAllPut: -1.
	($0 to: $9) do: [:each | DigitTable at: each asciiValue put: each digitValue].
	($A to: $F) do: [:each | DigitTable at: each asciiValue put: each digitValue].

]

{ #category : #accessing }
XMLTokenizer class >> isCharEscape: aChar [
	^CharEscapes includes: aChar
]

{ #category : #'instance creation' }
XMLTokenizer class >> new [
	^super new initialize
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

{ #category : #tokenizing }
XMLTokenizer >> checkAndExpandReference: parsingContext [
	| referenceString nextChar |
	nextChar _ self peek.
	self validating
		ifFalse: [^nil].
	nextChar == $&
		ifTrue: [
			self next.
			self peek == $#
				ifTrue: [^self pushStream: (ReadStream on: self nextCharReference asString)].
			referenceString _ self nextLiteral.
			self next == $;
				ifFalse: [self errorExpected: ';'].
			self handleEntity: referenceString in: parsingContext ]
		ifFalse: [
			((nextChar == $%
				and: [self parsingMarkup])
				and: [parsingContext == #entityValue])
				ifTrue: [
					self skipSeparators.
					referenceString _ self nextLiteral.
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
	parsingMarkup _ false
]

{ #category : #entities }
XMLTokenizer >> entities [
	entities ifNil: [entities _ self initEntities].
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
	externalEntities ifNil: [externalEntities _ Dictionary new].
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
	newSize _ writeStream position.
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
	entity _ self entity: referenceString.
	entityValue _ entity valueForContext: parsingContext.
	(self class isCharEscape: entityValue)
		ifTrue: [entityValue _ entity reference].
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
XMLTokenizer >> handleXMLDecl: attributes namespaces: namespaces [
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
	ents _ Dictionary new.
	ents
		at: 'amp' put: (DTDEntityDeclaration name: 'amp' value: $&);
		at: 'quot' put: (DTDEntityDeclaration name: 'quot' value: $");
		at: 'apos' put: (DTDEntityDeclaration name: 'apos' value: $');
		at: 'gt' put: (DTDEntityDeclaration name: 'gt' value: $>);
		at: 'lt' put: (DTDEntityDeclaration name: 'lt' value: $<).
	^ents
]

{ #category : #initialize }
XMLTokenizer >> initialize [
	parsingMarkup _ false.
	validating _ false.
	attributeBuffer _ WriteStream on: (String new: 128).
	nameBuffer _ WriteStream on: (String new: 128)
]

{ #category : #private }
XMLTokenizer >> log: aString [
	"Transcript show: aString; cr"
]

{ #category : #errors }
XMLTokenizer >> malformedError: errorString [
	SAXMalformedException signal: errorString
]

{ #category : #private }
XMLTokenizer >> nestedStreams [
	nestedStreams ifNil: [nestedStreams _ OrderedCollection new].
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
			^nextChar _ stream next]
		ifNotNil: [
			nextChar _ peekChar.
			peekChar _ nil.
			^nextChar].
	
]

{ #category : #tokenizing }
XMLTokenizer >> nextAttributeInto: attributes namespaces: namespaces [

	| attrName attrValue |
	attrName _ self nextName.
	self skipSeparators.
	self next == $=
		ifFalse: [self errorExpected: '='].
	self skipSeparators.
	attrValue _ self nextAttributeValue.

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
	delimiterChar _ self next.
	(delimiterChar == $"
		or: [delimiterChar == $'])
		ifFalse: [self errorExpected: 'Attribute value delimiter expected.'].
	attributeValueStream _ attributeBuffer reset.
	[
	nextPeek _ nextChar _ self next.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			self peek == $#
				ifTrue: [
					nextPeek _ nil.
					nextChar _ self nextCharReference]
				ifFalse: [
					referenceString _ self nextLiteral.
					self next == $;
						ifFalse: [self errorExpected: ';'].
					entity _ self entity: referenceString.
					entityValue _ entity valueForContext: #content.
					(self class isCharEscape: entityValue)
						ifTrue: [
							nextPeek _ nil.
							nextChar _ entityValue]
						ifFalse: [
							entityValue _ entityValue asString.
							entityValue isEmpty
								ifTrue: [nextPeek _ nextChar _ nil]
								ifFalse: [
									self pushStream: (ReadStream on: entityValue asString).
									nextPeek _ nextChar _ self next]]]].
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
	cdata _ self nextUpToAll: ']]>'.
	self handleCData: cdata

]

{ #category : #tokenizing }
XMLTokenizer >> nextCDataOrConditional [

	| nextChar conditionalKeyword |
	"Skip ["
	self next.
	self skipSeparators.
	nextChar _ self peek.
	nextChar == $%
		ifTrue: [
			self checkAndExpandReference: (self parsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
			conditionalKeyword _ self nextLiteral.
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
	| base charValue nextChar numberString |
	self next == $#
		ifFalse: [self errorExpected: 'character reference'].
	base _ self peek == $x
		ifTrue: [
			self next.
			16]
		ifFalse: [10].
"	numberString _ (self nextUpTo: $;) asUppercase.
	charValue _ [Number readFrom: numberString base: base] on: Error do: [:ex | self errorExpected: 'Number.'].
"	charValue _ [self readNumberBase: base] on: Error do: [:ex | self errorExpected: 'Number.'].
	(nextChar _ self next) == $;
		ifFalse: [self errorExpected: '";"'].
	^charValue > 255
		ifTrue: [^Character space]
		ifFalse: [charValue asCharacter]
]

{ #category : #tokenizing }
XMLTokenizer >> nextComment [
	| string |
	"Skip first -"
	self next.
	self next == $-
		ifFalse: [self errorExpected: 'second comment $-'].
	string _ self nextUpToAll: '-->'.
	self handleComment: string
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextDocType [
	| declType |
	declType _ self nextLiteral.
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
		ifFalse: [[nextChar _ self peek.
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
	| string |
	"Skip /"
	self next.
	self skipSeparators.
	string _ self nextTrimmedBlanksUpTo: $>.
	"string _ (self nextUpTo: $>) withBlanksTrimmed."
	self handleEndTag: string
]

{ #category : #tokenizing }
XMLTokenizer >> nextEntity [
	"return the next XMLnode, or nil if there are no more"

	"branch, depending on what the first character is"
	self nextWhitespace.
	self atEnd ifTrue: [self handleEndDocument. ^ nil].
	self checkAndExpandReference: (self parsingMarkup ifTrue: [#dtd] ifFalse: [#content]).
	^self peek = $<
		ifTrue: [self nextNode]
		ifFalse: [self nextPCData]
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextEntityDeclaration [
	| entityName entityDef referenceClass reference |
	self skipSeparators.
	referenceClass _ self peek == $%
		ifTrue: [
			self next.
			self skipSeparators.
			DTDParameterEntityDeclaration]
		ifFalse: [DTDEntityDeclaration].
	entityName _ self nextLiteral.
	self skipSeparators.
	entityDef _ (self peek == $" or: [self peek == $'])
		ifTrue: [self nextEntityValue]
		ifFalse: [self nextExternalId].
	self skipUpTo: $>.
	reference _ referenceClass name: entityName value: entityDef.
	reference registerIn: self.
	^reference
]

{ #category : #tokenizing }
XMLTokenizer >> nextEntityValue [
	| delimiterChar entityValueStream nextChar nextPeek referenceString entity entityValue |
	delimiterChar _ self next.
	(delimiterChar == $"
		or: [delimiterChar == $'])
		ifFalse: [self errorExpected: 'Entity value delimiter expected.'].

	entityValueStream _ WriteStream on: (String new).
	[
	nextPeek _ nextChar _ self peek.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			self next.
			self peek == $#
				ifTrue: [
					nextPeek _ nil.
					nextChar _ self nextCharReference]
				ifFalse: [
					referenceString _ self nextLiteral.
					self next == $;
						ifFalse: [self errorExpected: ';'].
					entity _ self entity: referenceString.
					entityValue _ entity valueForContext: #entityValue.
					self pushStream: (ReadStream on: entityValue asString).
					nextPeek _ nextChar _ self next]]
		ifFalse: [
			nextChar == $%
				ifTrue: [
					self skipSeparators.
					referenceString _ self nextLiteral.
					nextChar _ self handleEntity: referenceString in: #entityValue.
					nextPeek _ nextChar _ self next]
				ifFalse: [self next]].
	nextPeek == delimiterChar]
		whileFalse: [
			nextChar ifNotNil: [entityValueStream nextPut: nextChar]].
	^entityValueStream contents
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextExternalId [
	| extDefType systemId dir |
	extDefType _ self nextLiteral.
	extDefType = 'PUBLIC'
		ifTrue: [
			self skipSeparators.
			self nextPubidLiteral.
			self skipSeparators.
			self peek == $>
				ifFalse: [
					systemId _ self nextSystemLiteral]].

	extDefType = 'SYSTEM'
		ifTrue: [
			self skipSeparators.
			systemId _ self nextSystemLiteral].

	systemId
		ifNil: [^nil].

	"The rest of this method only applies if we're reading aFileStream"
	(self topStream isKindOf: FileStream)
		ifFalse: [^''].
	dir _ self topStream directory.
	^(dir fileExists: systemId)
		ifTrue: [(dir readOnlyFileNamed: systemId) contentsOfEntireFile]
		ifFalse: ['']
]

{ #category : #tokenizing }
XMLTokenizer >> nextIncludeSection: parseSection [
	| section |
	"Read the file up to the next include section delimiter and parse it if parseSection is true"

	
	section _ self nextUpToAll: ']]>'.
	parseSection
		ifTrue: [
			self pushStream: (ReadStream on: section)]
]

{ #category : #tokenizing }
XMLTokenizer >> nextLiteral [
	| resultStream nextChar resultString |
	resultStream _ (String new: 10) writeStream.
	((nextChar _ self peek) isLetter
		or: [nextChar == $_])
		ifFalse: [self errorExpected: 'Name literal.'].
	[nextChar _ self peek.
	(LiteralChars at: nextChar asciiValue+1)
		ifTrue: [
			nextChar == $&
				ifTrue: [
					nextChar _ self next.
					resultStream nextPut: (self peek == $#
						ifTrue: [self nextCharReference]
						ifFalse: [^resultStream contents])]
				ifFalse: [
					resultStream nextPut: self next]]
		ifFalse: [resultString _ resultStream contents.
			resultString isEmpty
				ifTrue: [self errorExpected: 'Name literal']
				ifFalse: [^resultString]]] repeat
]

{ #category : #'tokenizing dtd' }
XMLTokenizer >> nextMarkupDeclaration [
	| declType |
	declType _ self nextLiteral.
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
	[(nextChar _ self peek)
		ifNil: [self errorExpected: 'Character expected.'].
	NameDelimiters at: nextChar asciiValue] whileFalse: [
			nameBuffer nextPut: self next].
	^self fastStreamStringContents: nameBuffer
"	^nameBuffer contents"
]

{ #category : #tokenizing }
XMLTokenizer >> nextNode [
	| nextChar |
	"Skip < "
	self next.
	nextChar _ self peek.
	nextChar == $! ifTrue: [
		"Skip !"
		self next.
		nextChar _ self peek.
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
	resultStream _ (String new: 10) writeStream.
	self validating
		ifFalse: [
			[self peek == $<]
				whileFalse: [resultStream nextPut: self next].
			^self handlePCData: resultStream contents].

	[
	nextPeek _ nextChar _ self peek.
	nextChar ifNil: [self errorExpected: 'Character expected.'].
	nextChar == $&
		ifTrue: [
			self next.
			self peek == $#
				ifTrue: [
					nextPeek _ nil.
					nextChar _ self nextCharReference]
				ifFalse: [
					referenceString _ self nextLiteral.
					self next == $;
						ifFalse: [self errorExpected: ';'].
					entity _ self entity: referenceString.
					entityValue _ entity valueForContext: #content.
					(self class isCharEscape: entityValue)
						ifTrue: [
							nextPeek _ nil.
							nextChar _ entityValue]
						ifFalse: [
							entityValue _ entityValue asString.
							entityValue isEmpty
								ifTrue: [nextPeek _ nextChar _ nil]
								ifFalse: [
									self pushStream: (ReadStream on: entityValue asString).
									nextPeek _ nextChar _ self peek]]]]
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
	piTarget _ self nextLiteral.
	piTarget asUppercase = 'XML'
		ifTrue: [^self nextXMLDecl].
	self skipSeparators.
	piData _ self nextUpToAll: '?>'.
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
	tagName _ self nextName.
	self skipSeparators.
	attributes _ Dictionary new: 33.
	namespaces _ Dictionary new: 5.
	[(nextChar _ self peek) == $> or: [nextChar == $/]] whileFalse: [
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
	resultStream _ WriteStream on: (String new: 10).
	nextChar _ nil.
	[peekChar _ self peek.
	peekChar
		ifNotNil: [
			[peekChar == $ 
				and: [nextChar == $ ]]
				whileTrue: [peekChar _ self next]].
	(nextChar _ self next) == delimiter]
		whileFalse: [resultStream nextPut: nextChar].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found'].
	^resultStream contents

]

{ #category : #streaming }
XMLTokenizer >> nextUpTo: delimiter [
	| resultStream nextChar |
	resultStream _ WriteStream on: (String new: 10).
	[self atEnd or: [(nextChar _ self next) == delimiter]]
		whileFalse: [resultStream nextPut: nextChar].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found'].
	^resultStream contents

]

{ #category : #streaming }
XMLTokenizer >> nextUpToAll: delimitingString [
	| string |
	self unpeek.
	string _ self stream upToAll: delimitingString.
	self stream skip: delimitingString size negated.
	(self stream next: delimitingString size) = delimitingString
		ifFalse: [self parseError: 'XML no delimiting ' , delimitingString printString , ' found'].
	^string

]

{ #category : #tokenizing }
XMLTokenizer >> nextWhitespace [
	| nextChar resultStream resultString|
	resultStream _ (String new: 10) writeStream.
	[((nextChar _ self peek) == nil)
		or: [SeparatorTable at: nextChar asciiValue+1]]
		whileFalse: [resultStream nextPut: nextChar. self next].
	(nestedStreams == nil or: [self atEnd not])
		ifFalse: [self checkNestedStream.
				self nextWhitespace].
	resultString _ resultStream contents.
	resultString isEmpty ifFalse: [self handleWhitespace: resultString].
]

{ #category : #tokenizing }
XMLTokenizer >> nextXMLDecl [
	| attributes nextChar namespaces |
	self skipSeparators.
	attributes _ Dictionary new.
	namespaces _ Dictionary new.
	[(nextChar _ self peek) == $?] whileFalse: [
		self nextAttributeInto: attributes namespaces: namespaces.
		self skipSeparators.].
	self next.
	self next == $>
		ifFalse: [self errorExpected: '> expected.'].
	(attributes includesKey: 'encoding') ifTrue: [self streamEncoding: (attributes at: 'encoding')].
	self handleXMLDecl: attributes namespaces: namespaces
	
]

{ #category : #entities }
XMLTokenizer >> parameterEntities [
	parameterEntities ifNil: [parameterEntities _ Dictionary new].
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
			^peekChar _ stream next]
		ifNotNil: [^peekChar]
]

{ #category : #streaming }
XMLTokenizer >> popNestingLevel [
	self hasNestedStreams
		ifTrue: [
			self stream close.
			self stream: self nestedStreams removeLast.
			self nestedStreams size > 0
				ifFalse: [nestedStreams _ nil]]
]

{ #category : #streaming }
XMLTokenizer >> pushBack: aString [
	| pushBackString |
	pushBackString _ peekChar
		ifNil: [aString]
		ifNotNil: [peekChar asString , aString].
	peekChar _ nil.
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
	value _ 0.
	digit _ DigitTable at: self peek asciiValue.
	digit < 0
		ifTrue: [self error: 'At least one digit expected here'].
	self next.
	value _ digit.
	[digit _ DigitTable at: self peek asciiValue.
	digit < 0
		ifTrue: [^value]
		ifFalse: [
			self next.
			value _ value * base + digit]
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
	[((nextChar _ self peek) == nil)
		or: [SeparatorTable at: nextChar asciiValue+1]]
		whileFalse: [self next].
	(nestedStreams == nil or: [self atEnd not])
		ifFalse: [
			self checkNestedStream.
			self skipSeparators]
]

{ #category : #streaming }
XMLTokenizer >> skipUpTo: delimiter [
	| nextChar |
	self unpeek.
	[self atEnd or: [(nextChar _ self next) == delimiter]]
		whileFalse: [].
	nextChar == delimiter
		ifFalse: [self parseError: 'XML no delimiting ' , delimiter printString , ' found']

]

{ #category : #private }
XMLTokenizer >> startParsingMarkup [
	parsingMarkup _ true
]

{ #category : #private }
XMLTokenizer >> stream [
	^stream
]

{ #category : #private }
XMLTokenizer >> stream: newStream [
	"Continue parsing from the new nested stream."
	stream _ newStream
]

{ #category : #streaming }
XMLTokenizer >> streamEncoding: encodingString [

	Smalltalk at: #TextConverter ifPresent: [:tc | 
		(stream respondsTo: #converter:) ifTrue: [
			stream converter: (tc defaultConverterClassForEncoding: encodingString)]]
]

{ #category : #streaming }
XMLTokenizer >> topStream [
	^self hasNestedStreams
		ifTrue: [self nestedStreams first]
		ifFalse: [self stream]
]

{ #category : #streaming }
XMLTokenizer >> unpeek [
	peekChar
		ifNotNil: [
			self stream pushBack: (String with: peekChar).
			peekChar _ nil]
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
	validating _ aBoolean
]

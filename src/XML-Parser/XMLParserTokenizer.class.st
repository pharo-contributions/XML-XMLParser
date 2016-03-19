"
This is a base class for parser tokenizers that read tokens from a stream using an XMLNestedStreamReader and context objects. Sending #nextToken causes a token to be read and handler messages to be sent to a driver.

Be careful changing the code in this class or subclasses because it's optimized.
"
Class {
	#name : #XMLParserTokenizer,
	#superclass : #Object,
	#instVars : [
		'context',
		'driver',
		'streamReader',
		'writeStream',
		'nameStream'
	],
	#classVars : [
		'CharacterConverter',
		'PredefinedEntities'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLParserTokenizer class >> driver: aDriver on: aStringOrStream [
	^self
		driver: aDriver
		on: aStringOrStream
		readLimit: nil
]

{ #category : #'instance creation' }
XMLParserTokenizer class >> driver: aDriver on: aStringOrStream readLimit: aReadLimit [
	^self new
		setDriver: aDriver
		stream:
			(aStringOrStream isStream
				ifTrue: [aStringOrStream]
				ifFalse: [aStringOrStream readStream])
		readLimit: aReadLimit
]

{ #category : #'class initialization' }
XMLParserTokenizer class >> initialize [
	"self initialize"

	self
		initializePredefinedEntities;
		initializeCharacterConverter
]

{ #category : #'class initialization' }
XMLParserTokenizer class >> initializeCharacterConverter [
	CharacterConverter := XMLUTF8StreamConverter new
]

{ #category : #'class initialization' }
XMLParserTokenizer class >> initializePredefinedEntities [
	(PredefinedEntities := Dictionary new)
		at: 'lt' put: $<;
		at: 'gt' put: $>;
		at: 'amp' put: $&;
		at: 'apos' put: $';
		at: 'quot' put: $"
]

{ #category : #accessing }
XMLParserTokenizer class >> predefinedEntities [
	^ PredefinedEntities
]

{ #category : #testing }
XMLParserTokenizer >> atEnd [
	^ context isTerminatedContext
]

{ #category : #decoding }
XMLParserTokenizer >> characterFromCodePoint: aCodePoint [
	(aCodePoint notNil
		and: [aCodePoint > 0])
		ifTrue: [
			^ [CharacterConverter characterFromCodePoint: aCodePoint]
				on: Error
				do: [:error | nil]]
		ifFalse: [^ nil].
]

{ #category : #closing }
XMLParserTokenizer >> closeStreams [
	streamReader closeStreams
]

{ #category : #'entity replacing' }
XMLParserTokenizer >> constructReplacementForGeneralEntity: anEntity [
]

{ #category : #'entity replacing' }
XMLParserTokenizer >> constructReplacementForParameterEntity: anEntity [
]

{ #category : #accessing }
XMLParserTokenizer >> context [
	^ context
]

{ #category : #accessing }
XMLParserTokenizer >> context: aTokenContext [
	context := aTokenContext
]

{ #category : #decoding }
XMLParserTokenizer >> convertFromEncoding: anEncodingName [
	driver decodesCharacters
		ifTrue: [streamReader convertFromEncoding: anEncodingName]
]

{ #category : #accessing }
XMLParserTokenizer >> currentColumnNumber [
	^ streamReader currentColumnNumber
]

{ #category : #accessing }
XMLParserTokenizer >> currentLineNumber [
	^ streamReader currentLineNumber
]

{ #category : #accessing }
XMLParserTokenizer >> currentPosition [
	^ streamReader currentPosition
]

{ #category : #accessing }
XMLParserTokenizer >> driver [
	^ driver
]

{ #category : #'tokenizing - expecting' }
XMLParserTokenizer >> expectNext: aCharacter [
	self subclassResponsibility
]

{ #category : #'tokenizing - expecting' }
XMLParserTokenizer >> expectNextAll: aString [
	self subclassResponsibility
]

{ #category : #'tokenizing - expecting' }
XMLParserTokenizer >> expectSeparators [
	self subclassResponsibility
]

{ #category : #'tokenizing - expecting' }
XMLParserTokenizer >> expectTerminator [
	self subclassResponsibility
]

{ #category : #'tokenizing - expecting' }
XMLParserTokenizer >> expectUpToAll: aString [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextCDataSection [
	self expectNextAll: '[CDATA['.

	driver handleCData: (self expectUpToAll: ']]>').

]

{ #category : #tokenizing }
XMLParserTokenizer >> nextContentMarkupToken [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextContentToken [
	streamReader peek == $<
		ifTrue: [
			streamReader next.
			^ self nextContentMarkupToken].
	self nextPCDataToken.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextDoctypeDeclaration [
	| root publicID systemID |

	context := context doctypeDeclarationContext.
	self
		expectNextAll: 'DOCTYPE';
		expectSeparators.

	root := self nextName.
	(streamReader peek == $[
		or: [streamReader peek == $>])
		ifFalse: [
			self expectSeparators.
			streamReader peek == $P
				ifTrue: [
					publicID := self nextPublicID.
					self expectSeparators.
					systemID := self nextSystemIDLiteral]
				ifFalse: [
					streamReader peek == $S
						ifTrue: [systemID := self nextSystemID]]].
	driver
		handleStartDTD: root
		publicID: (publicID ifNil: [''])
		systemID: (systemID ifNil: ['']).

	streamReader skipSeparators.
	streamReader peek == $[
		ifTrue: [self nextInternalSubsetStart]
		ifFalse: [self nextEndDoctypeDeclaration].
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextEndDoctypeDeclaration [
	self expectTerminator.
	context := context postDoctypeDeclarationContext.

	driver handleEndDTD.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextEndDocument [
	context isTerminatedContext
		ifFalse: [
			self closeStreams.
			context := context terminatedContext.
			driver handleEndDocument]
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextEndIncludeSection [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextEndInternalSubset [
	"skip ]"
	streamReader
		next;
		skipSeparators.
	self nextEndDoctypeDeclaration.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextInternalSubsetStart [
	"skip ["
	streamReader next.
	context := context internalSubsetContext.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextInternalSubsetToken [
	streamReader skipSeparators.
	streamReader peek == $%
		ifTrue: [
			streamReader next.
			^ self nextParameterEntityReference].
	streamReader peek == $]
		ifTrue: [^ self nextEndInternalSubset].
	self nextSubsetMarkupToken.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextName [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPCDataToken [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPI [
	"skip ?"
	streamReader next.
	self nextPIWithTarget: self nextPITarget.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPITarget [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPIWithTarget: aTarget [
	streamReader peek == $?
		ifTrue: [
			streamReader next.
			self expectTerminator.
			driver
				handlePI: aTarget
				data: '']
		ifFalse: [
			self expectSeparators.
			driver
				handlePI: aTarget
				data: (self expectUpToAll: '?>')].
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextParameterEntityReference [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPrologToken [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextPublicID [
	^ self
		expectNextAll: 'PUBLIC';
		expectSeparators;
		nextPublicIDLiteral
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextPublicIDLiteral [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextStartContent [
	context := context contentContext.
	driver handleStartContent.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextStartDocument [
	context := driver initialContext ifNil: [XMLXMLDeclarationContext new].
	(context supportsEncodingDetection
		and: [driver decodesCharacters])
		ifTrue: [streamReader detectCurrentEncoding].
	driver handleStartDocument.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextSubsetMarkupToken [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextSystemID [
	^ self
		expectNextAll: 'SYSTEM';
		expectSeparators;
		nextSystemIDLiteral
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextSystemIDLiteral [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextToken [
	(streamReader atEnd
		and: [context isInitializedContext])
		ifTrue: [^ self nextEndDocument].
	context nextTokenFrom: self.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLAttributeName: aName [
	self expectNextAll: aName.
	streamReader skipSeparators.
	self expectNext: $=.
	streamReader skipSeparators.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLDeclaration [
	| version encoding |

	self expectSeparators.
	version := self nextXMLVersionAttributeRequired: true.
	streamReader peek == $?
		ifFalse: [self expectSeparators].
	(encoding := self nextXMLEncodingAttributeRequired: false) isEmpty
		ifFalse: [
			self convertFromEncoding: encoding.
			streamReader peek == $?
				ifFalse: [self expectSeparators]].
	driver
		handleXMLVersion: version
		encoding: encoding
		standalone: self nextXMLStandaloneAttribute.
	streamReader skipSeparators.
	self
		expectNext: $?;
		expectTerminator.

	context := context prologContext.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLDeclarationOrPrologToken [
	streamReader peek == $<
		ifTrue: [
			streamReader next.
			streamReader peek == $?
				ifTrue: [| target |
					streamReader next.
					(target := self nextPITarget) = 'xml'
						ifTrue: [^ self nextXMLDeclaration]
						ifFalse: [
							context := context prologContext.
							^ self nextPIWithTarget: target]].
			context := context prologContext.
			^ self nextNonPIPrologOrContentToken].

	"other prolog tokens can have whitespace before them, so the doc
	does not need to start with an < for them"
	context := context prologContext.
	self nextPrologToken.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLEncodingAttributeRequired: aBoolean [
	(aBoolean or: [streamReader peek == $e])
		ifTrue: [	
			^ self
				nextXMLAttributeName: 'encoding';
				nextXMLEncodingAttributeValue]
		ifFalse: [^ '']
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLEncodingAttributeValue [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLStandaloneAttribute [
	"always optional"
	(streamReader peek == $s)
		ifTrue: [
			^ self
				nextXMLAttributeName: 'standalone';
				nextXMLStandaloneAttributeValue]
		ifFalse: [^ '']
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLStandaloneAttributeValue [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLTextDeclaration [
	(streamReader nextMatchAll: '<?xml')
		ifTrue: [| encoding |
			self expectSeparators.
			(self nextXMLVersionAttributeRequired: false) isEmpty
				ifFalse: [self expectSeparators].
			(encoding := self nextXMLEncodingAttributeRequired: true) isEmpty
				ifFalse: [self convertFromEncoding: encoding].

			streamReader skipSeparators.
			self
				expectNext: $?;
				expectTerminator].
	context := context previousContext.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLVersionAttributeRequired: aBoolean [
	(aBoolean or: [streamReader peek == $v])
		ifTrue: [
			^ self
				nextXMLAttributeName: 'version';
				nextXMLVersionAttributeValue]
		ifFalse: [^ '']
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLVersionAttributeValue [
	self subclassResponsibility
]

{ #category : #accessing }
XMLParserTokenizer >> normalizedLineEndingChar [
	^ streamReader normalizedLineEndingChar
]

{ #category : #accessing }
XMLParserTokenizer >> normalizedLineEndingChar: aCharacter [
	streamReader normalizedLineEndingChar: aCharacter
]

{ #category : #printing }
XMLParserTokenizer >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: context;
		nextPutAll: '; ';
		print: streamReader;
		nextPut: $).
]

{ #category : #initialization }
XMLParserTokenizer >> setDriver: aDriver stream: aStream readLimit: aReadLimit [
	driver := aDriver.
	streamReader :=
		(XMLNestedStreamReader
			on: aStream
			readLimit: aReadLimit).
	"must use #writeStream instead of WriteStream on: to get a 0-based stream
	on Gemstone"
	writeStream := (String new: 128) writeStream.
	nameStream := (String new: 16) writeStream.
	context := XMLUnitializedContext new.
]

{ #category : #accessing }
XMLParserTokenizer >> streamReader [
	^ streamReader
]

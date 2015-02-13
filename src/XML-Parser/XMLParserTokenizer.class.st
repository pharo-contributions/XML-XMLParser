"
This is a base class for tokenizers. It reads tokens from a stream using a NestedStreamReader. Sending it #nextToken causes a token to be read and one or more handler messages to be dispatched to a driver.

Be careful changing the code in this class or subclass because it is optimized.
"
Class {
	#name : #XMLParserTokenizer,
	#superclass : #Object,
	#instVars : [
		'context',
		'driver',
		'nameStream',
		'streamReader',
		'writeStream'
	],
	#classVars : [
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

{ #category : #'entity replacing' }
XMLParserTokenizer >> characterFromCodePoint: anInteger [
	(anInteger notNil and: [anInteger > 0])
		ifFalse: [^ nil].
	^ [anInteger asCharacter]
		on: Error
		do: [:error | nil].
]

{ #category : #'file open/close' }
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
XMLParserTokenizer >> currentLineNumber [
	^ streamReader currentLineNumber
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
XMLParserTokenizer >> expectTerminator: aCharacter [
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
	|  root externalId |

	context := context doctypeContext.
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
		ifFalse: [self nextEndDoctypeDeclaration].
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextEndDoctypeDeclaration [
	streamReader skipSeparators.
	self expectTerminator: $>.
	context := context prologContext.

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
XMLParserTokenizer >> nextEndInternalSubset [
	self
		expectTerminator: $];
		nextEndDoctypeDeclaration
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextExternalIDSystemLiteralRequired: aBoolean [
	| publicId systemId |

	(streamReader atEnd not
		and: [streamReader peek == $P
			or: [streamReader peek == $S]])
		ifTrue: [
			streamReader peek == $P
				ifTrue: [
					self
						expectNextAll: 'PUBLIC';
						skipSeparatorsReplacingParameterEntities.
					publicId := self nextPubidLiteral.

					self skipSeparatorsReplacingParameterEntities.
					systemId := self nextSystemLiteralRequired: aBoolean]
				ifFalse: [
					self
						expectNextAll: 'SYSTEM';
						skipSeparatorsReplacingParameterEntities.
					systemId := self nextSystemLiteralRequired: true]].

	^ (publicId ifNil: ['']) -> (systemId ifNil: ['']).
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextInternalSubsetStart [
	"skip ["
	streamReader next.
	context := context internalSubsetContext.
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
XMLParserTokenizer >> nextPIOrXMLDeclaration [
	| piTarget piData |

	"Skip ?"
	streamReader next.
	piTarget := self nextPITarget.
	(piTarget = 'xml'
		and: [context isPrologContext])
		ifTrue: [^ self nextXMLDeclaration].
	streamReader skipSeparators.
	piData := self expectUpToAll: '?>'.

	driver handlePI: piTarget data: piData.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPITarget [
	self subclassResponsibility
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
XMLParserTokenizer >> nextPubidLiteral [
	self subclassResponsiblity
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextStartDocument [
	context := driver initialContext ifNil: [XMLPrologContext new].
	context isPrologContext
		ifTrue: [streamReader detectCurrentEncoding].
	driver handleStartDocument.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextSubsetMarkupToken [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextSubsetToken [
	streamReader skipSeparators.
	streamReader atEnd
		ifTrue: [^ self].

	streamReader peek == $%
		ifTrue: [
			streamReader next.
			^ self nextParameterEntityReference].
	(context isInternalSubsetContext and: [streamReader peek == $]])
		ifTrue: [^ self nextEndInternalSubset].

	self nextSubsetMarkupToken.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextSystemLiteralRequired: aBoolean [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextToken [
	(context isInitializedContext
		and: [streamReader atEnd])
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
	| version encoding standalone |

	version := self nextXMLVersionAttributeRequired: true.
	(encoding := self nextXMLEncodingAttributeRequired: false)
		ifNotEmpty: [streamReader convertFromEncoding: encoding].
	standalone := self nextXMLStandaloneAttribute.

	streamReader skipSeparators.
	self
		expectNext: $?;
		expectTerminator: $>.

	driver
		handleXMLVersion: version
		encoding: encoding
		standalone: standalone.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLEncodingAttributeRequired: aBoolean [
	streamReader skipSeparators.
	(aBoolean or: [streamReader peek == $e])
		ifFalse: [^ ''].

	^ self
		nextXMLAttributeName: 'encoding';
		nextXMLEncodingAttributeValue.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLEncodingAttributeValue [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLStandaloneAttribute [
	streamReader skipSeparators.
	(streamReader peek == $s)
		ifFalse: [^ ''].

	^ self
		nextXMLAttributeName: 'standalone';
		nextXMLStandaloneAttributeValue.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLStandaloneAttributeValue [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLTextDeclaration [
	(streamReader nextMatchAll: '<?xml')
		ifTrue: [
			self nextXMLVersionAttributeRequired: false.
			(self nextXMLEncodingAttributeRequired: true)
				ifNotEmpty: [:encoding | streamReader convertFromEncoding: encoding].

			streamReader skipSeparators.
			self
				expectNext: $?;
				expectTerminator: $>].
	context := context previousContext.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLVersionAttributeRequired: aBoolean [
	streamReader skipSeparators.
	(aBoolean or: [streamReader peek == $v])
		ifFalse: [^ ''].

	^ self
		nextXMLAttributeName: 'version';
		nextXMLVersionAttributeValue.
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

{ #category : #initialization }
XMLParserTokenizer >> setDriver: aDriver stream: aStream readLimit: aReadLimit [
	driver := aDriver.
	streamReader :=
		(XMLNestedStreamReader
			on: aStream
			readLimit: aReadLimit).
	writeStream := (String new: 128) writeStream.
	nameStream := (String new: 16) writeStream.
	context := XMLUnitializedContext new.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> skipSeparatorsReplacingParameterEntities [
	"this can be used to replace references within declarations"

	streamReader skipSeparators.
	context isExternalSubsetContext
		ifFalse: [^ self].
	[streamReader peek == $%]
		whileTrue: [
			streamReader next.
			self nextParameterEntityReference.
			streamReader skipSeparators].
]

{ #category : #accessing }
XMLParserTokenizer >> streamReader [
	^ streamReader
]

{ #category : #accessing }
XMLParserTokenizer >> tokenContext [
	^ context
]

{ #category : #accessing }
XMLParserTokenizer >> tokenContext: aTokenContext [
	context := aTokenContext
]

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
		'streamReader',
		'writeStream',
		'nameStream'
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
XMLParserTokenizer >> context [
	^ context
]

{ #category : #accessing }
XMLParserTokenizer >> context: aTokenContext [
	context := aTokenContext
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
XMLParserTokenizer >> nextEndInternalSubsetOrIncludeSection [
	context isInternalSubsetContext
		ifTrue: [self nextEndInternalSubset]
		ifFalse: [self nextEndIncludeSection]
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
XMLParserTokenizer >> nextPI [
	"skip ?"
	streamReader next.
	self nextPIWithTarget: self nextPITarget.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPIOrXMLDeclaration [
	| target |

	streamReader next.
	(target := self nextPITarget) = 'xml'
		ifTrue: [^ self nextXMLDeclaration].

	context := context prologContext.
	self nextPIWithTarget: target.
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
	context supportsEncodingDetection
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
	streamReader peek == $]
		ifTrue: [^ self nextEndInternalSubsetOrIncludeSection].

	self nextSubsetMarkupToken.
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
			streamReader convertFromEncoding: encoding.
			streamReader peek == $?
				ifFalse: [self expectSeparators]].
	
	driver
		handleXMLVersion: version
		encoding: encoding
		standalone: self nextXMLStandaloneAttribute.
	context := context prologContext.

	streamReader skipSeparators.
	self
		expectNext: $?;
		expectTerminator.
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
				ifFalse: [streamReader convertFromEncoding: encoding].

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
	writeStream := (String new: 128) writeStream.
	nameStream := (String new: 16) writeStream.
	context := XMLUnitializedContext new.
]

{ #category : #accessing }
XMLParserTokenizer >> streamReader [
	^ streamReader
]

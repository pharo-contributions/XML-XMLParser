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
		'elementNester',
		'streamReader',
		'nameStream',
		'declarationStream',
		'characterDataStream'
	],
	#classVars : [
		'PredefinedEntities'
	],
	#category : #'XML-Parser-Drivers'
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

	"assign after with #yourself to avoid possible race
	conditions when reinitializing the class"
	PredefinedEntities :=
		Dictionary new
			at: 'lt' put: $<;
			at: 'gt' put: $>;
			at: 'amp' put: $&;
			at: 'apos' put: $';
			at: 'quot' put: $";
			yourself
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
		and: [aCodePoint > 0
			and: [aCodePoint <= 16r10FFFF]])
		ifTrue: [
			^ [Character value: aCodePoint]
				on: Error
				do: [:error | nil]]
		ifFalse: [^ nil]
]

{ #category : #closing }
XMLParserTokenizer >> closeStreams [
	streamReader closeStreams
]

{ #category : #accessing }
XMLParserTokenizer >> context [
	^ context
]

{ #category : #accessing }
XMLParserTokenizer >> context: aTokenContext [
	(context := aTokenContext) isContentContext
		ifTrue: [elementNester := driver newElementNester].
	driver decodesCharacters
		ifTrue: [
			context supportsEncodingDetection
				ifTrue: [streamReader detectEncoding]]
		ifFalse: [streamReader decodeStreamWithNullConverter].
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

{ #category : #accessing }
XMLParserTokenizer >> elementNester [
	^ elementNester
]

{ #category : #errors }
XMLParserTokenizer >> errorExpected: aDescription [
	self parseError: 'Expected ', aDescription
]

{ #category : #errors }
XMLParserTokenizer >> errorExpected: aDescription butGot: aCharacter [
	self
		formatParseError: 'Expected {1} but got "{2}"'
		with: aDescription
		with: (aCharacter ifNil: [''])
]

{ #category : #errors }
XMLParserTokenizer >> errorExpectedLiteral: aCharacterOrString [
	self
		errorExpectedLiteral: aCharacterOrString
		butGot: nil
]

{ #category : #errors }
XMLParserTokenizer >> errorExpectedLiteral: anExpectedCharacterOrString butGot: aReceivedCharacterOrString [
	self
		formatParseError: 'Expected "{1}" but got "{2}"' 
		with: anExpectedCharacterOrString
		with: (aReceivedCharacterOrString ifNil: [''])
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

{ #category : #errors }
XMLParserTokenizer >> formatParseError: aString with: aFirstValue [
	self
		formatParseError: aString
		withArguments: (Array with: aFirstValue)
]

{ #category : #errors }
XMLParserTokenizer >> formatParseError: aString with: aFirstValue with: aSecondValue [
	self
		formatParseError: aString
		withArguments:
			(Array
				with: aFirstValue
				with: aSecondValue)
]

{ #category : #errors }
XMLParserTokenizer >> formatParseError: aString with: aFirstValue with: aSecondValue with: aThirdValue [
	self
		formatParseError: aString
		withArguments:
			(Array
				with: aFirstValue
				with: aSecondValue
				with: aThirdValue)
]

{ #category : #errors }
XMLParserTokenizer >> formatParseError: aString with: aFirstValue with: aSecondValue with: aThirdValue with: aFourthValue [
	self
		formatParseError: aString
		withArguments:
			(Array
				with: aFirstValue
				with: aSecondValue
				with: aThirdValue
				with: aFourthValue)
]

{ #category : #errors }
XMLParserTokenizer >> formatParseError: aString withArguments: aValueCollection [
	self parseError: (aString format: aValueCollection)
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextCDataSection [
	self subclassResponsibility

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
	elementNester isInElement
		ifTrue: [^ self nextPCDataToken].
	self nextNonElementWhitespace.
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
		ifTrue: [self nextStartInternalSubset]
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
XMLParserTokenizer >> nextEndInternalSubset [
	"skip ]"
	streamReader
		next;
		skipSeparators.
	self nextEndDoctypeDeclaration.
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
XMLParserTokenizer >> nextNonElementWhitespace [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextNonPIPrologOrContentMarkupToken [
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
XMLParserTokenizer >> nextPIData [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextPITarget [
	"should return a PI target string or nil if it's the start of
	an '<?xml ...?>' declaration"
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
				data: self nextPIData].
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
	elementNester := driver newElementNester.
	driver handleStartContent.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextStartDocument [
	self context: driver newInitialContext.
	driver handleStartDocument.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextStartInternalSubset [
	"skip ["
	streamReader next.
	context := context internalSubsetContext.
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
				ifTrue: [
					streamReader next.
					self nextPITarget
						ifNil: [^ self nextXMLDeclaration]
						ifNotNil: [:target |
							context := context prologContext.
							^ self nextPIWithTarget: target]].
			context := context prologContext.
			^ self nextNonPIPrologOrContentMarkupToken].

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

{ #category : #errors }
XMLParserTokenizer >> parseError: aString [
	driver handleParseError: aString
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
	context := XMLUnitializedContext new.
	driver := aDriver.
	streamReader :=
		(XMLNestedStreamReader
			on: aStream
			readLimit: aReadLimit).

	"must use #writeStream instead of 'WriteStream on:' to get 0-based
	streams on Gemstone"
	nameStream := (String new: 16) writeStream.
	declarationStream := (String new: 32) writeStream.
	characterDataStream := (String new: 128) writeStream.
]

{ #category : #accessing }
XMLParserTokenizer >> streamReader [
	^ streamReader
]

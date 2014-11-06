"
This is a base class for tokenizers. It reads tokens from a stream using a NestedStreamReader. Sending it #nextToken causes a token to be read and one or more handler messages to be dispatched to a driver.

Be careful changing the code in this class or subclass because it is optimized.
"
Class {
	#name : #XMLParserTokenizer,
	#superclass : #Object,
	#instVars : [
		'driver',
		'context',
		'streamReader',
		'writeStream',
		'nameStream'
	],
	#classInstVars : [
		'predefinedEntities'
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

	super initialize.
	self initializePredefinedEntities.
]

{ #category : #'class initialization' }
XMLParserTokenizer class >> initializePredefinedEntities [
]

{ #category : #accessing }
XMLParserTokenizer class >> predefinedEntities [
	^ predefinedEntities
]

{ #category : #testing }
XMLParserTokenizer >> atEnd [
	^ context atEnd
]

{ #category : #'entity replacement' }
XMLParserTokenizer >> characterFromCodePoint: aCodePoint [
	^ (aCodePoint notNil and: [aCodePoint > 0])
		ifTrue: [
			[aCodePoint asCharacter]
				on: Error
				do: [:error | nil]]
		ifFalse: [nil]
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

{ #category : #accessing }
XMLParserTokenizer >> initialContext: aContext [
	context setContext: aContext
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextAttributeValue [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextCDataSection [
	self expectNextAll: '[CDATA['.

	driver handleCData: (self expectUpToAll: ']]>').

]

{ #category : #tokenizing }
XMLParserTokenizer >> nextComment [
	| comment nextChar |

	"Skip first -"
	streamReader next.
	self expectNext: $-.

	writeStream reset.
	[(nextChar := streamReader next) == nil
		or: [nextChar == $-
			and: [(streamReader peek) == $-]]]
		whileFalse: [writeStream nextPut: nextChar].
	comment := writeStream contents.

	self
		expectNext: $-;
		expectTerminator: $>.

	driver handleComment: comment.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextContentMarkupToken [
	streamReader peek == $?
		ifTrue: [^ self nextPIOrXMLDecl].
	streamReader peek == $!
		ifTrue: [
			streamReader next.
			streamReader peek == $-
				ifTrue: [^self nextComment].
			^ self nextCDataSection].
	self nextTag.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextContentToken [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextDecodedCharReference [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextDocTypeDecl [
	|  root externalId |

	context enterDoctype.
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
		ifFalse: [self nextEndDocTypeDecl].
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextEndDocTypeDecl [
	streamReader skipSeparators.
	self expectTerminator: $>.
	context enterProlog.

	driver handleEndDTD.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextEndDocument [
	context atEnd
		ifFalse: [
			streamReader close.
			context enterAtEnd.
			driver handleEndDocument]
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextEndInternalSubset [
	self expectTerminator: $].

	context enterProlog.
	self nextEndDocTypeDecl.
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

{ #category : #tokenizing }
XMLParserTokenizer >> nextGeneralEntityReference [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextInternalSubsetStart [
	"skip ["
	streamReader next.
	context enterInternalSubset.
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
XMLParserTokenizer >> nextPIOrXMLDecl [
	| piTarget piData |

	"Skip ?"
	streamReader next.
	piTarget := self nextPITarget.
	(piTarget = 'xml'
		and: [context isInProlog
			or: [context isInTextDeclaration]])
		ifTrue: [^ self nextXMLDecl]
		ifFalse: [
			context isInExternalSubsetTextDeclaration
				ifTrue: [context enterExternalSubset]].
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
	context setContext: (driver initialContext ifNil: [#inProlog]).
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
		ifTrue: [^ self replaceParameterEntityReference].
	(context isInInternalSubset and: [streamReader peek == $]])
		ifTrue: [^ self nextEndInternalSubset].

	self nextSubsetMarkupToken.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> nextSystemLiteralRequired: aBoolean [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextTag [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextToken [
	(streamReader atEnd and: [context isInitialized])
		ifTrue: [^ self nextEndDocument].

	context isInContent
		ifTrue: [^ self nextContentToken].
	context isInSubset
		ifTrue: [^ self nextSubsetToken].
	context isInProlog
		ifTrue: [^ self nextPrologToken].
	context notInitialized 
		ifTrue: [^ self nextStartDocument].

	self nextEndDocument.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextUnparsedEntityReference [
	| name |

	name := self nextName.
	self expectNext: $;.

	^ (driver handleUnparsedEntityReference: name) ifNil: [''].
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLAttributeName: aName [
	self expectNextAll: aName.
	streamReader skipSeparators.
	self expectNext: $=.
	streamReader skipSeparators.
]

{ #category : #tokenizing }
XMLParserTokenizer >> nextXMLDecl [
	| version encoding standalone isTextDeclaration |

	isTextDeclaration  := context isInTextDeclaration.
	version := self nextXMLVersionAttributeRequired: isTextDeclaration not.
	(encoding := self nextXMLEncodingAttributeRequired: isTextDeclaration)
		ifNotEmpty: [streamReader useConverterForEncoding: encoding].
	isTextDeclaration
		ifFalse: [standalone := self nextXMLStandaloneAttribute].

	streamReader skipSeparators.
	self
		expectNext: $?;
		expectTerminator: $>.

	isTextDeclaration
		ifTrue: [
			context isInExternalSubsetTextDeclaration
				ifTrue: [context enterExternalSubset]]
		ifFalse: [
			driver
				handleXMLVersion: version
				encoding: encoding
				standalone: standalone].
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

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> replaceParameterEntityReference [
	streamReader next.
	self nextParameterEntityReference
]

{ #category : #initialization }
XMLParserTokenizer >> setDriver: aDriver stream: aStream readLimit: aReadLimit [
	driver := aDriver.
	streamReader :=
		(XMLNestedStreamReader
			on: aStream
			readLimit: aReadLimit).
	writeStream := WriteStream on: (String new: 128).
	nameStream := WriteStream on: (String new: 16).
	context := self tokenContextClass new.
]

{ #category : #'tokenizing - dtd' }
XMLParserTokenizer >> skipSeparatorsReplacingParameterEntities [
	"this can be used to replace references within declarations"

	streamReader skipSeparators.
	context isInExternalSubset
		ifFalse: [^ self].
	[streamReader peek == $%]
		whileTrue: [
			self replaceParameterEntityReference.
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
XMLParserTokenizer >> tokenContextClass [
	self subclassResponsibility
]

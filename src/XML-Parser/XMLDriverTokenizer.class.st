"
This is a base class for tokenizers. Be careful changing the code in this class or its subclases. It is heavily optimized.
"
Class {
	#name : #XMLDriverTokenizer,
	#superclass : #Object,
	#instVars : [
		'driver',
		'context',
		'streamReader',
		'streamWriter'
	],
	#classInstVars : [
		'predefinedEntities'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLDriverTokenizer class >> driver: aDriver on: aStringOrStream [
	^self new
		setDriver: aDriver
		stream:
			(aStringOrStream isStream
				ifTrue: [aStringOrStream]
				ifFalse: [aStringOrStream readStream])
]

{ #category : #'class initialization' }
XMLDriverTokenizer class >> initialize [
	"self initialize"

	self initializePredefinedEntities.
]

{ #category : #'class initialization' }
XMLDriverTokenizer class >> initializePredefinedEntities [
]

{ #category : #accessing }
XMLDriverTokenizer class >> predefinedEntities [
	^ predefinedEntities
]

{ #category : #testing }
XMLDriverTokenizer >> atEnd [
	self subclassResponsibility
]

{ #category : #'entity replacement' }
XMLDriverTokenizer >> characterFromCodePoint: aCodePoint [
	self subclassResponsibility
]

{ #category : #accessing }
XMLDriverTokenizer >> currentLineNumber [
	^ streamReader currentLineNumber
]

{ #category : #accessing }
XMLDriverTokenizer >> driver [
	^ driver
]

{ #category : #'tokenizing - expecting' }
XMLDriverTokenizer >> expectNext: aCharacter [
	self subclassResponsibility
]

{ #category : #'tokenizing - expecting' }
XMLDriverTokenizer >> expectNextAll: aString [
	self subclassResponsibility
]

{ #category : #'tokenizing - expecting' }
XMLDriverTokenizer >> expectTerminator: aCharacter [
	self subclassResponsibility
]

{ #category : #'tokenizing - expecting' }
XMLDriverTokenizer >> expectUpToAll: aString [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextCDataSection [
	self expectNextAll: '[CDATA['.

	driver handleCData: (self expectUpToAll: ']]>').

]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextComment [
	| comment |

	"Skip first -"
	streamReader next.
	self expectNext: $-.

	comment := streamReader upToAll: '--'.
	self expectTerminator: $>.

	driver handleComment: comment.
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextContentToken [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextDecodedCharReference [
	| codePoint |

	"skip #"
	streamReader next.
	codePoint := streamReader nextInteger.
	self expectNext: $;.

	^ self characterFromCodePoint: codePoint.
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextDelimitedBy: aDelimiter and: aSecondDelimiter entityChar: anEntityStartChar normalizeWhitespace: shouldNormalize ignorableWhitespace: shouldSkip [
	| isIgnorableWhitespace nextChar pcData |

	isIgnorableWhitespace := true.
	pcData := ''.
	streamWriter writeWith: [:writeStream |
		"separate arguments for delimiters are used instead of a collection for performance"
		[(nextChar := streamReader peek) isNil
			or: [nextChar == aDelimiter
				or: [nextChar == aSecondDelimiter]]]
			whileFalse: [
				nextChar == $&
					ifTrue: [
						streamReader next.
						streamReader peek == $#
							ifTrue: [
								writeStream nextPut: self nextDecodedCharReference.
								isIgnorableWhitespace := false]
							ifFalse: [
								anEntityStartChar == $&
									ifTrue: [
										(nextChar := self nextGeneralEntityReference)
											ifNotNil: [
												writeStream nextPut: nextChar.
												isIgnorableWhitespace := false]]
									ifFalse: [
										writeStream nextPut: $&.
										isIgnorableWhitespace := false]]]
					ifFalse: [
						streamReader next.
						nextChar == anEntityStartChar
							ifTrue: [self nextParameterEntityReference]
							ifFalse: [
								nextChar isSeparator
									ifTrue: [
										shouldNormalize
											ifTrue: [nextChar := Character space]]
									ifFalse: [isIgnorableWhitespace := false].
								writeStream nextPut: nextChar]]].
		isIgnorableWhitespace & shouldSkip
			ifTrue: [
				writeStream position > 0
					ifTrue: [driver handleWhitespace: writeStream contents]]
			ifFalse: [pcData :=  writeStream contents]].
	^ pcData.
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextDocTypeDecl [
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
XMLDriverTokenizer >> nextEndDocTypeDecl [
	streamReader skipSeparators.
	self expectTerminator: $>.
	context enterProlog.

	driver handleEndDTD.
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextEndDocument [
	context enterAtEnd.
	driver handleEndDocument.
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextEndInternalSubset [
	self expectTerminator: $].

	context enterProlog.
	self nextEndDocTypeDecl.
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextExternalIDSystemLiteralRequired: aBoolean [
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
XMLDriverTokenizer >> nextGeneralEntityReference [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextInternalSubsetStart [
	"skip ["
	streamReader next.
	context enterInternalSubset.
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextName [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextPIOrXMLDecl [
	| piTarget piData |

	"Skip ?"
	streamReader next.
	piTarget := self nextName.
	((context isInProlog or: [context isInTextDeclaration])
		and: [piTarget asUppercase = 'XML'])
		ifTrue: [^ self nextXMLDecl]
		ifFalse: [
			context isInExternalSubsetTextDeclaration
				ifTrue: [context enterExternalSubset]].

	streamReader skipSeparators.
	piData := self expectUpToAll: '?>'.

	driver handlePI: piTarget data: piData.
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextParameterEntityReference [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextPrologToken [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextPubidLiteral [
	self subclassResponsiblity
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextStartDocument [
	context enterProlog.
	driver handleStartDocument.
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextSubsetMarkupToken [
	self subclassResponsibility
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> nextSubsetToken [
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
XMLDriverTokenizer >> nextSystemLiteralRequired: aBoolean [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextTag [
	self subclassResponsibility
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextToken [
	self atEnd
		ifTrue: [^ self].
	context isInContent
		ifTrue: [^ self nextContentToken].
	context isInSubset
		ifTrue: [^ self nextSubsetToken].
	context notInitialized 
		ifTrue: [^ self nextStartDocument].

	self nextPrologToken.
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextUnparsedEntityReference [
	| name |

	streamReader next.
	name := self nextName.
	self expectNext: $;.

	^ (driver handleUnparsedEntityReference: name) ifNil: [''].
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextXMLDecl [
	| version encoding standalone |

	version := self nextXMLDeclAttribute: 'version'.
	streamReader skipSeparators.
	encoding := 
		streamReader peek == $e
			ifTrue: [self nextXMLDeclAttribute: 'encoding']
			ifFalse: [''].
	context isInTextDeclaration
		ifFalse: [standalone := self nextXMLDeclAttribute: 'standalone'].

	streamReader skipSeparators.
	self
		expectNext: $?;
		expectTerminator: $>.

	encoding
		ifNotEmpty: [streamReader useConverterForEncoding: encoding].

	context isInTextDeclaration
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
XMLDriverTokenizer >> nextXMLDeclAttribute: aName [
	streamReader skipSeparators.
	streamReader peek == $?
		ifTrue: [^ ''].

	self expectNextAll: aName.
	streamReader skipSeparators.
	self expectNext: $=.
	streamReader skipSeparators.

	^ self nextXMLDeclAttributeValue.
]

{ #category : #tokenizing }
XMLDriverTokenizer >> nextXMLDeclAttributeValue [
	self subclassResponsibility

]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> replaceParameterEntityReference [
	streamReader next.
	self nextParameterEntityReference
]

{ #category : #initialization }
XMLDriverTokenizer >> setDriver: aDriver stream: aStream [
	driver := aDriver.
	context := self tokenContextClass new.
	streamReader :=
		(XMLNestedStreamReader
			on: aStream
			from: (driver ifNotNil: [driver documentURI])
			onClose: nil).
	streamWriter := XMLNestedStreamWriter new: 3.
]

{ #category : #'tokenizing - dtd' }
XMLDriverTokenizer >> skipSeparatorsReplacingParameterEntities [
	"this can be used to replace references within declarations"

	streamReader skipSeparators.
	[streamReader atEnd not
		and: [context isInExternalSubset
			and: [streamReader peek == $%]]]
		whileTrue: [
			self replaceParameterEntityReference.
			streamReader skipSeparators].
]

{ #category : #accessing }
XMLDriverTokenizer >> streamReader [
	^ streamReader
]

{ #category : #accessing }
XMLDriverTokenizer >> tokenContext [
	^ context
]

{ #category : #accessing }
XMLDriverTokenizer >> tokenContextClass [
	self subclassResponsibility
]

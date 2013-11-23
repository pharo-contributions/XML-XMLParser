Class {
	#name : #HTMLTokenizer,
	#superclass : #XMLTokenizer,
	#instVars : [
		'nonHtmlCommentStarter',
		'nonHtmlElement'
	],
	#classVars : [
		'NameDelimiters',
		'NonHtmlSectionTags'
	],
	#category : #'XML-Parser-HTML'
}

{ #category : #'class initialization' }
HTMLTokenizer class >> initialize [
	"self initialize"

	super initialize.

	self
		initializeNameDelimiters;
		initializeNonHTMLSectionTags
]

{ #category : #'class initialization' }
HTMLTokenizer class >> initializeNameDelimiters [
	(NameDelimiters := CharacterSet new)
		addAll: Character separators;
		add: $>;
		add: $/;
		add: $<;
		add: $=;
		add: $";
		add: $';
		add: $;
]

{ #category : #'class initialization' }
HTMLTokenizer class >> initializeNonHTMLSectionTags [
	NonHtmlSectionTags := Set with: 'style' with: 'script'
]

{ #category : #testing }
HTMLTokenizer >> atNonHTMLSectionEndTag [
	(streamReader nextMatchAll: '</')
		ifFalse: [^ false].
	nonHtmlElement doWithIndex: [:each :i |
		(streamReader peek asLowercase == each)
			ifTrue: [streamReader next]
			ifFalse: [
				streamReader pushBack: '</', (nonHtmlElement copyFrom: 1to: i - 1).
				^ false]].
	streamReader pushBack: '</', nonHtmlElement.
	^ true.
]

{ #category : #tokenizing }
HTMLTokenizer >> expectNext: aCharacter [
	(streamReader peek == aCharacter)
		ifTrue: [streamReader next].
	^ aCharacter.
]

{ #category : #tokenizing }
HTMLTokenizer >> expectNextAll: aString [
	aString doWithIndex: [:each :i |
		each == streamReader peek
			ifTrue: [streamReader next]
			ifFalse: [
				self nextName.
				^ aString]].
	^ aString.
]

{ #category : #tokenizing }
HTMLTokenizer >> expectTerminator: aCharacter [
	streamReader upTo: aCharacter
]

{ #category : #'tokenizing dtd' }
HTMLTokenizer >> nextAttributeType [
	| nextChar type |

	type := streamWriter writeWith: [:writeStream |
		[self skipSeparatorsReplacingParameterEntities.
		(nextChar := streamReader peek) isNil
			or: [(String with: $# with: $> with: $' with:  $") includes: nextChar]]
			whileFalse: [writeStream nextPut: streamReader next].
		writeStream contents].
	^ self removeTrailingSpacesFrom: type.
]

{ #category : #tokenizing }
HTMLTokenizer >> nextAttributeValue [
	| quote value |

	streamReader peek == $&
		ifTrue: [^ self nextUnparsedEntityReference].

	self atQuote
		ifFalse: [^ self nextName].
	quote := streamReader next.
	context resetAfter: [
		context enterLiteralValue.
		value := self
			nextDelimitedBy: quote and: nil
			entityChar: $&
			normalizeWhitespace: false
			ignorableWhitespace: false].
	self expectNext: quote.

	^ value.
]

{ #category : #tokenizing }
HTMLTokenizer >> nextContentToken [
	| pcData |

	pcData :=
		context isInNonHTMLSection
			ifTrue: [self nextNonHTMLSectionToken]
			ifFalse: [self nextPCDataToken].
	pcData
		ifNotEmpty: [driver handlePCData: pcData]
		ifEmpty: [
			streamReader peek == $<
				ifTrue: [
					streamReader next.
					(streamReader atEnd not and: [streamReader peek isSeparator])
						ifTrue: [
							streamReader pushBack: '&lt;'.
							driver handlePCData: pcData.
							^ self].
			self nextContentMarkupToken]]
]

{ #category : #'tokenizing dtd' }
HTMLTokenizer >> nextElementDeclaration [
	| name contentModel |

	self expectNextAll: 'LEMENT'.
	self skipSeparatorsReplacingParameterEntities.
	name := self nextName.
	self skipSeparatorsReplacingParameterEntities.
	contentModel := self removeTrailingSpacesFrom: (streamReader upTo: $>).

	driver
		handleElementDeclaration: name
		contentModel: contentModel
]

{ #category : #tokenizing }
HTMLTokenizer >> nextEndTag [
	| tagName |
	streamReader next.
	tagName := self nextName asLowercase.
	(tagName = nonHtmlElement)
		ifTrue: [
			nonHtmlElement := nil.
			context enterContent].
	streamReader skipSeparators.
	self expectTerminator: $>.
	driver handleEndTag: tagName
]

{ #category : #tokenizing }
HTMLTokenizer >> nextName [
	| nextChar |

	^ streamWriter writeWith: [:writeStream |
		 [(nextChar := streamReader peek) isNil
			or: [(NameDelimiters includes: nextChar)
				or: [(context isInDoctype and: [nextChar == $[])
					or: [context isInInternalSubset and: [nextChar == $]]]]]]
			whileFalse: [writeStream nextPut: streamReader next].
		writeStream contents].
]

{ #category : #'tokenizing dtd' }
HTMLTokenizer >> nextNmtoken [
	^ self nextName
]

{ #category : #tokenizing }
HTMLTokenizer >> nextNonHTMLSectionToken [
	| nextChar quote |

	^ streamWriter writeWith: [:writeStream |
		[streamReader atEnd
			or: [self atNonHTMLSectionEndTag]]
			whileFalse: [
				nextChar := streamReader next.
				context isInNonHTMLComment
					ifTrue: [
						(nonHtmlCommentStarter = '//' and: [nextChar == Character lf])
							ifTrue: [context enterNonHTMLSection].
						(nonHtmlCommentStarter = '/*'
							and: [nextChar == $*
								and: [streamReader peek == $/]])
							ifTrue: [
								writeStream nextPut: nextChar.
								nextChar := streamReader next.
								context enterNonHTMLSection]]
					ifFalse: [
						(nextChar == $" or: [nextChar == $'])
							ifTrue: [
								writeStream
									nextPut: (quote := nextChar);
									nextPutAll: (streamReader upTo: quote)]
							ifFalse: [
								((nextChar == $/)
									and: [streamReader peek == $*
										or: [streamReader peek == $/]])
									ifTrue: [
										context enterNonHTMLComment.
										writeStream nextPut: $/.
										nextChar := streamReader next.
										nonHtmlCommentStarter := '/'  copyWith: nextChar]]].
				writeStream nextPut: nextChar].
		writeStream contents].
	
]

{ #category : #tokenizing }
HTMLTokenizer >> nextPCDataToken [
	| isIgnorableWhitespace nextChar pcData |

	isIgnorableWhitespace := true.
	pcData := ''.
	streamWriter writeWith: [:writeStream |
		[(nextChar := streamReader peek) isNil
			or: [nextChar == $<]]
			whileFalse: [
				streamReader next.
				nextChar == $&
					ifTrue: [
						(streamReader atEnd not and: [streamReader peek isSeparator])
							ifTrue: [
								writeStream nextPut: $&.
								isIgnorableWhitespace := false]
							ifFalse: [
								streamReader peek == $#
									ifTrue: [
										writeStream nextPut: self nextDecodedCharReference.
										isIgnorableWhitespace := false]
									ifFalse: [
										(nextChar := self nextGeneralEntityReference)
											ifNotNil: [writeStream nextPut: nextChar]]]]
					ifFalse: [
						nextChar isSeparator
							ifFalse: [isIgnorableWhitespace := false].
						writeStream nextPut: nextChar]].
		isIgnorableWhitespace
			ifTrue: [
				writeStream position > 0
					ifTrue: [driver handleWhitespace: writeStream contents]]
			ifFalse: [pcData :=  writeStream contents]].
	^ pcData.
]

{ #category : #tokenizing }
HTMLTokenizer >> nextPrologToken [
	streamReader skipSeparators.
	streamReader peek == $<
		ifTrue: [super nextPrologToken]
		ifFalse: [
			context enterContent.
			self nextContentToken].
]

{ #category : #'tokenizing dtd' }
HTMLTokenizer >> nextPubidLiteral [
	^ self nextQuotedValue
]

{ #category : #tokenizing }
HTMLTokenizer >> nextQuotedValue [
	^ self atQuote
		ifTrue: [streamReader upTo: streamReader next]
		ifFalse: [self nextName]
]

{ #category : #'tokenizing dtd' }
HTMLTokenizer >> nextSubsetMarkupToken [
	streamReader peek == $<
		ifFalse: [^ self skipNonDeclarationOrEntity].
	super nextSubsetMarkupToken.
]

{ #category : #'tokenizing dtd' }
HTMLTokenizer >> nextSystemLiteralRequired: aBoolean [
	^ self nextQuotedValue
]

{ #category : #tokenizing }
HTMLTokenizer >> nextTag [
	| tagName attributes attributeName  nextChar |

	(streamReader peek = $/)
		ifTrue: [^ self nextEndTag].
	tagName := self nextName asLowercase.

	attributes := OrderPreservingDictionary new: 10 withDefaultValue: ''.
	[streamReader skipSeparators.
	((nextChar := streamReader peek) isNil
		or: [nextChar == $>
			or: [nextChar == $/
				or: [(attributeName := self nextName asLowercase) isEmpty]]])]
		whileFalse: [
			streamReader skipSeparators.
			self expectNext: $=.
			streamReader skipSeparators.
			attributes at: attributeName put: self nextAttributeValue].

	driver
		handleStartTag: tagName
		attributes: attributes
		namespaces: nil.
	streamReader peek == $/
		ifTrue: [
			streamReader next.
			driver handleEndTag: tagName]
		ifFalse: [
			(NonHtmlSectionTags includes: tagName)
				ifTrue: [
					nonHtmlElement := tagName.
					context enterNonHTMLSection]].
	self expectTerminator: $>.
]

{ #category : #tokenizing }
HTMLTokenizer >> nextValue [
	^ self atQuote
		ifTrue: [streamReader upTo: streamReader next]
		ifFalse: [self nextName]
]

{ #category : #'tokenizing dtd' }
HTMLTokenizer >> skipNonDeclarationOrEntity [
	[streamReader atEnd
		or: [(streamReader peek == $<)
			or: [(streamReader peek == $%)
				or: [context isInInternalSubset and: [streamReader peek ==$]]]]]]
		whileFalse: [streamReader next].
	
]

{ #category : #accessing }
HTMLTokenizer >> tokenContextClass [
	^ HTMLTokenContext
]

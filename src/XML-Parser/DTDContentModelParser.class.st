Class {
	#name : #DTDContentModelParser,
	#superclass : #Object,
	#instVars : [
		'contentModel',
		'name',
		'contentModelStream',
		'operatorStack',
		'nfaBuilder'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDContentModelParser class >> name: aName contentModel: aContentModel [
	^ self new
		setName: aName
		contentModel: aContentModel
]

{ #category : #parsing }
DTDContentModelParser >> addElementMatchingState: aName [
	aName = '#PCDATA'
		ifTrue: [self errorUnexpectedPCData].
	nfaBuilder pushMatcher: (DTDElementMatcher element: aName).
]

{ #category : #parsing }
DTDContentModelParser >> applyBinaryOperatorOnStack [
	operatorStack last == $|
		ifTrue: [nfaBuilder applyAlternation]
		ifFalse: [nfaBuilder applyConcatenation].
	operatorStack removeLast.
]

{ #category : #parsing }
DTDContentModelParser >> applyUnaryOperator: aCharacter [
	aCharacter == $+
		ifTrue: [nfaBuilder applyPlus]
		ifFalse: [
			aCharacter == $*
				ifTrue: [nfaBuilder applyStar]
				ifFalse: [nfaBuilder applyOptional]].
]

{ #category : #errors }
DTDContentModelParser >> errorMismatchedParens [
	XMLValidationException signal: 'Mismatched parentheses in content model'
]

{ #category : #errors }
DTDContentModelParser >> errorUnexpectedPCData [
	XMLValidationException signal: 'Unexpected #PCDATA in content model'
]

{ #category : #testing }
DTDContentModelParser >> hasOperatorOnStack [
	^ operatorStack notEmpty
		and: [operatorStack last == $| or: [operatorStack last == $,]]
]

{ #category : #testing }
DTDContentModelParser >> isBinaryOperator: aCharacter [
	^ aCharacter == $| or: [aCharacter == $,]
]

{ #category : #testing }
DTDContentModelParser >> isBinaryOperator: aFirstOperator higherPrecedenceThan: aSecondOperator [
	^ aFirstOperator == $, and: [aSecondOperator == $|]
]

{ #category : #testing }
DTDContentModelParser >> isOperatorOrParen: aCharacter [
	^ '|,?*+()' includes: aCharacter
]

{ #category : #parsing }
DTDContentModelParser >> parse [
	"the tokenizer removes all spaces from the content model"
	(contentModel isEmpty or: [contentModel = 'ANY'])
		ifTrue: [^ XMLAnyElementValidator name: name].
	(contentModel = 'EMPTY')
		ifTrue: [^ XMLEmptyElementValidator name: name].

	(contentModel beginsWith: '(#PCDATA')
		ifTrue: [^ self parseMixedContentModel]
		ifFalse: [^ self parseDFAContentModel].
]

{ #category : #parsing }
DTDContentModelParser >> parseDFAContentModel [
	| nfa nextChar |

	contentModelStream := contentModel readStream.
	nfaBuilder := XMLNFABuilder new.
	operatorStack := OrderedCollection new.
	[contentModelStream atEnd]
		whileFalse: [
			(self isOperatorOrParen: contentModelStream peek)
				ifTrue: [ 
					nextChar := contentModelStream next.
					(self isBinaryOperator: nextChar)
						ifTrue: [
							self hasOperatorOnStack
								ifTrue: [
									(self isBinaryOperator: nextChar
										higherPrecedenceThan: operatorStack last)
									ifFalse: [self applyBinaryOperatorOnStack]].
							operatorStack addLast: nextChar]
					ifFalse: [
						nextChar == $)
							ifTrue: [self popParenthesizedOperators]
							ifFalse: [
								nextChar == $(
									ifTrue: [operatorStack addLast: nextChar]
									ifFalse: [self applyUnaryOperator: nextChar]]]]
				ifFalse: [self pushElementMatcher]].
	self popRemainingOperators.

	nfa := nfaBuilder buildNFAFromFragments.
	^ XMLDFAElementValidator
		name: name
		dfa: (XMLDFABuilder nfa: nfa) buildDFA.
]

{ #category : #parsing }
DTDContentModelParser >> parseMixedContentModel [
	| list allowedElements  |

	list :=
		(contentModel endsWith: '*')
			ifTrue: [contentModel allButLast]
			ifFalse: [contentModel].
	list do: [:each |
		(',?*+' includes: each)
			ifTrue: [
				XMLValidationException signal:
					'Cannot use ', each asString, ' in mixed content declaration']].

	allowedElements := (DTDEnumerationListParser on: list) parse.
	allowedElements remove: '#PCDATA'.

	^ XMLMixedElementValidator
		name: name
		elements: allowedElements.
]

{ #category : #parsing }
DTDContentModelParser >> popParenthesizedOperators [
	[operatorStack notEmpty]
		whileTrue: [
			operatorStack last == $(
				ifTrue: [
					operatorStack removeLast.
					^ self]
				ifFalse: [self applyBinaryOperatorOnStack]].
	self errorMismatchedParens.
]

{ #category : #parsing }
DTDContentModelParser >> popRemainingOperators [
	[operatorStack notEmpty]
		whileTrue: [
			operatorStack last == $(
				ifTrue: [self errorMismatchedParens].
			self applyBinaryOperatorOnStack]
]

{ #category : #parsing }
DTDContentModelParser >> pushElementMatcher [
	| element nextChar writeStream |

	writeStream := (String new: 32) writeStream.
	[contentModelStream atEnd
		or: [(nextChar := contentModelStream peek) isSeparator
			or: [self isOperatorOrParen: nextChar]]]
		whileFalse: [writeStream nextPut: contentModelStream next].
	contentModelStream skipSeparators.

	element := writeStream contents.
	element = '#PCDATA'
		ifTrue: [self errorUnexpectedPCData].

	nfaBuilder pushMatcher: (DTDElementMatcher element: element).
]

{ #category : #'instance creation' }
DTDContentModelParser >> setName: aName contentModel: aContentModel [
	name := aName.
	contentModel := aContentModel.
]

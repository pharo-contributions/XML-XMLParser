"
This class parses a DTD content model from an element declaration and produces a validator object from it.
"
Class {
	#name : #DTDContentModelParser,
	#superclass : #Object,
	#instVars : [
		'name',
		'contentModel',
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
DTDContentModelParser >> applyBinaryOperatorOnStack [
	nfaBuilder fragmentStack size >= 2
		ifFalse: [self errorMissingOperand].

	operatorStack last == $|
		ifTrue: [nfaBuilder applyAlternation]
		ifFalse: [nfaBuilder applyConcatenation].
	operatorStack removeLast.
]

{ #category : #parsing }
DTDContentModelParser >> applyUnaryOperator: aCharacter [
	nfaBuilder fragmentStack
		ifEmpty: [self errorMissingOperand].

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
DTDContentModelParser >> errorMissingOperand [
	XMLValidationException signal: 'Missing element name in content model'
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
	| mayContainElements mixedContentList allowedElements  |

	mayContainElements := contentModel last == $*.
	mixedContentList :=
		mayContainElements
			ifTrue: [contentModel allButLast]
			ifFalse: [contentModel].

	allowedElements := (DTDMixedContentListParser on: mixedContentList) parse.
	allowedElements remove: '#PCDATA'.
	(mayContainElements or: [allowedElements isEmpty])
		ifFalse: [XMLValidationException signal: 'Missing * after mixed content list with elements'].

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
			self applyBinaryOperatorOnStack].

	nfaBuilder fragmentStack size = 1
		ifFalse: [self errorMissingOperand].
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
		ifTrue: [XMLValidationException signal: 'Unexpected #PCDATA in content model'].

	nfaBuilder pushMatcher: (DTDElementMatcher element: element).
]

{ #category : #'instance creation' }
DTDContentModelParser >> setName: aName contentModel: aContentModel [
	name := aName.
	contentModel := aContentModel.
]

"
This class parses a content model using postfix conversion and an NFABuilder to build a NFA, which it converts to a DFA.
"
Class {
	#name : #DTDDFAContentModelParser,
	#superclass : #DTDContentModelParser,
	#instVars : [
		'contentModelStream',
		'operatorStack',
		'nfaBuilder',
		'nameStream'
	],
	#classVars : [
		'SpecialCharacters'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initialize [
	"self initialize"

	super initialize.

	(SpecialCharacters := CharacterSet new) addAll: '|,?*+()'
]

{ #category : #evaluation }
DTDDFAContentModelParser >> applyBinaryOperatorOnStack [
	nfaBuilder totalFragments > 1
		ifFalse: [self errorMissingOperand].

	operatorStack last == $|
		ifTrue: [nfaBuilder applyBranch]
		ifFalse: [nfaBuilder applyConcatenation].
	operatorStack removeLast.
]

{ #category : #evaluation }
DTDDFAContentModelParser >> applyUnaryOperator: aCharacter [
	nfaBuilder hasFragments
		ifFalse: [self errorMissingOperand].

	aCharacter == $+
		ifTrue: [nfaBuilder applyPlus]
		ifFalse: [
			aCharacter == $*
				ifTrue: [nfaBuilder applyStar]
				ifFalse: [nfaBuilder applyOptional]].
]

{ #category : #errors }
DTDDFAContentModelParser >> errorMismatchedParens [
	XMLValidationException signal: 'Mismatched parentheses in content model'
]

{ #category : #errors }
DTDDFAContentModelParser >> errorMissingOperand [
	XMLValidationException signal: 'Missing element name in content model'
]

{ #category : #testing }
DTDDFAContentModelParser >> hasOperatorOnStack [
	^ operatorStack notEmpty
		and: [self isBinaryOperator: operatorStack last]
]

{ #category : #testing }
DTDDFAContentModelParser >> isBinaryOperator: aCharacter [
	^ aCharacter == $| or: [aCharacter == $,]
]

{ #category : #testing }
DTDDFAContentModelParser >> isBinaryOperator: aFirstOperator higherPrecedenceThan: aSecondOperator [
	^ aFirstOperator == $, and: [aSecondOperator == $|]
]

{ #category : #testing }
DTDDFAContentModelParser >> isOperatorOrParen: aCharacter [
	^ SpecialCharacters includes: aCharacter
]

{ #category : #parsing }
DTDDFAContentModelParser >> parse [
	contentModelStream := contentModel readStream.
	nameStream := WriteStream on: (String new: 16).
	nfaBuilder := XMLNFABuilder new.
	operatorStack := OrderedCollection new.

	[contentModelStream atEnd]
		whileFalse: [
			(self isOperatorOrParen: contentModelStream peek)
				ifTrue: [self parseOperatorOrParen]
				ifFalse: [self parseElementName]].
	self popRemainingOperators.

	^ XMLDFAElementValidator
		element: element
		dfa: nfaBuilder firstStateOfAcceptingNFA asDFAState.
]

{ #category : #parsing }
DTDDFAContentModelParser >> parseElementName [
	| matcher nextChar |

	nameStream reset.
	[contentModelStream atEnd
		or: [(nextChar := contentModelStream peek) isSeparator
			or: [self isOperatorOrParen: nextChar]]]
		whileFalse: [nameStream nextPut: contentModelStream next].
	contentModelStream skipSeparators.

	matcher := nameStream contents.
	matcher = '#PCDATA'
		ifTrue: [XMLValidationException signal: 'Unexpected #PCDATA in content model'].

	nfaBuilder pushMatcher: matcher.
]

{ #category : #parsing }
DTDDFAContentModelParser >> parseOperatorOrParen [ 
	| nextChar |

	nextChar := contentModelStream next.
	nextChar == $)
		ifTrue: [^ self popParenthesizedOperators].
	nextChar == $(
		ifTrue: [^ self startParenthesizedOperators].

	(self isBinaryOperator: nextChar)
		ifTrue: [
			self hasOperatorOnStack
				ifTrue: [
					(self isBinaryOperator: nextChar
						higherPrecedenceThan: operatorStack last)
						ifFalse: [self applyBinaryOperatorOnStack]].
			operatorStack addLast: nextChar]
		ifFalse: [self applyUnaryOperator: nextChar].
]

{ #category : #evaluation }
DTDDFAContentModelParser >> popParenthesizedOperators [
	[operatorStack notEmpty]
		whileTrue: [
			operatorStack last == $(
				ifTrue: [
					operatorStack removeLast.
					^ self]
				ifFalse: [self applyBinaryOperatorOnStack]].

	self errorMismatchedParens.
]

{ #category : #evaluation }
DTDDFAContentModelParser >> popRemainingOperators [
	[operatorStack notEmpty]
		whileTrue: [
			operatorStack last == $(
				ifTrue: [self errorMismatchedParens].
			self applyBinaryOperatorOnStack].

	nfaBuilder totalFragments = 1
		ifFalse: [self errorMissingOperand].
]

{ #category : #evaluation }
DTDDFAContentModelParser >> startParenthesizedOperators [
	operatorStack addLast: $(
]

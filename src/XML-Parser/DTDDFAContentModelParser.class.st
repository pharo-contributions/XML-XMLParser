Class {
	#name : #DTDDFAContentModelParser,
	#superclass : #DTDContentModelParser,
	#instVars : [
		'contentModelStream',
		'operatorStack',
		'nfaBuilder'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #parsing }
DTDDFAContentModelParser >> applyBinaryOperatorOnStack [
	nfaBuilder totalFragments > 1
		ifFalse: [self errorMissingOperand].

	operatorStack last == $|
		ifTrue: [nfaBuilder applyAlternation]
		ifFalse: [nfaBuilder applyConcatenation].
	operatorStack removeLast.
]

{ #category : #parsing }
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
	^ '|,?*+()' includes: aCharacter
]

{ #category : #parsing }
DTDDFAContentModelParser >> parse [
	| nextChar |

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

	^ XMLDFAElementValidator
		element: element
		dfa: nfaBuilder buildNFAFromFragments asDFA.
]

{ #category : #parsing }
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

{ #category : #parsing }
DTDDFAContentModelParser >> popRemainingOperators [
	[operatorStack notEmpty]
		whileTrue: [
			operatorStack last == $(
				ifTrue: [self errorMismatchedParens].
			self applyBinaryOperatorOnStack].

	nfaBuilder totalFragments = 1
		ifFalse: [self errorMissingOperand].
]

{ #category : #parsing }
DTDDFAContentModelParser >> pushElementMatcher [
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

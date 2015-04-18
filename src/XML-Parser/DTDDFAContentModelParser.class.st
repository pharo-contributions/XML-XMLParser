"
This class parses a content model using postfix conversion and an NFABuilder to build a NFA before converting it to a DFA.
"
Class {
	#name : #DTDDFAContentModelParser,
	#superclass : #DTDContentModelParser,
	#instVars : [
		'operatorStack',
		'nfaBuilder'
	],
	#classVars : [
		'OperatorApplicators',
		'SpecialCharacterParsers'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initialize [
	"self initialize"

	self
		initializeSpecialCharacterParsers;
		initializeOperatorApplicators
]

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initializeOperatorApplicators [
	"use Array for faster lookup"
	(OperatorApplicators := Array new: 256)
		at: $, asciiValue put: #applyConcatenation;
		at: $| asciiValue put: #applyBranch;
		at: $? asciiValue put: #applyOptional;
		at: $* asciiValue put: #applyStar;
		at: $+ asciiValue put: #applyPlus
]

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initializeSpecialCharacterParsers [
	"use Array for faster lookup"
	(SpecialCharacterParsers := Array new: 256)
		at: $( asciiValue put: #parseParen:;
		at: $) asciiValue put: #parseParen:;
		at: $, asciiValue put: #parseBinaryOperator:;
		at: $| asciiValue put: #parseBinaryOperator:;
		at: $? asciiValue put: #parseUnaryOperator:;
		at: $* asciiValue put: #parseUnaryOperator:;
		at: $+ asciiValue put: #parseUnaryOperator:
]

{ #category : #evaluation }
DTDDFAContentModelParser >> applyBinaryOperatorOnStack [
	nfaBuilder totalFragments > 1
		ifFalse: [self errorMissingOperand].

	self applyOperator: operatorStack removeLast.
]

{ #category : #evaluation }
DTDDFAContentModelParser >> applyOperator: aCharacter [
	nfaBuilder perform: (OperatorApplicators at: aCharacter asciiValue)
]

{ #category : #private }
DTDDFAContentModelParser >> errorMismatchedParens [
	XMLValidationException signal: 'Mismatched parentheses in content model'
]

{ #category : #private }
DTDDFAContentModelParser >> errorMissingOperand [
	XMLValidationException signal: 'Missing element name in content model'
]

{ #category : #private }
DTDDFAContentModelParser >> hasOperatorOnStack [
	^ (operatorStack isEmpty or: [operatorStack last == $(]) not
]

{ #category : #private }
DTDDFAContentModelParser >> isBinaryOperator: aFirstOperator higherPrecedenceThan: aSecondOperator [
	^ aFirstOperator == $, and: [aSecondOperator == $|]
]

{ #category : #private }
DTDDFAContentModelParser >> isSpecialCharacter: aCharacter [
	^ (self parserForSpecialCharacter: aCharacter) notNil
]

{ #category : #parsing }
DTDDFAContentModelParser >> parse [
	"the tokenizer removes all spaces from the content model"
	| nameStart |

	operatorStack := OrderedCollection new.
	nfaBuilder := XMLNFABuilder new.
	1 to: contentModel size do: [:i |
		(self parserForSpecialCharacter: (contentModel at: i))
				ifNil: [
					nameStart
						ifNil: [nameStart := i]]
				ifNotNil: [:selector |
					nameStart
						ifNotNil: [
							nfaBuilder pushMatcher:
								(contentModel copyFrom: nameStart to: i - 1).
							nameStart := nil].
					self
						perform: selector
						with: (contentModel at: i)]].
	self popRemainingOperators.

	^ XMLDFAElementValidator
		element: element
		dfa: nfaBuilder acceptingNFAFirstState asDFAState.
]

{ #category : #private }
DTDDFAContentModelParser >> parseBinaryOperator: aCharacter [
	self hasOperatorOnStack
		ifTrue: [
			(self
				isBinaryOperator: aCharacter
				higherPrecedenceThan: operatorStack last)
					ifFalse: [self applyBinaryOperatorOnStack]].

	operatorStack addLast: aCharacter.
]

{ #category : #private }
DTDDFAContentModelParser >> parseParen: aCharacter [
	aCharacter == $)
		ifTrue: [self popParenthesizedOperators]
		ifFalse: [operatorStack addLast: $(].
]

{ #category : #private }
DTDDFAContentModelParser >> parseUnaryOperator: aCharacter [
	nfaBuilder hasFragments
		ifFalse: [self errorMissingOperand].

	self applyOperator: aCharacter.
]

{ #category : #private }
DTDDFAContentModelParser >> parserForSpecialCharacter: aCharacter [
	| asciiValue |

	((asciiValue := aCharacter asciiValue) > 0
		and: [asciiValue <= SpecialCharacterParsers size])
			ifTrue: [^ SpecialCharacterParsers at: asciiValue]
			ifFalse: [^ nil]
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

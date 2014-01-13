"
This class parses a content model using postfix conversion and an NFABuilder to build a NFA before converting it to a DFA.
"
Class {
	#name : #DTDDFAContentModelParser,
	#superclass : #DTDContentModelParser,
	#instVars : [
		'contentModelStream',
		'nameStream',
		'operatorStack',
		'nfaBuilder'
	],
	#classVars : [
		'OperatorApplicators',
		'SpecialCharacterParsers',
		'SpecialCharacters'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initialize [
	"self initialize"

	super initialize.
	self
		initializeOperatorApplicators;
		initializeSpecialCharacterParsers;
		initializeSpecialCharacters.
]

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initializeOperatorApplicators [
	"use Array for faster lookup"
	(OperatorApplicators := Array new: 128)
		at: $, asciiValue put: #applyConcatenation;
		at: $| asciiValue put: #applyBranch;
		at: $? asciiValue put: #applyOptional;
		at: $* asciiValue put: #applyStar;
		at: $+ asciiValue put: #applyPlus
]

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initializeSpecialCharacterParsers [
	"use Array for faster lookup"
	(SpecialCharacterParsers := Array new: 128)
		at: $( asciiValue put: #parseParen:;
		at: $) asciiValue put: #parseParen:;
		at: $, asciiValue put: #parseBinaryOperator:;
		at: $| asciiValue put: #parseBinaryOperator:;
		at: $? asciiValue put: #parseUnaryOperator:;
		at: $* asciiValue put: #parseUnaryOperator:;
		at: $+ asciiValue put: #parseUnaryOperator:
]

{ #category : #'class initialization' }
DTDDFAContentModelParser class >> initializeSpecialCharacters [
	(SpecialCharacters := CharacterSet new)
		addAll: '(),|?*+'
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

{ #category : #testing }
DTDDFAContentModelParser >> hasOperatorOnStack [
	^ operatorStack notEmpty and: [operatorStack last ~~ $(]
]

{ #category : #testing }
DTDDFAContentModelParser >> isBinaryOperator: aFirstOperator higherPrecedenceThan: aSecondOperator [
	^ aFirstOperator == $, and: [aSecondOperator == $|]
]

{ #category : #parsing }
DTDDFAContentModelParser >> parse [
	contentModelStream := contentModel readStream.
	nameStream := WriteStream on: (String new: 16).
	operatorStack := OrderedCollection new.
	nfaBuilder := XMLNFABuilder new.

	[contentModelStream atEnd]
		whileFalse: [ 
			(self parserForSpecialCharacter: contentModelStream peek)
				ifNotNil: [:selector |
					self
						perform: selector
						with: contentModelStream next]
				ifNil: [self parseElementName]].
	self popRemainingOperators.

	^ XMLDFAElementValidator
		element: element
		dfa: nfaBuilder firstStateOfAcceptingNFA asDFAState.
]

{ #category : #parsing }
DTDDFAContentModelParser >> parseBinaryOperator: aCharacter [
	self hasOperatorOnStack
		ifTrue: [
			(self
				isBinaryOperator: aCharacter
				higherPrecedenceThan: operatorStack last)
					ifFalse: [self applyBinaryOperatorOnStack]].

	operatorStack addLast: aCharacter.
]

{ #category : #parsing }
DTDDFAContentModelParser >> parseElementName [
	| matcher |

	nameStream reset.
	[contentModelStream atEnd
		or: [SpecialCharacters includes: contentModelStream peek]]
		whileFalse: [nameStream nextPut: contentModelStream next].

	matcher := nameStream contents.
	matcher = '#PCDATA'
		ifTrue: [XMLValidationException signal: 'Unexpected #PCDATA in content model'].

	nfaBuilder pushMatcher: matcher.
]

{ #category : #parsing }
DTDDFAContentModelParser >> parseParen: aCharacter [
	aCharacter == $)
		ifTrue: [self popParenthesizedOperators]
		ifFalse: [operatorStack addLast: $(].
]

{ #category : #parsing }
DTDDFAContentModelParser >> parseUnaryOperator: aCharacter [
	nfaBuilder hasFragments
		ifFalse: [self errorMissingOperand].

	self applyOperator: aCharacter.
]

{ #category : #parsing }
DTDDFAContentModelParser >> parserForSpecialCharacter: aCharacter [
	| asciiValue |

	^ ((asciiValue := aCharacter asciiValue) > 0
		and: [asciiValue <= SpecialCharacterParsers size])
			ifTrue: [SpecialCharacterParsers at: asciiValue]
			ifFalse: [nil]
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

"
This class parses a content model using postfix conversion and an XMLNFABuilder to build an NFA before converting it to a lazy DFA (states are built when needed and cached) and returned as an element validator.

It assumes all spaces have been removed from the input and that it's been checked for well-formedness (meaning no missing names or misplaced operators/parentheses).
"
Class {
	#name : #DTDElementContentModelParser,
	#superclass : #DTDContentModelParser,
	#instVars : [
		'nfaBuilder',
		'binaryOperatorStack'
	],
	#classVars : [
		'OperatorApplicators',
		'SpecialCharacterParsers'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'class initialization' }
DTDElementContentModelParser class >> initialize [
	"self initialize"

	self
		initializeSpecialCharacterParsers;
		initializeOperatorApplicators
]

{ #category : #'class initialization' }
DTDElementContentModelParser class >> initializeOperatorApplicators [
	"use Array for faster lookup"
	(OperatorApplicators := Array new: 255)
		at: $, asciiValue put: #applyConcatenation;
		at: $| asciiValue put: #applyBranch;
		at: $? asciiValue put: #applyOptional;
		at: $* asciiValue put: #applyStar;
		at: $+ asciiValue put: #applyPlus
]

{ #category : #'class initialization' }
DTDElementContentModelParser class >> initializeSpecialCharacterParsers [
	"use Array for faster lookup"
	(SpecialCharacterParsers := Array new: 255)
		at: $( asciiValue put: #parseOpeningParenthesis:;
		at: $) asciiValue put: #parseClosingParenthesis:;
		at: $, asciiValue put: #parseBinaryOperator:;
		at: $| asciiValue put: #parseBinaryOperator:;
		at: $? asciiValue put: #parseUnaryOperator:;
		at: $* asciiValue put: #parseUnaryOperator:;
		at: $+ asciiValue put: #parseUnaryOperator:
]

{ #category : #private }
DTDElementContentModelParser >> applyBinaryOperatorOnStack [
	self applyOperator: binaryOperatorStack removeLast
]

{ #category : #private }
DTDElementContentModelParser >> applyOperator: aCharacter [
	nfaBuilder perform: (OperatorApplicators at: aCharacter asciiValue)
]

{ #category : #private }
DTDElementContentModelParser >> hasBinaryOperatorOnStack [
	^ (binaryOperatorStack isEmpty
		or: [binaryOperatorStack last == $(]) not
]

{ #category : #parsing }
DTDElementContentModelParser >> parse [
	"the tokenizer removes all spaces from the content model and checks
	it for well-formedness (meaning no missing names or misplaced
	operators/parentheses), which simplifies parsing"
	| nameStart |

	binaryOperatorStack := OrderedCollection new.
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
	self popRemainingBinaryOperators.

	^ XMLDFAElementContentElementValidator
		element: element
		dfa: nfaBuilder buildAcceptingNFAFromFragments asDFAState.
]

{ #category : #private }
DTDElementContentModelParser >> parseBinaryOperator: aCharacter [
	binaryOperatorStack addLast: aCharacter
]

{ #category : #private }
DTDElementContentModelParser >> parseClosingParenthesis: aCharacter [
	self popRemainingBinaryOperators.
	(binaryOperatorStack notEmpty
		and: [binaryOperatorStack last == $(])
		ifTrue: [binaryOperatorStack removeLast].
]

{ #category : #private }
DTDElementContentModelParser >> parseOpeningParenthesis: aCharacter [
	binaryOperatorStack addLast: $(
]

{ #category : #private }
DTDElementContentModelParser >> parseUnaryOperator: aCharacter [
	self applyOperator: aCharacter
]

{ #category : #private }
DTDElementContentModelParser >> parserForSpecialCharacter: aCharacter [
	| asciiValue |

	"avoid at:ifAbsent: for speed"
	((asciiValue := aCharacter asciiValue) > 0
		and: [asciiValue <= SpecialCharacterParsers size])
			ifTrue: [^ SpecialCharacterParsers at: asciiValue]
			ifFalse: [^ nil]
]

{ #category : #private }
DTDElementContentModelParser >> popRemainingBinaryOperators [
	[self hasBinaryOperatorOnStack]
		whileTrue: [self applyBinaryOperatorOnStack]
]

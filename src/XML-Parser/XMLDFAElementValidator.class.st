"
This class can use a DFA to validate element content.

"
Class {
	#name : #XMLDFAElementValidator,
	#superclass : #XMLElementValidator,
	#instVars : [
		'dfa',
		'currentState'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLDFAElementValidator class >> element: aName dfa: aDFA [
	^ self new
		setElement: aName
		dfa: aDFA
]

{ #category : #testing }
XMLDFAElementValidator >> atEnd [
	^ currentState isAccepting
]

{ #category : #accessing }
XMLDFAElementValidator >> currentState [
	^ currentState
]

{ #category : #accessing }
XMLDFAElementValidator >> dfa [
	^ dfa
]

{ #category : #private }
XMLDFAElementValidator >> errorNonDeterminismInContentModelAfter: aName [
	XMLValidationException
		formatSignal:
			'Content model for <{1}> becomes non-deterministic after <{2}>. ',
			'Rewrite it deterministically; for example "(a,(b|c))" instead ',
			'of "((a,b)|(a,c))"'
		with: self element
		with: aName
]

{ #category : #initialization }
XMLDFAElementValidator >> setElement: aName dfa: aDFA [
	element := aName.
	dfa := aDFA.
	currentState := aDFA.
]

{ #category : #validating }
XMLDFAElementValidator >> validatePCData: aString [
	self errorUnexpectedPCData: aString
]

{ #category : #validating }
XMLDFAElementValidator >> validateStartTag: aName [
	currentState :=
		currentState
			nextDFAStateMatching: aName
			ifNone: [self errorUnexpectedElement: aName].
	currentState hasNonDeterminism
		ifTrue: [self errorNonDeterminismInContentModelAfter: aName].
]

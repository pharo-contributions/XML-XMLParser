"
This class is a DFA state made by grouping one or more NFA states.
"
Class {
	#name : #XMLDFAState,
	#superclass : #Object,
	#instVars : [
		'nfaStates',
		'transitions',
		'dfaStateCache'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLDFAState class >> nfaStates: anNfaStateSet [
	^ self
		nfaStates: anNfaStateSet
		dfaStateCache: nil
]

{ #category : #'instance creation' }
XMLDFAState class >> nfaStates: anNfaStateSet dfaStateCache: aDfaStateCache [
	^ self new
		setNFAStates: anNfaStateSet
		dfaStateCache: aDfaStateCache
]

{ #category : #enumerating }
XMLDFAState >> detectNextStateMatching: aMatcher [
	^ self detectNextStateMatching: aMatcher ifNone: [nil]
]

{ #category : #enumerating }
XMLDFAState >> detectNextStateMatching: aMatcher ifNone: aNoneBlock [
	^ (self transitions
		at: aMatcher
		ifAbsentPut: [self dfaStateMatching: aMatcher])
			ifNil: [aNoneBlock value]
]

{ #category : #accessing }
XMLDFAState >> dfaStateMatching: aMatcher [
	| matchingNfaStates |

	matchingNfaStates := XMLNFAStateSet new.
	nfaStates do: [:state |
		(state matches: aMatcher)
			ifTrue: [state nextState addTo: matchingNfaStates]].

	^ matchingNfaStates
		ifNotEmpty: [dfaStateCache dfaStateFor: matchingNfaStates]
		ifEmpty: [nil].
]

{ #category : #testing }
XMLDFAState >> isAccepting [
	^ nfaStates isAccepting
]

{ #category : #accessing }
XMLDFAState >> nfaStates [
	^ nfaStates
]

{ #category : #initialization }
XMLDFAState >> setNFAStates: anNfaStateSet dfaStateCache: aDfaStateCache [
	nfaStates := anNfaStateSet.
	dfaStateCache := (aDfaStateCache ifNil: [XMLDFAStateCache firstState: self]).
]

{ #category : #accessing }
XMLDFAState >> transitions [
	^ transitions ifNil: [transitions := Dictionary new]
]

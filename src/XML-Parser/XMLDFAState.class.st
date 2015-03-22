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
XMLDFAState class >> nfaStates: anNFAStateSet [
	^ self
		nfaStates: anNFAStateSet
		dfaStateCache: nil
]

{ #category : #'instance creation' }
XMLDFAState class >> nfaStates: anNFAStateSet dfaStateCache: aDFAStateCache [
	^ self new
		setNFAStates: anNFAStateSet
		dfaStateCache: aDFAStateCache
]

{ #category : #enumerating }
XMLDFAState >> detectNextStateMatching: aMatcher [
	^ self detectNextStateMatching: aMatcher ifNone: [nil]
]

{ #category : #enumerating }
XMLDFAState >> detectNextStateMatching: aMatcher ifNone: aBlock [
	^ (self transitions
		at: aMatcher
		ifAbsentPut: [self dfaStateMatching: aMatcher])
			ifNil: [aBlock value]
]

{ #category : #accessing }
XMLDFAState >> dfaStateMatching: aMatcher [
	| matchingNfaStates |

	matchingNfaStates := XMLNFAStateSet new.
	nfaStates do: [:state |
		(state matches: aMatcher)
			ifTrue: [state nextState addTo: matchingNfaStates]].
	matchingNfaStates isEmpty
		ifTrue: [^ nil].
	^ dfaStateCache dfaStateFor: matchingNfaStates.
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
XMLDFAState >> setNFAStates: anNFAStateSet dfaStateCache: aDFAStateCache [
	nfaStates := anNFAStateSet.
	dfaStateCache := (aDFAStateCache ifNil: [XMLDFAStateCache firstState: self]).
]

{ #category : #accessing }
XMLDFAState >> transitions [
	^ transitions ifNil: [transitions := Dictionary new]
]

"
This class is a DFA state made by grouping one or more NFA states.
"
Class {
	#name : #XMLDFAState,
	#superclass : #Object,
	#instVars : [
		'nfaStates',
		'dfaStateCache',
		'dfaStateTransitions'
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

{ #category : #private }
XMLDFAState >> addDFAStateTransitionMatching: aMatcher [
	self dfaStateTransitions size >= self maxDFAStateTransitions
		ifTrue: [self removeDFAStateTransitions].
	^ self dfaStateTransitions
		at: aMatcher
		put: (self dfaStateMatching: aMatcher).
]

{ #category : #enumerating }
XMLDFAState >> detectNextStateMatching: aMatcher [
	^ self
		detectNextStateMatching: aMatcher
		ifNone: nil
]

{ #category : #enumerating }
XMLDFAState >> detectNextStateMatching: aMatcher ifNone: aBlock [
	^ (self dfaStateTransitions
		at: aMatcher
		ifAbsent: [self addDFAStateTransitionMatching: aMatcher])
		ifNil: [aBlock value]
]

{ #category : #accessing }
XMLDFAState >> dfaStateCache [
	^ dfaStateCache
]

{ #category : #accessing }
XMLDFAState >> dfaStateMatching: aMatcher [
	| matchingNFAStates |

	matchingNFAStates := XMLNFAStateSet new.
	nfaStates do: [:state |
		(state matches: aMatcher)
			ifTrue: [state nextState addTo: matchingNFAStates]].
	matchingNFAStates isEmpty
		ifTrue: [^ nil]
		ifFalse: [^ dfaStateCache cachedDFAStateFor: matchingNFAStates].
]

{ #category : #private }
XMLDFAState >> dfaStateTransitions [
	^ dfaStateTransitions ifNil: [dfaStateTransitions := Dictionary new]
]

{ #category : #testing }
XMLDFAState >> isAccepting [
	^ nfaStates isAccepting
]

{ #category : #private }
XMLDFAState >> maxDFAStateTransitions [
	^ 64
]

{ #category : #accessing }
XMLDFAState >> nfaStates [
	^ nfaStates
]

{ #category : #printing }
XMLDFAState >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self nfaStates;
		nextPut: $).
]

{ #category : #private }
XMLDFAState >> removeDFAStateTransitions [
	dfaStateTransitions := nil
]

{ #category : #initialization }
XMLDFAState >> setNFAStates: anNFAStateSet dfaStateCache: aDFAStateCache [
	nfaStates := anNFAStateSet.
	dfaStateCache := (aDFAStateCache ifNil: [XMLDFAStateCache firstDFAState: self]).
]

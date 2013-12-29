"
This class is a DFA state made by grouping one or more NFA states.
"
Class {
	#name : #XMLDFAState,
	#superclass : #XMLFAState,
	#instVars : [
		'nfaStates',
		'cachedDfaStates',
		'transitions'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLDFAState class >> nfaStates: anNfaStateSet [
	^ self
		nfaStates: anNfaStateSet
		cachedDFAStates: Dictionary new
]

{ #category : #'instance creation' }
XMLDFAState class >> nfaStates: anNfaStateSet cachedDFAStates: aDfaStateCache [
	^ self new
		setNFAStates: anNfaStateSet
		cachedDFAStates: aDfaStateCache
]

{ #category : #private }
XMLDFAState >> addToCache [
	cachedDfaStates
		at: nfaStates
		ifAbsentPut: [self]
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
	matchingNfaStates
		ifEmpty: [ ^ nil].

	^ cachedDfaStates
		at: matchingNfaStates
		ifAbsent: [
			self class
				nfaStates: matchingNfaStates
				cachedDFAStates: cachedDfaStates].
]

{ #category : #testing }
XMLDFAState >> isAccepting [
	^ nfaStates isAccepting
]

{ #category : #initialization }
XMLDFAState >> setNFAStates: anNfaStateSet cachedDFAStates: aDfaStateCache [
	nfaStates := anNfaStateSet.
	cachedDfaStates := aDfaStateCache.

	self addToCache.
]

{ #category : #accessing }
XMLDFAState >> transitions [
	^ transitions ifNil: [transitions := Dictionary new]
]

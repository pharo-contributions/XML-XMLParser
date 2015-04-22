"
This class uses a dictionary with NFAStateSet keys to cache DFA states. (Does not use the regular XML key/value  cache for performance)
"
Class {
	#name : #XMLDFAStateCache,
	#superclass : #Object,
	#instVars : [
		'firstDFAState',
		'cachedDFAStates'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLDFAStateCache class >> firstDFAState: aDFAState [
	^ self new setFirstDFAState: aDFAState
]

{ #category : #private }
XMLDFAStateCache >> addDFAState: aDFAState [
	cachedDFAStates size >= self maxCachedDFAStates
		ifTrue: [self removeDFAStates].
	^ cachedDFAStates
		at: aDFAState nfaStates
		put: aDFAState.
]

{ #category : #accessing }
XMLDFAStateCache >> cachedDFAStateFor: anNFAStateSet [
	^ cachedDFAStates
		at: anNFAStateSet
		ifAbsent: [self addDFAState: (anNFAStateSet asDFAStateWithStateCache: self)]
]

{ #category : #private }
XMLDFAStateCache >> cachedDFAStates [
	^ cachedDFAStates
]

{ #category : #accessing }
XMLDFAStateCache >> firstDFAState [
	^ firstDFAState
]

{ #category : #private }
XMLDFAStateCache >> maxCachedDFAStates [
	^ 64
]

{ #category : #private }
XMLDFAStateCache >> removeDFAStates [
	cachedDFAStates
		valuesDo: [:each | each removeDFAStateTransitions];
		removeAll;
		at: firstDFAState nfaStates put: firstDFAState
]

{ #category : #initialization }
XMLDFAStateCache >> setFirstDFAState: aDFAState [
	firstDFAState := aDFAState.
	(cachedDFAStates := Dictionary new: 5)
		at: firstDFAState nfaStates
		put: firstDFAState.
]

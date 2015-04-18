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

{ #category : #adding }
XMLDFAStateCache >> addDFAState: aDFAState [
	cachedDFAStates size >= self maxCachedDFAStates
		ifTrue: [self clearCachedDFAStates].
	^ cachedDFAStates
		at: aDFAState nfaStates
		put: aDFAState.
]

{ #category : #private }
XMLDFAStateCache >> clearCachedDFAStates [
	cachedDFAStates
		removeAll;
		at: firstDFAState nfaStates
		put: firstDFAState
]

{ #category : #accessing }
XMLDFAStateCache >> dfaStateFor: aStateSet [
	^ cachedDFAStates
		at: aStateSet
		ifAbsent: [self addDFAState: (aStateSet asDFAStateWithStateCache: self)]
]

{ #category : #accessing }
XMLDFAStateCache >> firstDFAState [
	^ firstDFAState
]

{ #category : #private }
XMLDFAStateCache >> maxCachedDFAStates [
	^ 32
]

{ #category : #initialization }
XMLDFAStateCache >> setFirstDFAState: aDFAState [
	firstDFAState := aDFAState.
	(cachedDFAStates := Dictionary new: 5)
		at: firstDFAState nfaStates
		put: firstDFAState.
]

"
This class uses a dictionary with NFAStateSet keys to cache DFA states. (Does not use the regular XML key/value  cache for performance)
"
Class {
	#name : #XMLDFAStateCache,
	#superclass : #Object,
	#instVars : [
		'firstState',
		'cachedStates'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLDFAStateCache class >> firstState: aFirstState [
	^ self new firstState: aFirstState
]

{ #category : #adding }
XMLDFAStateCache >> addDFAState: aDFAState [
	cachedStates size >= self maxCachedStates
		ifTrue: [self clear].
	^ cachedStates
		at: aDFAState nfaStates
		put: aDFAState.
]

{ #category : #private }
XMLDFAStateCache >> clear [
	cachedStates
		removeAll;
		at: firstState nfaStates
		put: firstState
]

{ #category : #accessing }
XMLDFAStateCache >> dfaStateFor: aStateSet [
	^ cachedStates
		at: aStateSet
		ifAbsent: [self addDFAState: (aStateSet asDFAStateWithStateCache: self)]
]

{ #category : #accessing }
XMLDFAStateCache >> firstState: aFirstState [
	firstState := aFirstState.

	(cachedStates := Dictionary new: 5)
		at: firstState nfaStates
		put: firstState.
]

{ #category : #private }
XMLDFAStateCache >> maxCachedStates [
	^ 32
]

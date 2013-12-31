"
This class uses a dictionary with NFAStateSet keys to cache DFA states.
"
Class {
	#name : #XMLDFAStateCache,
	#superclass : #XMLFAState,
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

{ #category : #private }
XMLDFAStateCache >> clearCache [
	cachedStates
		removeAll;
		at: firstState nfaStates
		put: firstState
]

{ #category : #accessing }
XMLDFAStateCache >> dfaStateFor: aStateSet [
	^ cachedStates
		at: aStateSet
		ifAbsent: [
			cachedStates size >= self maxCachedStates
				ifTrue: [self clearCache].

			cachedStates
				at: aStateSet
				put: (self newDFAStateFor: aStateSet)].
]

{ #category : #accessing }
XMLDFAStateCache >> firstState: aFirstState [
	firstState := aFirstState.

	(cachedStates := Dictionary new)
		at: firstState nfaStates
		put: firstState.
]

{ #category : #private }
XMLDFAStateCache >> maxCachedStates [
	^ 32
]

{ #category : #private }
XMLDFAStateCache >> newDFAStateFor: aStateSet [
	^ XMLDFAState
		nfaStates: aStateSet
		dfaStateCache: self.
]

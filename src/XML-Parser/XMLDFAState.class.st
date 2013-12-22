Class {
	#name : #XMLDFAState,
	#superclass : #XMLFAState,
	#instVars : [
		'nfaStates',
		'cachedDfaStates'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLDFAState class >> nfaStates: anNfaStateCollection cachedDFAStates: aDfaStateCache isAccepting: aBoolean [
	^ self new
		setNFAStates: anNfaStateCollection
		cachedDFAStates: aDfaStateCache
		isAccepting: aBoolean
]

{ #category : #accessing }
XMLDFAState >> initializeDFAStateTransitions [
	| matchersAndTransitionStates matchersWithAcceptingTransitionStates dfaState |

	matchersAndTransitionStates := Dictionary new.
	matchersWithAcceptingTransitionStates := Set new.
	nfaStates do: [:state |
		state transitionsDo: [:transition |
			(matchersAndTransitionStates
				at: transition matcher
				ifAbsentPut: [IdentitySet new: 3]) add: transition nextState.
			transition nextState isAccepting
				ifTrue: [matchersWithAcceptingTransitionStates add: transition matcher]]].

	matchersAndTransitionStates keysAndValuesDo: [:matcher :transitionStates |
		dfaState :=
			cachedDfaStates
				at: transitionStates
				ifAbsentPut: [
					XMLDFAState
						nfaStates: transitionStates
						cachedDFAStates: cachedDfaStates
						isAccepting: (matchersWithAcceptingTransitionStates includes: matcher)].
		self addTransition:
			(XMLFATransition
				matcher: matcher
				nextState: dfaState)].
]

{ #category : #initialization }
XMLDFAState >> setNFAStates: anNfaStateCollection cachedDFAStates: aDfaStateCache isAccepting: aBoolean [
	nfaStates := anNfaStateCollection.
	cachedDfaStates := aDfaStateCache.
	 isAccepting := aBoolean.
]

{ #category : #accessing }
XMLDFAState >> transitions [
	^ transitions
		ifNil: [
			transitions := OrderedCollection new.
			self initializeDFAStateTransitions.
			transitions].
]

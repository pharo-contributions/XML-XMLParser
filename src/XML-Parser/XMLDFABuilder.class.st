"
This class builds a DFA from an NFA by grouping NFA states together based on what their transitions match.
"
Class {
	#name : #XMLDFABuilder,
	#superclass : #Object,
	#instVars : [
		'nfa',
		'cachedDfaStates'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLDFABuilder class >> nfa: anNfa [
	^ self new nfa: anNfa
]

{ #category : #building }
XMLDFABuilder >> buildDFA [
	| firstState |

	"each key is an IdentitySet of NFA states and each value is a DFA state"
	cachedDfaStates := Dictionary new.
	(firstState := XMLDFAState new) isAccepting: nfa isAccepting.
	self
		buildDFAState: firstState
		withNFAStates: (Array with: nfa).
	^ firstState.
]

{ #category : #building }
XMLDFABuilder >> buildDFAState: aDfaState withNFAStates: anNfaStateCollection [
	| matchersAndTransitionStates newDfaState |

	matchersAndTransitionStates := Dictionary new.
	anNfaStateCollection do: [:state |
		state transitionsDo: [:transition |
			(matchersAndTransitionStates
				at: transition matcher
				ifAbsentPut: [IdentitySet new: 5]) add: transition nextState].
		state isAccepting
			ifTrue: [aDfaState isAccepting: true]].

	matchersAndTransitionStates keysAndValuesDo: [:matcher :transitionStates |
		(cachedDfaStates includesKey: transitionStates)
			ifTrue: [newDfaState := cachedDfaStates at: transitionStates]
			ifFalse: [
				newDfaState := XMLDFAState new.
				cachedDfaStates at: transitionStates put: newDfaState.
				self buildDFAState: newDfaState withNFAStates: transitionStates].
		aDfaState addTransition:
			(XMLDFATransition
				matcher: matcher
				nextState: newDfaState)].
]

{ #category : #initialization }
XMLDFABuilder >> nfa: anNfa [
	nfa := anNfa
]

"
This is a base class for NFA states.
"
Class {
	#name : #XMLNFAState,
	#superclass : #Object,
	#instVars : [
		'lastAddedTo'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #adding }
XMLNFAState >> addTo: aStateSet [
	lastAddedTo == aStateSet
		ifFalse: [
			"This avoids getting caught in a loop"
			lastAddedTo := aStateSet.

			aStateSet add: self]
]

{ #category : #converting }
XMLNFAState >> asDFAState [
	| nfaStates |

	nfaStates := XMLNFAStateSet new.
	self addTo: nfaStates.
	^ nfaStates asDFAState.
]

{ #category : #connecting }
XMLNFAState >> connectToState: aState [
]

{ #category : #testing }
XMLNFAState >> isAccepting [
	^ false
]

{ #category : #testing }
XMLNFAState >> matches: anObject [
	^ false
]

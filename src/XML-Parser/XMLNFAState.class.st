"
This is a base class for NFA states.
"
Class {
	#name : #XMLNFAState,
	#superclass : #XMLFAState,
	#instVars : [
		'lastAddedTo'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #adding }
XMLNFAState >> addTo: aCollection [
	lastAddedTo == aCollection
		ifFalse: [
			lastAddedTo := aCollection.
			aCollection add: self]
]

{ #category : #converting }
XMLNFAState >> asDFAState [
	| nfaStates |

	nfaStates := XMLNFAStateSet new.
	self addTo: nfaStates.

	^ XMLDFAState nfaStates: nfaStates.
]

{ #category : #connecting }
XMLNFAState >> connectToState: aState [
]

{ #category : #testing }
XMLNFAState >> matches: anObject [
	^ false
]

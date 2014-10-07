"
An NFA in this state is considered to accept the input.
"
Class {
	#name : #XMLNFAAcceptingState,
	#superclass : #XMLNFAState,
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #testing }
XMLNFAAcceptingState >> isAccepting [
	^ true
]

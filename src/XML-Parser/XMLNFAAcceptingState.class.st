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

{ #category : #printing }
XMLNFAAcceptingState >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self identityHash; "only print ids to avoid loops"
		nextPut: $).
]

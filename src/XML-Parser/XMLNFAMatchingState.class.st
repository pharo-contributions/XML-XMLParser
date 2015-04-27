"
This state can pass to a next state if the input matches against an object.
"
Class {
	#name : #XMLNFAMatchingState,
	#superclass : #XMLNFAState,
	#instVars : [
		'matcher',
		'nextState'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLNFAMatchingState class >> matcher: aMatcher [
	^ self new matcher: aMatcher
]

{ #category : #connecting }
XMLNFAMatchingState >> connectToState: aState [
	nextState := aState
]

{ #category : #accessing }
XMLNFAMatchingState >> matcher: aMatcher [
	matcher := aMatcher
]

{ #category : #testing }
XMLNFAMatchingState >> matches: anObject [
	^ matcher = anObject
]

{ #category : #accessing }
XMLNFAMatchingState >> nextState [
	^ nextState
]

{ #category : #printing }
XMLNFAMatchingState >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self identityHash; "only print ids to avoid loops"
		nextPutAll: ': ';
		print: matcher;
		nextPutAll: ' -> ';
		print: nextState identityHash;
		nextPut: $).
]

Class {
	#name : #XMLFATransition,
	#superclass : #Object,
	#instVars : [
		'matcher',
		'nextState'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLFATransition class >> matcher: aMatcher nextState: aState [
	^ self new
		setMatcher: aMatcher
		nextState: aState
]

{ #category : #accessing }
XMLFATransition >> matcher [
	^ matcher
]

{ #category : #accessing }
XMLFATransition >> nextState [
	^ nextState
]

{ #category : #accessing }
XMLFATransition >> nextState: aState [
	nextState := aState
]

{ #category : #printing }
XMLFATransition >> printOn: aStream [
	matcher printOn: aStream.
	aStream nextPutAll: '->'.
	nextState identityHash printOn: aStream.
	aStream nextPut: $;
	
]

{ #category : #initialization }
XMLFATransition >> setMatcher: aMatcher nextState: aState [
	matcher := aMatcher.
	nextState := aState.
]

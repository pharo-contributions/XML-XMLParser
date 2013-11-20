Class {
	#name : #XMLNFATransition,
	#superclass : #XMLFATransition,
	#instVars : [
		'previousState'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #initialization }
XMLNFATransition >> nextState: aNewState [
	super nextState: aNewState.
	aNewState incomingTransition: self.
]

{ #category : #accessing }
XMLNFATransition >> previousState [
	^ previousState
]

{ #category : #accessing }
XMLNFATransition >> previousState: aState [
	previousState := aState
]

{ #category : #initialization }
XMLNFATransition >> setMatcher: aMatcher nextState: aNextState [
	super setMatcher: aMatcher nextState: aNextState.
	aNextState incomingTransition: self.
	
]

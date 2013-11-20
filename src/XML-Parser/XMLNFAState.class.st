Class {
	#name : #XMLNFAState,
	#superclass : #XMLFAState,
	#instVars : [
		'incomingTransitions'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #transitions }
XMLNFAState >> addTransition: aTransition [
	super addTransition: aTransition.
	aTransition previousState: self.
	
]

{ #category : #transitions }
XMLNFAState >> copyAndRedirectIncomingTransitionsTo: aState [
	self previousStatesDo: [:each |
		each transitions copy do: [:transition |
			each addTransition:
				(transition class
					matcher: transition matcher
					nextState: aState)]]
]

{ #category : #transitions }
XMLNFAState >> incomingTransition: aTransition [
	self incomingTransitions addIfNotPresent: aTransition
]

{ #category : #accessing }
XMLNFAState >> incomingTransitions [
	^ incomingTransitions ifNil: [incomingTransitions := self transitionCollectionClass new]
]

{ #category : #transitions }
XMLNFAState >> previousStatesDo: aBlock [
	self incomingTransitions do: [:each | aBlock value: each previousState]
]

{ #category : #transitions }
XMLNFAState >> redirectIncomingTransitionsTo: aState [
	self incomingTransitions copy do: [:each | each nextState: aState]
]

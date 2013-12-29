"
This is a fragment used to build an NFA by the NFABuilder.
"
Class {
	#name : #XMLNFAFragment,
	#superclass : #Object,
	#instVars : [
		'firstState',
		'terminalStates'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLNFAFragment class >> firstState: aFirstState terminalState: aTerminalState [
	^ self new
		firstState: aFirstState;
		terminalState: aTerminalState
]

{ #category : #'instance creation' }
XMLNFAFragment class >> firstState: aFirstState terminalStates: aTerminalStateCollection [
	^ self new
		firstState: aFirstState;
		terminalStates: aTerminalStateCollection
]

{ #category : #converting }
XMLNFAFragment >> combinedTerminalStatesFrom: aFragment [
	^ terminalStates isArray
		ifTrue: [
			aFragment terminalStates asOrderedCollection
				addAll: terminalStates;
				yourself]
		ifFalse: [
			terminalStates
				addAll: aFragment terminalStates;
				yourself]
]

{ #category : #connecting }
XMLNFAFragment >> connectToFragment: aFragment [
	self connectToState: aFragment firstState
]

{ #category : #connecting }
XMLNFAFragment >> connectToState: aState [
	self terminalStates do: [:each | each connectToState: aState]
]

{ #category : #accessing }
XMLNFAFragment >> firstState [
	^ firstState
]

{ #category : #accessing }
XMLNFAFragment >> firstState: aState [
	firstState := aState
]

{ #category : #accessing }
XMLNFAFragment >> terminalState: aTerminalState [
	terminalStates := Array with: aTerminalState
]

{ #category : #accessing }
XMLNFAFragment >> terminalStates [
	^ terminalStates
]

{ #category : #accessing }
XMLNFAFragment >> terminalStates: aTerminalStateCollection [
	terminalStates := aTerminalStateCollection
]

{ #category : #converting }
XMLNFAFragment >> terminalStatesWith: aState [
	^ terminalStates isArray
		ifTrue: [OrderedCollection with: terminalStates first with: aState]
		ifFalse: [
			terminalStates
				add: aState;
				yourself]
]

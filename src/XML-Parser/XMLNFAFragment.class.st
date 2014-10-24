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
	^ terminalStates isCollection
		ifTrue: [aFragment terminalStatesAddedTo: terminalStates]
		ifFalse: [
			aFragment terminalStates isCollection
				ifTrue: [self terminalStatesAddedTo: aFragment terminalStates]
				ifFalse: [
					self
						terminalStateCollectionWith: terminalStates
						and: aFragment terminalStates]]
]

{ #category : #converting }
XMLNFAFragment >> combinedTerminalStatesWith: aState [
	^ terminalStates isCollection
		ifTrue: [
			terminalStates
				addLast: aState;
				yourself]
		ifFalse: [self terminalStateCollectionWith: terminalStates and: aState]
]

{ #category : #connecting }
XMLNFAFragment >> connectToFragment: aFragment [
	self connectToState: aFragment firstState.
	terminalStates := aFragment terminalStates.
]

{ #category : #connecting }
XMLNFAFragment >> connectToState: aState [
	terminalStates isCollection
		ifTrue: [terminalStates do: [:each | each connectToState: aState]]
		ifFalse: [terminalStates connectToState: aState]
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
	terminalStates := aTerminalState
]

{ #category : #private }
XMLNFAFragment >> terminalStateCollectionWith: aFirstState and: aSecondState [
	^ (OrderedCollection new: 4)
		addLast: aFirstState;
		addLast: aSecondState;
		yourself
]

{ #category : #private }
XMLNFAFragment >> terminalStates [
	^ terminalStates
]

{ #category : #accessing }
XMLNFAFragment >> terminalStates: aTerminalStateCollection [
	terminalStates := aTerminalStateCollection
]

{ #category : #private }
XMLNFAFragment >> terminalStatesAddedTo: aCollection [
	terminalStates isCollection
		ifTrue: [aCollection addAll: terminalStates]
		ifFalse: [aCollection addLast: terminalStates].
	^ aCollection.
]

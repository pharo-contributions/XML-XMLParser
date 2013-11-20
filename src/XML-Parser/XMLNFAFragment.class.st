Class {
	#name : #XMLNFAFragment,
	#superclass : #Object,
	#instVars : [
		'firstState',
		'hasTerminalFirstState',
		'unconnectedTerminalState'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLNFAFragment class >> firstState: aState [
	^ self new firstState: aState
]

{ #category : #'instance creation' }
XMLNFAFragment class >> firstState: aFirstState terminalState: aTerminalState [
	^ self new
		setFirstState: aFirstState
		terminalState: aTerminalState
]

{ #category : #accessing }
XMLNFAFragment >> firstState [
	^ firstState
]

{ #category : #accessing }
XMLNFAFragment >> firstState: aState [
	firstState := aState
]

{ #category : #testing }
XMLNFAFragment >> hasTerminalFirstState [
	^ hasTerminalFirstState ifNil: [hasTerminalFirstState := false]
]

{ #category : #accessing }
XMLNFAFragment >> hasTerminalFirstState: aBoolean [
	hasTerminalFirstState := aBoolean
]

{ #category : #initialization }
XMLNFAFragment >> setFirstState: aFirstState terminalState: aTerminalState [
	firstState := aFirstState.
	unconnectedTerminalState := aTerminalState.
]

{ #category : #accessing }
XMLNFAFragment >> unconnectedTerminalState [
	^ unconnectedTerminalState
]

{ #category : #accessing }
XMLNFAFragment >> unconnectedTerminalState: aState [
	unconnectedTerminalState := aState
]

"
This class builds an NFA using a stack machine.
"
Class {
	#name : #XMLNFABuilder,
	#superclass : #Object,
	#instVars : [
		'fragmentStack'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #building }
XMLNFABuilder >> applyAlternation [
	|  alternationFragment  branchFragment |

	branchFragment := self popFragment.
	alternationFragment := self topFragment.

	branchFragment unconnectedTerminalState
		redirectIncomingTransitionsTo: alternationFragment unconnectedTerminalState.
	branchFragment firstState addTransitionsTo: alternationFragment firstState.
	alternationFragment hasTerminalFirstState:
		(alternationFragment hasTerminalFirstState
			or: [branchFragment hasTerminalFirstState]).
]

{ #category : #building }
XMLNFABuilder >> applyConcatenation [
	| firstFragment secondFragment |

	secondFragment := self popFragment.
	firstFragment := self popFragment.

	secondFragment hasTerminalFirstState
		ifTrue: [
			firstFragment unconnectedTerminalState
				copyAndRedirectIncomingTransitionsTo:
					secondFragment unconnectedTerminalState].
	firstFragment unconnectedTerminalState
		redirectIncomingTransitionsTo: secondFragment firstState.
	firstFragment unconnectedTerminalState:
		secondFragment unconnectedTerminalState.

	self pushFragment: firstFragment.
]

{ #category : #building }
XMLNFABuilder >> applyOptional [
	self topFragment hasTerminalFirstState: true
]

{ #category : #building }
XMLNFABuilder >> applyPlus [
	| plusFragment |

	plusFragment := self topFragment.
	plusFragment unconnectedTerminalState
		copyAndRedirectIncomingTransitionsTo: plusFragment firstState.
]

{ #category : #building }
XMLNFABuilder >> applyStar [
	self
		applyPlus;
		applyOptional
]

{ #category : #building }
XMLNFABuilder >> buildNFAFromFragments [
	| firstFragment |

	[self totalFragments > 1]
		whileTrue: [self applyConcatenation].

	firstFragment := self popFragment.
	firstFragment hasTerminalFirstState
		ifTrue: [firstFragment firstState isAccepting: true].
	firstFragment unconnectedTerminalState isAccepting: true.

	^ firstFragment firstState.
]

{ #category : #accessing }
XMLNFABuilder >> fragmentStack [
	^ fragmentStack ifNil: [fragmentStack := OrderedCollection new]
]

{ #category : #testing }
XMLNFABuilder >> hasFragments [
	^ self fragmentStack notEmpty
]

{ #category : #accessing }
XMLNFABuilder >> popFragment [
	^ self fragmentStack removeLast
]

{ #category : #accessing }
XMLNFABuilder >> pushFragment: aFragment [
	self fragmentStack addLast: aFragment
]

{ #category : #building }
XMLNFABuilder >> pushMatcher: aMatcher [
	| firstState transition terminalState |

	terminalState := XMLNFAState new.
	transition :=
		XMLNFATransition
			matcher: aMatcher
			nextState: terminalState.
	firstState := XMLNFAState transition: transition.

	self pushFragment:
		(XMLNFAFragment
			firstState: firstState
			terminalState: terminalState).
]

{ #category : #building }
XMLNFABuilder >> topFragment [
	^ self fragmentStack last
]

{ #category : #accessing }
XMLNFABuilder >> totalFragments [
	^ self fragmentStack size
]

"
This class builds an NFA using a stack of NFAFragments.
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
XMLNFABuilder >> applyBranch [
	| branchState leftFragment  rightFragment |

	leftFragment := self popFragment.
	rightFragment := self popFragment.
	branchState :=
		XMLNFABranchingState
			leftBranch: leftFragment firstState
			rightBranch: rightFragment firstState.

	self pushFragment:
		(XMLNFAFragment
			firstState: branchState
			terminalStates: (leftFragment combinedTerminalStatesFrom: rightFragment)).
]

{ #category : #building }
XMLNFABuilder >> applyConcatenation [
	| firstFragment secondFragment |

	secondFragment := self popFragment.
	firstFragment := self popFragment.

	firstFragment connectToFragment: secondFragment.

	self pushFragment: firstFragment.
]

{ #category : #building }
XMLNFABuilder >> applyOptional [
	| optionalFragment branchingState |

	optionalFragment := self popFragment.
	branchingState :=
		XMLNFABranchingState branch: optionalFragment firstState.

	self pushFragment:
		(XMLNFAFragment
			firstState: branchingState
			terminalStates:
				(optionalFragment combinedTerminalStatesWith: branchingState))
]

{ #category : #building }
XMLNFABuilder >> applyPlus [
	| plusFragment branchState |

	plusFragment := self topFragment.
	branchState := XMLNFABranchingState branch: plusFragment firstState.
	plusFragment
		connectToState: branchState;
		terminalState: branchState.
]

{ #category : #building }
XMLNFABuilder >> applyStar [
	| branchState starFragment |

	starFragment := self popFragment.
	branchState := XMLNFABranchingState branch: starFragment firstState.
	starFragment connectToState: branchState.

	self pushFragment:
		(XMLNFAFragment
			firstState: branchState
			terminalState: branchState)
]

{ #category : #building }
XMLNFABuilder >> buildAcceptingNFAFromFragments [
	[self totalFragments > 1]
		whileTrue: [self applyConcatenation].
	^ self popFragment
		connectToState: XMLNFAAcceptingState new;
		firstState.
]

{ #category : #private }
XMLNFABuilder >> fragmentStack [
	^ fragmentStack
]

{ #category : #testing }
XMLNFABuilder >> hasFragments [
	^ self totalFragments > 0
]

{ #category : #initialization }
XMLNFABuilder >> initialize [
	super initialize.
	fragmentStack := OrderedCollection new.
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
	| firstState |

	firstState := XMLNFAMatchingState matcher: aMatcher.
	self pushFragment:
		(XMLNFAFragment
			firstState: firstState
			terminalState: firstState).
]

{ #category : #accessing }
XMLNFABuilder >> topFragment [
	^ self fragmentStack last
]

{ #category : #accessing }
XMLNFABuilder >> totalFragments [
	^ self fragmentStack size
]

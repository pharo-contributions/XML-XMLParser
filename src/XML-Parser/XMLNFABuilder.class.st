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

	firstFragment
		connectToFragment: secondFragment;
		terminalStates: secondFragment terminalStates.

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
			terminalStates: (optionalFragment terminalStatesWith: branchingState))
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
XMLNFABuilder >> firstStateOfAcceptingNFA [
	| firstFragment |

	[self totalFragments > 1]
		whileTrue: [self applyConcatenation].

	firstFragment := self popFragment.
	firstFragment connectToState: XMLNFAAcceptingState new.

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
	| firstState |

	firstState := XMLNFAMatchingState matcher: aMatcher.
	self pushFragment:
		(XMLNFAFragment
			firstState: firstState
			terminalState: firstState).
]

{ #category : #building }
XMLNFABuilder >> topFragment [
	^ self fragmentStack last
]

{ #category : #accessing }
XMLNFABuilder >> totalFragments [
	^ self fragmentStack size
]

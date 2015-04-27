"
This state can branch off into two different states without matching against anything.
"
Class {
	#name : #XMLNFABranchingState,
	#superclass : #XMLNFAState,
	#instVars : [
		'leftBranch',
		'rightBranch'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLNFABranchingState class >> branch: aLeftBranch [
	^ self new
		setLeftBranch: aLeftBranch
		rightBranch: nil
]

{ #category : #'instance creation' }
XMLNFABranchingState class >> leftBranch: aLeftBranch rightBranch: aRightBranch [
	^ self new
		setLeftBranch: aLeftBranch
		rightBranch: aRightBranch
]

{ #category : #adding }
XMLNFABranchingState >> addTo: aStateSet [
	lastAddedTo == aStateSet
		ifFalse: [
			"This avoids getting caught in a loop"
			lastAddedTo := aStateSet.

			leftBranch addTo: aStateSet.
			rightBranch addTo: aStateSet]
]

{ #category : #connecting }
XMLNFABranchingState >> connectToState: aState [
	leftBranch ifNil: [leftBranch := aState].
	rightBranch ifNil: [rightBranch := aState].
]

{ #category : #printing }
XMLNFABranchingState >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self identityHash; "only print ids to avoid loops"
		nextPutAll: ': ';
		print: leftBranch identityHash;
		nextPutAll: ' | ';
		print: rightBranch identityHash;
		nextPut: $).
]

{ #category : #initialization }
XMLNFABranchingState >> setLeftBranch: aLeftBranch rightBranch: aRightBranch [
	leftBranch := aLeftBranch.
	rightBranch := aRightBranch.
]

Class {
	#name : #XMLDFATransition,
	#superclass : #XMLFATransition,
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #comparing }
XMLDFATransition >> = aTransition [
	^ aTransition == self
		or: [aTransition class == self class
			and: [aTransition nextState == nextState
				and: [aTransition matcher = matcher]]]
]

{ #category : #comparing }
XMLDFATransition >> hash [
	^ matcher hash bitXor: nextState hash
]

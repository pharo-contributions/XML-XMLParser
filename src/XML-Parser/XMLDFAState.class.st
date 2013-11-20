Class {
	#name : #XMLDFAState,
	#superclass : #XMLFAState,
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #accessing }
XMLDFAState >> transitionCollectionClass [
	"A set can be used here because DFA transitions don't change during construction"
	^ Set
]

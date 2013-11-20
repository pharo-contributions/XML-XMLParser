"
Matchers are used to tell what state to enter and to group NFA states together to construct DFA states.
"
Class {
	#name : #XMLFAMatcher,
	#superclass : #Object,
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #comparing }
XMLFAMatcher >> = anObject [
	self subclassResponsibility
]

{ #category : #comparing }
XMLFAMatcher >> hash [
	self subclassResponsibility
]

"
This class can use a DFA to validate element content.

"
Class {
	#name : #XMLDFAElementValidator,
	#superclass : #XMLElementValidator,
	#instVars : [
		'dfa',
		'currentState'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLDFAElementValidator class >> element: aName dfa: aDFA [
	^ self new
		setElement: aName
		dfa: aDFA
]

{ #category : #testing }
XMLDFAElementValidator >> atEnd [
	^ currentState isAccepting
]

{ #category : #accessing }
XMLDFAElementValidator >> currentState [
	^ currentState
]

{ #category : #accessing }
XMLDFAElementValidator >> dfa [
	^ dfa
]

{ #category : #copying }
XMLDFAElementValidator >> postCopy [
	currentState := dfa
]

{ #category : #accessing }
XMLDFAElementValidator >> setElement: aName dfa: aDFA [
	element := aName.
	dfa := aDFA.
	currentState := dfa.
]

{ #category : #validating }
XMLDFAElementValidator >> validatePCData: aString [
	self errorUnexpectedPCData: aString
]

{ #category : #validating }
XMLDFAElementValidator >> validateStartTag: aName [
	currentState :=
		currentState
			detectNextStateMatching: aName
			ifNone: [self errorUnexpectedElement: aName]
]

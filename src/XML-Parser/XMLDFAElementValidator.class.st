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
XMLDFAElementValidator class >> element: aName dfa: aDfa [
	^ self new
		setElement: aName
		dfa: aDfa
]

{ #category : #testing }
XMLDFAElementValidator >> atEnd [
	^ currentState isAccepting
]

{ #category : #copying }
XMLDFAElementValidator >> postCopy [
	currentState := dfa
]

{ #category : #accessing }
XMLDFAElementValidator >> setElement: aName dfa: aDfa [
	element := aName.
	dfa := aDfa.
	currentState := dfa.
]

{ #category : #validation }
XMLDFAElementValidator >> validatePCData: aString [
	self errorUnexpectedPCData: aString
]

{ #category : #validation }
XMLDFAElementValidator >> validateStartTag: aName [
	currentState :=
		currentState
			detectNextStateMatching: aName
			ifNone: [self errorUnexpectedElement: aName]
]

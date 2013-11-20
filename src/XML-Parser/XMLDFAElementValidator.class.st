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
XMLDFAElementValidator class >> name: aName dfa: aDfa [
	^ self new
		setName: aName
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
XMLDFAElementValidator >> setName: aName dfa: aDfa [
	name := aName.
	dfa := aDfa.
	currentState := dfa.
]

{ #category : #validation }
XMLDFAElementValidator >> validatePCData: aString [
	currentState := currentState
		detectNextStateMatching: [:matcher | matcher matchesPCData: aString]
		ifNone: [self errorUnexpectedPCData: aString]
]

{ #category : #validation }
XMLDFAElementValidator >> validateStartTag: aName [
	currentState := currentState
		detectNextStateMatching: [:matcher | matcher matchesElement: aName]
		ifNone: [self errorUnexpectedElement: aName]
]

"
A context for content tokens, everything from the first stat tag to the end of the document.
"
Class {
	#name : #XMLContentContext,
	#superclass : #XMLTokenContext,
	#instVars : [
		'isLiteralValueContext'
	],
	#category : #'XML-Parser-Drivers'
}

{ #category : #changing }
XMLContentContext >> enterLiteralValue [
	isLiteralValueContext := true
]

{ #category : #changing }
XMLContentContext >> exitLiteralValue [
	isLiteralValueContext := false
]

{ #category : #testing }
XMLContentContext >> isContentContext [
	^ true
]

{ #category : #testing }
XMLContentContext >> isLiteralValueContext [
	^ isLiteralValueContext ifNil: [isLiteralValueContext := false]
]

{ #category : #tokenizing }
XMLContentContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextContentToken
]

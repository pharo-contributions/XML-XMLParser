"
A context for content tokens.
"
Class {
	#name : #XMLContentContext,
	#superclass : #XMLTokenContext,
	#instVars : [
		'isLiteralValueContext'
	],
	#category : #'XML-Parser'
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

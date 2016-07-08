"
A context for prolog tokens.
"
Class {
	#name : #XMLPrologContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser-Drivers'
}

{ #category : #testing }
XMLPrologContext >> canTerminateDocument [
	^ false
]

{ #category : #testing }
XMLPrologContext >> isPrologContext [
	^ true
]

{ #category : #tokenizing }
XMLPrologContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextPrologToken
]

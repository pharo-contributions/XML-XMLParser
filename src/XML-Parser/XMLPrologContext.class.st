"
A context for prolog tokens.
"
Class {
	#name : #XMLPrologContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLPrologContext >> isPrologContext [
	^ true
]

{ #category : #tokenizing }
XMLPrologContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextPrologToken
]

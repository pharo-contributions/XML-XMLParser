"
A context for content tokens.
"
Class {
	#name : #XMLContentContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLContentContext >> isContentContext [
	^ true
]

{ #category : #tokenizing }
XMLContentContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextContentToken
]

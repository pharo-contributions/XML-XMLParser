"
A context for content tokens.
"
Class {
	#name : #XMLContentContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLContentContext >> isContextContext [
	^ true
]

{ #category : #tokenizing }
XMLContentContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextContentToken
]

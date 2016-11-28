"
A context for content tokens, everything from the first stat tag to the end of the document.
"
Class {
	#name : #XMLContentContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser-Drivers'
}

{ #category : #testing }
XMLContentContext >> isContentContext [
	^ true
]

{ #category : #tokenizing }
XMLContentContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextContentToken
]

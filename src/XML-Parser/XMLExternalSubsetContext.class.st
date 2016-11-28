"
A context for external subset tokens.
"
Class {
	#name : #XMLExternalSubsetContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser-Drivers'
}

{ #category : #testing }
XMLExternalSubsetContext >> isExternalSubsetContext [
	^ true
]

{ #category : #tokenizing }
XMLExternalSubsetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextExternalSubsetToken
]

"
A context for external subset tokens.
"
Class {
	#name : #XMLExternalSubsetContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLExternalSubsetContext >> isExternalSubsetContext [
	^ true
]

{ #category : #testing }
XMLExternalSubsetContext >> isSubsetContext [
	^ true
]

{ #category : #tokenizing }
XMLExternalSubsetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextSubsetToken
]

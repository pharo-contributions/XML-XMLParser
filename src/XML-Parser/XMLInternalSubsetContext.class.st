"
A context for internal subset tokens.
"
Class {
	#name : #XMLInternalSubsetContext,
	#superclass : #XMLDoctypeContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLInternalSubsetContext >> isInternalSubsetContext [
	^ true
]

{ #category : #testing }
XMLInternalSubsetContext >> isSubsetContext [
	^ true
]

{ #category : #tokenizing }
XMLInternalSubsetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextSubsetToken
]

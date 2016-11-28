"
A context for internal subset tokens.
"
Class {
	#name : #XMLInternalSubsetContext,
	#superclass : #XMLDoctypeDeclarationContext,
	#category : #'XML-Parser-Drivers'
}

{ #category : #testing }
XMLInternalSubsetContext >> isInternalSubsetContext [
	^ true
]

{ #category : #tokenizing }
XMLInternalSubsetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextInternalSubsetToken
]

"
A context for before parsing.
"
Class {
	#name : #XMLUnitializedContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLUnitializedContext >> isInitializedContext [
	^ false
]

{ #category : #tokenizing }
XMLUnitializedContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextStartDocument
]

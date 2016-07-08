"
A context for before parsing.
"
Class {
	#name : #XMLUnitializedContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser-Drivers'
}

{ #category : #testing }
XMLUnitializedContext >> isInitializedContext [
	^ false
]

{ #category : #tokenizing }
XMLUnitializedContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextStartDocument
]

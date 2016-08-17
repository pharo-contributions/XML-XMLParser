"
A context for before tokenizing has started.
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

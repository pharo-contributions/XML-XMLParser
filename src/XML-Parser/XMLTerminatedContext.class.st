"
A context for after parsing.
"
Class {
	#name : #XMLTerminatedContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLTerminatedContext >> isTerminatedContext [
	^ true
]

{ #category : #tokenizing }
XMLTerminatedContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextEndDocument
]

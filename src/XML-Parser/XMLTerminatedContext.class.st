"
A context for when tokenizing has stopped.
"
Class {
	#name : #XMLTerminatedContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser-Drivers'
}

{ #category : #testing }
XMLTerminatedContext >> isTerminatedContext [
	^ true
]

{ #category : #tokenizing }
XMLTerminatedContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextEndDocument
]

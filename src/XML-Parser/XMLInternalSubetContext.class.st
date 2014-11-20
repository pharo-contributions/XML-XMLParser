"
A context for internal subset tokens.
"
Class {
	#name : #XMLInternalSubetContext,
	#superclass : #XMLSubsetContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLInternalSubetContext >> isDoctypeContext [
	^ true
]

{ #category : #testing }
XMLInternalSubetContext >> isInternalSubsetContext [
	^ true
]

{ #category : #testing }
XMLInternalSubetContext >> isPrologContext [
	^ true
]

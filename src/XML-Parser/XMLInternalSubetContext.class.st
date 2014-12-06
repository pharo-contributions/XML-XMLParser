"
A context for internal subset tokens.
"
Class {
	#name : #XMLInternalSubetContext,
	#superclass : #XMLDoctypeContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLInternalSubetContext >> isInternalSubsetContext [
	^ true
]

{ #category : #testing }
XMLInternalSubetContext >> isSubsetContext [
	^ true
]

{ #category : #testing }
XMLInternalSubetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextSubsetToken
]

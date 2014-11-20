"
An abstract class for subset contexts.
"
Class {
	#name : #XMLSubsetContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLSubsetContext >> isSubsetContext [
	^ true
]

{ #category : #tokenizing }
XMLSubsetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextSubsetToken
]

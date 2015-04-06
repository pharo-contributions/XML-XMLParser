"
A context for external subset tokens.
"
Class {
	#name : #XMLExternalSubsetContext,
	#superclass : #XMLTokenContext,
	#instVars : [
		'isLiteralValueContext'
	],
	#category : #'XML-Parser'
}

{ #category : #changing }
XMLExternalSubsetContext >> enterLiteralValue [
	isLiteralValueContext := true
]

{ #category : #changing }
XMLExternalSubsetContext >> exitLiteralValue [
	isLiteralValueContext := false
]

{ #category : #testing }
XMLExternalSubsetContext >> isExternalSubsetContext [
	^ true
]

{ #category : #testing }
XMLExternalSubsetContext >> isLiteralValueContext [
	^ isLiteralValueContext ifNil: [isLiteralValueContext := false]
]

{ #category : #tokenizing }
XMLExternalSubsetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextSubsetToken
]
